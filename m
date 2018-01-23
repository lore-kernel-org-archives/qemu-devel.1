Received: from eggs.gnu.org ([2001:4830:134:3::10]:39799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee45j-0003bR-UF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee45f-0004ml-VH
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:18:43 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e2a54e7-d0d1-34de-f5e8-0a298f86d952@redhat.com>
Date: Tue, 23 Jan 2018 13:18:14 -0600
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qXmNATsrG8j5ypCeNdExi1I2IBLwfnsLC"
Subject: Re: [Qemu-devel] [PATCH v4 00/10] Interactive Boot Menu for DASD
 and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qXmNATsrG8j5ypCeNdExi1I2IBLwfnsLC
From: Eric Blake <eblake@redhat.com>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com
Message-ID: <6e2a54e7-d0d1-34de-f5e8-0a298f86d952@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/10] Interactive Boot Menu for DASD and
 SCSI Guests on s390x
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
In-Reply-To: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2018 12:26 PM, Collin L. Walling wrote:
> --- [v4] ---
>=20
> This round mostly includes some general cleanup to bootmap.c. Checkpatc=
h did=20
> not like any variation of "strtoi", so I properly implemented atoi inst=
ead.

strtol is actually a better interface than atoi (as it can report
errors); but for a fallback code used only on known boot parameters,
implementing the simpler atoi is probably fine.

>=20
>   - itostr and atoi now handle negative numbers (though not necessary=20
>       for these patches, it is available for robustness)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qXmNATsrG8j5ypCeNdExi1I2IBLwfnsLC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpninYACgkQp6FrSiUn
Q2qa4Af/VYPUQZd1P9X8IxhUBaggbTfi8iW5Zsb1PI9BdUzVN4z86RlwrNlAaK3q
ui8G75A8/hM2Pv9naBBawct/WEfEmhCOypIJiSL88RQ9XJAzsDsmr8AAMHwR9FjK
zrCTlaR+UFps1qTZPxpV5Xz9ZgqgCi7psK9gITkfZruDi6gB1OWdjXkJjrqsClqD
BuDrrjpzB/fE0I0hG0DxI3g2MbHNArehn3BytDNWsQ3zhMXGAqSxYPAlSsWjTCj+
nKHJL9lm1m7x39J31avIYVOdFPSL61ZjbkSdYmIWIOEmo4FBaa7xpyCCKAk68z70
F4GcfBSVwljKWl3fbJWs+t+U1faQAQ==
=Oizs
-----END PGP SIGNATURE-----

--qXmNATsrG8j5ypCeNdExi1I2IBLwfnsLC--
