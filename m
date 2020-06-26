Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31422C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1917206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="jiJhbLzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1917206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joraZ-0005Np-6D
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1jorPH-0000Pl-9y; Fri, 26 Jun 2020 12:40:51 -0400
Received: from home.keithp.com ([63.227.221.253]:44598 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1jorPE-0006Bz-57; Fri, 26 Jun 2020 12:40:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 3A8F13F2CB93;
 Fri, 26 Jun 2020 09:40:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id HjC7WkY8xVCJ; Fri, 26 Jun 2020 09:40:44 -0700 (PDT)
Received: from keithp.com (168-103-152-72.tukw.qwest.net [168.103.152.72])
 by elaine.keithp.com (Postfix) with ESMTPSA id C075E3F2C911;
 Fri, 26 Jun 2020 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1593189644; bh=827LtCAnkoMjc1G3RyVmd76kJUd8NxOWN20ehCqzhGQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jiJhbLzEOAURAG4w0FE3+MqmwdZrmtgKZC09GGHhWmPfZcd+EH28PPBeK5cU3QwoS
 Tj1UUh+60WSNj+MKdoWsdE0FamVSQU8ZMznLL/mZBsOUyZCibunJ38ScvotbEMdDgs
 U8tucww/6MPeAoYqL9YN8MC6RV0BSRDubpKkhSyl6Qa7vmgsuzdQRuk1XF5EcBFAsw
 wSrBq0m9MZbzpN6iJq3qncWRKt6Ii2vCZeAwY173t2zZMYa/Vqp5cP0F6jk8Tky5vG
 I73XxpTKoRWMNOLdg/glodSEvqLaMoz8jVKs/393kYq2rl3BqituKkSyCLhMYyrqyg
 nOv3fIUSeF62g==
Received: by keithp.com (Postfix, from userid 1000)
 id 189111582167; Fri, 26 Jun 2020 09:40:43 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH] hw/arm: Add 'virtm' hardware
In-Reply-To: <CAFEAcA9ut5CVAgRTP-_BK3WpiDSmitFowZMe549TvgSAjj+Kfg@mail.gmail.com>
References: <20200625230740.549114-1-keithp@keithp.com>
 <CAFEAcA9ut5CVAgRTP-_BK3WpiDSmitFowZMe549TvgSAjj+Kfg@mail.gmail.com>
Date: Fri, 26 Jun 2020 09:40:42 -0700
Message-ID: <87imfdixv9.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 12:40:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-to: "Keith Packard" <keithp@keithp.com>
From: "Keith Packard" via <qemu-devel@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> So, I'm really dubious about adding more "virtual"
> not-real-hardware boards. We have "virt" because we
> absolutely have to have it for KVM purposes; but otherwise
> "emulate real hardware" gives us a concrete specification
> of what we're trying to do and tends to lead us into fewer
> messy swamps than making up virtual platforms does.

It depends on what you're using qemu for. I'm using it for C library
tests, where I need memory and a processor, plus the ability to make
semihosting calls and that's it.

It seems like it should be possible to construct a virtual platform that
is limited to just these elements without getting too far into the
weeds?

> For instance, this board model claims to handle the M33
> but makes no attempt to set up any of the TrustZone
> related components like the IDAU, so it isn't really
> a useful platform for that CPU.

It's sufficient for my purposes, if adding those things would make it
suitable for more people, that'd be awesome.

> You also enable bitband, which is maybe plausible for Cortex-M3/M4 but
> not for the others.

Thanks for the bug report; bits of this code came from the stellaris
code, including that part. I'll review the code in more detail to make
sure it doesn't expose any features which aren't supposed to be. That
will catch toolchain bugs which attempt to use features not present in
the hardware, which is critical to successful validation.

> This is the kind of area where having a real hardware system to check
> against means we make the right choices about what does or doesn't
> need to be present.

I have tried every single 32-bit ARM emulation provided by qemu and none
of them offer enough memory along with the ability to select an
arbitrary processor. The stellaris code is the closest as it allows
overriding the CPU type, and I've been able to run most of the C library
tests using that. However, both boards supported by that code have a
small fixed memory size, which isn't large enough to run the full test
suite (the math tests require over 1M of ROM and RAM).

