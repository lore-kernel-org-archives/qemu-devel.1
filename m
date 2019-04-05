Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71350C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3954221855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="X6DN19em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3954221855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCOXY-0007xi-Ak
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 09:05:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCOWg-0007UJ-6Y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCOWe-0001Bh-0Y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:04:57 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::12]:29689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCOWc-00010V-Ae
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554469483;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=wGnSDtFJ6u4mZJFbLeI3raOy4J0c9Ao2FoQWusaac7E=;
	b=X6DN19emUxqv7CPUq/CmaRss+dnvuAxJsjaaWijAJdIoCBIkUuZuz7VkxgVyLFOa0a
	28s2yeOJGQ7YDFLQPhOgHAUUb+fNsDRxFf3/HOytZqZIR5SE2uWqt/S1d9uyftypWypH
	zNdcC0Ualm1AXkK9boCJYzg7nmUJpHTncvt/k8gj6ugnhX07LZ2FTbl/4Li6WwfXLMzE
	aU/p47P6vksbfEbjzCz8J9iLj8l3iaCeWxFPhJbActl/TFd57k0g4katrM6fHAdhm3Uv
	06HtK8HjDvg4WC6gdpyYa76al5NPF8X5ofde5G87JuhhJBN7ElPqti0ihXxQU+oxhSQ9
	vHQQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35D4gqAK
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Fri, 5 Apr 2019 15:04:42 +0200 (CEST)
Date: Fri, 5 Apr 2019 15:04:38 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190405150438.48c1cc84.olaf@aepfle.de>
In-Reply-To: <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/IkYw9CvzDzhQ5joI35eOSp8";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::12
Subject: Re: [Qemu-devel] [PATCH for-4.0] roms: Allow the EFIROM variable to
 be overridden
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405130438.M8SpDwQS3kaXGrlNQIy98iIONKyXMfveYztyBDg7Mp4@z>

--Sig_/IkYw9CvzDzhQ5joI35eOSp8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 14:59:16 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> On 4/5/19 2:09 PM, Olaf Hering wrote:
> > Am Fri,  5 Apr 2019 13:55:29 +0200
> > schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
> >  =20
> >> +EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom =20
> >=20
> > This name is too generic and will conflict with ipxe.git if any of "bio=
s seavgabios pxerom" is used for 'make -C roms'. =20
>=20
> This is similar to commit c9d18c1c150c84e where you said "it used to
> work", what is the difference?

Before there was no need to pass EFIROM=3D to make, so ipxe.git was happy.
Now it is required, and ipxe.git gets an unexpected value.

> IPXE override the EFIROM variable, so there is no change there.

For me ipxe tries to rm $(type -P EfiRom). Let me double check.

> How can I trigger a SUSE package build with this patch?

Not so easy without a VM.

Olaf

--Sig_/IkYw9CvzDzhQ5joI35eOSp8
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKdSZgAKCRBdQqD6ppg2
fmiNAKC4rVOVneYgarSZoWrosXTXEB7NggCeLLgbNwX2QuIFLYYvukYq/rzB1uc=
=yDkZ
-----END PGP SIGNATURE-----

--Sig_/IkYw9CvzDzhQ5joI35eOSp8--

