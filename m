Received: from eggs.gnu.org ([2001:4830:134:3::10]:46489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOI3-00015a-DN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOHy-0000iU-In
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:36:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciOHy-0000iC-9M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:36:42 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4769F8553C
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:36:42 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e71e6495-f4e3-cd7b-6ef7-d8675196426e@redhat.com>
Date: Mon, 27 Feb 2017 10:36:40 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a0mlfFDwk6wKhrJed0JNhE5tdXCEh5EKw"
Subject: Re: [Qemu-devel] [PATCH v2 02/26] libqtest: Work around a "QMP
 wants a newline" bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a0mlfFDwk6wKhrJed0JNhE5tdXCEh5EKw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e71e6495-f4e3-cd7b-6ef7-d8675196426e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/26] libqtest: Work around a "QMP wants
 a newline" bug
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> The next commit is going to add a test that calls qmp("null").
> Curiously, this hangs.  Here's why.
>=20
> qmp_fd_sendv() doesn't send newlines.  Not even when @fmt contains
> some.  At first glance, the QMP parser seems to be fine with that.
> However, it turns out that it fails to react to input until it sees
> either a newline, an object or an array.  To reproduce, feed to a QMP
> monitor like this:
>=20
>     $ echo -n 'null' | socat UNIX:/work/armbru/images/test-qmp STDIO

I didn't point this out last time, but 'echo -n' is not portable.  On
the other hand, it is sufficient for the example in the commit message,
so no need to change.

>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 8, "major": 2},=
 "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
>=20
> No output after the greeting.
>=20

> Work around this QMP bug by having qmp_fd_sendv() append a newline.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

R-b stands.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--a0mlfFDwk6wKhrJed0JNhE5tdXCEh5EKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtFWYAAoJEKeha0olJ0NqeYIH/2yaCHowppPNTDC7OX/PLtuY
i+fOArSlt8CAd9/EsfpWg9OoqMK91rRhppxIG71UDvPPDyPHlgzX4gRdO3iMGyli
QYxLX9Md5rQgu+Zt2P1OppPA1FHSB2kv64EjYVG65HgoNPCPGieG5UVxGZpezbJn
mn+CQyfCCXrtLQvnlI+QEI38mYa7cLWqyOu/Hynz5FYNeQHGHP7fqQRrJDEmNY1V
iTA3gu7VTrUtqm+/4S+bJyZPuTTljZ4LmERsSeNDrT7iiTYFMwUYLSZeam+JITQv
RqOe6ycqtRKN5JAafc5yq9odQWSIgQ3rAX7qR99u7lG7pOEaIUxLbfPVP6rF8IU=
=OiCf
-----END PGP SIGNATURE-----

--a0mlfFDwk6wKhrJed0JNhE5tdXCEh5EKw--
