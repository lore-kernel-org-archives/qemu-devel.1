Received: from eggs.gnu.org ([2001:4830:134:3::10]:39571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fhhDC-00006C-Si
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fhhD8-0007Yo-PH
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:13:42 -0400
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:54782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fhhD8-0007F0-Ks
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:13:38 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w6NKBvoB029461
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 16:13:32 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 9FFFA7E
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 16:13:32 -0400 (EDT)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 7F6797E
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 16:13:32 -0400 (EDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
	[209.85.208.69])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w6NKDVDF007378
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 16:13:32 -0400
Received: by mail-ed1-f69.google.com with SMTP id f8-v6so824367eds.6
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:13:32 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com.
	[74.125.82.44]) by smtp.gmail.com with ESMTPSA id
	r11-v6sm4414370edh.32.2018.07.23.13.13.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 23 Jul 2018 13:13:30 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id c14-v6so330348wmb.4
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:13:30 -0700 (PDT)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Mon, 23 Jul 2018 16:13:18 -0400
Message-ID: <CAHyh4xjUmwHr7b=92y7YUwKGSW0o+FUMwJLSehdzuFc3R6eLTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Virtual IOMMU + Virtio-net devices in a Windows VM
 doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>

Hi,

I'm running a Windows VM on top of KVM on x86, and one of virtio-net
device in the Windows VM doesn't seem to work. I provided virtual
IOMMU and two virtio-net devices to the VM: one bypassing the virtual
IOMMU and the other one behind the virtual IOMMU[1]. It turned out
that the virtio-net device behind virtual IOMMU didn't work while the
one bypassing the virtual IOMMU worked well. In a linux VM with the
same configuration, both of virtio-net device worked well.

I found that there is a subtle difference between virtio-net devices
bypassing and behind virtual IOMMU in a Linux VM. The lscpu command in
the Linux VM shows different device names for them; the first line is
for the bypassing one, and the second line is for the one behind the
virtual IOMMU

00:03.0 Ethernet controller: Red Hat, Inc Virtio network device
01:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)

I wonder if this difference somehow caused the problem in the Windows
VM. I've installed the latest virtio drivers (0.1.149) from the fedora
project [2]

Any thoughts?

I'm using v4.15 Linux kernel as a host, and QEMU 2.11.0.

Thanks,
Jintack

[1] https://wiki.qemu.org/Features/VT-d
[2] https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtual-machines-using-virtio-drivers.html