Instead of creating another virtual platform, should I be working on the
existing virt code to add cortex-m support?

Ideally, I'd be able to emulate the full set of configurations that the
embedded ARM GCC port does. I'm currently using the 2019-q3 release,
which offers 18 configurations. Before I included 'virtm', I was able to
test only one of them using the mps2-an385 emulator. With virtm, I'm
covering 11 of them.

The 'virt' emulator should cover the cortex-a7 cases, leaving only four
cases untested (I haven't figured out the right configuration to run
bare metal code on that yet). I can't find any ARM processors which
implement v8-m with DP support, and the only QEMU module with v5te
support appears to be digic, which I haven't experimented with at all.

                Architecture    FPU             QEMU -cpu       Picolibc te=
sts
        ----    -----           ------          ---------       -----------=
---
        arm	v5te		softfp          arm946=20=20=20=20=20=20=20=20=20=20
        arm	v5te		hard            arm946=20=20=20=20=20=20=20=20=20=20
        thumb	v7		nofp            cortex-a7=20=20=20=20=20=20=20
        thumb	v7+fp		softfp          cortex-a7=20=20=20=20=20=20=20
        thumb	v7+fp		hard            cortex-a7=20=20=20=20=20=20=20
        thumb	v6-m		nofp            cortex-m0       yes
        thumb	v7-m		nofp            cortex-m3       yes
        thumb	v7e-m		nofp            cortex-m4       yes
        thumb	v7e-m+fp	softfp          cortex-m4       yes
        thumb	v7e-m+fp	hard            cortex-m4       yes
        thumb	v7e-m+dp	softfp          cortex-m7       yes
        thumb	v7e-m+dp	hard            cortex-m7       yes
        thumb	v8-m.base	nofp            cortex-m33      yes
        thumb	v8-m.main	nofp            cortex-m33      yes
        thumb	v8-m.main+fp	softfp          cortex-m33      yes
        thumb	v8-m.main+fp	hard            cortex-m33      yes
        thumb	v8-m.main+dp	softfp
        thumb	v8-m.main+dp	hard

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl72JQoACgkQ2yIaaQAA
ABGk9BAAswcWC7xbNwvKXVzRsYg4XnYiGwOoORn1bIhqG7lbX/9kxNxhgYPp3mVB
OrVyfhqOWBZmZCaO9WXSlxFu7ZRBaBBM83qvT2jqjO2Nq0/tU96JFmX28ZVgQqz2
6SXmcpQ6W4Ib4Xx65tvJ9LXEy+imGF6oFktfRjHUHGkvuVFt8gad/z5ns0C4G1kP
76h4CXIQXcf6FjZle/xYJ4LTwHvq3BWyi18ywUHoLo5acGBqZ5DxxDlE2d9T/dCV
IpaHB8diOwOPaBM+X6aY3q3kHuwBe8wg/aUhHFSRnG6kYp2wPrdBF83tCs0L5jYG
IOKwdsxrNihgLONW0+9BqSkhCrYs7ojf3HwLtY2/9HS3zsBCRP8X3KTEK93JLZMp
VPwvIDp2y60KqPYxmiIQ6AZk5I3uu3BiMYH5a9yLXSWzXcqkJA5r5G1ISLTnzF3u
fD798LoJHlTJiRnBnCgsRXjU1lBFQv+UKYBWSVMAscL5t+uvz2vqX/VrZ/PT6W+O
mPjO1ql1h90sufAAhCEapk7LrPlYXQH12Sf4Hjx3lbKtJmNGVO0nr41oJ/XDHN6J
6Of61xM1kkWpmnpfupeschSl054mCmO/v5NhzlNzq0i7Zd/nTn1u+Ed7GBzKpLHu
tK+vlpw8J0SNW/Y47vhhuFTs9CR8sLpzSQkSlEdHTdAwHlGUZU0=
=Fg09
-----END PGP SIGNATURE-----
--=-=-=--

