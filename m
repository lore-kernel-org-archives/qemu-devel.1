Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C526C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118DF2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118DF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2oM-0007R7-4o
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT2ls-00045u-Ua
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT2lr-0000gm-Dc
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:49:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT2lq-0000fx-Li
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:49:43 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 71C5AC04959B
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 11:49:41 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id c6so3055602wrp.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 03:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Khm/MucwVUPrqO0140sB3/az0X7po32ryKnCUVR/JyM=;
 b=S/CdvEGqT9u0G1Sy98Ocx20wFktZbLjYROtHyhkaiRd/XGE+sIYXIMsQZGktVel7AB
 dXxzoilGx0l9qNG/bGqoGkW8p3KwC8vLxB/eEc5yi9NC8G+O7yoqsv+10LCoVgWQQ5D3
 xqb1tZO2pa+wP/L+xooLXLoiaoADt/fXuLU8neCDXHmAIfVasfJgW0GakCv34AEPOVfz
 tHDD+ywzs205IR+7Ak14ad97bKK31XsaXxyNlychJ19YfV5m+MVwQxsOsi4K+ls+dqjx
 V73Y3N2KilKGMQUZ5V5doX/ry2yC6UgKP13+qf+0X6dZZ70GiJDsixR9hYwcC7prZxae
 GVug==
X-Gm-Message-State: APjAAAWrqjOEkjWKxVsVQghKFMyBh9EJqZe1meXg99iY1VTH0KALaWqC
 nMYxi1c7fsMDUR+CmsOfGCne2Etysaj+1wAfmWPsQGeE0ttPpxY+b6cQRCOFEHspdP9614Az+Tx
 sTOW8mv1aYbzUL/A=
X-Received: by 2002:adf:e449:: with SMTP id t9mr8306471wrm.196.1573213780229; 
 Fri, 08 Nov 2019 03:49:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8EZIXX6gx0b6vo4liWlAwVnDbj2DNQ8acDXIjIw3Ae8RvjCgefZL1VWdvLmrynPO2JWlPFw==
X-Received: by 2002:adf:e449:: with SMTP id t9mr8306458wrm.196.1573213780036; 
 Fri, 08 Nov 2019 03:49:40 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id v10sm8040484wmg.48.2019.11.08.03.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 03:49:39 -0800 (PST)
Subject: Re: [PATCH v2 1/2] configure: Only decompress EDK2 blobs for X86/ARM
 targets
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
References: <20191108114531.21518-1-philmd@redhat.com>
 <20191108114531.21518-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97a31e52-8961-8fd5-60bc-be2eb62a942f@redhat.com>
Date: Fri, 8 Nov 2019 12:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108114531.21518-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The EDK2 firmware blobs only target the X86/ARM architectures.
> Define the DECOMPRESS_EDK2_BLOBS variable and only decompress
> the blobs when the variable exists.
>=20
> Fixes: 536d2173b2b
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: new
> ---
>   Makefile  |  2 ++
>   configure | 13 +++++++++++++

Oops sorry, new workspace, I hadn't installed scripts/git.orderfile.

>   2 files changed, 15 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index aa9d1a42aa..3430eca532 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -480,7 +480,9 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
>   $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
>   $(SOFTMMU_ALL_RULES): $(io-obj-y)
>   $(SOFTMMU_ALL_RULES): config-all-devices.mak
> +ifdef DECOMPRESS_EDK2_BLOBS
>   $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
> +endif
>  =20
>   .PHONY: $(TARGET_DIRS_RULES)
>   # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
> diff --git a/configure b/configure
> index efe165edf9..9b322284c3 100755
> --- a/configure
> +++ b/configure
> @@ -427,6 +427,7 @@ softmmu=3D"yes"
>   linux_user=3D"no"
>   bsd_user=3D"no"
>   blobs=3D"yes"
> +edk2_blobs=3D"no"
>   pkgversion=3D""
>   pie=3D""
>   qom_cast_debug=3D"yes"
> @@ -2146,6 +2147,14 @@ case " $target_list " in
>     ;;
>   esac
>  =20
> +for target in $target_list; do
> +  case "$target" in
> +    arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
> +      edk2_blobs=3D"yes"
> +      ;;
> +  esac
> +done
> +
>   feature_not_found() {
>     feature=3D$1
>     remedy=3D$2
> @@ -7526,6 +7535,10 @@ if test "$libudev" !=3D "no"; then
>       echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
>   fi
>  =20
> +if test "$edk2_blobs" =3D "yes" ; then
> +  echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak
> +fi
> +
>   # use included Linux headers
>   if test "$linux" =3D "yes" ; then
>     mkdir -p linux-headers
>=20

