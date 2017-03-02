Received: from eggs.gnu.org ([2001:4830:134:3::10]:53564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjWOy-0007s8-NS
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjWOu-000858-Jm
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjWOu-00084X-BY
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:28:32 -0500
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
	<1488479153-21203-2-git-send-email-felipe@nutanix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26656b88-ca65-33a4-aecb-fdca32c6ca65@redhat.com>
Date: Thu, 2 Mar 2017 13:28:29 -0600
MIME-Version: 1.0
In-Reply-To: <1488479153-21203-2-git-send-email-felipe@nutanix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ksiwQ1im4pr0DVPfAdrlGEhF6jdSvpdoV"
Subject: Re: [Qemu-devel] [PATCH v5 1/4] libvhost-user: replace vasprintf()
 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ksiwQ1im4pr0DVPfAdrlGEhF6jdSvpdoV
From: Eric Blake <eblake@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <26656b88-ca65-33a4-aecb-fdca32c6ca65@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] libvhost-user: replace vasprintf() to
 fix build
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
 <1488479153-21203-2-git-send-email-felipe@nutanix.com>
In-Reply-To: <1488479153-21203-2-git-send-email-felipe@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 12:25 PM, Felipe Franciosi wrote:
> On gcc 3.4 and newer, simply using (void) in front of WUR functions is
> not sufficient to ignore the return value. That prevents a build when
> handling warnings as errors.
>=20
> libvhost-user had a usage of (void)vasprintf() which triggered such a
> condition. This fixes it by replacing this call with g_strdup_vprintf()=

> which aborts on OOM.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-u=
ser/libvhost-user.c
> index af4faad..61e1657 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -81,7 +81,7 @@ vu_panic(VuDev *dev, const char *msg, ...)
>      va_list ap;
> =20
>      va_start(ap, msg);
> -    (void)vasprintf(&buf, msg, ap);
> +    buf =3D g_strdup_vprintf(msg, ap);
>      va_end(ap);
> =20
>      dev->broken =3D true;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ksiwQ1im4pr0DVPfAdrlGEhF6jdSvpdoV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuHJdAAoJEKeha0olJ0NqRCcH/26H9NAPDIjFbEZKjVKfmVmX
+zRllOlcSebRlQMONYvMZFO8YQN6qfxT7PcoAq/SkNcGLfyVsExm5CU4AO3z3rYJ
pA1MNMhl0pfCnXAoZy9BZksbiiN8SODuJj2D+TFx6YQxb0LOAJLNiHth50ZwMCHb
dsCcXvl2LIwQxi+vizWwxXtMnjqX5Hqw8XFMvmvyPrg0mQDFgmugGQiIg0UMms0k
YpzNCrgDCdUkwY7piWiCS1jVIS4bsF0on53t9bc//IQgk5FTpr5vIEDA9ac4cjfg
/bKtAQMM5KBJLqJImvgDB8Y55IAIxMXKpWCl3pjFCzfe96pnXG6VbHBHaniqiqY=
=ERCJ
-----END PGP SIGNATURE-----

--ksiwQ1im4pr0DVPfAdrlGEhF6jdSvpdoV--
