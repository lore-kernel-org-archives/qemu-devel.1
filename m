Received: from eggs.gnu.org ([209.51.188.92]:53201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <reader@fennosys.fi>) id 1hHdIW-000642-Cp
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <reader@fennosys.fi>) id 1hHd8Q-0005Qm-EJ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:41:35 -0400
Received: from smtp.fennosys.fi ([62.241.241.27]:45058 helo=mail.fennosys.fi)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <reader@fennosys.fi>) id 1hHd8O-0005P3-K5
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:41:34 -0400
Date: Sat, 20 Apr 2019 07:41:17 +0800
From: Antti Antinoja <reader@fennosys.fi>
Message-Id: <20190420074117.e4f4e200b576b0e9b034b0f4@fennosys.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Using --enable-kvm fails with WindowsXP guest on an
 AMD host (works on Intel host)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

After upgrading host (Gentoo Linux) a Windows XP guest can't boot anymore.

Some findings while testing:

* XP image boots & works OK on an Intel machine (Gentoo Linux)
** qemu: 3.1.0-r4
** kernel: 5.0.7
** CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz

* XP image FAILS to boot on an AMD machine (Gentoo Linux)
** qemu: 3.1.0-r4
** kernel: 4.19.34
** CPU: AMD FX-6300 Six-Core Processor
** image boots OK if NOT using --enable-kvm

* XP image FAILS to boot on an AMD machine (Gentoo Linux)
** qemu: 3.1.0-r4 & 3.1.0-r1
** kernel: 4.19.34 & 5.0.7
** CPU: AMD Opteron(tm) Processor 4170 HE
** image boots OK if NOT using --enable-kvm
** The image worked OK on this machine with Qemu 2.12.1 & Kernel 4.18.20

Booting to Safe Mode fails too (on mentioned AMD machines with --enbale-kvm). 

Trying various -cpu options on the AMD machines didn't seem to help either (qemu64, pentium3, etc).

There are no errors visible on the host (kernel logs etc clean). The guest boot just interrupts on very early state and Windows safe mode menu will loop forever.

All Linux VM's are working without issues.

Cheers,
Antti

-- 
Antti Antinoja <reader@fennosys.fi>
