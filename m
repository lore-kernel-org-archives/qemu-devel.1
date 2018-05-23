Received: from eggs.gnu.org ([2001:4830:134:3::10]:39409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fLR3x-0004kC-Ak
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fLR3w-0008Gd-BH
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:32:09 -0400
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
	<3db651e3-a237-fbaa-6ffe-ecc5db43ad0f@tuxfamily.org>
	<E9FA9AA6-FDA6-467F-9B72-B331756464A7@xenosoft.de>
	<ccaa7d46-79d4-c223-3828-ae22a59392db@tuxfamily.org>
	<7d552162-5165-c022-ce6d-4903da7d2262@xenosoft.de>
	<20180519171949.0031d971@thl530.multi.box>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <c669b25f-4012-8394-4a3e-f9717ec62d25@xenosoft.de>
Date: Wed, 23 May 2018 12:31:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180519171949.0031d971@thl530.multi.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Subject: [Qemu-devel] [Qemu-ppc] [PPC64] P5020DS: Booting from img possible
 (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, qemu-devel@nongnu.org

Hi All,

I would like to say thank you for your help. My virtual e5500 PowerPC 
machine works without any problems on my PC. I can use ubuntu MATE 16.04 
LTS PowerPC with the RC6 of kernel 4.17 in a virtual e5500 QEMU 2.12.0 
machine with a VirtIO graphics card and with a connection to the network.

Screenshot: 
https://plus.google.com/u/0/photos/photo/115515624056477014971/6558706783010232546

Command:

/home/christian/Downloads/qemu-2.12.0/ppc64-softmmu/qemu-system-ppc64 -M 
ppce500 -cpu e5500 -m 2048 -kernel 
/home/christian/Downloads/uImage-4.17-QEMU-e1000 -drive 
format=raw,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img,index=0,if=virtio 
-nic user,model=e1000 -append "rw root=/dev/vda3" -device virtio-vga 
-device virtio-mouse-pci -device virtio-keyboard-pci

Cheers,
Christian
