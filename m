Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F98C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4EC217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="g+mMv65O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4EC217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCMZy-0007Jn-8Q
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:00:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMZG-00072p-HJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMZF-0006nI-Je
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:59:30 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::12]:10938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCMZE-0006jA-Ap
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554461964;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=UOHor8g6tmFA/HlkerAcoQmj8Hv3UMm+KlMIWr6A/0Q=;
	b=g+mMv65OiktvKTRNpGx6xt/kBRu0FzUQgfzmHqv3jYJSviIRzZ1lw7asj6vjhtX9MH
	UtzF57MF+WV9zfPGyyuTHblDuY82D+RltTMcbMH1hlnAcpt9Pk2Hu/NASGPAZ/GTd2wj
	jmzpzzO1tZ6ksunA548GN5NEyqCsz1QyoQHKar5OVdEOVRywSC0HlCNZ7jeUXVCVpkfh
	lgiPvWOD870Iaisf4NpR7DeH2ibb0hjhBtUHIBP002PV1UyjDLa1Wbagfb0XmQHXyWTU
	CYshAfyYseBtEwXg3TdCzBB/Wa9KwDX5rsqrILnBWI0nz87aZGF2GHNsNmc47Pp0eE8W
	JJww==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35AxNpNn
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Fri, 5 Apr 2019 12:59:23 +0200 (CEST)
Date: Fri, 5 Apr 2019 12:59:18 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190405125918.462c6ae4.olaf@aepfle.de>
In-Reply-To: <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qxyv.yX5szkNIorp2b5/mpZ";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::12
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
Message-ID: <20190405105918.gQHGtP-_epPL75eVc7HO3_rqGKOs1VkfGI7-FDlKcRA@z>

--Sig_/qxyv.yX5szkNIorp2b5/mpZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 12:49:15 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> The EDK2 submodule was added for UEFI testing, you don't need to compile
> it to build/use QEMU.
>=20
> How did you end up compiling it?

The qemu.spec file has this since a very long time:
make -C roms efirom ${unrelated_settings}

This used to work still in January with c9d18c1c150c84e7a976df989ad04ddf010=
83f46.

Olaf

--Sig_/qxyv.yX5szkNIorp2b5/mpZ
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc1BwAKCRBdQqD6ppg2
fh9/AKCQYcL7VuEatSXVQcwVI1TsBd2BfwCfdsKy0MYdn/CCqZD6biEzttKfq5o=
=yysl
-----END PGP SIGNATURE-----

--Sig_/qxyv.yX5szkNIorp2b5/mpZ--

