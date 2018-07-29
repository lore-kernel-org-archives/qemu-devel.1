Received: from eggs.gnu.org ([2001:4830:134:3::10]:47175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fjkGw-0005E3-De
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fjkGr-000528-Gn
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:54:02 -0400
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:49278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fjkGr-0004u9-CQ
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:53:57 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w6TBq6CS031416
	for <qemu-devel@nongnu.org>; Sun, 29 Jul 2018 07:53:50 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id BFFCC6D
	for <qemu-devel@nongnu.org>; Sun, 29 Jul 2018 07:53:50 -0400 (EDT)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id AAB2C6D
	for <qemu-devel@nongnu.org>; Sun, 29 Jul 2018 07:53:50 -0400 (EDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
	[209.85.221.71])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w6TBrn4W021818
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 29 Jul 2018 07:53:50 -0400
Received: by mail-wr1-f71.google.com with SMTP id a9-v6so7274059wrw.20
	for <qemu-devel@nongnu.org>; Sun, 29 Jul 2018 04:53:50 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
	[209.85.221.54]) by smtp.gmail.com with ESMTPSA id
	l5-v6sm7645453wrq.86.2018.07.29.04.53.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 29 Jul 2018 04:53:48 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t13-v6so9351124wrv.12
	for <qemu-devel@nongnu.org>; Sun, 29 Jul 2018 04:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyh4xjUmwHr7b=92y7YUwKGSW0o+FUMwJLSehdzuFc3R6eLTg@mail.gmail.com>
	<20180724055501.GA2479@xz-mi>
	<CAHyh4xhOWbhs50jsT1_SzKqaGoiaZH3oLto_x7QE8UNfW+9M7g@mail.gmail.com>
	<B6A12E36-F118-473C-B90A-B4F897334D1F@redhat.com>
In-Reply-To: <B6A12E36-F118-473C-B90A-B4F897334D1F@redhat.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Sun, 29 Jul 2018 07:53:15 -0400
Message-ID: <CAHyh4xiGJCCfG-A9Zyy1nU6jPasXQrxr9DOeUegTEhdbA3vaAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Virtual IOMMU + Virtio-net devices in a Windows VM
 doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yvugenfi@redhat.com
Cc: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, "\\ Michael S . Tsirkin \\" <mst@redhat.com>

Thanks, Yan.

On Sun, Jul 29, 2018 at 7:44 AM Yan Vugenfirer <yvugenfi@redhat.com> wrote:
>
>
>
> > On 26 Jul 2018, at 05:53, Jintack Lim <jintack@cs.columbia.edu> wrote:
> >
> > Hi Peter,
> >
> > On Tue, Jul 24, 2018 at 1:55 AM Peter Xu <peterx@redhat.com> wrote:
> >>
> >> On Mon, Jul 23, 2018 at 04:13:18PM -0400, Jintack Lim wrote:
> >>> Hi,
> >>>
> >>> I'm running a Windows VM on top of KVM on x86, and one of virtio-net
> Hi,
>
> What Windows OS are you using? Keep in mind that IOMMU support in Windows=
 drivers will work in Windows 10 and Windows Server 2016.
> What=E2=80=99s the version of the virtio-win drivers are you using (shoul=
d be build 150 and up, or to include the following commit: https://github.c=
om/virtio-win/kvm-guest-drivers-windows/commit/eac3270d10924903ff38a08fcdaa=
252604d2e4a9)?
>

I'm using Windows Server 2016, and the virtio-win driver version is
0.1.149, which is the latest binary from here [1]. I'll try to build
150, and test it again. Thanks for the confirmation!

[1] https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtua=
l-machines-using-virtio-drivers.html

> Best regards,
> Yan.
>
> >>> device in the Windows VM doesn't seem to work. I provided virtual
> >>> IOMMU and two virtio-net devices to the VM: one bypassing the virtual
> >>> IOMMU and the other one behind the virtual IOMMU[1]. It turned out
> >>> that the virtio-net device behind virtual IOMMU didn't work while the
> >>> one bypassing the virtual IOMMU worked well. In a linux VM with the
> >>> same configuration, both of virtio-net device worked well.
> >>>
> >>> I found that there is a subtle difference between virtio-net devices
> >>> bypassing and behind virtual IOMMU in a Linux VM. The lscpu command i=
n
> >>> the Linux VM shows different device names for them; the first line is
> >>> for the bypassing one, and the second line is for the one behind the
> >>> virtual IOMMU
> >>>
> >>> 00:03.0 Ethernet controller: Red Hat, Inc Virtio network device
> >>> 01:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
> >>>
> >>> I wonder if this difference somehow caused the problem in the Windows
> >>> VM. I've installed the latest virtio drivers (0.1.149) from the fedor=
a
> >>> project [2]
> >>>
> >>> Any thoughts?
> >>>
> >>> I'm using v4.15 Linux kernel as a host, and QEMU 2.11.0.
> >>
> >> Have you tried the latest QEMU?
> >>
> >
> > I just tried the latest QEMU, but observed the same symptom.
> >
> >> Also CC Jason and Michael.
> >
> > Thanks!
> >
> >>
> >>>
> >>> Thanks,
> >>> Jintack
> >>>
> >>> [1] https://wiki.qemu.org/Features/VT-d
> >>> [2] https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-=
virtual-machines-using-virtio-drivers.html
> >>>
> >>>
> >>
> >> Regards,
> >>
> >> --
> >> Peter Xu
> >>
> >
> >
>
>
