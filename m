Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30OG-0006Wu-NC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30OC-0000IU-3J
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:20:24 -0400
References: <1493107736-6608-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <336a0e0f-b544-bef1-56dd-66901ec8487a@redhat.com>
Date: Tue, 25 Apr 2017 08:20:11 -0500
MIME-Version: 1.0
In-Reply-To: <1493107736-6608-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ne0o7Lu6kqXb47n9cqKqE08o7lVvXALUM"
Subject: Re: [Qemu-devel] [PATCH] Issue a deprecation warning if the user
 specifies the "-hdachs" option.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ne0o7Lu6kqXb47n9cqKqE08o7lVvXALUM
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Message-ID: <336a0e0f-b544-bef1-56dd-66901ec8487a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Issue a deprecation warning if the user
 specifies the "-hdachs" option.
References: <1493107736-6608-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1493107736-6608-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 03:08 AM, Thomas Huth wrote:
> If the user needs to specify the disk geometry, the corresponding
> parameters of the "-drive" option should be used instead. "-hdachs"
> is considered as deprecated and might be removed soon.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/vl.c b/vl.c
> index 0b4ed52..0980213 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3230,6 +3230,8 @@ int main(int argc, char **argv, char **envp)
>                          }
>                      }
>                  }
> +                error_report("'-hdachs' is deprecated. Please use '-dr=
ive"
> +                             " ...,cyls=3Dc,heads=3Dh,secs=3Ds,trans=3D=
t' instead.");

No trailing dot.  With that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ne0o7Lu6kqXb47n9cqKqE08o7lVvXALUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/00LAAoJEKeha0olJ0Nq3YoH/23ySALBdAH9MuxSJs+Ud0lv
9SFCcE5NKQJUxStDY+CAWnaD8mtwHU6xB0ZkhycRnViZ/waTghb0ZnsJxbJXKN53
YxKJNnARdmW/XgfF8zB0/w9sm3S7aaZXl35ogvYOpiEW3anLCG9VPJFKZJ5wm8E+
t0rwG2sOHtHsjeuJkxDWqVfnpXS2vchXlwC7MBXnLydQrI4sfVOcTPs6oyo7m2vw
wW45E+nksRfhP3ArSB4mqPpK11Ri/kxmts90SkMUjgHnIUe1m2bimaT9gjhEtMWk
qws6ZPgcPvknjP/arG2CBMKOs4qGr1sFEnR7blvbRCrSNjsfTEq9G4+x+IzX6/8=
=Y7xg
-----END PGP SIGNATURE-----

--ne0o7Lu6kqXb47n9cqKqE08o7lVvXALUM--
