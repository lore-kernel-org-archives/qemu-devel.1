Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F04C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C338E2186A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="JEUHgeek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C338E2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCMqh-0003L3-0t
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:17:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMpf-00033D-Pe
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMpe-0003Y7-Sa
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:16:27 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::10]:8830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCMpd-0002zH-J7
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554462981;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=bFZNxBbj8tEZ2zKrDbkvy3eDYtNwMxVVjFHRHJsTAQ8=;
	b=JEUHgeekbKXQDiqA0xPMLYJ4PMybjOA2vXGviIemwiiLk5XAkhS1l6mA3jMXdNwvI9
	+UsNtleh5ZDzomP6VpxBfF0eiVCN7+07ArcxmjAMRPUKI4jmiCzEZbQK4ChNn2SB1UAs
	DUCN+OkI6xXzvvltGsc4nHYFJhW2hAJQTMPX/FBe9OIRZkKmKkG02veUGawlLIQhFBgr
	JLssQlKJWKChLD9Tam/Ze2UeoGgans9GbfMmRniDD123MMs9Tdj0ipFtaBtPY8OAjSMp
	Z/QSS+Q8NEt/Ga8yHvf2KC+YG+Y0GEuOiqXqav0c0OkXZBPOWisGrESE0iD2WmvtI/r2
	JpFw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35BGLpSF
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Fri, 5 Apr 2019 13:16:21 +0200 (CEST)
Date: Fri, 5 Apr 2019 13:16:16 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190405131616.071a6390.olaf@aepfle.de>
In-Reply-To: <20190405125918.462c6ae4.olaf@aepfle.de>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//HIIvx4XHusNlIL9qTMU16i";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::10
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
Message-ID: <20190405111616.XSgNLkLEIuKqLngnUPo2svs4YLOQIAb8Iw65M0enVak@z>

--Sig_//HIIvx4XHusNlIL9qTMU16i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 12:59:18 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> This used to work still in January with c9d18c1c150c84e7a976df989ad04ddf0=
1083f46.

It is not possible to just override EFIROM=3D$(type -P EfiRom) because this=
 variable is also used by ipxe.git.

Olaf

--Sig_//HIIvx4XHusNlIL9qTMU16i
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc5AAAKCRBdQqD6ppg2
ftktAJ9zGqkhztmcHlXyz4W069+m22o9GQCg2h5J+QdpJX+j1Y9YTfdceAg1Oi8=
=EMC/
-----END PGP SIGNATURE-----

--Sig_//HIIvx4XHusNlIL9qTMU16i--

