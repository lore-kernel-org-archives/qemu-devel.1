Received: from eggs.gnu.org ([2001:4830:134:3::10]:55690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epGqh-0001N9-1M
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epGqf-0003gb-Uu
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:09:30 -0500
Date: Fri, 23 Feb 2018 18:09:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180223170921.GG3470@localhost.localdomain>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-22-kwolf@redhat.com>
	<3482089d-ae14-ff82-6792-498de033c600@redhat.com>
	<20180223161951.GE3470@localhost.localdomain>
	<bc9f6454-45eb-156f-5cef-cdc73c80249e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <bc9f6454-45eb-156f-5cef-cdc73c80249e@redhat.com>
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


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.02.2018 um 17:43 hat Max Reitz geschrieben:
> On 2018-02-23 17:19, Kevin Wolf wrote:
> > Am 23.02.2018 um 00:25 hat Max Reitz geschrieben:
> >> On 2018-02-21 14:53, Kevin Wolf wrote:
> >>> With the conversion to a QAPI options object, the function is now
> >>> prepared to be used in a .bdrv_co_create implementation.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >=20
> >>> -    *s_snap =3D g_strdup(snap);
> >>> -    *s_image_name =3D g_strdup(image_name);
> >>> +    *s_snap =3D g_strdup(opts->snapshot);
> >>> +    *s_image_name =3D g_strdup(opts->image);
> >>> =20
> >>>      /* try default location when conf=3DNULL, but ignore failure */
> >>> -    r =3D rados_conf_read_file(*cluster, conf);
> >>> -    if (conf && r < 0) {
> >>> -        error_setg_errno(errp, -r, "error reading conf file %s", con=
f);
> >>> +    r =3D rados_conf_read_file(*cluster, opts->conf);
> >>> +    if (opts->has_conf && r < 0) {
> >>
> >> Reading opts->conf without knowing whether opts->has_conf is true is a
> >> bit weird.  Would you mind "s->has_conf ? opts->conf : NULL" for the
> >> rados_conf_read() call?
> >>
> >> On that thought, opts->snapshot and opts->user are optional, too.  Are
> >> they guaranteed to be NULL if they haven't been specified?  Should we
> >> guard those accesses with opts->has_* queries, too?
> >=20
> > These days, both the QMP marshalling code (for the outermost struct when
> > called from x-blockdev-create) and the input visitor (for nested structs
> > and non-QMP callers) initialise the objects with {0} and g_malloc0().
> >=20
> > I think Markus once told me that I shouldn't do pointless has_* checks
> > any more in QMP commands, so I intentionally did the same here.
>=20
> I'm a bit cautious because of non-zero defaults (like sslverify in the
> ssh driver), but as long as you're aware...

I still hope that QAPI will allow specifying default values in the
schema sometime. But yes, for the time being, not checking has_*
obviously only works when the default is 0/false/NULL.

Kevin

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJakErBAAoJEH8JsnLIjy/WE3UQAJJGHiaBBmRgQdYg4fpMJe/q
IXXMJTnQKctdZRz44/vS5nrJgVx8/E2fabA8cJocblUKKjIh6gZxeJh/9vbgQSRZ
Y6rw+HAo6+iICecrk6UxocO7WUkdvm8u9h57NoZQzTJc5ijxhXQroYRCyiqBUuof
qvgwTs2U8les2TLaVo8SsFiXrrT6CoPfCXX/VZATwjSTHS9/RgUrkyXUAg9UJZyN
wf+DeYqWB1dbmUFP4G5dDWqBu1HXo3Le5WFuw/KyvlTcmy6lbvgwCTp4Ek4bbmId
FNmcbljLFVcwznEQJQvNsVHAV9Ho9JC0ycXTNjbAECb7tx/nlwwiKSs636LP7kux
M7z6ZcaESsFQQM717TVAqnT2GGFC4+/RL42MZKXKkRlunvhuTA/R41NsiXCnhjey
jYXZtj4Q8XkHt/mPUr6yH1N4FWMi2465BU0A1CQ4rN9KJ2Fq+2rokSbrZWYN5d1F
XVsQzjAj+/4VnMbDgZbWrqZZpy+l0v5foggV+xUOsiXeIGZk7S6qCoIwxn15gqHq
hLVxL8ldUYitcN12iZQAovuMY6nM5QxUz282zvrCCoC2CtUQtHACv5X4yxPF5F9u
TYygX8QW53t+Qc2LdlQyUUQ83xKygRVUjw7ryBg0n/z/zdCRrfP7o1CmufMQ/Y89
gyewJgGilgozlNMW7gJN
=UvOL
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
