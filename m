Received: from eggs.gnu.org ([2001:4830:134:3::10]:53108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cunming.liang@intel.com>) id 1f9MJ6-0000SZ-KU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cunming.liang@intel.com>) id 1f9MJ3-0004RS-IQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:01:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:65455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cunming.liang@intel.com>)
	id 1f9MJ3-0004Q9-7z
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:01:49 -0400
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Fri, 20 Apr 2018 03:01:45 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E95117D@SHSMSX104.ccr.corp.intel.com>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-7-tiwei.bie@intel.com>
	<20180418192154-mutt-send-email-mst@kernel.org>
	<20180419111439.i6gfhnept6wy7uzp@debian>
	<D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
	<c41439d6-69b7-474a-530f-07ffb5f1b9e6@redhat.com>
	<20180419180912-mutt-send-email-mst@kernel.org>
	<D0158A423229094DA7ABF71CF2FA0DA34E950B7C@SHSMSX104.ccr.corp.intel.com>
	<20180419194926-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180419194926-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] RE: [PATCH v3 6/6] vhost-user:
 support registering external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly,
	Dan" <dan.daly@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang,
	Xiao W" <xiao.w.wang@intel.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, April 20, 2018 12:56 AM
> To: Liang, Cunming <cunming.liang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Bie, Tiwei <tiwei.bie@intel.com>=
;
> jasowang@redhat.com; alex.williamson@redhat.com; stefanha@redhat.com;
> qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org; Daly, Dan
> <dan.daly@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>; Wang, Zhiho=
ng
> <zhihong.wang@intel.com>; Wang, Xiao W <xiao.w.wang@intel.com>
> Subject: Re: [virtio-dev] RE: [PATCH v3 6/6] vhost-user: support register=
ing
> external host notifiers
>=20
> On Thu, Apr 19, 2018 at 04:24:29PM +0000, Liang, Cunming wrote:
> >
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > Sent: Thursday, April 19, 2018 11:19 PM
> > > To: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Liang, Cunming <cunming.liang@intel.com>; Bie, Tiwei
> > > <tiwei.bie@intel.com>; jasowang@redhat.com;
> > > alex.williamson@redhat.com; stefanha@redhat.com;
> > > qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org; Daly, Dan
> > > <dan.daly@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>; Wang,
> > > Zhihong <zhihong.wang@intel.com>; Wang, Xiao W
> > > <xiao.w.wang@intel.com>
> > > Subject: Re: [virtio-dev] RE: [PATCH v3 6/6] vhost-user: support
> > > registering external host notifiers
> > >
> > > On Thu, Apr 19, 2018 at 03:02:40PM +0200, Paolo Bonzini wrote:
> > > > On 19/04/2018 14:43, Liang, Cunming wrote:
> > > > >> 2. Memory barriers. Right now after updating the avail idx,
> > > > >> virtio does smp_wmb() and then the MMIO write. Normal hardware
> > > > >> drivers do
> > > > >> wmb() which is an sfence. Can a PCI device read bypass index
> > > > >> write and see a stale index value?
> > > > >
> > > > > A compiler barrier is enough on strongly-ordered memory
> > > > > platform. As it doesn't re-order store, PCI device won't see a st=
ale index
> value.
> > > > > But a weakly-ordered memory needs sfence.
> > > >
> > > > That is complicated then.  We need to define a feature bit and (in
> > > > the Linux driver) propagate it to vring_create_virtqueue's
> > > > weak_barrier argument.  However:
> > > >
> > > > - if we make it 1 when weak barriers are needed, the device also
> > > > needs to nack feature negotiation (not allow setting the
> > > > FEATURES_OK) if the bit is not set by the driver.
> > > >  However, that is not enough.  Live migration assumes that it is
> > > > okay to migrate a virtual machine from a source that doesn't
> > > > support a feature to a destination that supports it.
> > > >  In this case, it would assume that it is okay to migrate from
> > > > software virtio to hardware virtio.  This is wrong because the
> > > > destination would use weak barriers
> > >
> > > You can't migrate between systems with different sets of device
> > > features right now.
> > >
> > > > - if we make it 1 when strong barriers are enough, software virtio
> > > > devices needs to be updated to expose the bit.  This works,
> > > > including live migration, but updated drivers will now go slower
> > > > when run against an old device that doesn't know the feature bit.
> > > >
> > > > Maybe bump the PCI revision, so that only the new revision has the =
bit?
> > > >
> > > > Thanks,
> > > >
> > > > Paolo
> > >
> > > As a first step, if you want to migrate to a HW offloaded solution
> > > then you need to enable the feature.
> >
> > > It does mean it will go a bit slower when run with software, so it's
> > > only good if most systems in your cluster do have the HW offload.
> > To clarify a bit more, it's suboptimal to always use mandatory barriers=
 for MMIO.
> Per strongly-order memory, 'weak barriers' (smp_wmb) is pretty good for M=
MIO.
> The tradeoff doesn't always happen, software and HW offload can align on =
the
> same page.
>=20
> I agree to all of the above except where you say smp_wmb.
>=20
> smp_wmb is for controlling SMP effects on Linux, and I suspect it will no=
t do the
> right thing on some non-Intel architectures.
>=20
> The claim is I think correct for Intel/AMD platforms, and probably other =
strongly
> ordered ones. I suspect it's incorrect for ARM and power.
>=20
> Replace smp_wmb with 'asm volatile ("") on Intel' and I'll agree.

Yeah, that's more accurate.=20

>=20
>=20
>=20
> > > I think we can start by getting that working and think about ways to
> > > improve down the road.
> > >
> > >
> > > That's the usecase we designed FEATURES_OK for though, so I do
> > > think/hope it's enough and we don't need to play with revisions.
> > >
> > >
> > > --
> > > MST
