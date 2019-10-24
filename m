Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51BACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C4721906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7LBe6S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C4721906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdGT-0007tL-Dl
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNbfW-0006e4-3d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNbfU-0002H9-FV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:52:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNbfT-0002GL-SP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:52:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id s22so20368849otr.6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yc2rcnVA2Lk9wwG5059ptOPuD0SUyeMds9j2vZiOKLc=;
 b=n7LBe6S0xgI9UQr1nzYKxNUZioAcah8IYI0SKUFwbmNKSDtwMSRsRMSaXt3d7gDT1e
 qPwnPp7UQvI92ca6jqsEqsi0avZM2vTvW8pEOdZNC646vSrly5dlyhE1eUZ1vLAC4R9O
 4KdPxuz3PsYoYrZbCfA7TKiBuVD+dV36cI3p+7BaMnH6UjLcbrO+P6lyhzBekLdixsdI
 ACzgaEPeYh2CxtZbaPWWDtxXmWR5Fgtc6TP24Q7PRp+2P7XccSPqP1gl9STVNFz/wxCC
 zknGrHDXdz1gaDR+MKP+H5DEqRK6D5sECNZx8SJABELAsm50d8v0SxoQ4wHTjom2vWiD
 8gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yc2rcnVA2Lk9wwG5059ptOPuD0SUyeMds9j2vZiOKLc=;
 b=JxajM0Na4z8ugaFFx0T7UohYTixbv0Yaj7lIWIKt6tSvWAXsJYakiCXC2vIuN80uId
 P4sgfxJstRGp3DHrQkuocYPNuLRXSBnleCRizgIgQv7zIib+vnHt4D/5CRAHZd1k4503
 4alHErvXEOxStpI5uY6Ifh8ERZEua6BsweT0bVtLboo0v8J9JIxJyQ1z4E2chUoB5EUm
 LzYWgQUVMmJD7F8EL0yOlozC+6HqQT+suVTiEnPyvWYGhOx4ko5tezrCncAQ4z8ZmY1n
 GFNCWX7hkArtN/KtHXLJ7f0c1vWn9EkwGX7ai9byE81dRNvFUn41gtXp4d5bQ6QEgvVs
 T41Q==
X-Gm-Message-State: APjAAAWaOxq+hNdpbqAdxEoN25CCqzyPHmGSZJWJIVmNnhIlcpc9MGRb
 zlP5NotQEMl8FIKMTUuEpcnrYEdna4AaIMpElTWmfg==
X-Google-Smtp-Source: APXvYqy/KMDJ97bmnGus3jcWeHgoJKHhbzvdzJw1X9TWGl4nD3QzwGegpEInEnCw/F78+l9frsTVJqU/udT4SrEZ3xg=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr10728093otb.97.1571917958865; 
 Thu, 24 Oct 2019 04:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-22-marcandre.lureau@redhat.com>
 <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
 <CAMxuvay9kroZUo7ZbdhJqKAdp52rMmLGv0LBvktb68B2CKg+Mw@mail.gmail.com>
 <2b9352d7-f4de-bd5c-62c5-cebec79e1c48@redhat.com>
In-Reply-To: <2b9352d7-f4de-bd5c-62c5-cebec79e1c48@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 12:52:28 +0100
Message-ID: <CAFEAcA_A4edo3fQBJux6QBxkCf_r_EdrmYgv5OPidWDdn4aD8g@mail.gmail.com>
Subject: Re: [PATCH v3 21/33] lance: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 12:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Just wondering, if we had a "bus_address" property to the abstract
> SysBus class (and eventually "bus_name" for later) we could create/map
> sysbus devices from command line?

I don't think this is a good plan -- users shouldn't have to know
about the memory map of their boards. Plus it doesn't deal with
the complications of multiple address spaces, DMA, wiring up
irq lines to an interrupt controller, SoC reset handling,
clocks, power-managment...  Command line -device was designed
for pluggable devices, where in the world of real hardware
the device can be physically plugged and unplugged and there's
a clear interface that can be modelled. You can't add an
extra UART to an embedded board in real hardware either.

The only plausible argument I've seen for command-line
plugging of embedded devices is as a sort of side-effect
of having a configuration language syntax for them for
the purpose of being able to write board models as
data-driven config files rather than in C code. But
that would be a lot of design and engineering work, and
if we want that I think we should approach it forwards,
not arrive at it backwards by adding gradual tweaks like
'address' properties to devices.

thanks
-- PMM

