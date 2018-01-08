Received: from eggs.gnu.org ([2001:4830:134:3::10]:54979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eYdde-0001FA-Db
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eYdda-0004UK-Dy
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:03:18 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:13349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eYdda-0004TE-44
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:03:14 -0500
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <cb61acc7-1a7a-616a-e2f7-29e8226ca0c3@profihost.ag>
Date: Mon, 8 Jan 2018 21:03:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] how to pass pcid to guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello,

for meltdown mitigation and performance it's important to have the pcid
flag passed down to the guest (f.e.
https://groups.google.com/forum/m/#!topic/mechanical-sympathy/L9mHTbeQLNU).

My host shows the flag:
# grep ' pcid ' /proc/cpuinfo  | wc -l
56

But the guest does not:
# grep pcid /proc/cpuinfo
#

Guest was started with:
-cpu IvyBridge,+kvm_pv_unhalt,+kvm_pv_eoi,enforce,vendor=GenuineIntel

Qemu is 2.9.1

Thanks!

Greets,
Stefan
