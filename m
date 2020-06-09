Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30B520774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NHn2+CYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30B520774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiTEZ-0004vr-Sg
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 21:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTBf-00032G-QF; Mon, 08 Jun 2020 21:36:23 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTBd-00006V-J9; Mon, 08 Jun 2020 21:36:23 -0400
Received: by mail-ej1-x641.google.com with SMTP id q19so20503310eja.7;
 Mon, 08 Jun 2020 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BbNUu4Jc4lvGb9KgotfafO1lnmYANRJc+h+ReKwcTOg=;
 b=NHn2+CYBg4rakryj+pmovN9rmc3oq5puTOrBEa58Fqvj9lHVJQ+0vWxUtINpYp1WfP
 nGJcvKc/jHIYjwrXvYdW9L0A2DNHfAwJKdxH//RWBnCfPKrXYXRIFrSSqlwu2VR+dMaO
 dXXV65cUxCX3s0ZeCYzkMrR4TV1NUM5PJg1j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BbNUu4Jc4lvGb9KgotfafO1lnmYANRJc+h+ReKwcTOg=;
 b=m5PPLAVrW2WMHhONBCcqYpnmZCPHHLoEY8SrUmUmS6xIAZTJi53dANp6+rz+c0Dzn6
 FsRdtyn5ylvBuXXd/XJNru3T5oxSh76kxzQ+9x7xuvRrPiEWt0BCLa3naByiMHHCd0rp
 ExrA6fXar4pK//0zQUx3+EQLsddyAgGZmF6/7WuHB0Ws/3tvxPTin6ihTkQNmAjxTEgA
 Ol71NGzwMLZcNVVW+53JD2U6/lzaoZx/OUc1yuCndSgUGjbkNS7RQ+c+5A4X3x2FaMS5
 6E6Tl+C6aO8k1z/wcHQvHK6GaXy12ZXQVkOHAiH7YGOxpfZCCacvvFz4yhUNiW7a2xEr
 sTmg==
X-Gm-Message-State: AOAM530gsNerXoKyPzUO4yciILzRmt0KrjJqhDFbaDHTJiSQ4FJR4WNg
 PgFAaoyQTrMkF9FaC8b1nicpTCvkD00xo+KuOug=
X-Google-Smtp-Source: ABdhPJyNTXp1/TAPjMfS6B0AD1gLkM3SH59bhAsvrjK+Brw9oud1gXrViXposa6k9vDUYglAj1odcviE6QHIk9oHnVg=
X-Received: by 2002:a17:906:4350:: with SMTP id
 z16mr22830095ejm.139.1591666578876; 
 Mon, 08 Jun 2020 18:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-2-hskinnemoen@google.com>
In-Reply-To: <20200521192133.127559-2-hskinnemoen@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 9 Jun 2020 01:36:07 +0000
Message-ID: <CACPK8Xe4BEXAhgKmxt4YZVm2ggOPZ4hFbyJP-8NxBDa7+NrdCA@mail.gmail.com>
Subject: Re: [PATCH 1/6] npcm7xx: Add config symbol
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kfting@nuvoton.com,
 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 20:39, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> Add a config symbol for the NPCM7xx BMC SoC family that subsequent
> patches can use in Makefiles.
>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

Acked-by: Joel Stanley <joel@jms.id.au>


> ---
>  default-configs/arm-softmmu.mak | 1 +
>  hw/arm/Kconfig                  | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 8fc09a4a51..9a94ebd0be 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -27,6 +27,7 @@ CONFIG_GUMSTIX=y
>  CONFIG_SPITZ=y
>  CONFIG_TOSA=y
>  CONFIG_Z2=y
> +CONFIG_NPCM7XX=y
>  CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 5364172537..47d0a3ca43 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -354,6 +354,14 @@ config XLNX_VERSAL
>      select VIRTIO_MMIO
>      select UNIMP
>
> +config NPCM7XX
> +    bool
> +    select A9MPCORE
> +    select ARM_GIC
> +    select PL310  # cache controller
> +    select SERIAL
> +    select UNIMP
> +
>  config FSL_IMX25
>      bool
>      select IMX
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>
>

