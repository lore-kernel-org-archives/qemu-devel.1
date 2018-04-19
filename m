Received: from eggs.gnu.org ([2001:4830:134:3::10]:57393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bw2-00055t-68
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bvx-0005kU-GW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:57:22 -0400
References: <20180419132026.5494-1-kraxel@redhat.com>
	<20180419132026.5494-2-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8fc65111-4c2f-9e07-3e4a-c95a6d52b29f@redhat.com>
Date: Thu, 19 Apr 2018 10:57:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180419132026.5494-2-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kP2csZIYcM4GbRuLNlJnkdAEM3L3ZRC4P"
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: add qapi parser for -display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kP2csZIYcM4GbRuLNlJnkdAEM3L3ZRC4P
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fc65111-4c2f-9e07-3e4a-c95a6d52b29f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: add qapi parser for -display
References: <20180419132026.5494-1-kraxel@redhat.com>
 <20180419132026.5494-2-kraxel@redhat.com>
In-Reply-To: <20180419132026.5494-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 08:20 AM, Gerd Hoffmann wrote:
> Add parse_display_qapi() function which parses the -display command lin=
e
> using a qapi visitor for DisplayOptions.  Wire up as default catch in
> parse_display().
>=20
> Improves the error message for unknown display types.
>=20
> Also enables json as -display argument, i.e. -display "{ 'type': 'gtk' =
}"
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

> +
> +    /*
> +     * We don't have any dynamically allocated stuff inside
> +     * DisplayOptions, so we can simply copy the struct content and
> +     * free opts without ending up with pointers pointing into
> +     * nowhere.
> +     */
> +    dpy =3D *opts;
> +    qapi_free_DisplayOptions(opts);

That's risky; would it be better to use QAPI_CLONE_MEMBERS() to not have
to worry about if we add a pointer in the future?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kP2csZIYcM4GbRuLNlJnkdAEM3L3ZRC4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYvFkACgkQp6FrSiUn
Q2okGQf/afP7Qpp7Y8rUfXFAJmkSPKUDbGcasIZGdWvLZvg9koCOPe8K66ssNyBT
KTYXHziiJWUc94n58T7imIGtgIxeDeXaImTl+7QQYFX0IvRMVh3b0vA2XJat4niX
qFTqQN/5yv51m+FG3So14lpIfScrCSIA+TDLjbuR5fgizsa2mFqvOQKchMfP9zd0
4lUFTnZoWWWYwVFlKnTtP9tU02XJp2Rw2Nz+XikCgaa3C+14lIGZ3ZbUfb/tfMnW
Oc/hsdpo2XNV4CmK/AaM4qmTZ9hcri/RbR320jVxiFugBBeCWSNgezbxXgNSP5w4
SqYt1yE+OgKLWbeLQ/q/MPR/MqekmA==
=v0va
-----END PGP SIGNATURE-----

--kP2csZIYcM4GbRuLNlJnkdAEM3L3ZRC4P--
