Received: from eggs.gnu.org ([209.51.188.92]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDPm6-0000Dl-Vh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDPm5-00046z-TR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:37:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDPm5-00046B-EX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:37:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so13254990wml.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 01:37:04 -0700 (PDT)
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
	<20190405150438.48c1cc84.olaf@aepfle.de>
	<3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
	<20190405191703-mutt-send-email-mst@kernel.org>
	<20190408082129.5103140f.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b0e145bd-8072-21d2-9cd5-f955ee10e993@redhat.com>
Date: Mon, 8 Apr 2019 10:37:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190408082129.5103140f.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL"
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
To: Olaf Hering <olaf@aepfle.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, ipxe-devel@lists.ipxe.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 ipxe-devel@lists.ipxe.org
Message-ID: <b0e145bd-8072-21d2-9cd5-f955ee10e993@redhat.com>
Subject: Re: [PATCH for-4.0] roms: Allow the EFIROM variable to be overridden
References: <20190405115529.11590-1-philmd@redhat.com>
 <20190405140917.3af9b91d.olaf@aepfle.de>
 <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
 <20190405150438.48c1cc84.olaf@aepfle.de>
 <3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
 <20190405191703-mutt-send-email-mst@kernel.org>
 <20190408082129.5103140f.olaf@aepfle.de>
In-Reply-To: <20190408082129.5103140f.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 4/8/19 8:21 AM, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 19:17:35 -0400
> schrieb "Michael S. Tsirkin" <mst@redhat.com>:
>=20
>> Let's keep it simple: set a config variable, then check it here.
>=20
> Better revert f590a812c21074e82228de3e1dfb57b75fc02b62 and 23858f4092fc=
9ebf9e7a5e5110e44abef6fc6643 for the time being. It looks like a no-op ri=
ght now. How did people get away without the system-wide EfiRom until now=
? It is certainly only a very small inconvenience to build a private EfiR=
om for those who can not possibly receive it from the vendor.

But f590a812c210 and 23858f4092fc are used for ACPI UEFI testing, what
about the v2 which looks "simple" to me:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html

> Also roms/ seems to be unable to receive configure options.
>=20
> Olaf
>=20


--txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlyrCC0ACgkQoqP9bt6t
wN4gwBAAxp0AsAlU3AZV6ZZT1GWgdpzhMnazPiuiuDYUtlxga7wq5FA+j26aWZiz
aOgwM2ACTrtRLQNnK0kz5r64N0tYrRLUqR2eX90WaknOhDyXAwci7GpQh4ofKjdV
s3lIH6dTcJ4Hyuk+24NLrID07bArLhnvQW4ZWKivFhjQKrA1ToGZwWGNa3UbEk2u
Hf2AkXkgXqva9Acf0VHv4Tf5oxMRurE7/AIxSorwAqPG/EcBnINpCwB385HgAe44
mQnjj6//7R8NmTNlNb6r/E6EjYDy3fa3O4m5kYZ30bLzHh0ewTOf8TDXRNmL/GeK
zUaRlCXHB228/UexxYxjrJdt9gvtGaZzhKqbG3dNpXAkOAp3sRvvwkO0MVXaDqQK
UzZwViNR8DopkXd6mSnlGxjnPR1eQE7X6uk5NBgVNfakcN1gDSxGn0zUjA56GFwJ
dlUf7k3xTDtgOSvOp0+5Dr2b/hmsrV1iWtjKn2ozUl1wdPqRS1InGPxA8/u5VR9d
QYc/+VGapG6TmEzgWS1BhdDFEzZ+vdNkbkyJT72Q9g81lV4hxX//nE88TSOsHzC/
x6HzfQYe5zSdEfawJSRJD2FmV5eO+tKPNC+whTXtdpzCWQP7VZ48f8qY4HVxRmqA
S74O07N3IMMpMQQChni626kQ+5mqidtsjyn56ysnFnLd7fJ7ZvM=
=6Wlb
-----END PGP SIGNATURE-----

--txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL--
