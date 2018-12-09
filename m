Received: from eggs.gnu.org ([2001:4830:134:3::10]:48542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gW3sM-0007WN-PD
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 13:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gW3sH-0004Eu-LX
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 13:32:22 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:36338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gW3sF-0003v8-Mj
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 13:32:17 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB9IU9AI015324
	for <qemu-devel@nongnu.org>; Sun, 9 Dec 2018 13:32:08 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id CA0E482
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 13:32:08 -0500 (EST)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 816AB95
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 13:32:07 -0500 (EST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
	[209.85.208.71])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB9IW69p010170
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 9 Dec 2018 13:32:07 -0500
Received: by mail-ed1-f71.google.com with SMTP id y35so4341164edb.5
	for <qemu-devel@nongnu.org>; Sun, 09 Dec 2018 10:32:07 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
	[209.85.128.50])
	by smtp.gmail.com with ESMTPSA id h47sm2732341eda.8.2018.12.09.10.32.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 09 Dec 2018 10:32:04 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id n190so8842704wmd.0
	for <qemu-devel@nongnu.org>; Sun, 09 Dec 2018 10:32:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
	<CAHyh4xjNU2ZTvBTqRhVn17SpcqXcKnKvK90oGFeA72t_h3-REw@mail.gmail.com>
	<7cc73aeb-5eee-8b4f-c005-aee64dfb1bf8@redhat.com>
	<CAHyh4xhysVpEEiwmYU4cyMZaXwzHZfEyMD4=_4QiNbr9HtKGzA@mail.gmail.com>
	<356e7f1d-e95a-a090-4a79-c1cf5a37d50f@redhat.com>
	<1c2e9828-467f-1120-f200-6a1d18f93c89@redhat.com>
In-Reply-To: <1c2e9828-467f-1120-f200-6a1d18f93c89@redhat.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Sun, 9 Dec 2018 13:31:56 -0500
Message-ID: <CAHyh4xi4aXNHpF=bNZpmDVe6PC=ApXT=uEHfdnOn3g5x5XsTFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, "\\ Michael S . Tsirkin \\" <mst@redhat.com>

On Fri, Dec 7, 2018 at 7:37 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2018/12/6 =E4=B8=8B=E5=8D=888:44, Jason Wang wrote:
> >
> > On 2018/12/6 =E4=B8=8B=E5=8D=888:11, Jintack Lim wrote:
> >> On Thu, Dec 6, 2018 at 2:33 AM Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>> On 2018/12/5 =E4=B8=8B=E5=8D=8810:47, Jintack Lim wrote:
> >>>> On Tue, Dec 4, 2018 at 8:30 PM Jason Wang <jasowang@redhat.com> wrot=
e:
> >>>>> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> I'm wondering how the current implementation works when logging
> >>>>>> dirty
> >>>>>> pages during migration from vhost-net (in kernel) when used vIOMMU=
.
> >>>>>>
> >>>>>> I understand how vhost-net logs GPAs when not using vIOMMU. But wh=
en
> >>>>>> we use vhost with vIOMMU, then shouldn't vhost-net need to log the
> >>>>>> translated address (GPA) instead of the address written in the
> >>>>>> descriptor (IOVA) ? The current implementation looks like vhost-ne=
t
> >>>>>> just logs IOVA without translation in vhost_get_vq_desc() in
> >>>>>> drivers/vhost/net.c. It seems like QEMU doesn't do any further
> >>>>>> translation of the dirty log when syncing.
> >>>>>>
> >>>>>> I might be missing something. Could somebody shed some light on
> >>>>>> this?
> >>>>> Good catch. It looks like a bug to me. Want to post a patch for thi=
s?
> >>>> Thanks for the confirmation.
> >>>>
> >>>> What would be a good setup to catch this kind of migration bug? I
> >>>> tried to observe it in the VM expecting to see network applications
> >>>> not getting data correctly on the destination, but it was not
> >>>> successful (i.e. the VM on the destination just worked fine.) I didn=
't
> >>>> even see anything going wrong when I disabled the vhost logging
> >>>> completely without using vIOMMU.
> >>>>
> >>>> What I did is I ran multiple network benchmarks (e.g. netperf tcp
> >>>> stream and my own one to check correctness of received data) in a VM
> >>>> without vhost dirty page logging, and the benchmarks just ran fine i=
n
> >>>> the destination. I checked the used ring at the time the VM is stopp=
ed
> >>>> in the source for migration, and it had multiple descriptors that is
> >>>> (probably) not processed in the VM yet. Do you have any insight how =
it
> >>>> could just work and what would be a good setup to catch this?
> >>>
> >>> According to past experience, it could be reproduced by doing scp fro=
m
> >>> host to guest during migration.
> >>>
> >> Thanks. I actually tried that, but didn't see any problem either - I
> >> copied a large file during migration from host to guest (the copy
> >> continued on the destination), and checked md5 hashes using md5sum,
> >> but the copied file had the same checksum as the one in the host.
> >>
> >> Do you recall what kind of symptom you observed when the dirty pages
> >> were not migrated correctly with scp?
> >
> >
> > Yes,  the point is to make the migration converge before the end of
> > scp (e.g set migration speed to a very big value). If scp end before
> > migration, we won't catch the bug. And it's better to do several
> > rounds of migration during scp.
> >
> > Anyway, let me try to reproduce it tomorrow.
> >
>
> Looks like I can reproduce this, scp give the following error to me:
>
> scp /home/file root@192.168.100.4:/home
> file                                           63% 1301MB 58.1MB/s
> 00:12 ETAReceived disconnect from 192.168.100.4: 2: Packet corrupt
> lost connection

Thanks for sharing this.

I was able to reproduce the bug. I observed different md5sum in the
host and the guest after several tries. I didn't observe the
disconnect you saw, but the different md5sum is enough to show the
bug, I guess.

Thanks,
Jintack

>
> FYI, I use the following cli:
>
> numactl --cpunodebind 0 --membind 0 $qemu_path $img_path \
>             -netdev tap,id=3Dhn0,vhost=3Don \
>             -device ioh3420,id=3Droot.1,chassis=3D1 \
>             -device
> virtio-net-pci,bus=3Droot.1,netdev=3Dhn0,ats=3Don,disable-legacy=3Don,dis=
able-modern=3Doff,iommu_platform=3Don
> \
>             -device intel-iommu,device-iotlb=3Don \
>             -M q35 -m 4G -enable-kvm -cpu host -smp 2 $@
>
> Thanks
>
>
> > Thanks
>
