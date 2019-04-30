Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F994C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 05:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D54920835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 05:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D54920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLLf5-0003fm-Fy
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 01:50:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLeC-0003Bj-BN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLeB-0002Xs-DR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:49:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLLeB-0002Xc-7g
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:49:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so19429462wrt.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 22:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TAvHRHlxJf5DQyuAsMedomeY952qG7woc62OfFiA8jc=;
	b=rVivYJfuGzPUtg/1icrUq55ubcxcScq99ummeQ6V6+HExgPNxt5IHvYVQQz6BtFm2d
	SCbF+09yc8QqhVY+6At1YTeLf5VyA9NhKKwDyXHyUQTzzbteVPmA/sEbsKTsnqt7pAna
	r3tcHB+MEdnksRJ+c4+9Arc/xnmHJLZo+pCujzL0edWjZM0dJOE8m6d6ql2cPD7wLgGs
	MG5o0Mhkr0tAATldEhFy2gzZSOFCM7TSOu0z1cDNHLIbhnRKkTZ8qifm6iEeHBstO8jH
	NYOwvg7jaLWgda/i3shVXPghiAjpYuor4ma/hp67L+ItYW+YZ9axmGFa0uVeq/xHSEG2
	iz9A==
X-Gm-Message-State: APjAAAVZO6RKcfMyvh745eIr1aEhEyFUYq6bRieyZ0o6dmIQ83dFcssz
	GmYc0BANdbwrNpOTGQWG39ZoQtddpbM=
X-Google-Smtp-Source: APXvYqxmgDWFON5QfzsOjc+OvLseKI6S08RXYa0SsbZoCoIykME2rctMzTNk3ZNNXQlySSCKoMgT1w==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr17813287wrv.153.1556603381942;
	Mon, 29 Apr 2019 22:49:41 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	s22sm6852439wrb.44.2019.04.29.22.49.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 22:49:41 -0700 (PDT)
To: driver1998 <driver1998@foxmail.com>, qemu-devel@nongnu.org
References: <20190429003322.22908-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d25baf06-1176-5cce-2ff1-3b5652e3ca27@redhat.com>
Date: Tue, 30 Apr 2019 07:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429003322.22908-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430054940.l_OiJjjRrGxMWVT10IAIfgDThmLkVJm49VyRIycNh5w@z>

On 4/29/19 2:33 AM, driver1998 wrote:
> Windows ARM64 uses LLP64 model, which breaks current assumptions.
> 
> Signed-off-by: driver1998 <driver1998@foxmail.com>
> ---
>  util/cacheinfo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 3cd080b83d..a815cb0722 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>  static void arch_cache_info(int *isize, int *dsize)
>  {
>      if (*isize == 0 || *dsize == 0) {
> -        unsigned long ctr;
> +        uintptr_t ctr;
>  
>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
>             but (at least under Linux) these are marked protected by the
> @@ -120,6 +120,8 @@ static void arch_cache_info(int *isize, int *dsize)
>          if (*dsize == 0) {
>              *dsize = 4 << ((ctr >> 16) & 0xf);
>          }
> +
> +        printf("%d %d\n", *isize, *dsize);

The patch looks correct (except your real name), but here you forgot to
remove this debugging code.

>      }
>  }
>  
> 

