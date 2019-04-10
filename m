Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5141CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 06:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163DD20850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 06:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="RnAML9Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163DD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE6hR-0000Wh-Ah
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 02:27:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hE6gg-0000Cc-8z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hE6gf-0003PI-BC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:26:22 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::6]:26583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hE6ge-0003La-Jm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554877572;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=Xakrn9RpdUpwqnmuOue1ThsyA1OqNPZO5Hkl1C+36hA=;
	b=RnAML9IroE3UT5GnWgtzdNONTC1PQg30lUv96rjkAfJCSO15/pGyKdLtIOp7BBFRtx
	qNyTOhzmIzZZ3n209LzRJDp1rmv59lOtrK01pbtsbbNys2ekKKJP8QtSgDScezfiKr4S
	AqotVdEQGpfuDZ4EKmNYkC/wmh/QlSLhySCNXDGy9hJ7eOvucWQFnxP+FBHrKThudibD
	8CvLoTK8YLqf6e6xmu5OF23mqo0mt1pT1D5lojc8DLB05cHGZstE02SmcvUy9j2x6+rn
	1hRFP5poRdjqbrPl8cxBGJAtmtDyHJie/T//4jQ3Cuyd1LyQC+RwUx5eTQTgTYnvwdRG
	FcaA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC44eztn93Z9OGdNZkQhh"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
	with ESMTPSA id 60a847v3A6QB3ju
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Wed, 10 Apr 2019 08:26:11 +0200 (CEST)
Date: Wed, 10 Apr 2019 08:25:54 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190410082554.6c595b3f.olaf@aepfle.de>
In-Reply-To: <fbf6f219-4821-67be-27b2-42a0bad9746a@redhat.com>
References: <20190405153314.2068-1-philmd@redhat.com>
	<20190405153314.2068-3-philmd@redhat.com>
	<fbf6f219-4821-67be-27b2-42a0bad9746a@redhat.com>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qpQU+wBOGMTWT_9aY1lUNlz";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::6
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 2/2] roms: Allow the EDK2_EFIROM
 variable to be overridden
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410062554.DkJnCcdKFP3ie9uYx4cgV61z6EI_JR_a4GEhGtX5Ui4@z>

--Sig_/qpQU+wBOGMTWT_9aY1lUNlz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 8 Apr 2019 13:05:07 +0200
schrieb Laszlo Ersek <lersek@redhat.com>:

> Then build scripts could be updated to invoke:
>=20
>   make -C roms \
>     EDK2_BASETOOLS_OPTFLAGS=3D'...' \
>     EDK2_BASETOOLS_LDFLAGS=3D'...' \
>     efirom

The question remains: 'But why?'.
Why can edk2 not be built with '-fno-pie' right away?
Did noone approach the edk2 developers yet that their buildsystem is broken=
 in that regard?

Olaf

--Sig_/qpQU+wBOGMTWT_9aY1lUNlz
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXK2McgAKCRBdQqD6ppg2
fmXLAJ9CZLvvfEoP6rZsnG8NA75pbyL4KgCdHDh8gIwoZ5ox7oeOoLCUrzfRygc=
=m8/g
-----END PGP SIGNATURE-----

--Sig_/qpQU+wBOGMTWT_9aY1lUNlz--

