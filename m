Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2CAC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5546F20883
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="rOOoLJ7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5546F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDNfu-0008Qn-JB
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 02:22:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hDNf6-00089A-48
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hDNf5-0003Uz-2d
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:21:44 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::10]:15443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hDNf4-0003Ot-6U
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554704496;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=RC69ycn+9N8UYmq9ZW6ZwI2Wq0ZMTDb8m9AuIMXnZuo=;
	b=rOOoLJ7NQh/N9Jl8yFtZN7j7lriH5kymUswy61VkYVhUH1y/bl+VEwitDXGfZ4c16F
	lCtSC/PKIYOO4Iwa5isWOTLFcGK+Ly1lK72ghRYt5EqYcD0QNbKIHh9BryvRyBJVXdAB
	69QXHHKKB5jDlsCEU9pB0LqQeS2obt7mwPQebN+a369w4fPz4SQkQJmPaIvLzApRS6z7
	iPkfI5XURn7hgQlfy0chyEQiL6X+vXVlpPMKZjns8yipU/OMA0cTMwUNM4iQW9QWe/DK
	+UF/DkbhOBNm5DUiYLcQVzHF1jC/i6zHbM41F5I11iawqI1cjY9fziymM2JinbTI5qr+
	zh2A==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v386LXx23
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Mon, 8 Apr 2019 08:21:33 +0200 (CEST)
Date: Mon, 8 Apr 2019 08:21:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190408082129.5103140f.olaf@aepfle.de>
In-Reply-To: <20190405191703-mutt-send-email-mst@kernel.org>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
	<20190405150438.48c1cc84.olaf@aepfle.de>
	<3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
	<20190405191703-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/B1aWM0eKGCXgd7+BkdNzIVu";
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
Cc: ipxe-devel@lists.ipxe.org,
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408062129.oh71_poU7r_oNyQgnURx0u97RjUNbZJLeq1CTvhi96Q@z>

--Sig_/B1aWM0eKGCXgd7+BkdNzIVu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 19:17:35 -0400
schrieb "Michael S. Tsirkin" <mst@redhat.com>:

> Let's keep it simple: set a config variable, then check it here.

Better revert f590a812c21074e82228de3e1dfb57b75fc02b62 and 23858f4092fc9ebf=
9e7a5e5110e44abef6fc6643 for the time being. It looks like a no-op right no=
w. How did people get away without the system-wide EfiRom until now? It is =
certainly only a very small inconvenience to build a private EfiRom for tho=
se who can not possibly receive it from the vendor.

Also roms/ seems to be unable to receive configure options.

Olaf

--Sig_/B1aWM0eKGCXgd7+BkdNzIVu
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKroaQAKCRBdQqD6ppg2
fkguAKDk/IxJfhbTevVlX2jyQ3ZhrbEZKwCglcUFMXN07n3n7iJus66+8x77w4M=
=gzcx
-----END PGP SIGNATURE-----

--Sig_/B1aWM0eKGCXgd7+BkdNzIVu--

