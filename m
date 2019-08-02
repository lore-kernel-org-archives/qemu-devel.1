Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316FBC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D392087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D392087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta9J-0001LT-AC
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hta8X-0000Rg-Oz
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hta8W-0004Oy-GD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:10:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hta8W-0004O2-Ad
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:10:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so72801181eds.8
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rdDytL/LvlkBPiC5YPCjoS9yAmmOAw4abjNfD/j2Hfw=;
 b=Byk2u/j7nT9c8zbzZexJD2x/TbTVIda6z0YMYBf9he62YqsTgu+wP9UwNv6KttBxdr
 EgkMwvnEFQvJ/GhvdfQoq1HVoxojj/GA0zi4vFIovDPIHFKYHEygzyl2v2KXG1r51XwN
 rA7YkHvZxEL9CcEOiyzRSKxq9KnYFlrKuOCbY2ZfCCNAaIfQOTNkVffchlaVaINM/VkG
 V2BUDg17BCvXGLZgSCAKDcAYxHDTjySnjiFHSx+45/9FpUdJzqsyceLgyyQmCArH8RyZ
 cD9pw3MncRzILaiO++cLcPGpHtYhS9fGpwq9euDU3ki783CJE82i+dTlnwqJLri//ziF
 r8Hg==
X-Gm-Message-State: APjAAAW1paUvC7SYAzgozjEidS3BqrR9OTTSsQYuNHnEM0asozTGwZ2d
 JOPyKMZSt23KT6CSp8N7guNaCw==
X-Google-Smtp-Source: APXvYqzCeLk6GpTyJbJMV85OUTRQ/1klGh5AGKlAWcAkMHDJ0cuqD70ZfZsw/69ctLHIMHRQmKce5A==
X-Received: by 2002:a17:906:9453:: with SMTP id
 z19mr101204091ejx.287.1564762231397; 
 Fri, 02 Aug 2019 09:10:31 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id l1sm17856615edr.17.2019.08.02.09.10.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:10:30 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1564677923-23173-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564677923-23173-11-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <10c0985a-0fc9-2e1c-843d-b660c4085864@redhat.com>
Date: Fri, 2 Aug 2019 18:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564677923-23173-11-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.68
Subject: Re: [Qemu-devel] [PATCH for 4.2 v5 10/12] target/mips: Style
 improvements in machine.c
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 6:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fixes mostly errors and warings reported by 'checkpatch.pl -f'.

"warnings"

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/machine.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index e23b767..06887d8 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -25,7 +25,7 @@ static int get_fpr(QEMUFile *f, void *pv, size_t size,
>      int i;
>      fpr_t *v = pv;
>      /* Restore entire MSA vector register */
> -    for (i = 0; i < MSA_WRLEN/64; i++) {
> +    for (i = 0; i < MSA_WRLEN / 64; i++) {
>          qemu_get_sbe64s(f, &v->wr.d[i]);
>      }
>      return 0;
> @@ -37,7 +37,7 @@ static int put_fpr(QEMUFile *f, void *pv, size_t size,
>      int i;
>      fpr_t *v = pv;
>      /* Save entire MSA vector register */
> -    for (i = 0; i < MSA_WRLEN/64; i++) {
> +    for (i = 0; i < MSA_WRLEN / 64; i++) {
>          qemu_put_sbe64s(f, &v->wr.d[i]);
>      }
>  
> 

