Received: from eggs.gnu.org ([2001:4830:134:3::10]:40182)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1fVD93-0003Ma-Ps
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1fVD8z-0001Jh-TK
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:41:49 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:35528 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1fVD8z-0001Il-Jn
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:41:45 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:41:34 +0200
From: Peter Lieven <pl@kamp.de>
Message-ID: <0b14b035-0e63-8ac1-3558-fbf08ac28777@kamp.de>
Date: Tue, 19 Jun 2018 11:41:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] Assertion bus->irq_count[i] == 0 in Qemu 2.9.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,


ich habe some hosts running rather old Qemu Versions which sometimes show the following behaviour:


1) Live Migration

2) One Network Interface (virtio-net) stops forwarding traffic.

3) If I reboot the server I hit the following assertion

qemu-2.9.0: hw/pci/pci.c:311: pcibus_reset: Assertion `bus->irq_count[i] == 0' failed.


Does anybody remember this kind of error? Is this something that has already been fixed?


The patch:

commit 3936161f1fd72d1dfa577aaba910819c5e873260
Author: Herongguang (Stephen) <herongguang.he@huawei.com>
Date:   Tue Apr 25 10:29:54 2017 +0800

     pci: deassert intx when pci device unrealize

     If a pci device is not reset by VM (by writing into config space)
     and unplugged by VM, after that when VM reboots, qemu may assert:
     pcibus_reset: Assertion `bus->irq_count[i] == 0' failed


Is applied to our 2.9.0 tree.


Thanks,

Peter
