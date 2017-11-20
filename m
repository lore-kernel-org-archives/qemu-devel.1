Received: from eggs.gnu.org ([2001:4830:134:3::10]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eGlH7-0000wE-VK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eGlH4-0008Kg-TW
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:34:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eGlH4-0008Ij-Ai
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:34:06 -0500
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <8726068c-1112-eaea-5315-ec17ae37ae33@huawei.com>
Date: Mon, 20 Nov 2017 20:32:38 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [question] mask SIGBUS in qemu main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, mst@redhat.com, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Ingo Molnar <mingo@redhat.com>
Cc: Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>

Hi all,
  sorry to disturb you, I have a question to consult with you why the SIGBUS mask bit is set in the Qemu main thread?
do we not want to Qemu main thread to handle the SIGBUS signal? thanks.
As shown in [1], the Qemu main thread PID is 30976.
"cat /proc/30976/status" in [2], we can see the "SigBlk: 0000000010002240", SIGBUS block bit is 7, so the SIGBUS block bit is set.
then the Qemu main thread will not be woken up if there is SIGBUS set to it.
thanks!


[1]:
# ps -eL | grep "qemu"
30976 30976 pts/7    00:00:00 qemu-system-x86
30976 30977 pts/7    00:00:00 qemu-system-x86

[2]
# cat /proc/30976/status
Name:   qemu-system-x86
State:  S (sleeping)
Tgid:   30976
Ngid:   0
Pid:    30976
PPid:   34807
TracerPid:      0
Uid:    1000    1000    1000    1000
Gid:    1000    1000    1000    1000
FDSize: 256
Groups: 4 24 27 30 46 108 114 115 1000
NStgid: 30976
NSpid:  30976
NSpgid: 30976
NSsid:  34772
VmPeak:   604260 kB
VmSize:   538724 kB
VmLck:         0 kB
VmPin:         0 kB
VmHWM:     34176 kB
VmRSS:     34176 kB
VmData:   294308 kB
VmStk:       136 kB
VmExe:      4808 kB
VmLib:     36144 kB
VmPTE:       528 kB
VmPMD:        16 kB
VmSwap:        0 kB
HugetlbPages:          0 kB
Threads:        2
SigQ:   6/514067
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000010002240
SigIgn: 0000000000001000
SigCgt: 0000000180004243
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000
Seccomp:        0
Cpus_allowed:   ffff,ffffffff
Cpus_allowed_list:      0-47
Mems_allowed:   00000000,00000003
Mems_allowed_list:      0-1
voluntary_ctxt_switches:        7638
nonvoluntary_ctxt_switches:     3
