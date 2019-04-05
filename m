Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A919C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B2521871
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="I0kw+uid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B2521871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40341 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNEU-0003ML-98
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:42:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNCc-0000x4-IY
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCN47-0005sB-8n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:31:25 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::11]:23162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCN45-0005YF-J4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554463876;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=w0oUHz4o+C+83dRB2p8Qf8HYsM96nt2n8dwMsGuP7mQ=;
	b=I0kw+uidZnE+xwksqYxD8af3TSpIA+rcpz4Qnkjehz2zUC7TTsoeogSHFnXmjovR0j
	yzofMWnpOqrMHyXpn8eXOWrRkw7iZ3FwtOAvTZiP78MZxKf3VtOhyIhp1/spw7Qd5jB9
	4ozQS1VR0fkcN8e7h4KJv8b4b2abx3Suf9FENAN5nt82rHoupjL5jk6OHUZtlKoEyfaA
	dnh35E9xbrXdvGTRXCHBSoswxESmTM06eIoPdIVvOOtt+9iYzpJ+A2EhDbViotyVOcjY
	dnvM/Rajh3Iw/vWsBrfePnpfKk1FBQzhbHNylQmyJdIq4Q5XTvog28TkPWuunHdx8ntL
	A05Q==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35BVGpWD
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Fri, 5 Apr 2019 13:31:16 +0200 (CEST)
Date: Fri, 5 Apr 2019 13:31:14 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190405133114.485ca24e.olaf@aepfle.de>
In-Reply-To: <b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<20190405131616.071a6390.olaf@aepfle.de>
	<b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/BZMUf3vx_2P/1aun_wF1/QI";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::11
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
Message-ID: <20190405113114.EIhHn9aL-mtyM586kNnl06t_lD7-1vdSkm6ppalNBPg@z>

--Sig_/BZMUf3vx_2P/1aun_wF1/QI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 13:29:44 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> I'll submit that patch.

Can this actually work? It does not remove the naming conflict.

Olaf

--Sig_/BZMUf3vx_2P/1aun_wF1/QI
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc8ggAKCRBdQqD6ppg2
fhouAKCRJ8C+XNoA5yb8mfDilhDtOqRI9ACeMU9AZNCrUzoPq3Aazgi4C7d/+qI=
=yoFY
-----END PGP SIGNATURE-----

--Sig_/BZMUf3vx_2P/1aun_wF1/QI--

