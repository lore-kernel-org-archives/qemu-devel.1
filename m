Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF8EC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870A620873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870A620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRKw-0007s2-Ir
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41215)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoRKj-0007K5-Cg
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoRKi-000172-Cm
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:45:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoRKi-00016R-5x
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:45:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so18380661wmc.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ic/Zh/DiGrt51Nn2Kyvkv205FonItVi+cVwsMddKFrE=;
 b=T2GK8/FSqbYBpLqJ7QIYfPLj/1Xi5e1EBAebKhb8HOLCO0E2TTDUrETLBE+e0idF0w
 MFv+Bq7ROkWMVXydapQ6Ld3umfLwmO95Hm14NUPad66VCIK8QrZLCW7dH4SQaF2o+MMC
 FISA/qcPw48MKWDNag0MQX9AKWQTEDtJYXfRCM2xeWlTcmXKuG7vfaj0fOCjkCoiGcDN
 AV8yna3cac+AETyO2RmhlV1mwVWJrNENkqCZl3bJ2gsaj2/EL3HP6CKjZ0Inx6n9CtFp
 PLeJFgaIRlafHtTrpvtwZVQZOAOCsCmIrKnFIeUVjB80Y5y6hGwDOh0qnZsQcyoK30rc
 hU3Q==
X-Gm-Message-State: APjAAAVqi/U3xNxQGLOG4T8OZj0oysXSXCfeGdQ2aFLPl6fYTvqWB9RE
 lqr5r34hq+92b/iJSCUTzw+5rg==
X-Google-Smtp-Source: APXvYqwsLveD9UIUX/Ov9HgKXcrJUGRX5n+falgajfqCNtDq5M+gO3IWOpu2Jk5Pv85yvT6qcVevtQ==
X-Received: by 2002:a05:600c:214e:: with SMTP id
 v14mr49363175wml.96.1563536751122; 
 Fri, 19 Jul 2019 04:45:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id v5sm32485452wre.50.2019.07.19.04.45.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 04:45:50 -0700 (PDT)
To: Jiri Slaby <jslaby@suse.cz>, qemu-trivial@nongnu.org
References: <20190719104118.17735-1-jslaby@suse.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c5487d32-f3b8-8534-fe19-3c7aef7188eb@redhat.com>
Date: Fri, 19 Jul 2019 13:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719104118.17735-1-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: fix failed message typos
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 12:41, Jiri Slaby wrote:
> In these multiline messages, there were typos. Fix them -- add a missing
> space and remove a superfluous apostrophe.
> 
> Inspired by Tom's patch.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-trivial@nongnu.org
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  target/i386/sev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 5ba1384ea1f6..f1423cb0c0d1 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -763,7 +763,7 @@ sev_guest_init(const char *id)
>                                          "reduced-phys-bits", NULL);
>      if (s->reduced_phys_bits < 1) {
>          error_report("%s: reduced_phys_bits check failed, it should be >=1,"
> -                     "' requested '%d'", __func__, s->reduced_phys_bits);
> +                     " requested '%d'", __func__, s->reduced_phys_bits);
>          goto err;
>      }
>  
> @@ -783,7 +783,7 @@ sev_guest_init(const char *id)
>      ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
>                               &fw_error);
>      if (ret) {
> -        error_report("%s: failed to get platform status ret=%d"
> +        error_report("%s: failed to get platform status ret=%d "
>                       "fw_error='%d: %s'", __func__, ret, fw_error,
>                       fw_error_to_str(fw_error));
>          goto err;
> 

Queued, thanks.

Paolo

