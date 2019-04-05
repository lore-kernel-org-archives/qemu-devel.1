Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE5C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 12:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F6820449
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 12:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="FX1xSIBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F6820449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNfo-0007sT-PR
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 08:10:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNex-0007bZ-UD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNex-0007Ma-1Q
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:09:27 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::10]:19593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCNev-0007JZ-Qe
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554466163;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=QGbQwWcGSn1cmW0XWUkaPTABhCLJAkBVToAtmgoZsk8=;
	b=FX1xSIBB783FSjotER/drSUNNyHf/MWl8d/Xh/rw1Xt6HkVrorZaQOPUKlag3S3B/H
	fFL64VWwC/TES8oAwJxxTic89qbncm16pYX22g3lBtJ4n+y7do9OwuSY+J1a++BaX7+6
	UEMRh18YQ+9gkoUAZuJajolL0IU2XQCCWLVvhx970bMlTrBnUujxS6xev19hHjfIR5JH
	Ch2oQ9PQRhtryRpFxT3Ztd6V43BmrbQKwfiG6pVgx48on+kIilHRfWBFcZpCiZSC05gX
	OaBxz0hJnXARygjhQwv8Unqxn6BtHxEw9kPBqa9WKn8T65B5RkCfDfGPscX0BBnfdtxV
	npbg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35C9Lpgf
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Fri, 5 Apr 2019 14:09:21 +0200 (CEST)
Date: Fri, 5 Apr 2019 14:09:17 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190405140917.3af9b91d.olaf@aepfle.de>
In-Reply-To: <20190405115529.11590-1-philmd@redhat.com>
References: <20190405115529.11590-1-philmd@redhat.com>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::10
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
Message-ID: <20190405120917.wzaIBI3SZ6wZ5PtsabKS8lnew_ca0L6YMVBWn6dOrYg@z>

--Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri,  5 Apr 2019 13:55:29 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> +EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom

This name is too generic and will conflict with ipxe.git if any of "bios se=
avgabios pxerom" is used for 'make -C roms'.

Olaf

--Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKdFbQAKCRBdQqD6ppg2
fkRNAJ99Ry8ACOCI8Oi3lFj0I4/1FKU9YACgxmjYmn095wUNKBxXZ1EiStfU5Dg=
=tORK
-----END PGP SIGNATURE-----

--Sig_/Qvc=w8aZ/K4qshRZ2RdK2Nf--

