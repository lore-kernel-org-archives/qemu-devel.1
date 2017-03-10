Received: from eggs.gnu.org ([2001:4830:134:3::10]:60356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmCOV-00020c-Ff
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmCOR-0000x0-Je
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:43:11 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cmCOR-0000w2-CU
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:43:07 -0500
Received: by mail-pf0-x241.google.com with SMTP id o126so9457041pfb.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 20:43:07 -0800 (PST)
Date: Fri, 10 Mar 2017 12:42:56 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170310044256.GE4589@stefanha-x1.localdomain>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<20170303135150.12145-4-stefanha@redhat.com>
	<CAMRbyytpufX+9xzshezDuYabbDNt+9jzQqk0NCL1FxmQWnRU+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <CAMRbyytpufX+9xzshezDuYabbDNt+9jzQqk0NCL1FxmQWnRU+A@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 3/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 11:56:54PM +0200, Nir Soffer wrote:
> On Fri, Mar 3, 2017 at 3:51 PM, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > +    ret_size =3D bdrv_max_size(drv, opts, in_blk ? blk_bs(in_blk) : NU=
LL,
> > +                             &local_err);
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +        goto fail;
> > +    }
> > +
> > +    if (output_format =3D=3D OFORMAT_HUMAN) {
> > +        printf("%" PRIu64 "\n", ret_size);
> > +    } else {
> > +        printf("{ \"size\": %" PRIu64 " }\n", ret_size);
> > +    }
> > +
> > +    ret =3D 0;
> > +
> > +fail:
>=20
> This looks more like out: to me, since we use it both for normal
> and abnormal flows.

Looking at the source file there is no consistency: "err", "fail", "out"
are all used in various places.  I'm happy to switch this to "out", but
for the record, I find "fail" clearer since it communicates the
intention that this is an error return.

Will fix.

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYwi7QAAoJEJykq7OBq3PIV54IAMNTpTPTjGObzsHV150Kl13M
SIIOca940V8Q9Cro+19lfDRGH5B4a6Ucn5eYV6PCQk0l44JyVeGb4vJrdqM/b1Ef
Qvrg17K8RSkf9arTrutxxQYLcUaXKszLiN45mRlH8MXqcqtCtvyrIQkruy+uzn8U
6zNqsQYPDyA8+m05VgjeXxNteePn51tUg58qLXsGgdywyR9sKi+9DUUMUfaQ6pJ3
IlJuYCtw1Kskg9k3tOorYJ4ugzrNRrrQMXExMj3PQQxKf0Lve11jVjPvLx3k90ad
2QxLS9opYe96SpG65Ebnvi+a8kRTFUmo9h8Qs+9GZuNzPxrZlseew+0MQqpfn7s=
=j70N
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
