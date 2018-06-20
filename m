Received: from eggs.gnu.org ([2001:4830:134:3::10]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fVjGL-0007ww-Jp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 15:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fVjGK-0002lP-CU
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 15:59:29 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:43681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fVjGK-0002kr-48
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 15:59:28 -0400
Received: by mail-io0-x242.google.com with SMTP id t6-v6so851588iob.10
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 12:59:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180620163408.737af8c2.cohuck@redhat.com>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
	<20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
	<CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<CADGSJ20wrF418-WVev6OjaeShZWE488uxRwgaZmsjOHZr8jyOw@mail.gmail.com>
	<20180620163408.737af8c2.cohuck@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Wed, 20 Jun 2018 12:59:26 -0700
Message-ID: <CADGSJ22h0Ypn=TzHcxWHt5fF3Xi=J2H5AesYyCWFAiHr+vXEJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Wed, Jun 20, 2018 at 7:34 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 19 Jun 2018 13:09:14 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Tue, Jun 19, 2018 at 3:54 AM, Cornelia Huck <cohuck@redhat.com> wrote:
>> > On Fri, 15 Jun 2018 10:06:07 -0700
>> > Siwei Liu <loseweigh@gmail.com> wrote:
>> >
>> >> On Fri, Jun 15, 2018 at 4:48 AM, Cornelia Huck <cohuck@redhat.com> wrote:
>> >> > On Thu, 14 Jun 2018 18:57:11 -0700
>> >> > Siwei Liu <loseweigh@gmail.com> wrote:
>
>> >> > I'm a bit confused here. What, exactly, ties the two devices together?
>> >>
>> >> The group UUID. Since QEMU VFIO dvice does not have insight of MAC
>> >> address (which it doesn't have to), the association between VFIO
>> >> passthrough and standby must be specificed for QEMU to understand the
>> >> relationship with this model. Note, standby feature is no longer
>> >> required to be exposed under this model.
>> >
>> > Isn't that a bit limiting, though?
>> >
>> > With this model, you can probably tie a vfio-pci device and a
>> > virtio-net-pci device together. But this will fail if you have
>> > different transports: Consider tying together a vfio-pci device and a
>> > virtio-net-ccw device on s390, for example. The standby feature bit is
>> > on the virtio-net level and should not have any dependency on the
>> > transport used.
>>
>> Probably we'd limit the support for grouping to virtio-net-pci device
>> and vfio-pci device only. For virtio-net-pci, as you might see with
>> Venu's patch, we store the group UUID on the config space of
>> virtio-pci, which is only applicable to PCI transport.
>>
>> If virtio-net-ccw needs to support the same, I think similar grouping
>> interface should be defined on the VirtIO CCW transport. I think the
>> current implementation of the Linux failover driver assumes that it's
>> SR-IOV VF with same MAC address which the virtio-net-pci needs to pair
>> with, and that the PV path is on same PF without needing to update
>> network of the port-MAC association change. If we need to extend the
>> grouping mechanism to virtio-net-ccw, it has to pass such failover
>> mode to virtio driver specifically through some other option I guess.
>
> Hm, I've just spent some time reading the Linux failover code and I did
> not really find much pci-related magic in there (other than checking
> for a pci device in net_failover_slave_pre_register). We also seem to
> look for a matching device by MAC only. What magic am I missing?

The existing assumptions around SR-IOV VF and thus PCI is implicit. A
lot of simplications are built on the fact that the passthrough device
is a SR-IOV Virtual Function specifically than others: MAC addresses
for couple devices must be the same, changing MAC address is
prohibited, programming VLAN filter is challenged, the datapath of
virtio-net has to share the same physical function where VF belongs
to. There's no hankshake during datapath switching at all to support a
normal passthrough device at this point. I'd imagine some work around
that ahead, which might be a bit involved than just to support a
simplified model for VF migration.

>
> Is the look-for-uuid handling supposed to happen in the host only?

The look-for-MAC matching scheme is not ideal in many aspects. I don't
want to repeat those again, but once the group UUID is added to QEMU,
the failover driver is supposed to switch to the UUID based matching
scheme in the guest.

>
>> >> > If libvirt already has the knowledge that it should manage the two as a
>> >> > couple, why do we need the group id (or something else for other
>> >> > architectures)? (Maybe I'm simply missing something because I'm not
>> >> > that familiar with pci.)
>> >>
>> >> The idea is to have QEMU control the visibility and enumeration order
>> >> of the passthrough VFIO for the failover scenario. Hotplug can be one
>> >> way to achieve it, and perhaps there's other way around also. The
>> >> group ID is not just for QEMU to couple devices, it's also helpful to
>> >> guest too as grouping using MAC address is just not safe.
>> >
>> > Sorry about dragging mainframes into this, but this will only work for
>> > homogenous device coupling, not for heterogenous. Consider my vfio-pci
>> > + virtio-net-ccw example again: The guest cannot find out that the two
>> > belong together by checking some group ID, it has to either use the MAC
>> > or some needs-to-be-architectured property.
>> >
>> > Alternatively, we could propose that mechanism as pci-only, which means
>> > we can rely on mechanisms that won't necessarily work on non-pci
>> > transports. (FWIW, I don't see a use case for using vfio-ccw to pass
>> > through a network card anytime in the near future, due to the nature of
>> > network cards currently in use on s390.)
>>
>> Yes, let's do this just for PCI transport (homogenous) for now.
>
> But why? Using pci for passthrough to make things easier (and because
> there's not really a use case), sure. But I really don't want to
> restrict this to virtio-pci only.

Of course, technically it doesn't have to be virtio-pci only. The
group UUID can even extend it further to non-pci transport. However,
with the current focus of the driver support on SR-IOV VF and limited
use case on non-pci, I'd feel no immediate effort will be needed on
that front.

>
>> >> In the model of (b), I think it essentially turns hotplug to one of
>> >> mechanisms for QEMU to control the visibility. The libvirt can still
>> >> manage the hotplug of individual devices during live migration or in
>> >> normal situation to hot add/remove devices. Though the visibility of
>> >> the VFIO is under the controll of QEMU, and it's possible that the hot
>> >> add/remove request does not involve actual hot plug activity in guest
>> >> at all.
>> >
>> > That depends on how you model visibility, I guess. You'll probably want
>> > to stop traffic flowing through one or the other of the cards; would
>> > link down or similar be enough for the virtio device?
>>
>> I'm not sure if it is a good idea. The guest user will see two devices
>> with same MAC but one of them is down. Do you expect user to use it or
>> not? And since the guest is going to be migrated, we need to unplug a
>> broken VF from guest before migrating, why do we bother plugging in
>> this useless VF at the first place?
>
> I was thinking about using hotunplugging only over migration and doing
> the link up only after feature negotiation has finished, but that is
> probably too complicated. Let's stick to hotplug for simplicity's sake.

OK. Thanks for the discussion, it's really useful.

Regards,
-Siwei
