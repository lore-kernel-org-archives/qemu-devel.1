Received: from eggs.gnu.org ([2001:4830:134:3::10]:40827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30QX-0007TG-73
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30QS-0002MR-Jy
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d30QS-0002M3-9y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:22:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A16DC05AD7B
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 13:22:39 +0000 (UTC)
References: <194bfbef-efad-0f2e-457c-84533e66fdb5@redhat.com>
	<1493097407-20482-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e95a7963-875b-efa8-95ee-f89bc6151bee@redhat.com>
Date: Tue, 25 Apr 2017 08:22:36 -0500
MIME-Version: 1.0
In-Reply-To: <1493097407-20482-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0xtructkNslgxQ38jXV2S6m8NCmj8vEoi"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests: Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0xtructkNslgxQ38jXV2S6m8NCmj8vEoi
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e95a7963-875b-efa8-95ee-f89bc6151bee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests: Add a tester for HMP commands
References: <194bfbef-efad-0f2e-457c-84533e66fdb5@redhat.com>
 <1493097407-20482-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1493097407-20482-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 12:16 AM, Thomas Huth wrote:
> HMP commands do not get any automatic testing yet, so on certain
> QEMU machines, some HMP commands were causing crashes in the past.
> Thus we should test HMP commands in our test suite, too, to avoid
> that such problems creep in again in the future.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3:
>  - Fixed the stupid "!strcmp() =3D=3D 0" problem

That's why libvirt prefers the use of a STREQ() macro (it's easier to
read STREQ(a,b) than it is to remember if !strcmp(a,b) has the right
semantics).  But switching the code base to use such a nice wrapper
would be a task for Coccinelle, if we wanted it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0xtructkNslgxQ38jXV2S6m8NCmj8vEoi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/02cAAoJEKeha0olJ0NqDR4H/RMsyR3Apnk/RiT5CAJsKsVo
uI/JMjaWrsNComm9TMNpXxpwfbbMlaMrdleItt/fQ+f/1nCLKKDz5KFPcrR/e6K4
F5YXlyQzdFdkH7RLSGVVmdaQlBfk3pEOIi0G3fLLTugamgurLzGL4eMM4zTb1dW5
Ky7DDDysBp7W1LA5/kd4H2GXWrs7K0XA1ccx+Sxj4xwA6TUBL69Sby6X8sYtt0rq
wR9E1y9w0NcKYH2/f6kJdiBHz3hISBn+S3nqYUGQXeFwKcwWXghXjDZjyhKirnXN
rCw0AUnHlxGUD4OtcoL2gI2yFUg4mhTCsOaKhwhHYDldRi8mqrWBa7S9S0rzwFk=
=tr1f
-----END PGP SIGNATURE-----

--0xtructkNslgxQ38jXV2S6m8NCmj8vEoi--
