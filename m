Received: from eggs.gnu.org ([2001:4830:134:3::10]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkmKj-0002uh-T6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkmKg-0001SB-9X
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkmKg-0001Rr-3j
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:13:38 -0400
Date: Thu, 24 Aug 2017 09:13:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824091332.01ff3698.cohuck@redhat.com>
In-Reply-To: <871ef0e3-ea8b-df59-0eeb-8019b350f1d2@linux.vnet.ibm.com>
References: <20170823072656.3352-1-zyimin@linux.vnet.ibm.com>
	<871ef0e3-ea8b-df59-0eeb-8019b350f1d2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] four zpci patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Thu, 24 Aug 2017 13:20:12 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> Why can't I receive [Qemu-devel] prefixed patches?
>=20
>=20
> =E5=9C=A8 2017/8/23 =E4=B8=8B=E5=8D=883:26, Yi Min Zhao =E5=86=99=E9=81=
=93:
> > This patch set contains four small zpci patches to fixup different issu=
es.
> > 1) fixup calculation of msix boundary
> > 2) remove zpci idx from msix message, instead we could use PCIDevice's =
id to
> >     find zpci device in kvm_arch_fixup_msi_route()
> > 3) fixup ind_offset calculation for adapter interrupt routing entry
> > 4) introduce our own iommu_replay callback
> >
> > Yi Min Zhao (4):
> >    s390x/pci: fixup trap_msix()
> >    s390x/pci: remove idx from msix msg data
> >    s390x/pci: fixup ind_offset of msix routing entry
> >    s390x/pci: add iommu replay callback
> >
> >   hw/s390x/s390-pci-bus.c  | 24 +++++++++++++-----------
> >   hw/s390x/s390-pci-bus.h  |  2 ++
> >   hw/s390x/s390-pci-inst.c | 28 ++--------------------------
> >   target/s390x/kvm.c       | 11 ++++++-----
> >   4 files changed, 23 insertions(+), 42 deletions(-)
> > =20
>=20

Well, I did not get any of your original patches, just this reply...
seem to be stuck somewhere?
