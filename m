Received: from eggs.gnu.org ([2001:4830:134:3::10]:47905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unix.co@gmail.com>) id 1cTlxp-0004UI-TG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unix.co@gmail.com>) id 1cTlxp-0008Uh-4S
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:51:29 -0500
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:35855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <unix.co@gmail.com>) id 1cTlxo-0008Tg-Vw
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:51:29 -0500
Received: by mail-qt0-x229.google.com with SMTP id k15so5621054qtg.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 00:51:27 -0800 (PST)
MIME-Version: 1.0
From: Umar Draz <unix.co@gmail.com>
Date: Wed, 18 Jan 2017 13:51:26 +0500
Message-ID: <CAAKRE72RN=DvVqxYMba5KdnWQ+jrAXTpxQc7Qdgiymu6oByosg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] VM Hung issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I am running qemu-kvm on CentOS 7.3, I have few vms of CentOS and Windows
2012 servers.

Randomly they are hung, but the status of virtual machine keep running, vnc
and network not responding.

I have checked all /var/log/messages and /var/log/libvirt/qemu/vm.log but
nothing found anything wrong.

Here is the following packages list regarding qemu and libvirt.

libvirt-daemon-driver-qemu-2.0.0-10.el7_3.2.x86_64
libvirt-2.0.0-10.el7_3.2.x86_64
ipxe-roms-qemu-20160127-5.git6366fa7a.el7.noarch
qemu-img-1.5.3-126.el7.x86_64
qemu-guest-agent-2.5.0-3.el7.x86_64
qemu-kvm-1.5.3-126.el7.x86_64
qemu-kvm-common-1.5.3-126.el7.x86_64

Would you please help what should I do more so I can find the issue.

-- Umar
