Received: from eggs.gnu.org ([2001:4830:134:3::10]:45699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJvU-0008R5-IH
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJvO-0007AF-TY
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:06:32 -0400
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-11-eblake@redhat.com>
	<20170908125102.GH3283@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0950cb8-fe6f-1137-edba-28b977fb0731@redhat.com>
Date: Fri, 8 Sep 2017 09:05:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170908125102.GH3283@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f5tQ0AS9i0Gj2OJJQxQQO7Q4djjQJLuBG"
Subject: Re: [Qemu-devel] [PATCH v6 10/18] dirty-bitmap: Change
 bdrv_get_dirty_count() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f5tQ0AS9i0Gj2OJJQxQQO7Q4djjQJLuBG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <e0950cb8-fe6f-1137-edba-28b977fb0731@redhat.com>
Subject: Re: [PATCH v6 10/18] dirty-bitmap: Change bdrv_get_dirty_count() to
 report bytes
References: <20170830210542.2153-1-eblake@redhat.com>
 <20170830210542.2153-11-eblake@redhat.com>
 <20170908125102.GH3283@localhost.localdomain>
In-Reply-To: <20170908125102.GH3283@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 07:51 AM, Kevin Wolf wrote:
> Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
>> Thanks to recent cleanups, all callers were scaling a return value
>> of sectors into bytes; do the scaling internally instead.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
>> diff --git a/block/mirror.c b/block/mirror.c
>> index af13f5d658..cc47e21814 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -811,11 +811,10 @@ static void coroutine_fn mirror_run(void *opaque=
)
>=20
> There is one more place before this one that needs to be converted,
> mirror_iteration() at line 343:
>=20
>     trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap) =
*
>                               BDRV_SECTOR_SIZE);

Good catch. (I guess I'm a victim of sitting on a patch for several
months, across several rebases...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f5tQ0AS9i0Gj2OJJQxQQO7Q4djjQJLuBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmyo8QACgkQp6FrSiUn
Q2pf7ggAlFfoAY4V6UJLZ1Pme5HpXh37oRl244Cs53ZUjM/WNLNJInumc9Uda1Yv
tqnioQuSl1VjW7CdpMaQAnvm+lFowZ8Nx0fzXZRUMmBzFzllJtKw6cKEL6MaEoxP
QRgJ4XtGLXGY0LdE2ys2WOp5UxX8wmDxUS1HbsUqxukmOWnckdtwKJLi2IN4f2dy
vPeH5HHSR/FTAPlNoGtiMB0OxRS+TW8b+EeL65lKMCG3jhLDc+A3iMUAEw1WJJKb
7JChumN3TevkeVpH5Jmudsw5LK2sGB7w5ggc9d7ODCY3Nhg2uWjETpqX4Jr2Qvi9
zbyWw7Yyr/whfjc2Vzoc5BMV9GQCuQ==
=gvXz
-----END PGP SIGNATURE-----

--f5tQ0AS9i0Gj2OJJQxQQO7Q4djjQJLuBG--
