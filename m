Received: from eggs.gnu.org ([2001:4830:134:3::10]:58913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJYSm-0003Mc-Ah
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJYSl-0005Ve-Dl
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:02:00 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::12]:32364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chzigotzky@xenosoft.de>)
	id 1fJYSk-0005Ua-Sr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:01:59 -0400
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
Date: Fri, 18 May 2018 08:01:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Subject: [Qemu-devel] [PPC64] P5020DS: Booting from img possible (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

|Hello,

I was able to boot a Linux kernel (uImage) with an initrd in a virtual 
P5020DS PPC64 machine with an e5500 core (QEMU 2.12.0) with the 
following command.

qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -initrd 
/home/christian/Downloads/slitaz25.gz -nographic -kernel 
/home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17 
-net nic,vlan=0,model=e1000 -net user,vlan=0 -machine 
dt_compatible=fsl,,P5020DS -append "root=/dev/ramdisk"

It also works with the machine 'MPC8544DS':

qemu-system-ppc64 -M mpc8544ds -cpu e5500 -m 2048 -initrd 
/home/christian/Downloads/slitaz25.gz -nographic -kernel 
/home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17 
-net nic,vlan=0,model=e1000 -net user,vlan=0 -machine 
dt_compatible=fsl,,P5020DS -append "root=/dev/ramdisk"

I tried to boot ubuntu MATE 16.04 LTS PowerPC from an img with the 
option '-drive' but without any success. Is it possible to boot from a 
hard disk img with a virtual P5020DS PPC64 machine? Can I use a virtual 
graphics card with this machine?

Have a nice weekend! :-)

Thanks,
Christian
|
