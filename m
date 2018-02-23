Received: from eggs.gnu.org ([2001:4830:134:3::10]:57316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epG4m-0000GJ-Ht
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epG4l-0004iC-MM
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:20:00 -0500
Date: Fri, 23 Feb 2018 17:19:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180223161951.GE3470@localhost.localdomain>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-22-kwolf@redhat.com>
	<3482089d-ae14-ff82-6792-498de033c600@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <3482089d-ae14-ff82-6792-498de033c600@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 21/36] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.02.2018 um 00:25 hat Max Reitz geschrieben:
> On 2018-02-21 14:53, Kevin Wolf wrote:
> > With the conversion to a QAPI options object, the function is now
> > prepared to be used in a .bdrv_co_create implementation.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > -    *s_snap =3D g_strdup(snap);
> > -    *s_image_name =3D g_strdup(image_name);
> > +    *s_snap =3D g_strdup(opts->snapshot);
> > +    *s_image_name =3D g_strdup(opts->image);
> > =20
> >      /* try default location when conf=3DNULL, but ignore failure */
> > -    r =3D rados_conf_read_file(*cluster, conf);
> > -    if (conf && r < 0) {
> > -        error_setg_errno(errp, -r, "error reading conf file %s", conf);
> > +    r =3D rados_conf_read_file(*cluster, opts->conf);
> > +    if (opts->has_conf && r < 0) {
>=20
> Reading opts->conf without knowing whether opts->has_conf is true is a
> bit weird.  Would you mind "s->has_conf ? opts->conf : NULL" for the
> rados_conf_read() call?
>=20
> On that thought, opts->snapshot and opts->user are optional, too.  Are
> they guaranteed to be NULL if they haven't been specified?  Should we
> guard those accesses with opts->has_* queries, too?

These days, both the QMP marshalling code (for the outermost struct when
called from x-blockdev-create) and the input visitor (for nested structs
and non-QMP callers) initialise the objects with {0} and g_malloc0().

I think Markus once told me that I shouldn't do pointless has_* checks
any more in QMP commands, so I intentionally did the same here.

Kevin

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJakD8nAAoJEH8JsnLIjy/W0TMQAL3AcuNWj9Hg477grH+67cJn
r4nfILgw64tz6VCQlBMvW/o+pjHp/8J5RobLLvcx2fb3UHSUtDyZD9vAUgne2M5p
y8cTYTQ5wkMz2k5RySv3CeIZmyQVnoRU+scPNHha55zgT5M1KSi1yhwvmatTLQuR
IzjtnCdqMRLReQGYT3qbtUINtJ32GusrL/5BFwY5rWXlnuh9DFCcVfb/SHQhMqp+
FpMMzPRHX96SFjh+cR4yJv9kq7wOe9tyT/7Hq6DGn2sUuRBoOPZpZcztCVVZtuem
9WX9Fiz79Tc/wWBdfMU4jcBaLaLXdxXmEZ/9bT8An2ClPLhcdJykefN0yoO6gRic
f+gpxeBbB61U9Lx2YUi9qH09K600kTrjYQHj6D8OTWMFRvoCTICZoeehDGRG8UKH
YEU0se8+3DcHd1WmvyPdGeJyBwVDcS9SMcSeerxgzYq9k16VQVp+S1cILJUEK06j
bwjCnzX+DbfVcp3qT2nMJAzIN3imSdKCOzKKy1eGl7afSOFeaG7ccWz9ySXeKBqg
5a+dgLABd0yrH8kg4yQG6UpqUBIl40hQcJzlhN6jfXvcCPtH2TbLrGvSe23lyMY1
mmtoRAsuI3a2UI3cCM4iio6/QGg/nVzmjCZt5ICWGu+DLkC92CdgYeWk9BVTK6jP
l5/4JEYZ/gBay8N2Qf3q
=CxsF
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
