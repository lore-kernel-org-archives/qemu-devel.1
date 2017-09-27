Received: from eggs.gnu.org ([2001:4830:134:3::10]:48991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxA0o-0002eQ-It
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxA0k-0001K3-Je
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:56:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxA0k-0001Jm-DR
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:56:14 -0400
Date: Wed, 27 Sep 2017 12:56:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170927125606.65dc514d.cohuck@redhat.com>
In-Reply-To: <e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
	<e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: create a compat s390 phb for
 <=2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, dgilbert@redhat.com

On Wed, 27 Sep 2017 18:25:00 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/9/27 =E4=B8=8B=E5=8D=885:47, Cornelia Huck =E5=86=99=E9=81=
=93:
> > On Tue, 26 Sep 2017 20:40:25 +0200
> > David Hildenbrand <david@redhat.com> wrote:

> >> I'd really really really (did I mention really?) favor something like a
> >> dummy device, because we could easily handle the !CONFIG_PCI case then.
> >>
> >> All these compat options and conditions will kill us someday... we're
> >> already patching around that whole stuff way too much.
> >>
> >> If we ever unconditionally created a device, we should keep doing so. =
=20
> > Yes, that whole thing is horrible, especially interaction with compat
> > machines.
> >
> > Do you have an idea on how to create such a dummy device (without
> > having to effectively copy a lot of configured-out code)?
> >
> > =20
> How about in s390_pcihost_hot_plug() we check s390_has_feat(zpci)?
> If no zpci feature, we avoid plugging any pci device.
> Then we could always create phb.
> I think pcibus's vmstate is only data to migrate.

That's still problematic if CONFIG_PCI is off. I currently don't have a
better idea than either disallowing compat machines on builds without
pci, or using a dummy device...
