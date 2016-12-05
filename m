Received: from eggs.gnu.org ([2001:4830:134:3::10]:54858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE0X6-0000OD-98
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE0X1-0000Dp-8y
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:10:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cE0X0-0000Dc-Oz
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:10:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD3DE61B96
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 21:10:37 +0000 (UTC)
References: <1478105438-20883-1-git-send-email-prasanna.kalever@redhat.com>
	<1478105438-20883-2-git-send-email-prasanna.kalever@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fcfed634-f073-4fe9-ff90-c3ae09b0dec3@redhat.com>
Date: Mon, 5 Dec 2016 15:10:32 -0600
MIME-Version: 1.0
In-Reply-To: <1478105438-20883-2-git-send-email-prasanna.kalever@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PoVqEgVQvw9D5lpRj1FURGRBsLTqmXJs0"
Subject: Re: [Qemu-devel] [PATCH for-2.8 v3 1/3] block/gluster: fix QMP to
 match debug option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com, vbellur@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PoVqEgVQvw9D5lpRj1FURGRBsLTqmXJs0
From: Eric Blake <eblake@redhat.com>
To: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 qemu-devel@nongnu.org
Cc: jcody@redhat.com, vbellur@redhat.com
Message-ID: <fcfed634-f073-4fe9-ff90-c3ae09b0dec3@redhat.com>
Subject: Re: [PATCH for-2.8 v3 1/3] block/gluster: fix QMP to match debug
 option
References: <1478105438-20883-1-git-send-email-prasanna.kalever@redhat.com>
 <1478105438-20883-2-git-send-email-prasanna.kalever@redhat.com>
In-Reply-To: <1478105438-20883-2-git-send-email-prasanna.kalever@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2016 11:50 AM, Prasanna Kumar Kalever wrote:
> The QMP definition of BlockdevOptionsGluster:
> { 'struct': 'BlockdevOptionsGluster',
>   'data': { 'volume': 'str',
>             'path': 'str',
>             'server': ['GlusterServer'],
>             '*debug-level': 'int',
>             '*logfile': 'str' } }
>=20
> But instead of 'debug-level we have exported 'debug' as the option for =
choosing
> debug level of gluster protocol driver.
>=20
> This patch fix QMP definition BlockdevOptionsGluster
> s/debug-level/debug/
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> ---
>  block/gluster.c      | 34 +++++++++++++++++-----------------
>  qapi/block-core.json |  4 ++--
>  2 files changed, 19 insertions(+), 19 deletions(-)
>=20
> @@ -787,17 +787,17 @@ static int qemu_gluster_open(BlockDriverState *bs=
,  QDict *options,
> =20
>      filename =3D qemu_opt_get(opts, GLUSTER_OPT_FILENAME);
> =20
> -    s->debug_level =3D qemu_opt_get_number(opts, GLUSTER_OPT_DEBUG,
> +    s->debug =3D qemu_opt_get_number(opts, GLUSTER_OPT_DEBUG,
>                                           GLUSTER_DEBUG_DEFAULT);

Indentation is now off.  That's minor, a maintainer could fix it on commi=
t.

> @@ -1010,14 +1010,14 @@ static int qemu_gluster_create(const char *file=
name,
>      char *tmp =3D NULL;
> =20
>      gconf =3D g_new0(BlockdevOptionsGluster, 1);
> -    gconf->debug_level =3D qemu_opt_get_number_del(opts, GLUSTER_OPT_D=
EBUG,
> +    gconf->debug =3D qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
>                                                   GLUSTER_DEBUG_DEFAULT=
);

and again

> +++ b/qapi/block-core.json
> @@ -2195,7 +2195,7 @@
>  #
>  # @server:      gluster servers description
>  #
> -# @debug-level: #optional libgfapi log level (default '4' which is Err=
or)
> +# @debug:       #optional libgfapi log level (default '4' which is Err=
or)
>  #
>  # @logfile:     #optional libgfapi log file (default /dev/stderr) (Sin=
ce 2.8)
>  #
> @@ -2205,7 +2205,7 @@
>    'data': { 'volume': 'str',
>              'path': 'str',
>              'server': ['GlusterServer'],
> -            '*debug-level': 'int',
> +            '*debug': 'int',

This changes what introspection shows. We already declared that
blockdev-add is not stable in 2.7, and made some radical changes in 2.8
that are visible through introspection.  But we WANT to avoid any more
backwards-incompatible changes beyond 2.8, so on that grounds, this HAS
to go in to 2.8 if it is going in at all (otherwise, we have
inconsistent naming between QMP and the command line that we have to
document and keep forevermore).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PoVqEgVQvw9D5lpRj1FURGRBsLTqmXJs0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRdfIAAoJEKeha0olJ0NqLP8IAKA43BNDZvWayA8sk5NtYMpA
i1EQ9uh1ZJCSvSlBdOwm5BRDLwIPph95MxiE/Ksi0sTTS7l7z4O3O/jPaE75ymOQ
t4zweXD2KPC4quG1tmWD0mP6FCmKSo0cMR9Lwben7WPFP1iqxXv4KEbvVBDuGTQ1
wea97n6cn0DlmFn88Yg24wWTYO4GI8ragv22d/HvG22LdHKET9Q3viy6BrOgzesg
MvRp3ui+Ki0RqsJ8QCM0X2frtQSAGeG4diZ0Ya6Zj4VovvEGelZYuBS+pb+8lawp
fzSAHsNo2/tamiZH3M7+fgEpxxrQcVcsiaDuAikRdvabEDE7hKGFnNw7djSHZsM=
=OthN
-----END PGP SIGNATURE-----

--PoVqEgVQvw9D5lpRj1FURGRBsLTqmXJs0--
