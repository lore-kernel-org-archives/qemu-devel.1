Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D7B2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbD1-0001qL-0C
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIb0M-0004MU-FJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIb0L-00078w-Cw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIb0L-00078X-50
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:09:29 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7C2EC049E17
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 16:09:27 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w2so2987332wrn.4
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M3FS2Kc8SnrTVjy1x8xFYQKVHVTCY+I6LMcd4/4EQ6k=;
 b=jfBCnQEzx2aZLhqsO0dp7rOLc7/oHUK45gEMx6HjBGUp1GpkSV4skRhox+Wlw3/TsB
 6we4rw3a25I3WzPgq2vr9NxuvoQZ6x+FELdTkONuU+JaKF58twYqod5ui4UQNiD9LZCs
 ZncuaDP6Rq5YyDKGoqrEPeOrX0fN/fNyGmxmqF3rsZGwo+w1IM0VeVu+e8f5I+8vULHA
 acMMXuR5IZYsNvzDzFoARBKF0ujERHmL5L+cJ/FmorMIqa+SufL6HAo8Brvv71yW0EvI
 HxIdm4Mde8Kgq+IEuqSBCPrUa1SmLrW9SYdPLSONJitxf0yF+ImL7S7coz7lW0wFQmMP
 eZyw==
X-Gm-Message-State: APjAAAU3Obah7RDRHL011eDdWey7QPrzRJr+ubuXWX1A/EWOOeGvt/50
 QyGRUmrFufFFXopFcYrwPiGT5gv1wvapMSmoVloNk9tDAB2BvRb58uCvytEmfWgNe6GCHKgrxDT
 Y8/bgHYTHvz17YfU=
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr8859593wrw.195.1570723766742; 
 Thu, 10 Oct 2019 09:09:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmYEo090LWvIyLcJj2QdbqLwWPCb1IZNxKU2bNpj1D9ygBHI83YFFVs6VLEjfeJvcBY1FG1A==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr8859575wrw.195.1570723766549; 
 Thu, 10 Oct 2019 09:09:26 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id f8sm6728772wmb.37.2019.10.10.09.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 09:09:25 -0700 (PDT)
Subject: Re: [PATCH v25 22/22] qapi/machine.json: Add RX cpu.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190927062302.110144-1-ysato@users.sourceforge.jp>
 <20190927062302.110144-23-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <68a06c51-c01f-7ea0-52fb-2f4a743d4452@redhat.com>
Date: Thu, 10 Oct 2019 18:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927062302.110144-23-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The subject should be "Add RX architecture" but anyway this patch has to 
be squashed in patch #20 "Add rx-softmmu"

On 9/27/19 8:23 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   qapi/machine.json | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..4409c113c2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,6 +21,7 @@
>   #        is true even for "qemu-system-x86_64".
>   #
>   # ppcemb: dropped in 3.1
> +# rx: added in 4.2
>   #
>   # Since: 3.0
>   ##
> @@ -28,7 +29,7 @@
>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>                'x86_64', 'xtensa', 'xtensaeb' ] }
>   
> 

