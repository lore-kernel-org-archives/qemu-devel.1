Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cbi4G-0001Jz-R0
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 01:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cbi4D-0007hK-M6
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 01:18:56 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:15626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cbi4D-0007gQ-2n
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 01:18:53 -0500
Message-ID: <589C099A.9090605@huawei.com>
Date: Thu, 9 Feb 2017 14:18:02 +0800
From: hangaohuai <hangaohuai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org

Dear all:
I try to boot windows2012R2 (more than 64 cores)on kvm platform with hyper-v on*<relaxed state='on'/>*.
the guest halts on the starting time.
Also tested in these cases:
<topology sockets='64' cores='1' threads='1'/>  - boot sucess
<topology sockets='1' cores='64' threads='1'/>  - boot sucess
<topology sockets='1' cores='1' threads='64'/>  - boot sucess
<topology sockets='1' cores='68' threads='1'/>  - boot failed
<topology sockets='68' cores='1' threads='1'/>  - boot sucess(in Guest we can found 64)
<topology sockets='1' cores='1' threads='68'/>  - boot failed

Environment:
GUEST:
  windows2012R2
HOST:
    kernel version:4.10.0-rc4
    QEMU version:QEMU emulator version 2.8.50 (v2.8.0-664-gd1c82f7-dirty)
part of GuestXML:
  <vcpu placement='static'>68</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.3'>hvm</type>
    <boot dev='hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <pae/>
    <hyperv>
      <relaxed state='on'/>
    </hyperv>
  </features>
  <cpu>
    <topology sockets='1' cores='68' threads='1'/>
  </cpu>

//////////////////////////////////
debug info:
virsh qemu-monitor-command win2012 --hmp "info cpus"
  CPU #61: pc=0xfffff8031296a21c thread_id=21410
  CPU #62: pc=0xfffff8031296a21c thread_id=21411
  CPU #63: pc=0xfffff8031296a21c thread_id=21414
  CPU #64: pc=0x00000000000fd31c (halted) thread_id=21415
  CPU #65: pc=0x00000000000fd31c (halted) thread_id=21416
  CPU #66: pc=0x00000000000fd31c (halted) thread_id=21417
  CPU #67: pc=0x00000000000fd31c (halted) thread_id=21418


Any suggestions?

Thanks a lot.

Gaohuai Han
