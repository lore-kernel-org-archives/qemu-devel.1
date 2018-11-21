Received: from eggs.gnu.org ([2001:4830:134:3::10]:48756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPWcP-00033n-DD
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPWTe-0007MJ-75
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:39:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gPWTe-0007Lf-1p
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:39:50 -0500
Date: Wed, 21 Nov 2018 12:39:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181121123929-mutt-send-email-mst@kernel.org>
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
	<20181121115718.GN26577@redhat.com>
	<20181121072237-mutt-send-email-mst@kernel.org>
	<60500f8b-47e8-c530-076a-d7f14d0f0ee5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <60500f8b-47e8-c530-076a-d7f14d0f0ee5@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Li Qiang <liq3ea@gmail.com>, Jason Wang <jasowang@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

On Wed, Nov 21, 2018 at 11:30:41AM -0600, Eric Blake wrote:
> On 11/21/18 6:23 AM, Michael S. Tsirkin wrote:
>=20
> > >=20
> > > I agree it is good to preserve fcntl flags though, so this patch
> > > looks desirable.
> > >=20
> > > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> >=20
> > Sure
> >=20
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > but really not for this release I guess as we are in freeze.
>=20
> We're in freeze, so the criteria is: Does this fix a bug that we would
> otherwise not want in 3.1.  If the code is pre-existing (that is, if 3.=
0 was
> released with the same problem), or then delaying the patch to 4.0 is a=
n
> easier call to make.  If the problem is new to 3.1, then fixing it for =
-rc3
> is still reasonable with maintainer discretion (although once -rc3 land=
s, we
> want as little as possible to go into -rc4, even if our track record sa=
ys we
> will be unable to avoid -rc4 altogether).
>=20
> I think that losing flags is likely enough to be a noticeable bug worth
> fixing for 3.1, but I did not research when the problem was introduced,=
 so I
> don't have a strong preference for 3.1 vs. 4.0.

Maintainer in this case is Jason, so it's up to him.

> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
