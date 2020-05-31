Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B6CC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39BF20723
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gh/yOzBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39BF20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfTxd-0003jF-2P
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTww-0002xR-RW
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:48:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTwv-0006hM-Kb
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:48:50 -0400
Received: by mail-oi1-x241.google.com with SMTP id a137so7277195oii.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ILaa0c1UMVCHaphm0DdLpskuHaCCEchvE3UnkzWKwTU=;
 b=gh/yOzBvDIyuIfovF4HlMlYod16q8wUChDeH3hG7Vg+iTSHsq68cyaZOlaiNPIf9US
 ygkjSaJT2vmqdUJQIEGlL8gV2MtXWHco1mZIOuO5KiIKQs3G5nr+4EVe214ZZXeEv7t2
 BrAvP75A4QrCdtXWHeTAoOJNw5pvGzbuC2G/kLi877DgbTs+y3Xd2yQqelINQ+/4seCD
 JnV4TjmGBJgF8NzHohYqz7Kn6m0rIYAsc00stNMZ+W0zNNKTer3Nbo9C6s5802r+PVaz
 RvSVWI8S5dnalEPSFqzdJ82hUjtjWbzfyTWqx+oNh8fIgRphvyytYus3c9E04tDW/7Xd
 ywBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ILaa0c1UMVCHaphm0DdLpskuHaCCEchvE3UnkzWKwTU=;
 b=DSFNBGr26p/V8bhWZswhQpRLoFTbfJYnYwRtaUqq1LHuMEIByCI+JnIKnoTpGDb5ie
 IeGiSbtXYO4DUmbxv0R/gTALDQE4igCZAwlOV5eY6iBp0fyE4RcAgvH1eaAQ7xiaZ7ZN
 FJDWzlethl7QI2dIR9O4h5NXEjd7+nFbG7gts2CYtDKAds3h8/Fq8/3QFk3eHVJI+H6/
 BWSVuCjd4S88rfOgN7ywim09E8j2fzUDdGC8NBQVLuatkHciBO1mixGXf/TKOwYXqBTG
 xaEmREAqWg7syBBkwWSAqBTLvusf0VsO74xtTcrULIJWmvask4GFx+BVZgBgFdoagTgQ
 as0A==
X-Gm-Message-State: AOAM5304wuxxJnZeMWp2f3rKDc1t7LX1FvS5VIlY6PWxObI2L9oF0h2d
 p6DFLq8FCIzw1z7k0ww8SGMYcwGI5e2RAERMQYaBIQ==
X-Google-Smtp-Source: ABdhPJxKeNN10qTHbz3+NODuq1ECUVF+14p38NKGTSU2wB+Fz1ZTvl0ES71h3qOGWCxhFj3oAr/7710lgqqoniYFZ4Q=
X-Received: by 2002:aca:5451:: with SMTP id i78mr7136005oib.48.1590954528355; 
 Sun, 31 May 2020 12:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200531173814.8734-1-f4bug@amsat.org>
In-Reply-To: <20200531173814.8734-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 May 2020 20:48:37 +0100
Message-ID: <CAFEAcA95OLKmG1xNVjAg_KPt3hfN4vT5wvZ6SJbcKk5zdYO_Gg@mail.gmail.com>
Subject: Re: [PATCH 0/8] hw: Fix some incomplete memory region size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 18:38, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> memory_region_set_size() handle the 16 Exabytes limit by
> special-casing the UINT64_MAX value.
> This is not a problem for the 32-bit maximum, 4 GiB, but
> in some places we incorrectly use UINT32_MAX instead of
> 4 GiB, and end up missing 1 byte in the memory region.
>
> This series fixes the cases I encountered.
> Also included few patches while reviewing, I replaced some
> magic values by the IEC binary prefix equivalent.
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (8):
>   hw/arm/aspeed: Correct DRAM container region size
>   hw/pci-host/prep: Correct RAVEN bus bridge memory region size
>   hw/pci/pci_bridge: Correct pci_bridge_io memory region size
>   hw/pci/pci_bridge: Use the IEC binary prefix definitions
>   hw/pci-host: Use the IEC binary prefix definitions
>   hw/hppa/dino: Use the IEC binary prefix definitions
>   hw/i386/xen/xen-hvm: Use the IEC binary prefix definitions
>   target/i386/cpu: Use the IEC binary prefix definitions

whole series:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

