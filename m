Received: from eggs.gnu.org ([2001:4830:134:3::10]:56013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leon@kernel.org>) id 1cuvSR-0000O2-72
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 02:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leon@kernel.org>) id 1cuvSN-0004w9-Ub
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 02:27:19 -0400
Received: from mail.kernel.org ([198.145.29.136]:57206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <leon@kernel.org>) id 1cuvSN-0004w2-La
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 02:27:15 -0400
Date: Mon, 3 Apr 2017 09:27:30 +0300
From: Leon Romanovsky <leon@kernel.org>
Message-ID: <20170403062730.GP20443@mtr-leonro.local>
References: <1490872341-9959-1-git-send-email-marcel@redhat.com>
	<20170330141314.GM20443@mtr-leonro.local>
	<5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7KxW38SoMauyveo"
Content-Disposition: inline
In-Reply-To: <5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pvrdma: Proposal of a new pvrdma
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Ledford <dledford@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, linux-rdma@vger.kernel.org, yuval.shaia@oracle.com


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2017 at 03:28:21PM -0500, Doug Ledford wrote:
> On 3/30/17 9:13 AM, Leon Romanovsky wrote:
> > On Thu, Mar 30, 2017 at 02:12:21PM +0300, Marcel Apfelbaum wrote:
> > > From: Yuval Shaia <yuval.shaia@oracle.com>
> > >
> > >  Hi,
> > >
> > >  General description
> > >  ===================
> > >  This is a very early RFC of a new RoCE emulated device
> > >  that enables guests to use the RDMA stack without having
> > >  a real hardware in the host.
> > >
> > >  The current implementation supports only VM to VM communication
> > >  on the same host.
> > >  Down the road we plan to make possible to be able to support
> > >  inter-machine communication by utilizing physical RoCE devices
> > >  or Soft RoCE.
> > >
> > >  The goals are:
> > >  - Reach fast and secure loos-less Inter-VM data exchange.
> > >  - Support remote VMs or bare metal machines.
> > >  - Allow VMs migration.
> > >  - Do not require to pin all VM memory.
> > >
> > >
> > >  Objective
> > >  =========
> > >  Have a QEMU implementation of the PVRDMA device. We aim to do so without
> > >  any change in the PVRDMA guest driver which is already merged into the
> > >  upstream kernel.
> > >
> > >
> > >  RFC status
> > >  ===========
> > >  The project is in early development stages and supports
> > >  only basic send/receive operations.
> > >
> > >  We present it so we can get feedbacks on design,
> > >  feature demands and to receive comments from the
> > >  community pointing us to the "right" direction.
> >
> > If to judge by the feedback which you got from RDMA community
> > for kernel proposal [1], this community failed to understand:
> > 1. Why do you need new module?
>
> In this case, this is a qemu module to allow qemu to provide a virt rdma
> device to guests that is compatible with the device provided by VMWare's ESX
> product.  Right now, the vmware_pvrdma driver works only when the guest is
> running on a VMWare ESX server product, this would change that.  Marcel
> mentioned that they are currently making it compatible because that's the
> easiest/quickest thing to do, but in the future they might extend beyond
> what VMWare's virt rdma driver provides/uses and might then need to either
> modify it to work with their extensions or fork and create their own virt
> client driver.

Doug,

As I mentioned during OFA, I just responded to the latest email, but
targeted my questions for their module. Sorry for not being clear about
it.

>
> > 2. Why existing solutions are not enough and can't be extended?
>
> This patch is against the qemu source code, not the kernel.  There is no
> other solution in the qemu source code, so there is no existing solution to
> extend.
>
> > 3. Why RXE (SoftRoCE) can't be extended to perform this inter-VM
> >    communication via virtual NIC?
>
> Eventually they want this to work on real hardware, and to be more or less
> transparent to the guest.  They will need to make it independent of the
> kernel hardware/driver in use.  That means their own virt driver, then the
> virt driver will eventually hook into whatever hardware is present on the
> system, or failing that, fall back to soft RoCE or soft iWARP if that ever
> makes it in the kernel.
>
>
> >
> > Can you please help us to fill this knowledge gap?
> >
> > [1] http://marc.info/?l=linux-rdma&m=149063626907175&w=2
>

--i7KxW38SoMauyveo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAljh61IACgkQ5GN7iDZy
WKfwtg//RAhltqcBrIa5Xnef3dc9WUrUVzpqCf2r7MIf8OBCdKyea+eLwz0RbLiF
nzv1ZJPZfDvQFVCWbNSOVzjACp2rEtx79g732Xp+4eL/9wzBZmBI0HuIvH6H/6ci
uApwILW/FTAGJL+jXX953Oml2yxEvGzvp7pq36NKj8utsjgJcDZMjp6/IhE+6NzP
BVJo+W3l3MmhFO9kCBnWtZnP6UbxDkny+EVXwBp3PFg1Zdla69FpprhlG38Nojbz
wZsWs+aoZrWrRhuXQECeCCKvf/mPmymeUEkdgkXHdarc2iDKtPL8VXtaTK7q4xe2
xh37c1rygN0evaIGpycr7AdVUDEfN/U2ZYPyCLq9WCABZz9A+IctkD4R2IPXfywn
l4mwHIKdqxozjgjzREm4vOLi8/YaRpUKK1xmOVuQX8+sMJs7ccaMhME1vIe7KxDA
CvvXNRbSOwj88SqwLTcrvE8x3a741aPNK/1kvS0WxyraUakYq5t8tz6/Dky95qXj
C3BjFuICOnyy1DKMfvFiyRutybymWJDHCy3WvSsNpfdx22WdUvU1fRmInCaesdyB
Ee6dM5wobtdEhhKLWiMlreQef23qj2ThIEslE9NtII6R8vrnmk0WA+8hY/MZFHgZ
9ZqvhVXhfp/IJ+SOc7bh75SJ6wetBNtPHMxKdSaSiO9CWSBlEHM=
=kLxZ
-----END PGP SIGNATURE-----

--i7KxW38SoMauyveo--
