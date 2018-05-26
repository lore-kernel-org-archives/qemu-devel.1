Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <info@vintageelectronics.ca>) id 1fMdnp-00020k-1S
	for qemu-devel@nongnu.org; Sat, 26 May 2018 14:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <info@vintageelectronics.ca>) id 1fMdnk-0007TU-Mv
	for qemu-devel@nongnu.org; Sat, 26 May 2018 14:20:28 -0400
Received: from 24-65.162.static.aei.ca ([216.162.65.24]:10924
	helo=mail.earthlovesme.ca)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <info@vintageelectronics.ca>)
	id 1fMdnj-0007Ob-6k
	for qemu-devel@nongnu.org; Sat, 26 May 2018 14:20:24 -0400
From: info@vintageelectronics.ca
Message-ID: <e9e38261-5957-7c61-b69f-6aa770cea287@vintageelectronics.ca>
Date: Sat, 26 May 2018 13:19:20 -0400
MIME-Version: 1.0
Content-Language: en-CA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Not able to install QNX into a VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,


I tried to create a VM for QNX in a Virtualbox first. It installed 
successfully, but then could not boot from the virtual HDD. I googled, 
and found a couple of posts about how at some point VB and QEMU both 
implemented the busmaster bit for storage controllers and that broke QNX 
and some other OSs, but then VB team refused to address that, while QEMU 
team created a patch which is in the latest QEMU.

So I installed QEMU (the latest as of this moment) into a Fedora 26 host 
and created a new VM. I set CDROM to be the device 0 on IDE and HDD to 
be the device 1. Then I booted into this VM and hit F2 to advance into 
the "Auto-detecting Hardware..." screen of the QNX installer.

Unlike Virtualbox, the QEMU VM takes quite some time to detect the 
devices, and especially long to detect cd0.0. Once detection completes, 
I see not one CD device, but two:

Then if I press F2, QNX installer asks to insert the installation CD 
into the drive.

This does not occur under Virtualbox. It only shows one CD device.

and once I hit F2 it advances to the next screen w/o a prompt to insert 
the CDROM

What is missing in QEMU VM that it does not see the CD which it just 
booted the OS installer from?


Thank you

Alex
