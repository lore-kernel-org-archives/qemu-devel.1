Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3D8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989F7207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CztX77zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989F7207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1FGS-0006oT-T0
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1FFf-0006FP-9I
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:34:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1FFc-0004jC-0g
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:34:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id o21so4143345oie.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TopSsp2fUc0f/Ix/J3pFrqrf9rKYT2QkqIOI3QpaBww=;
 b=CztX77zyoVY0ugdGySFHiuPuOP8pznYUfyBbkLLs/GmF+bljRgH96xnq28JSsMIAPq
 BI6TXNRCwnnT1ugNsAahnGf5GCzldHlI/qaotBI8VRIJCwKcoV8eGSGxjbnnj0dYAuep
 BXBOda3Eg5aGpXfLoSR16HWLSmS9QwqavM8WxqPjKrgyyoz2/1ztLjIqXHoVz02ZX1BT
 s4qgz0S2SpKWy3mRrMyG89UL1x2d3c6uEMriqCJP2XxgDgGHwftdvn5J9mgKNK0lepD4
 D6nur4c+RtALovcBE77YU/WtLzI1Abf16m8hK99CvtKlVvAXpPLD9Cbuen1S9w5MGRqJ
 eO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TopSsp2fUc0f/Ix/J3pFrqrf9rKYT2QkqIOI3QpaBww=;
 b=mp+sf1Coa/uiii+/XLKtxmAoVh+PWIr49VTHJnNqyl9/enL1eriNW4P37NaeM4RNnk
 oCP8Qj0mVFYPoomMzFhPCIlky1XpRBRiCgl50i+tPpKz4shV23XcERb/GCwydxRmbNOo
 Sw9/K1HO15za/ngXND1pKAtaLaAxHi7IJ4fhDKPoo7VnM1xEOxiXDHm3c4LELuurii1l
 xY/5E7sNXVoX9NPg4QC0Tt8nplmBhBuQ4f2pv9NMc+ErndI0OQG3WIX0uYhu3QBfG7LG
 c1FGlpqprXgOtesujwhd0u6qhISFft78SFJ3qcrct0tWL+a5Dpbyj4K/MYaUtP852Vw6
 j88w==
X-Gm-Message-State: AOAM531IgbO7a9UP41TQREzXv2BvnbvNK4aHz6T/RSIIpSIkW9eTVktZ
 F0jmUYWvgjiQ+njraDWxm8MvUIdLD/DRRi4DIY8B0Q==
X-Google-Smtp-Source: ABdhPJw3ouvam48uueVNE4F4LyJyZyV3ifhL5v9329U6nKouhKMofIRLM3rSna0xc/EJNmy7oA8vaZIs8OxIi9ytc5c=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr577956oib.146.1596141242626; 
 Thu, 30 Jul 2020 13:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200730155755.188845-1-mst@redhat.com>
 <20200730155755.188845-2-mst@redhat.com>
In-Reply-To: <20200730155755.188845-2-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 21:33:50 +0100
Message-ID: <CAFEAcA_Kq3wDbKL_NWTN+DiKQkBGN4yaZ8eZg3J1QYfqU2OKPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/acpi: fix an out of spec _UID for PCI root
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: vit9696 <vit9696@protonmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 16:58, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On ARM/virt machine type QEMU currently reports an incorrect _UID in
> ACPI.
>
> The particular node in question is the primary PciRoot (PCI0 in ACPI),
> which gets assigned PCI0 in ACPI UID and 0 in the
> DevicePath. This is due to the _UID assigned to it by build_dsdt in
> hw/arm/virt-acpi-build.c Which does not correspond to the primary PCI
> identifier given by pcibus_num in hw/pci/pci.c
>
> In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
> the paragraph,
>
>     Root PCI bridges will use the plug and play ID of PNP0A03, This will
>     be stored in the ACPI Device Path _HID field, or in the Expanded
>     ACPI Device Path _CID field to match the ACPI name space. The _UID
>     in the ACPI Device Path structure must match the _UID in the ACPI
>     name space.
>
> (See especially the last sentence.)
>
> A similar bug has been reported on i386, on that architecture it has
> been reported to confuse at least macOS which uses ACPI UIDs to build
> the DevicePath for NVRAM boot options, while OVMF firmware gets them via
> an internal channel through QEMU.  When UEFI firmware and ACPI have
> different values, this makes the underlying operating system unable to
> report its boot option.
>
> Reported-by: vit9696 <vit9696@protonmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Peter can you either ack or merge this one pls?

Since you have the x86 one to do anyway, I'll let you take
this one.
Acked-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

