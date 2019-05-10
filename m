Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB7C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3690217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3690217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPC5Z-0006aJ-A1
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:25:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hPC4b-000671-Qm
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hPC4a-0007zK-Qu
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:24:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hPC4a-0007to-Je
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:24:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so8580297wmb.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/j0ppzR9ZIeOxAqvywQpNXkO1cNGJmykGyC7FhB5wyw=;
	b=sNUGFFgyINaPAzrkIN5XEZD+Vwnvwcihi+aCI6s1rJzsoqj+MyAKPT612QW0vdmvgF
	OaW8Aef99+4jFKHfig1OL+E4/TL4prA4zWPVgvSuZKl5182Q+hhmeZgdA3AHetLcV/M+
	hHRp0kImen7yP6RjHMaSl9xjpG9/AM42SQQsPB7SxglTcwVEw6eHMOaENvPdiDaVKHDw
	8sv0vgWBQf/WA5Ry640Uh7tZTOiyQdGLIF9eS35kJXzkSGT0M3T/Tt1gmG3aJjpyxur1
	d+zxdxdRzy2oe1VRoVyHzaUyXvbyxH4/GCErh8HCRaYLNHlj6YgyHuomBEFzaaNoseaZ
	YQ5w==
X-Gm-Message-State: APjAAAUVxwbXMFsObhcz3BN1IUxziViv8HPjGDfI2yQ2X7YSM83eD9W1
	tjBT2Sdze0vBWfeLVa5v0Wk/0w==
X-Google-Smtp-Source: APXvYqynD65aWeHtlgSLl9V/etWfRolSmUVVMKHIBa58PgG5pUGNapFVYTREkC30/h5Sl/ofBFV5Sg==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr4977963wmc.90.1557519889903; 
	Fri, 10 May 2019 13:24:49 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id
	a15sm9512030wru.88.2019.05.10.13.24.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 13:24:48 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190510082057.9104-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5ae14ab-f664-9023-fb30-b41f4ae8bfd2@redhat.com>
Date: Fri, 10 May 2019 22:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510082057.9104-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] Makefile: Fix inclusion of the
 config-devices.mak.d Kconfig dependencies
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/05/19 03:20, Thomas Huth wrote:
> The Makefile tries to include device Kconfig dependencies via
> 
>  -include $(SUBDIR_DEVICES_MAK_DEP)
> 
> and thus expects files that match *-softmmu/config-devices.mak.d ...
> However, the minikconf script currently generates files a la
> "*-softmmu-config.devices.mak.d" instead, so the dependency files
> simply got ignored so far. For example, after a "touch hw/arm/Kconfig",
> the arm-softmmu/config-devices.mak file is currently not re-generated.
> Fix it by putting the dependency files in the *-softmmu folders now.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile               | 2 +-
>  configure              | 2 +-
>  docs/devel/kconfig.rst | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a971247cac..d878767066 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -350,7 +350,7 @@ endif
>  # This has to be kept in sync with Kconfig.host.
>  MINIKCONF_ARGS = \
>      $(CONFIG_MINIKCONF_MODE) \
> -    $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
> +    $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
>      CONFIG_KVM=$(CONFIG_KVM) \
>      CONFIG_SPICE=$(CONFIG_SPICE) \
>      CONFIG_IVSHMEM=$(CONFIG_IVSHMEM) \
> diff --git a/configure b/configure
> index 63f312bd1f..8999698bc2 100755
> --- a/configure
> +++ b/configure
> @@ -1832,7 +1832,7 @@ exit 0
>  fi
>  
>  # Remove old dependency files to make sure that they get properly regenerated
> -rm -f *-config-devices.mak.d
> +rm -f */config-devices.mak.d
>  
>  if test -z "$python"
>  then
> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> index cce146f87d..d6f8eb0977 100644
> --- a/docs/devel/kconfig.rst
> +++ b/docs/devel/kconfig.rst
> @@ -299,7 +299,7 @@ and also listed as follows in the top-level Makefile's ``MINIKCONF_ARGS``
>  variable::
>  
>      MINIKCONF_ARGS = \
> -      $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
> +      $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
>        CONFIG_KVM=$(CONFIG_KVM) \
>        CONFIG_SPICE=$(CONFIG_SPICE) \
>        CONFIG_TPM=$(CONFIG_TPM) \
> 

Queued, thanks.

Paolo

