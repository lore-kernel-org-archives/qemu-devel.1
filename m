Received: from eggs.gnu.org ([2001:4830:134:3::10]:38602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gV04d-0006DO-5r
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gV04Z-0007ia-7W
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:16:39 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gV04Y-0007aV-Uh
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:16:35 -0500
References: <20181206084816.30485-1-ppandit@redhat.com>
From: Michael Hanselmann <public@hansmi.ch>
Message-ID: <cba63977-00b9-bf59-480d-402b9c0af4b1@msgid.hansmi.ch>
Date: Thu, 6 Dec 2018 21:16:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181206084816.30485-1-ppandit@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="9m4kl7FA2Vm6BG91BvNw0uwATDIfamP62"
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, liq3ea@outlook.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9m4kl7FA2Vm6BG91BvNw0uwATDIfamP62
From: Michael Hanselmann <public@hansmi.ch>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit
 <pjp@fedoraproject.org>, liq3ea@outlook.com
Message-ID: <cba63977-00b9-bf59-480d-402b9c0af4b1@msgid.hansmi.ch>
Subject: Re: [PATCH] i2c: pm_smbus: check smb_index before block transfer
 write
References: <20181206084816.30485-1-ppandit@redhat.com>
In-Reply-To: <20181206084816.30485-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.12.18 09:48, P J P wrote:
> While performing block transfer write in smb_ioport_writeb(),
> 'smb_index' is incremented and used to index smb_data[] array.
> Check 'smb_index' value to avoid OOB access.
>=20
> Reported-by: Michael Hanselmann <public@hansmi.ch>

Considering that Li Qiang had already published his exploit for a couple
of hours (at the time of writing the URL is returning an HTTP 404 though
I'd seen it earlier) and with the patch being public I decided to also
publish my report:

https://hansmi.ch/articles/2018-12-qemu-pm-smbus-oob

I'd like to thank Prasad and his colleagues at Red Hat for the quick
response to my report (patch committed within less than 18 hours).

Best regards,
Michael

--=20
https://hansmi.ch/


--9m4kl7FA2Vm6BG91BvNw0uwATDIfamP62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENEVC6w7lpobWh8t0Yy8zJpbbY3YFAlwJg5cACgkQYy8zJpbb
Y3ajjQ/9EBfksQBV6m3TYoOLfm7VADKxPCLRTL7/8g7lW6utWfpOln85gWEYARtw
ws/DqDLQrrfjFdj8Wb/JWvJBRV/r9O2ru85aIMCR0fCKj8Bez94VaKrwUgADTyix
W+VfqEPM7pkOsXiGM+drIp6Vr/iNQN2XJADnrMrLwztcjtTrKFeaawIBaVn6G3zz
hP3v3zHJERJeZtdakni7+CcjvK3CAhY4UG51FnvRkYr6t0DUuNTc2UrtFvTXS7Tn
DkL6Ow/L2HlPcj9glGvw8YHataNwwzToEMH0ZyhByZExho2q7/QZL3B7FuMKeNy5
v2J4DWEVOknIkOP/XSL4nRNch6K9n1o7Da9MAYIGxobkG7seGIzu+jM0UeFEL+gC
P6TXPVM7amWJQRaCOePx/O8rwcQFV58/6Mx1OCIJS03QDn/qaBs1hHfnjZgAMIWF
d6JfLnkHpJx64lqxfUHRYUjGtC9ml3h7wFMS6IweoM1poCbv0Jmjj7LsQSLuECCr
j1oNhqZLuVWlwWStfpfUZO7qx7iZPxKPq/UclW3H0doAdKxYzOsCtrtDqQc5fiPA
oXH3342KnAGkwD6w8xHhIjxnJQCul3Dmqtsm2NiDd1bJbMKLvSIqe2d6f+y37O20
V0umjfoo1unoTGI4WuJ9E2DEFQHm+mDCe4jY/EW3hC9xt//mE4A=
=lzkG
-----END PGP SIGNATURE-----

--9m4kl7FA2Vm6BG91BvNw0uwATDIfamP62--
