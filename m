Received: from eggs.gnu.org ([2001:4830:134:3::10]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWI3-0003dq-Df
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWHz-0003Mi-H6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:28:06 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30cc43d2-f414-ad9f-9fb3-fd4123141d60@redhat.com>
Date: Tue, 18 Jul 2017 12:27:50 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s0wtJvCCLBMsKdHTrOaVekvM18eM963t6"
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/10] block: Use JSON null
 instead of "" to disable backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s0wtJvCCLBMsKdHTrOaVekvM18eM963t6
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <30cc43d2-f414-ad9f-9fb3-fd4123141d60@redhat.com>
Subject: Re: [PATCH for-2.10 05/10] block: Use JSON null instead of "" to
 disable backing file
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> BlockdevRef is an alternate of BlockdevOptions (inline definition) and
> str (reference to an existing block device by name).  BlockdevRef
> value "" is special: "no block device should be referenced."  It's
> actually interpreted that way in just one place: optional member
> @backing of COW formats.  Semantics:
>=20
> * Present means "use this block device" as backing storage
>=20
> * Absent means "default to the one stored in the image"
>=20
> * Except "" means "don't use backing storage at all"
>=20
> The first two are perfectly normal: when the parameter is absent, it
> defaults to an implied value, but the value's meaning is the same.
>=20
> The third one overloads the parameter with a second meaning.  The
> overloading is *implicit*, i.e. it's not visible in the types.  Works
> here, because "" is not a value block device ID.
>=20
> Pressing argument values the schema accepts, but are semantically
> invalid, into service to mean "do something else entirely" is not
> general, as suitable invalid values need not exist.  I also find it
> ugly.
>=20
> To clean this up, we could add a separate flag argument to suppress
> @backing, or add a distinct value to @backing.  This commit implements
> the latter: add JSON null to the values of @backing, deprecate "".
>=20
> Because we're so close to the 2.10 freeze, implement it in the
> stupidest way possible: have qmp_blockdev_add() rewrite null to ""
> before anything else can see the null.  Works, because BlockdevRef
> occurs only within arguments of blockdev-add.  The proper way to do it
> would be rewriting "" to null, preferably in a cleaner way, but that
> requires fixing up code to work with null.  Add a TODO comment for
> that.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s0wtJvCCLBMsKdHTrOaVekvM18eM963t6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluRRYACgkQp6FrSiUn
Q2pi5gf+MChi326PWy6A8HOMEWN0VL2eXwMyxEyndzjzuMIMWNp26a5AolBkYckh
7wOs0v0Fq732/wAZchfJuscXFO+Qv7IdlnRdM7G0Y+G0GHEBSVOVK8tgppr7aYYt
f7mC9XNpghfN1L2hzrNmEgx0Upi6RwhHD8+PHTJ9cfC0szZuukjD/4AJL+v43NMj
JnapvNTklgWXe4MR7gQXf6+MpogMCYZBnxxZBBdQZgdduWSiUf3n+lDbXAWDbufq
y6zXg8MVG67jG60saUceIEoxxQHXvuTzkYYAOi66Nxf1vMVfgOww7ajvO+asnLhp
XgtDcemb7QwT6rtglp0cUBx8VCxAXQ==
=AJZ/
-----END PGP SIGNATURE-----

--s0wtJvCCLBMsKdHTrOaVekvM18eM963t6--
