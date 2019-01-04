Received: from eggs.gnu.org ([208.118.235.92]:35934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gfVym-0006ko-LF
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gfVyj-0000Go-GT
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:22:04 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:59676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gfVyj-00007f-Bz
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:22:01 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	x04KLtn3008286
	for <qemu-devel@nongnu.org>; Fri, 4 Jan 2019 15:21:55 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 7CF498B
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 15:21:55 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 3B5236D
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 15:21:41 -0500 (EST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
	[209.85.208.70])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	x04KLe2M044616
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 4 Jan 2019 15:21:41 -0500
Received: by mail-ed1-f70.google.com with SMTP id d41so35113364eda.12
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 12:21:40 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
	[209.85.128.46]) by smtp.gmail.com with ESMTPSA id
	q4sm23355189eda.50.2019.01.04.12.21.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jan 2019 12:21:38 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id y185so1798786wmd.1
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 12:21:38 -0800 (PST)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Fri, 4 Jan 2019 15:21:27 -0500
Message-ID: <CAHyh4xhv5ZDfZv842U=adQN7hQFr=16BKEgZcEUZOLjFo3P+Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Why one virtio-pci device has two different
 DeviceState?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>

Hi,

I was wondering why one virtio-pci device has two different
DeviceState? - one directly from VirtIOPCIProxy and the other from
VirtIO<dev type> such as VirtIONet. As an example, they are denoted as
qdev and vdev respectively in virtio_net_pci_realize().

I thought that just one DeviceState is enough for any device in QEMU.
Maybe I'm missing something fundamental here.

*Just* for people who wonder why I'm asking this question, I'd like to
find a device in the list of SaveStateEntry on a MMIO operation to a
PCI device. For virtio devices, I only have qdev information in the
MMIO handler while I need to have vdev information to find the virtio
device in the SaveStateEntry list. I can possibly do this by
converting qdev to vdev knowing this is a virtio device as in
virtio_net_pci_realize(), but I'd like to find a way to do it without
knowing the device is a virtio device.

Thanks,
Jintack
