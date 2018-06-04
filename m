Received: from eggs.gnu.org ([2001:4830:134:3::10]:53287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <llvilanovag@gmail.com>) id 1fPmin-0005yE-52
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <llvilanovag@gmail.com>) id 1fPmim-0007dk-8g
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:17 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:40528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <llvilanovag@gmail.com>)
	id 1fPmim-0007dR-2L
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:16 -0400
Received: by mail-pg0-x22d.google.com with SMTP id l2-v6so14280791pgc.7
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 03:28:15 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <llvilanovag@gmail.com>
Date: Mon, 4 Jun 2018 13:27:58 +0300
Message-ID: <CANyMRgRUyZibWnjgWgD_LisUX39cdLeVu=G_YVHWJDnW3=fnYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Starting KVM/VMX guest with non-exiting RDTSC
 instruction
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

Is there some way to start a KVM-accelerated VM with QEMU (on an Intel/VMX
host) that is configured so that RDTSC/RDTSCP instructions won't cause a
VM-exit?

According to Intel's manual, it seems I should disable the "RDTSC exiting"
bit on the MSR that Linux identifies as MSR_IA32_VMX_PROCBASED_CTLS (in its
KVM code).

I've checked the vmxcap script from qemu:

$ sudo /tmp/vmvm-vilanova/vmxcap.py | grep -i rdtsc
  RDTSC exiting                            yes
  Enable RDTSCP                            yes

So, can I somehow curbe QEMU+KVM to disable RDTSC exiting?

Thanks,
Lluis
