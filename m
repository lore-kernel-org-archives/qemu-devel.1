Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA2C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962762070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962762070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6j8-0006we-Sh
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hs6ie-0006TK-6L
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hs6id-0003XR-5s
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:33:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hs6ic-0003XB-VN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:33:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so62218437wru.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lGRv+t0quDP+Ze/c8kxZ+GqzrVcwVVvrd4yX5h+DcfQ=;
 b=HyVAp7IjAL4AT0S1DXqZIrP8ZhkDpXPPRlszR73s1P8BNPOytlhp7UbpTJRP1ioPH/
 b8H3qI14qt2iyIJ+WbFT0EVHgl7p36DI5OvxiK5SxAmr3EaQaNWD07GcBbnvItshnc3c
 4Wo1Y3osczPFpHNtNgyMX+A64DMQjL/jF0NXMNhzZv7fymP5KBhpXqhy1HqnWh+mu55e
 TB4pxcxXyDdVCIX2fFpGxMBdz1gbf4ggvvLxWkkiA5281xEEYIy8LW3jwXFnu1LRoEC6
 kPeikZzfOOuIaT/8JYWo8InqB6zjFzsTVTCfl60omg5SX+vwP8NvORS9olNy+J+gZrfx
 BMCw==
X-Gm-Message-State: APjAAAWU25e41zbFslTBrVX+NBk9FYYTZOujgr5ryhRKcn5XGghON96E
 gf7HEYinqNtmTmQWay37GruOVA==
X-Google-Smtp-Source: APXvYqxNT2pvoSS/8bSOmvUpkXE5nY8VsCI1CH0O7fNPgGMqBXtzegOU5pezqyLNlPtYNzCPXfgqXA==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr41937968wrs.88.1564410822102; 
 Mon, 29 Jul 2019 07:33:42 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id z6sm55428718wrw.2.2019.07.29.07.33.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 07:33:41 -0700 (PDT)
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <6a7d3b524e7c0a41ef232d9dc21d7c337b05b97d.1564080680.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3d45d806-3cc2-a13f-a431-c5a4d6fe42b8@redhat.com>
Date: Mon, 29 Jul 2019 16:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6a7d3b524e7c0a41ef232d9dc21d7c337b05b97d.1564080680.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH-4.2 v1 1/6] target/riscv: Don't set write
 permissions on dirty PTEs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 8:52 PM, Alistair Francis wrote:
> Setting write permission on dirty PTEs results in userspace inside a
> Hypervisor guest (VU) becoming corrupted. This appears to be becuase it

"because"

> ends up with write permission in the second stage translation in cases
> where we aren't doing a store.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e32b6126af..f027be7f16 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -340,10 +340,8 @@ restart:
>              if ((pte & PTE_X)) {
>                  *prot |= PAGE_EXEC;
>              }
> -            /* add write permission on stores or if the page is already dirty,
> -               so that we TLB miss on later writes to update the dirty bit */
> -            if ((pte & PTE_W) &&
> -                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
> +            /* add write permission on stores */
> +            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
>                  *prot |= PAGE_WRITE;
>              }
>              return TRANSLATE_SUCCESS;
> 

