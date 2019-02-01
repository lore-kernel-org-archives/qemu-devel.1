Received: from eggs.gnu.org ([209.51.188.92]:55955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpchh-0005ZB-Tf
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpchg-0002qk-Q3
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:34:13 -0500
Date: Fri, 1 Feb 2019 18:34:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201173401.GD31750@localhost.localdomain>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<2edaa66c-52d9-ad56-d155-304ec7fb6903@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <2edaa66c-52d9-ad56-d155-304ec7fb6903@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 3/3] qemu-img info: bitmaps extension
 new test 239
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.02.2019 um 18:23 hat Eric Blake geschrieben:
> On 1/31/19 7:46 AM, Andrey Shinkevich wrote:
> > A new test file 239 added to the qemu-iotests set. It checks
> > the output format of 'qemu-img info' for bitmaps extension of
> > qcow2 specific information.
> >=20
> > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > ---
> >  tests/qemu-iotests/239     |  74 ++++++++++++++++++++++++++
> >  tests/qemu-iotests/239.out | 130 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 205 insertions(+)
> >  create mode 100755 tests/qemu-iotests/239
> >  create mode 100644 tests/qemu-iotests/239.out
>=20
> Kevin just sent a pull request with 239 consumed for something else (a
> test for dmg; also consumed 240); I don't mind renumbering the test as
> 242 or later as part of staging if we are happy with this version of the
> test.  But I also see that Vladimir had some suggestions, so I wouldn't
> be surprised if you want to send a v12.
>=20
> >=20
> > diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
> > new file mode 100755
> > index 0000000..bee7943
> > --- /dev/null
> > +++ b/tests/qemu-iotests/239
> > @@ -0,0 +1,74 @@
> > +#!/usr/bin/env python
> > +#
> > +# Test for qcow2 bitmap printed information
> > +#
> > +# Copyright (c) 2018 Virtuozzo International GmbH
>=20
> Want to claim 2019?
>=20
>=20
> > +def add_bitmap(bitmap_number, persistent, disabled):
> > +    granularity =3D 2**(13 + bitmap_number)
> > +    bitmap_name =3D 'bitmap-' + str(bitmap_number-1)
> > +    vm =3D iotests.VM().add_drive(disk)
> > +    vm.launch()
> > +    vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3Dbitma=
p_name,
> > +               granularity=3Dgranularity, persistent=3Dpersistent,
> > +               disabled=3Ddisabled)
> > +    vm.shutdown()
> > +
> > +def write_to_disk(offset, size):
> > +    write =3D 'write {} {}K'.format(offset, size)
> > +    qemu_io('-f', iotests.imgfmt, '-c', write, disk)
> > +    log('Write ' + str(size) + 'K to disk at offset ' + str(hex(offset=
)))
> > +
> > +
> > +qemu_img_create('-f', iotests.imgfmt, disk, '1M')
> > +
> > +for num in range(1, 4):
> > +    disabled =3D False
> > +    if num =3D=3D 2:
> > +        disabled =3D True
> > +    add_bitmap(num, bool(num-1), disabled)
>=20
> I don't know the pythonic way of coercing a bool value out of a check
> for whether another value is a particular integer; but I see that you
> did it in two different styles.  I don't know if this works, but it
> would at least look more consistent:
>=20
> add_bitmap(num, bool(num =3D=3D 1), bool(num =3D=3D 2))

Hm...

    >>> num =3D 0
    >>> type(num =3D=3D 2)
    <class 'bool'>

Why all the bool() calls when the result of =3D=3D is already a bool?

Kevin

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcVIMJAAoJEH8JsnLIjy/WzoQQAIhhqez34KMLOH9JuujJSA6O
Jg1/4WJMfvI5W53dT0zK9h5YYEHolgKRxyB+PUXT/OYCUkN7Bw8KxgNUPZJ1jEwl
A7O5k/BfH6gIKKZMv8eh9o3VSsubayjNWfUAP9tqXaLeAPzHWnHfwTkHJ0159vMk
SKNBzH+lgrchcHusHmsg8vIV0CcYe9CLfq1x87UjuX0Y/Dld5yY3a8jhKMIbATr8
VZ1vs9mPysxDHH784/eOWPh6xr08n+mGqPk+iUmaK7ktPK33tCT69mA5/2IyYoNQ
ju81ZOta9GTnFOOr6GvkGdqbP41+/c+l9ZzYSWCEa74p4ty0hz6Dcil7uBoQK59K
5aNShvC/GZoDfdEwQnt5+nmsCjhnF+4oR7qjou4sRpYavx6CJ73zfIF0F6LIJWWL
VqZwHzJsWbhDFQf6svi7n6FRZ4D2Fv67DPUoZS156upzVVRHIUJ7+tba/B3krGoh
+NbuMoS6JGApuleDEPC1YeaJ2eZU8Dwtkc9DpDghmc2XFxRPRzhSugo4sP0FrSGd
I3tj5haS8ZFKyufLFCgbtRebUo4Owf42AnDCSudpjGNRo1QlEoX0kdIpvmPPx2s6
mWS981v+aQyw7Z2/ti7RNWEbz31yLFCAZOKBZDc/4KVG6NlFnZQfi2prz65i4nRG
u/nAj0NawZJT8YSt7EJH
=OvHx
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
