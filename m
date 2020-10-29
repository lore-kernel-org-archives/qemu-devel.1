Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC88C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12AA206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kp/esOVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12AA206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY65m-00079L-1r
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY651-0006WI-In
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:26:55 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY64x-0005XL-6C
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:26:55 -0400
Received: by mail-ej1-x644.google.com with SMTP id za3so3306467ejb.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QRAzfMrRGwRRUzvgOK+sY9TBoKY4vb5n/jLZfIZGS5M=;
 b=Kp/esOVLxzC8hZV5EmW0iId5K2OLRxla57GwNICcIHExLz2Z0IYGGqJycjsMgKLnsQ
 mgl8eA9ockct9VNAcX2KdMrjyHG1uYVZ9qcC4SFrJ6RUlhykEGBmC/TnxSxFJNtKl3Eq
 5quuGzl2nouQtfguq5MCX39+OgjYYofga2XkJIg43xQRvlj6idj290pp42xKL9TNEyJo
 1kqs1ffvShu8itFVw+FWcWSNnkT8M38KJiYf9tLU3xvY0SKQ2xxoh+SsnmvLZOQh+9cQ
 Bh+bss6wuj2M3L3kvSnekCT3i/Gt0jcmZh5wmlYFq8F1XXF+D8g1F8xxKXrEyXJe6QGs
 8CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QRAzfMrRGwRRUzvgOK+sY9TBoKY4vb5n/jLZfIZGS5M=;
 b=KPx/jXUwywp/y5jyalmtXXLbcr+22PsC/4Lj3rwWYFoca4mdvM8c1eXPqtuWiIOksk
 7yYAkIQQupkfRkQ/eU6sprisAvkMnU9aRAVVTWnCPCCdYzkZ1LR+RaP3mGt24KTq7ezL
 vKmGbFlvy8bUeA1zk6IkE483eKnXMfPGPj9QYszHK1HO3D27B5o2sQHqXnn3kQTsWhAa
 Q+bnoRQU5W871ZB4BvG69MPXdyCS6uXqtM8hm+syWkZquYBwzdWaH3+os3Av3PR593cI
 OH8LwS1ZDUeXFUGWsRw799uwRbwTG4i3n51yfs66yZNFBCqvSOkPWN+sl/WwRSkPlpBE
 xOJg==
X-Gm-Message-State: AOAM5300B9hBOc/A3V+7cLql5o7clPjsVGObnvtz4dl6L5ExG3P56aMH
 ae+SDtbWAhbchet4pc1QpreCk2LYHfK8wy2LlCK/Dw==
X-Google-Smtp-Source: ABdhPJxdxgui4+HU7+rSp1pNuyS5DPQw7gmSDJuu7ri/xLJzj20fi46cctJRfAvvgI1NB0IhZ3S1cCAr6NuYlvXD5pg=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr3567421ejb.482.1603970805210; 
 Thu, 29 Oct 2020 04:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201028085918.14580-1-maxim.uvarov@linaro.org>
 <CAFEAcA8_1w=4qdE_AJxUP-uPoFL=Fsg9hy62Lw7bLDjKzL9Vvg@mail.gmail.com>
 <20201029111939.GI1664@vanye>
In-Reply-To: <20201029111939.GI1664@vanye>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 11:26:34 +0000
Message-ID: <CAFEAcA8etCVD9QkG8+VNezF_5rX-CMVRV1tSjqwBT04yDvdM_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/virt: use sbsa-ec for reboot and poweroff in
 secure mode
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 QEMU Developers <qemu-devel@nongnu.org>, tf-a@lists.trustedfirmware.org,
 qemu-arm <qemu-arm@nongnu.org>, ard.biesheuvel@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 11:19, Leif Lindholm <leif@nuviainc.com> wrote:
>
> Hi Peter, (+Ard)
>
> Graeme is on holiday this week, and I would like his input.

Sure. There's no rush here, as QEMU has just entered freeze for
5.2, so at the very earliest patches for this feature wouldn't go
into master until mid-December.

> On Wed, Oct 28, 2020 at 20:31:41 +0000, Peter Maydell wrote:
> > A couple of notes on this patch if we do go down that route:
> >  * we would need to arrange to only add the new device for
> >    new versions of the virt board (that is, the "virt-5.0"
> >    machine must not have this device because it must look
> >    like the version of "virt" that shipped with QEMU 5.0)
> >  * the device needs to be mapped into the Secure address
> >    space only, because Secure firmware wants control over
> >    it and doesn't want to allow NS code to reboot the system
> >    without asking the firmware
> >  * it would need to be described in the DTB (and maybe also
> >    ACPI tables? I forget whether we need to describe Secure-only
> >   devices there)
>
> Would it? Could it be something that goes into the virt spec?
> We don't consume ACPI in firmware (but TF-A will of course have access
> to the DT regardless).

Well, for sbsa-ref it doesn't need to go into the DTB. For
virt we mandate that everything is described in the DTB
(and that secure firmware should consume the DTB to figure
out where things live), so whatever power-control device we
come up with would have to be described there. I'm less sure
about ACPI because I think that is used only for describing
the non-secure environment to the non-secure EL2/EL1 code
so it doesn't need to describe devices that aren't visible there.
But I'm not very familiar with ACPI, hence my uncertainty.

> For sbsa-ref, I would ideally like to move to emulating communicating
> with an SCP over time, as opposed to TF-A directly controlling the EC.
> I am unsure if that leaves much opportunity for code sharing with
> virt.

Yeah, that's the kind of complexity that we would want to avoid
in 'virt', I think.

thanks
-- PMM

