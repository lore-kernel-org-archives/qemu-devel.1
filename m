Received: from eggs.gnu.org ([2001:4830:134:3::10]:43987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eBdr8-0000Wo-EM
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eBdr5-0007jl-8r
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:38:10 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:11741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eBdr4-0007hv-UF
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:38:07 -0500
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <1b862cf2-2fee-3243-cb54-2780ace6f25b@profihost.ag>
Date: Mon, 6 Nov 2017 10:38:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] kvm: virtio-net: saved image requires TUN_F_UFO support
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

i've upgraded some servers from kernel 4.4 to 4.12 - both running Qemu
2.9.1.

If i migrate a VM from a host running kernel 4.4 to a host running 4.12
i get:

kvm: virtio-net: saved image requires TUN_F_UFO support
kvm: Failed to load virtio-net-device:tmp
kvm: Failed to load virtio-net:virtio
kvm: error while loading state for instance 0x0 of device
'0000:00:12.0/virtio-net'
kvm: load of migration failed: Invalid argument


while migrating from 4.12 to 4.4 works fine.

Can anybody help? Is this expected?

Greets,
Stefan
