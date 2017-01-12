Received: from eggs.gnu.org ([2001:4830:134:3::10]:43889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgLr-0006vs-HF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgLo-0005i7-Br
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:27:39 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cRgLo-0005hJ-4u
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:27:36 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so4083074wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 06:27:36 -0800 (PST)
Date: Thu, 12 Jan 2017 14:27:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170112142722.GD14042@stefanha-x1.localdomain>
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
	<e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
	<20170104144458.GC8194@stefanha-x1.localdomain>
	<e1a9afaf-74c0-77f1-72e9-c61cf225122e@gmail.com>
	<20170112022212.GA26504@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20170112022212.GA26504@lemon>
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhang <yang.zhang.wz@gmail.com>
Cc: Junkang Fu <fujunkang@gmail.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 10:22:12AM +0800, Fam Zheng wrote:
> On Thu, 01/12 09:22, Yang Zhang wrote:
> > On 2017/1/4 22:44, Stefan Hajnoczi wrote:
> > > On Tue, Jan 03, 2017 at 10:53:06AM -0600, Eric Blake wrote:
> > > > On 12/29/2016 08:41 PM, Junkang Fu wrote:
> > > > > >From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:0=
0 2001
> > > > > From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
> > > > > Date: Wed, 24 Aug 2016 19:36:53 +0800
> > > > > Subject: [PATCH] virtio-blk: add disk-name device property
> > > > >=20
> > > > > Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with=
 the
> > > > > target dev
> > > > > name specified in libvirt xml file. For example, we may get disk =
name
> > > > > /dev/vdb in
> > > > > VM while target dev specified in libvirt xml is vdc.
> > > >=20
> > > > It's not really libvirt's fault.  The libvirt XML names are for
> > > > convenience, but nothing on the host side requires the guest to pic=
k the
> > > > same naming scheme as the host.
> > > >=20
> > > > I guess your proposal is to enhance the virtio spec such that clien=
ts
> > > > that are new enough to honor the new addition to the virtio spec wi=
ll
> > > > change their name-picking algorithm to use the name provided by the
> > > > host, rather than their current approach of picking whatever name t=
hey
> > > > feel like, and then enhance libvirt to pass the XML name on down to=
 the
> > > > guest?  It might work, but as others have pointed out, it will requ=
ire a
> > > > virtio spec change first.
> > >=20
> > > This change is unnecessary.  The -device virtio-blk-pci,serial=3D pro=
perty
> > > already exists for this purpose.
> >=20
> > how about the /dev/vdabc? I guess lots of people prefer to use it inste=
ad of
> > /dev/disk/by-id/xxx?
>=20
> I disagree. Using /dev/sdX has exactly the same issue and that's why fsta=
b and
> boot loader etc almost always use UUID or disk label by default because t=
hey are
> more stable.

Right, /dev/sdX shouldn't be used in configuration files or other
persistent state.

Try cat /etc/fstab on your own system.

On my system there are no /dev/sdX paths in /etc/fstab, only UUIDs and
LVM logical volume paths.

Stefan

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd5JKAAoJEJykq7OBq3PIZz4H/1y1wcyY4nRAjVQAY8u/vtgF
vFXatdKyuRl7gFziH6qXG1uZ4IJWWM2+e0MTqFfwLiLGXzP2YNhCw3EJmpWQNvto
UY/WxZPIZJeQzMaKOURLSbS7F5YBhpPw0DG9P3nUaVOXxynX+oAZ3uv7vV4tOIYW
EU1Oxr6uiQwOLEddDYdX5E6Wo9DKdA6Fe0/8UNF56xMC7cFvBg1lG6uJ1YJNdsYy
bg/JQdcT4mC8rFqu+0AUHnDyWHg6hsfqFcnirWMZmjOpBxe4WGHbcCItQ/GskatX
yQbDz8To0/gFx3MU62yM5oyoo5igKQl9bHaVv8gsfNaOwbWWx/ZWHO0EZa1y4NY=
=b9zK
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
