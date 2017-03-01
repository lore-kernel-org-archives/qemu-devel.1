Received: from eggs.gnu.org ([2001:4830:134:3::10]:56551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj1PZ-0003AC-G7
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj1PY-0007yv-Oe
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:23:09 -0500
Date: Wed, 1 Mar 2017 10:22:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170301102259.GB29473@stefanha-x1.localdomain>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170227164600.GH10201@stefanha-x1.localdomain>
	<58B63B57.5090804@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <58B63B57.5090804@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/6]
 docs/block-replication: Add description for shared-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kwolf@redhat.com, xuquan8@huawei.com, xiecl.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>, zhangchen.fnst@cn.fujitsu.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 11:09:11AM +0800, Hailiang Zhang wrote:
> On 2017/2/28 0:46, Stefan Hajnoczi wrote:
> > On Fri, Jan 20, 2017 at 11:47:55AM +0800, zhanghailiang wrote:
> > > +Secondary:
> > > + -drive if=3Dnone,driver=3Dqcow2,file.filename=3D/mnt/ramfs/hidden_d=
isk.img,id=3Dhidden_disk0,\
> > > +        backing.driver=3Draw,backing.file.filename=3D1.raw \
> > > + -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dse=
condary,\
> > > +        file.driver=3Dqcow2,top-id=3Dactive-disk0,\
> > > +        file.file.filename=3D/mnt/ramfs/active_disk.img,\
> > > +        file.backing=3Dhidden_disk0,shared-disk=3Don
> >=20
> > I don't see where this patch series adds a -drive shared-disk=3Don opti=
on.
> > Did I miss it?
> >=20
>=20
> In patch 2, we add this option.

Of course!  For some reason I thought it was a new global -drive option.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtqEDAAoJEJykq7OBq3PIvSQH/3PllT6oRKbtjAmIWhK3VZiu
VEqIpe8dtgoZ6lTs9lNT7/x2yFR+DglBxjditrLduEXG7gep0t2nnJMbVKfvgIuA
C2XcdSFbMACYhxEiAdD+bS1Errx6q7bLgFS+LEoJUoMXOTnEfsNzaAwBxkj/KePR
G377CzNpkRw0umMB4mcnN2COrZgGrI0y8Wl4Av9/+Tp94UqcySZZIlhtMB+tnvpS
/oJt6YPbb3Sl358BjP4nBcx2/+rvtD3oGWm33sdlhcm/Uy1L5m3wYwpuCxw+TD8+
Xq4donr+67+/b5wALjwZOV1C34rJjzZKJdRx+MNMDOWE6ugOFfBstUcZgSN1NJ4=
=1l6g
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
