Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498BCC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 00:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F5720737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 00:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="DEwnZFyE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZaJIXMvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5720737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKAWL-0007ty-3R
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 20:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1jKAVi-0007PO-AY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 20:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1jKAVh-0004u7-6g
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 20:48:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>) id 1jKAVg-0004lh-Mk
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 20:48:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id E682C5C02EE;
 Thu,  2 Apr 2020 20:48:34 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Thu, 02 Apr 2020 20:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm2; bh=l1cXe
 2bVpaiepOWEl4UHhrUYeTQgpbanp1Eg0szXH8A=; b=DEwnZFyEeYU+xWdHS8Dv8
 umbf2eiZlLl+DTCvA69LIu/W/qfV3Z2aJY7rY1phicxAdJ5nhUCKqLB42abp2wRY
 3GvySJq6DefOQHZt4SXkGTp7CMqDHMUzDti84WJFg2NBYKA+HMaxGZOj9uuCo5B0
 tsBBOHTyH4Yy05PDC9oIxPiR6zPwquXkR6h+oSIS1yEqclqhPjRYXEfk4Np6Bdkb
 nxPonbTFfEBvDgNjNm3bowPU5gNCQBKLaA4eOjoy981LBHGug9kaXts00x2URm4p
 dIdRe4D+F+afvxEJD1NJR8dn1cNQcAOFlQVAsMxHxsiU1WDTg1GDmMoy7GVdU8eb
 g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=l1cXe2bVpaiepOWEl4UHhrUYeTQgpbanp1Eg0szXH
 8A=; b=ZaJIXMvQTfkRlj5nyBliOXQVej+CUi4xdiYBkWNacCUf7gSMAGi7LF/ao
 YQYgYAnfSp2u1eZ0ofZuxfs/9tfc2Cp7NzQLIttdsi9bGnIrvCpew/C0wqUFPMWn
 NJ6L1ioZ8ghQcXK5v7E4XnzrSI7/xAoHY2aP26ZntQUHj3bPoXlc8sDQW/E9drD2
 0iqCifSaqY60PPg2b5nbbbXalGlP0BmywPQn7PucDTQM/RPS0hXlopkNLWdtX410
 mC28V2F44s/lTDp5EnHID63EeQxn9KcegajtqTpczucGb07HeqlfEwceu7vraS9A
 k6cOYScKAy4Exy8Dgf6CTpv8mrZWw==
X-ME-Sender: <xms:4YeGXg9NLzigVuMXVeHsnX2nxE-tPt-h4lzI5xrLrYDJw4SHNfW0JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdehgdefjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomh
 grihhnpehmrghilhdqrghrtghhihhvvgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifse
 grjhdrihgurdgruh
X-ME-Proxy: <xmx:4YeGXv16UupFXOcGxOWHuF60-jmRkf5SWsP_pp-L3DtZbqTMLYbjpA>
 <xmx:4YeGXoYotJZuqK_KxpmEpmva2ExxY5TqUI43v4bsq0bOdKqKk0lWtA>
 <xmx:4YeGXqKPBVSrvJZC662Fwyp092gOzp0MRt989U9vVDUPDP3hxymi6g>
 <xmx:4oeGXrZWG0qJsfRvpVxOOyDuQeLxoGvfzsk5ZnkJ4MO3sXXZKuZo4Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C4C5BE00B9; Thu,  2 Apr 2020 20:48:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1080-gca5de7b-fmstable-20200402v5
Mime-Version: 1.0
Message-Id: <dd8fc1f7-56d9-4d9f-96a4-0fdcafdc8f55@www.fastmail.com>
In-Reply-To: <2c04ba56-436d-354b-512e-50c9d995b702@kaod.org>
References: <20200330214444.43494-1-dirty@apple.com>
 <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
 <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
 <ad609899-d544-f660-6784-5fe5cdc2bf21@redhat.com>
 <2c04ba56-436d-354b-512e-50c9d995b702@kaod.org>
Date: Fri, 03 Apr 2020 11:18:54 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Cameron Esfahani" <dirty@apple.com>
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.28
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
Cc: Robert Mustacchi <rm@fingolfin.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani via <qemu-devel@nongnu.org>, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wed, 1 Apr 2020, at 21:53, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> On 3/31/20 1:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 3/31/20 11:57 AM, Cameron Esfahani wrote:
> >> Philippe -
> >> =C2=A0From what I've seen, access size has nothing to do with align=
ment.
> >=20
> > Yes, I was wondering if you were using unaligned accesses.
> >=20
> > I *think* the correct fix is in the "memory: Support unaligned acces=
ses on aligned-only models" patch from Andrew Jeffery:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg461247.html
>=20
> Here is an updated version I have been keeping since :=20
>=20
> 	https://github.com/legoater/qemu/commit/d57ac950c4be47a2bafd6c6a96dec=
2922c2ecd65
>=20
> which breaks qtest :
>=20
> 	microbit-test.c:307:test_nrf51_gpio: assertion failed (actual =3D=3D=20=

> 0x01): (0 =3D=3D 1)
>=20
> I haven't had time to look at this closely but it would be nice to get=
 this=20
> patch merged.

Second this! I never had the chance to circle back and fix it up.

Andrew

