Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D745C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 21:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8B620657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 21:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVvEgqfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8B620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvoou-0006Py-D3
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 17:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvoo7-0005qv-Fv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 17:19:15 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:44520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvoo5-00088a-By
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 17:19:15 -0400
Received: by mail-vs1-xe42.google.com with SMTP id x205so1865570vsc.11
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Potn9mzcEUjKpDHBj8d/p5FKGcs1ovgdzwYN0zt0NGY=;
 b=RVvEgqfLdM4JAOIel7pUvSo7yD3UETOQfm9TPRl4wZ53zwlm/8qsSEvipJgU8Ikg76
 IXHyaTKP0o5+qQnJilnd8GeSW3e4MI6GEGd1IX9BAVdAXuqKQYz1DbQ68FI7yP8sk+vG
 LowbfzCTzUaSh8zbejaYnoUSuzcUl0iomUXmV8Fs98G2nuNrPZwAk62xqZ5No73/PJBn
 bMnP+S9ZHZuO+VT6LKNjKY6bF445c25AHRX+6w9K05MVFebGTWXdQjDet1KSkqXLLTmj
 W3+JNEJrjxoh6oCS3PS4MxU1gr00yDh9pLoquzeOBSQt/KP1NN1+5Ic3guwTrvRkzV3B
 /eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Potn9mzcEUjKpDHBj8d/p5FKGcs1ovgdzwYN0zt0NGY=;
 b=UumA9CRHw0n0lyVFv5uggX8eIiAwpYCPkLhAPjk01YqOv5G+aQ7UIA0HSvLh3OSeUu
 QXiH9O3T4RUidja3j9yYm5QsvGhWyd40AVFFpbQImG8akYUpUKhkcaam+yBpq9DafN1N
 lenu6Z/ig8iuA/vfWxMKqgg8UDQubYH5f2RPKPQWUBn0q+nOoE4obBVADvEmDRJjNU4q
 RGXRW10cD4p1vmgH1NtSrK87ibRj83d/ZF7rjlpkBOrZSZYUGGgUvTlj84DWicrMoZmk
 +45y1nxPNTJ6II5qURbvK4GTUWMIIxZf8ThpQ4KqyLhytFG1i7kDbNguxHjzgC68b9wl
 FrwQ==
X-Gm-Message-State: AOAM531pJAwamY+XX49XuM1iz7yuFRn1bGioCBOzq+9ZhJs889f+N8Wh
 /fG9AYqazUl9yfbf+3z+haD60RPgd6/NU5DdKQyFwg==
X-Google-Smtp-Source: ABdhPJxyMbQdlKBcQwhGbN7QLN6XToIcm/LWzvKS2eidnU/JpQhZbIBOftDPtwAd9j42ucvCxeOsC4w0u+VZM5fqESw=
X-Received: by 2002:a67:e0c3:: with SMTP id m3mr1006915vsl.1.1594847951732;
 Wed, 15 Jul 2020 14:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <9a1567f0-f13c-326d-460f-6ad167bcf523@kaod.org>
In-Reply-To: <9a1567f0-f13c-326d-460f-6ad167bcf523@kaod.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 15 Jul 2020 14:19:00 -0700
Message-ID: <CAFQmdRY8LaVTRcZG4rPPsVtOY6cK57HT1TT-OGROn1yNfL43pw@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, CS20 KFTing <kfting@nuvoton.com>, 
 Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e42;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 12:42 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>
> On 7/14/20 4:56 AM, Havard Skinnemoen wrote:
> > On Mon, Jul 13, 2020 at 7:57 AM C=C3=A9dric Le Goater <clg@kaod.org> wr=
ote:
> >>
> >> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> >>> This allows these NPCM7xx-based boards to boot from a flash image, e.=
g.
> >>> one built with OpenBMC. For example like this:
> >>>
> >>> IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
> >>> qemu-system-arm -machine quanta-gsj -nographic \
> >>>       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
> >>>       -drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=3D0,format=3Draw,s=
napshot=3Don
> >>>
> >>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> >>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> >>
> >> May be we don't need to create the flash object if dinfo is NULL.
> >
> > It's soldered on the board, so you can't really boot the board without
> > it. But if you think it's better to remove it altogether if we don't
> > have an image to load into it, I can do that.
> >
> >>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>
> >> Nice !
> >>
> >> We need a SPI controller model and a network device model now.
> >
> > Yeah, and i2c, PWM, GPIO, etc., but if you're referring to the kernel
> > crash, see below.
>
> We don't need all device models but fixing the crash would be better.
>
> >> npcm7xx_bootrom.bin is a bit of a pain. Could we include it in
> >> the QEMU roms ?
> >
> > Yeah, I was planning to include this in v6.
>
> Good. It will ease CI.
>
> >> spi_master spi0: /ahb/fiu@fb000000/spi-nor@0 has no valid 'spi-max-fre=
quency' property (-22)
> >> spi_master spi0: Failed to create SPI device for /ahb/fiu@fb000000/spi=
-nor@0
> >
> > This is a device tree bug:
> >
> > https://github.com/hskinnemoen/openbmc/commit/99b172f88002f4fac939f85de=
be1187b9c569871
> >
> >> libphy: Fixed MDIO Bus: probed
> >> 8<--- cut here ---
> >> Unable to handle kernel paging request at virtual address fffffffe
> >
> > I believe this is a kernel bug:
> >
> > https://github.com/hskinnemoen/openbmc/commit/77e9f58ba157eabc976f15fa4=
9892128fe2b2382
> >
> > I needed two additional patches to get all the way to the login prompt:
> >
> > https://github.com/hskinnemoen/openbmc/commits/20200711-gsj-qemu-0
>
>
> Great. So are these for mainline or Joel's openbmc branch ?

I believe they need to go to the openbmc kernel and/or the Nuvoton
vendor kernel. Mainline has none of the things these patches apply to
(gsj device tree and emac driver).

I'll try to send them out within the next day or two.

Thanks for testing!

Havard

