Received: from eggs.gnu.org ([2001:4830:134:3::10]:33118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dELxo-0002YB-V2
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dELxo-0001hm-4C
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dELxn-0001gS-MC
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1BCA753C0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 20:35:57 +0000 (UTC)
References: <20170526202316.22736-1-ehabkost@redhat.com>
	<20170526202316.22736-2-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2c23b1d-49bc-28fd-0ec3-325be33a0a46@redhat.com>
Date: Fri, 26 May 2017 15:35:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170526202316.22736-2-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JQ6CtOu7XSovd0WLu97hLI70kwDm8W3F5"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] tests: Simplify abstract-interfaces
 check with a helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JQ6CtOu7XSovd0WLu97hLI70kwDm8W3F5
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <a2c23b1d-49bc-28fd-0ec3-325be33a0a46@redhat.com>
Subject: Re: [PATCH v2 1/3] tests: Simplify abstract-interfaces check with a
 helper
References: <20170526202316.22736-1-ehabkost@redhat.com>
 <20170526202316.22736-2-ehabkost@redhat.com>
In-Reply-To: <20170526202316.22736-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:23 PM, Eduardo Habkost wrote:
> Add a new type_list_find() helper to device-introspect-test.c, to
> simplify the code at test_abstract_interfaces().
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/device-introspect-test.c | 43 ++++++++++++++++++++++++----------=
--------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JQ6CtOu7XSovd0WLu97hLI70kwDm8W3F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJGsAAoJEKeha0olJ0NqHfYH/10VkcpNb6NOFDoWPYL6LnKp
9CyIGtZLCwOwcJQD6RJGOigk5p0I2c4d5FOlTAepXMdHFwstQJYorM85xj4QNTsP
H/y5dDOt+kqoKuC2kiSjGGPnH/qHGLKQXJW4pKokNV3lMX34xU+nTYJsqpoz1gaR
fJ3AtTyC+14zyXE1ybHI033gvb1kb6X0TLwNd8V4RtCac/aa92Q3bpau3Bn73Gon
+XKY2m70srHfCjg5s7qn1zDJIOsiFBthodp6cG+RhNk816I9CfRukWQdvF8jM5YH
5+/4B98p5QfqS866CheVlZYJpu8d82onV/a3umNBEO3hD/yjyoPkZEv1ZgzfehE=
=35pQ
-----END PGP SIGNATURE-----

--JQ6CtOu7XSovd0WLu97hLI70kwDm8W3F5--
