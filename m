Received: from eggs.gnu.org ([2001:4830:134:3::10]:58947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chP16-0002kj-8L
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chP13-0003YS-0b
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:11:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chP12-0003Xw-QQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:11:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A495061B9C
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 23:11:08 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0dc86fde-5a59-fc7e-1068-4b75f8a22ad0@redhat.com>
Date: Fri, 24 Feb 2017 17:11:06 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FDArCgtQ7vt0lBwUepRHwRrdbJ9mTRdpT"
Subject: Re: [Qemu-devel] [PATCH 07/21] qmp: Eliminate silly QERR_QMP_*
 macros
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
--FDArCgtQ7vt0lBwUepRHwRrdbJ9mTRdpT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0dc86fde-5a59-fc7e-1068-4b75f8a22ad0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/21] qmp: Eliminate silly QERR_QMP_* macros
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> The QERR_ macros are leftovers from the days of "rich" error objects.
>=20
> QERR_QMP_BAD_INPUT_OBJECT, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
> QERR_QMP_EXTRA_MEMBER are used in just one place now, except for one
> use that has crept into qobject-input-visitor.c.
>=20
> Drop these macros, to make the (bad) error messages more visible.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--FDArCgtQ7vt0lBwUepRHwRrdbJ9mTRdpT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsL2KAAoJEKeha0olJ0NqunYH/R4Ow0jwKOg8+COKvw20kAgQ
or6YZRH/6iuPJukOg+/YadHo+4lZXbi/fFiGA/gEwIaDqeCD8V/N9fV+bhPx5R3J
ZHWCLkAiY0HbNOZy3IxAi8guBGBUrVirDkYZcQb4rnbpX74f7shRN1KbTKAer7aW
R5uzXYrWk9L6SrbD4oUednt54CrFAAW0p9xfwC+KMZ7IZ/x0rD6kogqBCT9k5KTS
P4HrQwHq0lb3M3y19c2ozvtArfVtJY1ocwkT6JZepJlu0QUk77r9ER7nuB1tRBny
EJDNj/i+n5L2sMS7VHz5LDW5rDT7ZN7ezGRdtnrsum98QJoNxuhAT0aVWV8pC24=
=Sut7
-----END PGP SIGNATURE-----

--FDArCgtQ7vt0lBwUepRHwRrdbJ9mTRdpT--
