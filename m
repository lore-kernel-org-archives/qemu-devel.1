Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7725C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8E521872
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="a6EHzQoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8E521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNGs-00059b-H6
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:44:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNCp-0000x1-UE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCN0t-0001xN-Ru
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:28:05 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::3]:27492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCN0s-0001e0-1T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554463678;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=7rbZAuZtgfC7TjcGh7awYqvrRBzVaby8B5JrmT1H1Hk=;
	b=a6EHzQoWGcZXIfnJNqNr7JK9bo4J4OnLPlPluzYasoyQYQAnOf7eKyOwrRo4TQxuGU
	TJ4PG8tYA5nE8jOfFeGVmLxc6m8fqUNRPO/j8jygHfuLB3ImtTMCgOWueEPH2lMQ05Km
	B7SO81xwSELrw+VSOkKI/Y4bGOgEtBB+l0HxHeI7567qITdPEsSlAFwXUyCPuulBBWbe
	whk0tqME2N6vMe9inULrDA4Yhkb75c+axf/yONGFDkCd0yGvOeAgvEB75XONi6Y8JlpL
	0o+fv9UyJX5JKlobdWxuHvqUmIcZLP1BDiHVgggrGY7j7JbZC+BgTrVDtuFk98PDalKW
	YaVw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35BRwpVL
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Fri, 5 Apr 2019 13:27:58 +0200 (CEST)
Date: Fri, 5 Apr 2019 13:27:53 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190405132753.6c5f2f88.olaf@aepfle.de>
In-Reply-To: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//xrNmntm2G9FQWJNWZ43hwF";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::3
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
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
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405112753.lQ5ViLpyGwdO6oXUmgueKqxqb0YVBK7D7RZq9K2hyF0@z>

--Sig_//xrNmntm2G9FQWJNWZ43hwF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 13:14:35 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> On 4/5/19 12:59 PM, Olaf Hering wrote:
> > Am Fri, 5 Apr 2019 12:49:15 +0200
> > schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
> >  =20
> >> The EDK2 submodule was added for UEFI testing, you don't need to compi=
le
> >> it to build/use QEMU.
> >>
> >> How did you end up compiling it? =20
> >=20
> > The qemu.spec file has this since a very long time:
> > make -C roms efirom ${unrelated_settings} =20
> I don't have any qemu.spec, is it a SUSE file?

Yes, it is part of the qemu package.

https://build.opensuse.org/package/show/Virtualization/qemu

> > This used to work still in January with c9d18c1c150c84e7a976df989ad04dd=
f01083f46. =20
> Before f590a812c210 the EfiRom tool was not available, now we compile it
> inconditionally.

I wonder why it must be compiled unconditionally.
This is my workaround:

sed -i 's@EFIROM@KAPUTT@g' roms/Makefile
efirom=3D
test -x "$(type -P EfiRom)" && KAPUTT=3D"$_" efirom=3Defirom
make -C roms ${efirom} KAPUTT=3D${KAPUTT}

> So I assume your distribution already provides the EfiRom tool. Can you
> point me at the package which provides it? I wonder if your distribution
> use a non-upstreamed patch that change the EDK2 BaseTools PIE/PIC flags.

It is in ovmf-tools.rpm, which comes from ovmf. And looking at this package,
they also had to workaround the fact that edk2 does not cope with PIE.

https://build.opensuse.org/package/show/Virtualization/ovmf

Olaf

--Sig_//xrNmntm2G9FQWJNWZ43hwF
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc7uQAKCRBdQqD6ppg2
fgMzAKDMEdZ5NGbn7CUZAUgOjvq0JgGlwwCggxo1upLeZMc3Z2pxx95QZxoKiCA=
=Sd/W
-----END PGP SIGNATURE-----

--Sig_//xrNmntm2G9FQWJNWZ43hwF--

