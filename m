Received: from eggs.gnu.org ([209.51.188.92]:57133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hH3Xc-00069R-PS
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hH3Xa-0005cb-OF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:41:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hH3XW-0005Z9-Ut
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:41:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id 4so2012385wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 02:41:05 -0700 (PDT)
Date: Thu, 18 Apr 2019 10:41:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190418094101.GA23876@stefanha-x1.localdomain>
References: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20190416125912.44001-1-liran.alon@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, nir.weiner@oracle.com, bijan.mottahedeh@oracle.com


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
> Hi,
>=20
> This patch series aims to add supprot to migrate a VM with a vhost-scsi d=
evice.
>=20
> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backend w=
hen a
> VM is stopped (As happens on migratino pre-copy completion).
>=20
> The 2nd patch adds ability to save/load vhost-scsi device state in VMStat=
e.
>=20
> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin to =
specify
> it's setup supports vhost-scsi migratino. For more detailed information o=
n why
> this is valid, see commit message of specific patch.
>=20
> Regards,
> -Liran

Looks fine for vhost_scsi.ko.  I have not checked how this interacts
with vhost-user-scsi.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcuEYtAAoJEJykq7OBq3PIEcsH/1vNqde/oYQpzqgvf2wJ4rJz
b6w+NN8o/o25fA3j6+2K6rRhuYwvH5FVb2cZyKEc1bD267NMsx9KmgBwNBk6+Mqc
Q7d0DFxJZILudDOvgp0AQUcSXZxlwPhsFY2lQkKAPccqHNoVGASPrhOGzXLnkZGx
Hjh7MhhiWD6OS6TTkTmzVLM+5DVjSjFystwZuB3u/dVnXIjbIkKwXSCDBr0zDWlF
ON2ieQVwqcKzgrOfDPdgDytAKeIJcnASgn1xv7X7U+YDzjq7jMJceww9SdGSRsgT
QU5DK5wJL344qnP2lmM4tGzSu9IhMiqeLy0wPle4kak5YcpDdqDKMi+pGeW2MHE=
=ZRen
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
