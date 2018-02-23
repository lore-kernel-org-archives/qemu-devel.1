Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ep6x5-0002by-0v
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ep6w0-0002Rj-Mn
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:35:26 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:42991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1ep6vz-0002Np-Ql
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:34:20 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1N6XAMH056627
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 01:34:18 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id B038C6D
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 01:34:19 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 9AE7B80
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 01:34:19 -0500 (EST)
Received: from mail-wm0-f69.google.com (mail-wm0-f69.google.com [74.125.82.69])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1N6YH5D057173
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 01:34:18 -0500
Received: by mail-wm0-f69.google.com with SMTP id n14so63615wmc.0
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 22:34:18 -0800 (PST)
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com.
	[209.85.128.171])
	by smtp.gmail.com with ESMTPSA id z8sm1408744edi.11.2018.02.22.22.34.15
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Feb 2018 22:34:15 -0800 (PST)
Received: by mail-wr0-f171.google.com with SMTP id v65so12909400wrc.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 22:34:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
	<20180223035555.GL18962@xz-mi>
	<CAHyh4xiCpJQZgtQR-KDrDntZZnAK5V5D=oB7UwQbuZNy7G_z7g@mail.gmail.com>
	<20180223061034.GM18962@xz-mi>
In-Reply-To: <20180223061034.GM18962@xz-mi>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Fri, 23 Feb 2018 06:34:04 +0000
Message-ID: <CAHyh4xh+EP6-vvrcQiQTBQQ4+3yrQvVFNGrtgt0w57ZZ0LNcZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] intel-iommu and vhost: Do we need 'device-iotlb'
 and 'ats'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, jasowang@redhat.com

On Fri, Feb 23, 2018 at 1:10 AM Peter Xu <peterx@redhat.com> wrote:

> On Fri, Feb 23, 2018 at 12:32:13AM -0500, Jintack Lim wrote:
> > Hi Peter,
> >
> > Hope you had great holidays!
> >
> > On Thu, Feb 22, 2018 at 10:55 PM, Peter Xu <peterx@redhat.com> wrote:
> > > On Tue, Feb 20, 2018 at 11:03:46PM -0500, Jintack Lim wrote:
> > >> Hi,
> > >>
> > >> I'm using vhost with the virtual intel-iommu, and this page[1] shows
> > >> the QEMU command line example.
> > >>
> > >> qemu-system-x86_64 -M q35,accel=3Dkvm,kernel-irqchip=3Dsplit -m 2G \
> > >>                    -device intel-iommu,intremap=3Don,device-iotlb=3D=
on \
> > >>                    -device ioh3420,id=3Dpcie.1,chassis=3D1 \
> > >>                    -device
> > >>
> virtio-net-pci,bus=3Dpcie.1,netdev=3Dnet0,disable-legacy=3Don,disable-mod=
ern=3Doff,iommu_platform=3Don,ats=3Don
> > >> \
> > >>                    -netdev tap,id=3Dnet0,vhostforce \
> > >>                    $IMAGE_PATH
> > >>
> > >> I wonder what's the impact of using device-iotlb and ats options as
> > >> they are described necessary.
> > >>
> > >> In my understanding, vhost in the kernel only looks at
> > >> VIRTIO_F_IOMMU_PLATFORM, and when it is set, vhost uses a
> > >> device-iotlb. In addition, vhost and QEMU communicate using vhost_ms=
g
> > >> basically to cache mappings correctly in the vhost, so I wonder what=
's
> > >> the role of ats in this case.
> > >
> > > The "ats" as virtio device parameter will add ATS capability to the
> > > PCI device.
> > >
> > > The "device-iotlb" as intel-iommu parameter will enable ATS in the
> > > IOMMU device (and also report that in ACPI field).
> > >
> > > If both parameters are provided IIUC it means guest will know virtio
> > > device has device-iotlb and it'll treat the device specially (e.g.,
> > > guest will need to send device-iotlb invalidations).
> >
> > Oh, I see. I was focusing on how QEMU and vhost work in the host, but
> > I think I missed the guest part! Thanks. I see that the Intel IOMMU
> > driver has has_iotlb_device flag for that purpose.
> >
> > >
> > > We'd better keep these parameters when running virtio devices with
> > > vIOMMU.  For the rest of vhost/arm specific questions, I'll leave to
> > > others.
> >
> > It seems like SMMU is not checking ATS capability - at least
> > ats_enabled flag - but I may miss something here as well :)
> >
> > >
> > > PS: Though IIUC the whole ATS thing may not really be necessary for
> > > current VT-d emulation, since even with ATS vhost is registering UNMA=
P
> > > IOMMU notifiers (see vhost_iommu_region_add()), and IIUC that means
> > > vhost will receive IOTLB invalidations even without ATS support, and
> > > it _might_ still work.
> >
> > Right. That's what I thought.
> >
> > Come to think of it, I'm not sure why we need to flush mappings in
> > IOMMU and devices separately in the first place... Any thoughts?
>
> I don't know ATS much, neither.
>
> You can have a look at chap 4 of vt-d spec:
>
>         One approach to scaling IOTLBs is to enable I/O devices to
>         participate in the DMA remapping with IOTLBs implemented at
>         the devices. The Device-IOTLBs alleviate pressure for IOTLB
>         resources in the core logic, and provide opportunities for
>         devices to improve performance by pre-fetching address
>         translations before issuing DMA requests. This may be useful
>         for devices with strict DMA latency requirements (such as
>         isochronous devices), and for devices that have large DMA
>         working set or multiple active DMA streams.
>
> So I think it's for performance's sake. For example, the DMA operation
> won't need to be translated at all if it's pre-translated, so it can
> have less latency.  And also, that'll offload some of the translation
> process so that workload can be more distributed.
>
> When with that (caches located both on IOMMU's and device's side), we
> need to invalidate all the cache when needed.
>

Right. I think my question was not clear. My question was that why don=E2=
=80=99t
IOMMU invalidate device-iotlb along with its mappings in one go. Then IOMMU
device driver doesn=E2=80=99t need to flush device-iotlb explicitly. Maybe =
the
reason is that ATS and IOMMU are not always coupled.. but I guess it=E2=80=
=99s time
for me to get some more background :)


> >
> > Your reply was really helpful to me. I appreciate it.
>
> My pleasure.  Thanks,
>
> >
> > Thanks,
> > Jintack
> >
> > > But there can be other differences, like
> > > performance, etc.
> > >
> > >>
> > >> A related question is that if we use SMMU emulation[2] on ARM withou=
t
> > >> those options, does vhost cache mappings as if it has a device-iotlb=
?
> > >> (I guess this is the case.)
> > >>
> > >> I'm pretty new to QEMU code, so I might be missing something. Can
> > >> somebody shed some light on it?
> > >>
> > >> [1] https://wiki.qemu.org/Features/VT-d
> > >> [2]
> http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04736.html
> > >>
> > >> Thanks,
> > >> Jintack
> > >>
> > >
> > > --
> > > Peter Xu
> > >
> >
>
> --
> Peter Xu
>
>
