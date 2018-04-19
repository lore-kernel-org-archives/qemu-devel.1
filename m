Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9BM4-00007E-3Y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9BLy-00076b-EW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:20:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9BLy-00074n-42
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:20:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69F888185336
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:20:04 +0000 (UTC)
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
Date: Thu, 19 Apr 2018 10:20:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180419150145.24795-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gDZhtJvR7vnKnH2q0jQgu6hgQj5joJcMH"
Subject: Re: [Qemu-devel] [PATCH v6 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gDZhtJvR7vnKnH2q0jQgu6hgQj5joJcMH
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
Subject: Re: [PATCH v6 1/5] qobject: ensure base is at offset 0
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
 <20180419150145.24795-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180419150145.24795-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
> All QObject types have the base QObject as their first field. This
> allows the simplification of qobject_to().
>=20
> This explicitly guarantees that existing casts work correctly (even
> though we'd prefer to get rid of such casts in any location except the
> qobject.h macros)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

My R-b stands that this is correct from a coding point of view.  But if
I read Markus' review correctly, we could omit this patch, fix the one
broken client in tests/check-qdict.c to use qobject_to() (why didn't you
fix that in v6)?, and then just apply patches 2-5 without this patch,
with no change in behavior and where we are no longer dependent on using
offset 0 (even though all current instances do).  So, I'll leave that to
maintainer discretion.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gDZhtJvR7vnKnH2q0jQgu6hgQj5joJcMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYs6MACgkQp6FrSiUn
Q2rZKwf/ZDplyrJRQNFAVhoXKP8RvZljOlhUhkLcMCm0VafntTzwA24+prS1sY1c
WDAeZV2ZxQQ9abvZCxTWH3mOIplcwUUkBzbMnavZxmhl4kxtRSj8IMny+DJo5vvU
qwDR6YJz+fu/k6vZcsLd7Ou7gcreCgr7ZhsSRP9kPe1D37zC32VHyVjy+lQxO3Y5
DD5ZAS0u5ZDEhtCTJmfhj/2dX6JK7nolfxne32Et6EdCxqc8K37YPUBUwcM9ytbw
qYA34v0+Du7/Rh1frJDCW8Uf5+eLVdp5rU11ckedQv69Vhb1gbvpoHZtu0GZcWX2
ouuEi2sHIK92IW6zARlvyq4Sn+bu+Q==
=qB9H
-----END PGP SIGNATURE-----

--gDZhtJvR7vnKnH2q0jQgu6hgQj5joJcMH--
