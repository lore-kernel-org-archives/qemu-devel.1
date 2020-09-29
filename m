Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC492C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8D12076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0WcvVom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8D12076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLuu-0002RC-13
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNLtv-0000zI-KX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:07:03 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNLtu-0001qq-4b
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:07:03 -0400
Received: by mail-ej1-x641.google.com with SMTP id h26so6878535ejq.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u1h2fvvT4OPp+mDt9BSuEIwI1NU5rX5oD8xSPHyS3oE=;
 b=t0WcvVombLhwdXdTCcUWhl2itrZyb/IumcAxL3uVxGyb+WGHU7Uoz2ogoqkVeZAGQG
 gW2aYszOTJ2aNsbB+Z7NeadAmAPSpjGCuOEUp39eBda8VphQlH9gIWkuTtSj77LJ420/
 vF54QA5aweY79WlMUb7c3cN0o9CvJGUE+WTyQte3ECfZObuWUpdj9EPiWNEYkwgpj7GH
 ascElJ35lrz2DMJ0n/C6k96ywcVccRucu9kHhvLPb3qgPv1z0IcZoajuknEAnKVtrnzt
 ViwIn7o/SNtjAmnE92xgSNB+qc6WQwHs3Wp8lIFhQqnKMy71Vse1JvjQELUunP9Uqndf
 0miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u1h2fvvT4OPp+mDt9BSuEIwI1NU5rX5oD8xSPHyS3oE=;
 b=rCyoLSgSHPZoUKJsotmiD74Kma9VAhBT0NgHS6yjD36PICTVdP/OFVJ1jWcNy8vitU
 8T0ilEyIcX6/52ry5pIfV70IiWc8nKbLO7Yoz1TILgVm2iHKXZxwdf6se4ch/3nBB50Y
 /KqmcuMyw8pK+aqAzwCaGZzlUqKx6HWbZtpQSlyK7Wmk6gFKQutI8Ke89G8iYDQNYTyu
 XlRvdeFpeXDOxYUV3CrWFWILxq5Zu/ufyv5MA5enY7k3CmTs9uCRHxL8GMt+xZGEMnrO
 lUuHmALtGyWh/gHRibN7Cl89a7iS2SndGUpXTAgPctJfs+Be3e37vGbyb67hxo1LX/0X
 kCSg==
X-Gm-Message-State: AOAM531xBE2hfKsNwco5Aa+ucjHfJEIpnYIW9DKLKFnJYW0lvU02hrqS
 NJ+ipxD5qqGZsRaVc0667KX+3yZi/S6NKUvPH5d51Q==
X-Google-Smtp-Source: ABdhPJzNvPmfpqeFF5weiJ06WOCbfrwLMo30g1vXELPjVSGmAHTe0OlZZUhZENuMjibdqJ8Ah+loAU7hXvzaKksnKQA=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr5774019ejb.4.1601410020098; 
 Tue, 29 Sep 2020 13:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-18-philmd@redhat.com>
In-Reply-To: <20200316160634.3386-18-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 21:06:48 +0100
Message-ID: <CAFEAcA-Rt__Du0TqqVFov4mNoBvC9hTt7t7e-3G45Eck4z94tQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/19] hw/arm: Automatically select the 'virt' machine
 on KVM
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 16:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> When building a KVM-only QEMU, the 'virt' machine is a good
> default :)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index d0903d8544..8e801cd15f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -1,5 +1,6 @@
>  config ARM_VIRT
>      bool
> +    default y if KVM
>      imply PCI_DEVICES
>      imply TEST_DEVICES
>      imply VFIO_AMD_XGBE

What does this actually do ? Why should the choice of
accelerator affect what boards we pull in by default?
I can see why you'd want to disable boards that only
work with accelerators we don't enable, ie don't build
TCG-only boards unless CONFIG_TCG, but this is the other
way around...

thanks
-- PMM

