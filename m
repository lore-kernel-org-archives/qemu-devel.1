Received: from eggs.gnu.org ([2001:4830:134:3::10]:38609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecXnt-0004Fk-7d
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecXnp-00056z-3b
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:38:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ecXno-00056N-RH
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:37:57 -0500
References: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <067e772c-b1ce-471c-d947-a60e90a6c30c@redhat.com>
Date: Fri, 19 Jan 2018 08:37:53 -0600
MIME-Version: 1.0
In-Reply-To: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="y0gL3YlibdxxuDWLVvAWa2QGSaVKzDqjL"
Subject: Re: [Qemu-devel] [PATCH] allow to build with older sed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y0gL3YlibdxxuDWLVvAWa2QGSaVKzDqjL
From: Eric Blake <eblake@redhat.com>
To: Jan Beulich <JBeulich@suse.com>, qemu-devel@nongnu.org
Message-ID: <067e772c-b1ce-471c-d947-a60e90a6c30c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] allow to build with older sed
References: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
In-Reply-To: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 01:52 AM, Jan Beulich wrote:
> sed's -E option may not be supported by older distros. As there's no
> point using sed here at all, use just shell mechanisms to establish the=

> variable values, starting from the stem instead of the full target.

Grammar in the subject ("allow to ${verb}" is not idiomatic, better is
"allow ${subject} to ${verb}" or "allow ${verb}ing"):

s/to build/building/

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>=20
> --- a/Makefile
> +++ b/Makefile
> @@ -242,8 +242,7 @@ GENERATED_FILES +=3D $(KEYCODEMAP_FILES)
> =20
>  ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/u=
i/Makefile.objs
>  	$(call quiet-command,\
> -	    src=3D$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$=
$,\1,") && \
> -	    dst=3D$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$=
$,\2,") && \
> +	    stem=3D$* && src=3D$${stem%-to-*} dst=3D$${stem#*-to-} && \
>  	    test -e $(KEYCODEMAP_GEN) && \
>  	    $(PYTHON) $(KEYCODEMAP_GEN) \
>  	          --lang glib2 \
>=20
>=20
>=20
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--y0gL3YlibdxxuDWLVvAWa2QGSaVKzDqjL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpiAsEACgkQp6FrSiUn
Q2pq7QgAgsvbL2SDE/l3IdeE+lnAE0/dvH51xbm9n713sBPVRK1SWhY9/jL1J9mJ
FTib9uM3DcpAuvL4s/vDgXY18S+bal+Y9eoGljpjcB7Fb8HnQ34auiHUQk4FySPw
kHU6DASi0N41U2eEWmNm0sDXWO92UAf9+qhH8gQnS/fpzV6ok5SqpwiJwjGxKmE/
PAaH5H165Krbrrlj7rT94JPMJJsAdjB7D3gZcyJRdUk5tk9OoMOUzV69xWgy1vYg
Q5turvu/sRAldipYHfazRKH0lsPVmXB/TzOvcWdywlBXEaClsQZobuSjAYtBrv2K
Zep2ENk068xbZOv+tVRjHyIPTwHbKQ==
=FX3v
-----END PGP SIGNATURE-----

--y0gL3YlibdxxuDWLVvAWa2QGSaVKzDqjL--
