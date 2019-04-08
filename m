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
Date: Mon, 8 Apr 2019 08:21:29 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190408082129.5103140f.olaf@aepfle.de>
In-Reply-To: <20190405191703-mutt-send-email-mst@kernel.org>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
	<20190405150438.48c1cc84.olaf@aepfle.de>
	<3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
	<20190405191703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/B1aWM0eKGCXgd7+BkdNzIVu";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-4.0] roms: Allow the EFIROM variable to
 be overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, ipxe-devel@lists.ipxe.org

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
