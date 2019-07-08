Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75205C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 03:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A94220673
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 03:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A94220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkK3w-0005d7-IA
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 23:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkK3I-0005Bh-HC
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 23:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkK3E-0005C0-KD
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 23:10:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:34626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkK3E-0005BZ-An
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 23:10:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkK3D-0004Me-4f
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 03:10:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 14EF02E80C7
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 03:10:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jul 2019 03:05:01 -0000
From: Abdulla <1835694@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alhaddad2000
X-Launchpad-Bug-Reporter: Abdulla (alhaddad2000)
X-Launchpad-Bug-Modifier: Abdulla (alhaddad2000)
Message-Id: <156255510137.2177.7648111145482157380.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: f4d884f84567920a47a64f76889212c6409e5baf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1835694] [NEW] hardware-based time keeping
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1835694 <1835694@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi all,

I hope you're all doing well.

As i was looking for a solution for a particular problem in Qemu/KVM
virtualization.

My issue is that I have a virtual machine that runs well in VMware and when
I migrated that to Qemu/KVM-enabled environment, it didn't work! I figured
out that under VMware hypervisor, VMware supplies CPU TSC and Performance
Counters values to the guest VM with the option
"monitor_control.pseudo_perfctr =3D TRUE" set the vmx configuration file,
Ref.: https://www.vmware.com/pdf/vmware_timekeeping.pdf

My question is, is there any similar option in Qemu/KVM-enabled environment
that I can use to get my VM working the same way as in the VMware
environment?

I almost tried all options in Qemu with regards to CPU but no avail.

To elaborate more, the VM I'm trying to port under Qemu/KVM environment is
a an old version of Cisco virtual ASA Firewall. The VM image is actually
meant to be run under VMware ESXi and with that
"*monitor_control.pseudo_perfctr
=3D TRUE*" option it can also run in Vware Workstation as well. *Yes, this
option that makes it run under VMware and if it's removed from the
configuration vmx file then the VM boots half way and crashes the same way
it crashes under Qemu*. That dictates it's the option in interest that
needs to be found in Qemu/KVM. I have a copy of this VM in the below link
in case you would like to try its behavior in under VMware. I downloaded it
from a youtube previously to test it out:

https://drive.google.com/open?id=3D1SEXws18hoj2sWGk8iFqqH8RpBZsBNpRH

Once you power on the VM you can telnet to 127.0.0.1 on port 3000 to see
the boot process. If you remove that option i mentioned to you and boot the
VM again you'll see the crashing in process.


I've converted that vmdk disk images into Qemu disks "qcow2" format and i
ran them using the below command line on Ubuntu:

/opt/qemu/bin/qemu-system-x86_64 -L -nographic -device
e1000-82545em,netdev=3Dnet0,mac=3D50:00:00:6a:00:00 -netdev
tap,id=3Dnet0,ifname=3Dvunl0_33_0,script=3Dno -device
e1000-82545em,netdev=3Dnet1,mac=3D50:00:00:6a:00:01 -netdev
tap,id=3Dnet1,ifname=3Dvunl0_33_1,script=3Dno -device
e1000-82545em,netdev=3Dnet2,mac=3D50:00:00:6a:00:02 -netdev
tap,id=3Dnet2,ifname=3Dvunl0_33_2,script=3Dno -device
e1000-82545em,netdev=3Dnet3,mac=3D50:00:00:6a:00:03 -netdev
tap,id=3Dnet3,ifname=3Dvunl0_33_3,script=3Dno -machine type=3Dpc-1.0  *-cpu
host,migratable=3Doff,invtsc=3Don,pmu=3Don* -m 4096 -hda hda.qcow2 -hdb hdb=
.qcow2
-serial telnet:0.0.0.0:3000,server,nowait -monitor
tcp:127.0.0.1:42379,server,nowait
-nographic -display none -enable-kvm


Once you power on the VM you can telnet to xx.xx.xx.xx 3000 (where the xx
IP is the Ubuntu machine IP) to see the crashing in process. You may need
to wait for a while for the status messages to appear in the terminal
window.

I assume it's a cpu issue because in page 9 of the Vmware pdf reference
file; it says there are machine instructions become available when this
option "*monitor_control.pseudo_perfctr =3D TRUE*" is enabled:

The following machine instructions then become available:

Instruction    Time Value    Returned
rdpmc           0x10000       Physical host TSC
rdpmc           0x10001       Elapsed real time in ns
rdpmc           0x10002       Elapsed apparent time in ns

Therefore, I used many of the Qemu cpu options such as these:

-cpu host,migratable=3Dno,+invtsc (ref: https://wiki.qemu.org/ChangeLog/2.1)
-cpu host, tsc-frequency=3Dxxxx (ref: https://lists.gnu.org/archive/
html/qemu-devel/2017-01/msg03555.html)
 -cpu host,migratable=3Doff,invtsc=3Dtrue,pmu=3Dtrue

Not sure if i'm hitting the wrong option!

The log I'm getting when the VM boots up looks like the following crash
happens at the blue colored log:

---------------------------------------------------------------------------=
-------------------------------------------------
Loading...

Starting image verification
Hash Computation:    100% Done!
Computed Hash   SHA2: 63c1e8aa9de3d0c6e738dc91be8e1784
                      5caf64af4cf06cf6a3c5da7200d478dd
                      938d380d2b1064f6a349401c7860f50e
                      cc4eeb98a0ae16c097dbc9447d4d6626

Get key records from key storage: Primary, key_store_type: 2
Embedded Hash   SHA2: 63c1e8aa9de3d0c6e738dc91be8e1784
                      5caf64af4cf06cf6a3c5da7200d478dd
                      938d380d2b1064f6a349401c7860f50e
                      cc4eeb98a0ae16c097dbc9447d4d6626

The digital signature of the running image verified successfully
Processor memory 3183296512, Reserved memory: 0

Total NICs found: 4
i82545EM rev03 Gigabit Ethernet @ irq10 dev 6 index 03 MAC: 5000.006a.0003
i82545EM rev03 Gigabit Ethernet @ irq10 dev 5 index 02 MAC: 5000.006a.0002
i82545EM rev03 Gigabit Ethernet @ irq11 dev 4 index 01 MAC: 5000.006a.0001
i82545EM rev03 Gigabit Ethernet @ irq11 dev 3 index 00 MAC: 5000.006a.0000

Thread Name: lina_flash_init_thread
Page fault: Unknown
        r8 0x0000000000000790
        r9 0x00007fff3fa8b000
       r10 0x0000000000000001
       r11 0x000000000210e130
       r12 0x00000000062ebfc0
       r13 0x0000000000010001
       r14 0x0000000000000000
       r15 0x00000000062ebfc0
       rdi 0x00000000062ebfc0
       rsi 0x0000000006c17c20
       rbp 0x00007fff4056f4e0
       rbx 0x00000000062ebfc0
       rdx 0x00007fff40566f10
       rax 0x0000000000000001
       rcx 0x0000000000010001
       rsp 0x00007fff4056f4b0
       rip 0x0000000001581130
    eflags 0x0000000000013202
    csgsfs 0x0000000000000033
error code 0x0000000000000000
    vector 0x000000000000000d
  old mask 0xffffffde3e3b5a05
       cr2 0x0000000000000000

Cisco Adaptive Security Appliance Software Version 9.3(1)

Compiled on Wed 23-Jul-14 18:16 PDT by builders
Hardware:   ASAv
Crashinfo collected on 03:42:24.059 UTC Tue Nov 28 2017

Traceback:
0: 0x0000000000422118
1: 0x0000000000422152
2: 0x0000000000424331
3: 0x00000000015874a9
4: 0x00007ffffecd55f0
5: 0x0000000000558d85
6: 0x00000000008f5a2b
7: 0x00000000008fd361
8: 0x0000000000428a15
Stack dump: base:0x00007fff4056f2e0 size:178, active:178
     entries above '=3D=3D': return PC preceded by input parameters
     entries below '=3D=3D': local variables followed by saved regs
                 '=3D=3DFn': stack frame n, contains next stack frame
                    '*': stack pointer at crash
 rdi rsi rdx rcx r8 r9 : Arguments 1 through 6 to leaf function
 For example:
    0x00007fffeeeeef00: 0x0000000000000009     : arg9
    0x00007fffeeeeeefc: 0x0000000000000008     : arg8
    0x00007fffeeeeeef8: 0x0000000000000007     : arg7
    0x00007fffeeeeeef4: 0x0000000000000abc     : return PC
    0x00007fffeeeeeef0: 0x00007fffeeeeef20 =3D=3DF2: stack frame F2
    0x00007fffeeeeeeec: 0x0000000000000def     : local variable
    0x00007fffeeeeeee8: 0x0000000000000123     : local variable or saved reg
    0x00007fffeeeeeee4: 0x0000000000000456     : local variable or saved reg
    0x00007fffeeeeeee0: 0x0000000000000789     : local variable or saved reg
0x00007fff4056f870: 0x00007fff4056f7e0
0x00007fff4056f868: 0x0000000000000000
0x00007fff4056f860: 0x00000038a11c0123
0x00007fff4056f858: 0x0000000000000083
0x00007fff4056f850: 0x00007fff16a864c8
0x00007fff4056f848: 0x0000000000000000
0x00007fff4056f840: 0x00000000a11ccdef
0x00007fff4056f838-0x00007fff4056f808: 0x0000000000000000
0x00007fff4056f800: 0x0000000000429867
0x00007fff4056f7f8: 0x00007fff4056f860
0x00007fff4056f7f0: 0x00007fff40567100
0x00007fff4056f7e8: 0x0000000000000000
0x00007fff4056f7e0: 0x00000030a11c0123
0x00007fff4056f7d8: 0x0000000000000083
0x00007fff4056f7d0: 0x00007fff16a864c8
0x00007fff4056f7c8: 0x0000000000000000
0x00007fff4056f7c0: 0x00000000a11ccdef
0x00007fff4056f7b8: 0x0fffffff0fffffff
0x00007fff4056f7b0-0x00007fff4056f7a8: 0x0000000000000000
0x00007fff4056f7a0: 0x00000000062cc8a0
0x00007fff4056f798: 0x0000000000000000
0x00007fff4056f790: 0x00007fff4056f6e0
0x00007fff4056f788: 0x00007fff4056f758
0x00007fff4056f780: 0x0000000000000000
0x00007fff4056f778: 0x00007fff3ff48620
0x00007fff4056f770-0x00007fff4056f730: 0x0000000000000000
0x00007fff4056f728: 0x0000000004d14940
0x00007fff4056f720: 0x000000000041d690
0x00007fff4056f718: 0x0000000002777640
0x00007fff4056f710: 0x0000000200010010
0x00007fff4056f708: 0x0000000006c17d40
0x00007fff4056f700: 0x00007fff4056f6e0
0x00007fff4056f6f8: 0x00007fff40150e80
0x00007fff4056f6f0: 0x000000000638e598
0x00007fff4056f6e8: 0x00007fff3ff48620
0x00007fff4056f6e0: 0x00007fff4056f778
0x00007fff4056f6d8: 0x00000000deadfeed
0x00007fff4056f6d0-0x00007fff4056f6c8: 0x0000000000000000
0x00007fff4056f6c0: 0x000000000041e1f6
0x00007fff4056f6b8: 0x00007fff40571fd0
0x00007fff4056f6b0: 0x00007fff40560cf0
0x00007fff4056f6a8: 0x0000000000000000
0x00007fff4056f6a0: 0x000000f0a11c0123
0x00007fff4056f698: 0x0000000000000143
0x00007fff4056f690: 0x00007fff16a864c8
0x00007fff4056f688: 0x0000000000000000
0x00007fff4056f680: 0x00000000a11ccdef
0x00007fff4056f678-0x00007fff4056f660: 0x0000000000000000 =3D=3DF5
0x00007fff4056f658: 0x000000009abcdef0
0x00007fff4056f650-0x00007fff4056f5b8: 0x123456789abcdef0
0x00007fff4056f5b0: 0x0000000000428a01
0x00007fff4056f5a8: 0x00007fff4056f570
0x00007fff4056f5a0-0x00007fff4056f590: 0x0000000000000000
0x00007fff4056f588: 0xffffffffffffdf98
0x00007fff4056f580: 0x00007fff4056f670
0x00007fff4056f578: 0x00007fff3ff48370
0x00007fff4056f570: 0x0000000000000000
0x00007fff4056f568: 0x0000000000428a15
0x00007fff4056f560: 0x00007fff4056f670 =3D=3DF4
0x00007fff4056f558: 0x00000000008fd361
0x00007fff4056f550: 0x00007fff4056f560 =3D=3DF3
0x00007fff4056f548: 0x00000000008f5a2b
0x00007fff4056f540: 0x00007fff4056f550 =3D=3DF2
0x00007fff4056f538: 0x0000000000000000
0x00007fff4056f530: 0xffffffffffffdf98
0x00007fff4056f528: 0x00007fff3ff48370
0x00007fff4056f520: 0x00000000008fba90
0x00007fff4056f518: 0x00000000008fb908
0x00007fff4056f510: 0x00007fff4056f550
0x00007fff4056f508: 0x00000000008fb87e
0x00007fff4056f500: 0x00007fff4056f510
0x00007fff4056f4f8: 0x0000000000000000
0x00007fff4056f4f0: 0xffffffffffffdf98
0x00007fff4056f4e8: 0x0000000000558d85
0x00007fff4056f4e0: 0x00007fff4056f540 =3D=3DF1
0x00007fff4056f4d8-0x00007fff4056f4d0: 0x0000000000000000
0x00007fff4056f4c8: 0x0000000000000001
0x00007fff4056f4c0-0x00007fff4056f4b8: 0x00000000062ebfc0
0x00007fff4056f4b0: 0x0000000000000000 *
0x00007fff4056f4a8: 0x00000000008fd973
0x00007fff4056f4a0: 0x00007fff4056f4d0
0x00007fff4056f498: 0x00007fff40563908
0x00007fff4056f490: 0x00007fff4056f4d0
0x00007fff4056f488: 0x00000000009d4b01
0x00007fff4056f480: 0x00007fff4056f4a0
0x00007fff4056f478-0x00007fff4056f470: 0x0000000000000000
0x00007fff4056f468: 0x00007fff418d6390
0x00007fff4056f460: 0x0000000000000000
0x00007fff4056f458: 0x000000000201b9f8
0x00007fff4056f450: 0x00007fff4056f480
0x00007fff4056f448: 0x00007fff40563908
0x00007fff4056f440: 0x0000000000000001
0x00007fff4056f438: 0x00007fff405619a0
0x00007fff4056f430: 0x00007fff40563908
0x00007fff4056f428: 0x0000000000000001
0x00007fff4056f420: 0x0000000000000000
0x00007fff4056f418: 0x0000000001627125
0x00007fff4056f410: 0x00007fff4056f450
0x00007fff4056f408: 0x00007fff3fa8b010
0x00007fff4056f400: 0x00007fff46505845
0x00007fff4056f3f8-0x00007fff4056f3c8: 0x0000000000000000
0x00007fff4056f3c0: 0x0000000000000003
0x00007fff4056f3b8-0x00007fff4056f3a8: 0x0000000000000000
0x00007fff4056f3a0: 0x0000000000000240
0x00007fff4056f398: 0x0000000000000003
0x00007fff4056f390: 0x0000024446505853
0x00007fff4056f388-0x00007fff4056f310: 0x0000000000000000
0x00007fff4056f308: 0x424b7e25fece8fc2
0x00007fff4056f300: 0x2cc4f98473045e95
0x00007fff4056f2f8: 0x18fa9b6c57ca0e78
0x00007fff4056f2f0: 0x081e2a254ab96aa4
0x00007fff4056f2e8: 0x0000000300000000

Begin to dump crashinfo to flash....

core0: An internal error occurred.  Specifically, a programming assertion
was
violated.  Copy the error message exactly as it appears, and get the
output of the show version command and the contents of the configuration
file.  Then call your technical support representative.

assertion "_vf_mode_init" failed: file "vf_api.c", line 136
core0 same core snap_count=3D1 signo=3D6 RIP=3D7ffffecd43fb


-----------------------------------------------
Traceback output aborted.
Flushing first exception frame:
Page fault: Unknown
        r8 0x0000000000000790
        r9 0x00007fff3fa8b000
       r10 0x0000000000000001
       r11 0x000000000210e130
       r12 0x00000000062ebfc0
       r13 0x0000000000010001
       r14 0x0000000000000000
       r15 0x00000000062ebfc0
       rdi 0x00000000062ebfc0
       rsi 0x0000000006c17c20
       rbp 0x00007fff4056f4e0
       rbx 0x00000000062ebfc0
       rdx 0x00007fff40566f10
       rax 0x0000000000000001
       rcx 0x0000000000010001
       rsp 0x00007fff4056f4b0
       rip 0x0000000001581130
    eflags 0x0000000000013202
    csgsfs 0x0000000000000033
error code 0x0000000000000000
    vector 0x000000000000000d
  old mask 0xffffffde3e3b5a05
       cr2 0x0000000000000000
Nested traceback attempted via signal, from:
Abort: Unknown
        r8 0x000000000000003c
        r9 0x0000000005097a27
       r10 0x00007fff4056de28
       r11 0x0000000000003206
       r12 0x0000000000000001
       r13 0x00007fff4056df80
       r14 0x0000000000000000
       r15 0x0000000000000006
       rdi 0x0000000000000008
       rsi 0x00007fff4056df80
       rbp 0x00007fff4056dfc0
       rbx 0x00007fff29f6b780
       rdx 0x0000000000000010
       rax 0x0000000000000010
       rcx 0xffffffffffffffff
       rsp 0x00007fff4056df50
       rip 0x00007ffffecd43fb
    eflags 0x0000000000003206
    csgsfs 0x1234000000000033
error code 0x0000000000000000
    vector 0x000000000000000d
  old mask 0xffffffde3e3b5a05
       cr2 0x0000000000000000

Cisco Adaptive Security Appliance Software Version 9.3(1)

Compiled on Wed 23-Jul-14 18:16 PDT by builders
Hardware:   ASAv
Crashinfo collected on 03:42:24.059 UTC Tue Nov 28 2017

Traceback:
0: 0x0000000000422118
1: 0x00000000004221f8
2: 0x000000000042226d
3: 0x0000000001587076
4: 0x00007ffffecd55f0
5: 0x00000000015820a0
6: 0x000000000212d482
7: 0x000000000139f304
8: 0x000000000213f315
9: 0x0000000001460873
10: 0x0000000001488625
11: 0x0000000000423e7a
12: 0x00000000004244dc
13: 0x00000000015874a9
14: 0x00007ffffecd55f0
15: 0x0000000000558d85
16: 0x00000000008f5a2b
17: 0x00000000008fd361
18: 0x0000000000428a15
-----------------------------------------------
Process shutdown finished
Rebooting.....

Thanks in advance for your help! :)

Regards,
Abdullah Alhaddad

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835694

Title:
  hardware-based time keeping

Status in QEMU:
  New

Bug description:
  Hi all,

  I hope you're all doing well.

  As i was looking for a solution for a particular problem in Qemu/KVM
  virtualization.

  My issue is that I have a virtual machine that runs well in VMware and wh=
en
  I migrated that to Qemu/KVM-enabled environment, it didn't work! I figured
  out that under VMware hypervisor, VMware supplies CPU TSC and Performance
  Counters values to the guest VM with the option
  "monitor_control.pseudo_perfctr =3D TRUE" set the vmx configuration file,
  Ref.: https://www.vmware.com/pdf/vmware_timekeeping.pdf

  My question is, is there any similar option in Qemu/KVM-enabled environme=
nt
  that I can use to get my VM working the same way as in the VMware
  environment?

  I almost tried all options in Qemu with regards to CPU but no avail.

  To elaborate more, the VM I'm trying to port under Qemu/KVM environment is
  a an old version of Cisco virtual ASA Firewall. The VM image is actually
  meant to be run under VMware ESXi and with that
  "*monitor_control.pseudo_perfctr
  =3D TRUE*" option it can also run in Vware Workstation as well. *Yes, this
  option that makes it run under VMware and if it's removed from the
  configuration vmx file then the VM boots half way and crashes the same way
  it crashes under Qemu*. That dictates it's the option in interest that
  needs to be found in Qemu/KVM. I have a copy of this VM in the below link
  in case you would like to try its behavior in under VMware. I downloaded =
it
  from a youtube previously to test it out:

  https://drive.google.com/open?id=3D1SEXws18hoj2sWGk8iFqqH8RpBZsBNpRH

  Once you power on the VM you can telnet to 127.0.0.1 on port 3000 to see
  the boot process. If you remove that option i mentioned to you and boot t=
he
  VM again you'll see the crashing in process.

  =

  I've converted that vmdk disk images into Qemu disks "qcow2" format and i
  ran them using the below command line on Ubuntu:

  /opt/qemu/bin/qemu-system-x86_64 -L -nographic -device
  e1000-82545em,netdev=3Dnet0,mac=3D50:00:00:6a:00:00 -netdev
  tap,id=3Dnet0,ifname=3Dvunl0_33_0,script=3Dno -device
  e1000-82545em,netdev=3Dnet1,mac=3D50:00:00:6a:00:01 -netdev
  tap,id=3Dnet1,ifname=3Dvunl0_33_1,script=3Dno -device
  e1000-82545em,netdev=3Dnet2,mac=3D50:00:00:6a:00:02 -netdev
  tap,id=3Dnet2,ifname=3Dvunl0_33_2,script=3Dno -device
  e1000-82545em,netdev=3Dnet3,mac=3D50:00:00:6a:00:03 -netdev
  tap,id=3Dnet3,ifname=3Dvunl0_33_3,script=3Dno -machine type=3Dpc-1.0  *-c=
pu
  host,migratable=3Doff,invtsc=3Don,pmu=3Don* -m 4096 -hda hda.qcow2 -hdb h=
db.qcow2
  -serial telnet:0.0.0.0:3000,server,nowait -monitor
  tcp:127.0.0.1:42379,server,nowait
  -nographic -display none -enable-kvm

  =

  Once you power on the VM you can telnet to xx.xx.xx.xx 3000 (where the xx
  IP is the Ubuntu machine IP) to see the crashing in process. You may need
  to wait for a while for the status messages to appear in the terminal
  window.

  I assume it's a cpu issue because in page 9 of the Vmware pdf reference
  file; it says there are machine instructions become available when this
  option "*monitor_control.pseudo_perfctr =3D TRUE*" is enabled:

  The following machine instructions then become available:

  Instruction    Time Value    Returned
  rdpmc           0x10000       Physical host TSC
  rdpmc           0x10001       Elapsed real time in ns
  rdpmc           0x10002       Elapsed apparent time in ns

  Therefore, I used many of the Qemu cpu options such as these:

  -cpu host,migratable=3Dno,+invtsc (ref: https://wiki.qemu.org/ChangeLog/2=
.1)
  -cpu host, tsc-frequency=3Dxxxx (ref: https://lists.gnu.org/archive/
  html/qemu-devel/2017-01/msg03555.html)
   -cpu host,migratable=3Doff,invtsc=3Dtrue,pmu=3Dtrue

  Not sure if i'm hitting the wrong option!

  The log I'm getting when the VM boots up looks like the following crash
  happens at the blue colored log:

  -------------------------------------------------------------------------=
---------------------------------------------------
  Loading...

  Starting image verification
  Hash Computation:    100% Done!
  Computed Hash   SHA2: 63c1e8aa9de3d0c6e738dc91be8e1784
                        5caf64af4cf06cf6a3c5da7200d478dd
                        938d380d2b1064f6a349401c7860f50e
                        cc4eeb98a0ae16c097dbc9447d4d6626

  Get key records from key storage: Primary, key_store_type: 2
  Embedded Hash   SHA2: 63c1e8aa9de3d0c6e738dc91be8e1784
                        5caf64af4cf06cf6a3c5da7200d478dd
                        938d380d2b1064f6a349401c7860f50e
                        cc4eeb98a0ae16c097dbc9447d4d6626

  The digital signature of the running image verified successfully
  Processor memory 3183296512, Reserved memory: 0

  Total NICs found: 4
  i82545EM rev03 Gigabit Ethernet @ irq10 dev 6 index 03 MAC: 5000.006a.0003
  i82545EM rev03 Gigabit Ethernet @ irq10 dev 5 index 02 MAC: 5000.006a.0002
  i82545EM rev03 Gigabit Ethernet @ irq11 dev 4 index 01 MAC: 5000.006a.0001
  i82545EM rev03 Gigabit Ethernet @ irq11 dev 3 index 00 MAC: 5000.006a.0000

  Thread Name: lina_flash_init_thread
  Page fault: Unknown
          r8 0x0000000000000790
          r9 0x00007fff3fa8b000
         r10 0x0000000000000001
         r11 0x000000000210e130
         r12 0x00000000062ebfc0
         r13 0x0000000000010001
         r14 0x0000000000000000
         r15 0x00000000062ebfc0
         rdi 0x00000000062ebfc0
         rsi 0x0000000006c17c20
         rbp 0x00007fff4056f4e0
         rbx 0x00000000062ebfc0
         rdx 0x00007fff40566f10
         rax 0x0000000000000001
         rcx 0x0000000000010001
         rsp 0x00007fff4056f4b0
         rip 0x0000000001581130
      eflags 0x0000000000013202
      csgsfs 0x0000000000000033
  error code 0x0000000000000000
      vector 0x000000000000000d
    old mask 0xffffffde3e3b5a05
         cr2 0x0000000000000000

  Cisco Adaptive Security Appliance Software Version 9.3(1)

  Compiled on Wed 23-Jul-14 18:16 PDT by builders
  Hardware:   ASAv
  Crashinfo collected on 03:42:24.059 UTC Tue Nov 28 2017

  Traceback:
  0: 0x0000000000422118
  1: 0x0000000000422152
  2: 0x0000000000424331
  3: 0x00000000015874a9
  4: 0x00007ffffecd55f0
  5: 0x0000000000558d85
  6: 0x00000000008f5a2b
  7: 0x00000000008fd361
  8: 0x0000000000428a15
  Stack dump: base:0x00007fff4056f2e0 size:178, active:178
       entries above '=3D=3D': return PC preceded by input parameters
       entries below '=3D=3D': local variables followed by saved regs
                   '=3D=3DFn': stack frame n, contains next stack frame
                      '*': stack pointer at crash
   rdi rsi rdx rcx r8 r9 : Arguments 1 through 6 to leaf function
   For example:
      0x00007fffeeeeef00: 0x0000000000000009     : arg9
      0x00007fffeeeeeefc: 0x0000000000000008     : arg8
      0x00007fffeeeeeef8: 0x0000000000000007     : arg7
      0x00007fffeeeeeef4: 0x0000000000000abc     : return PC
      0x00007fffeeeeeef0: 0x00007fffeeeeef20 =3D=3DF2: stack frame F2
      0x00007fffeeeeeeec: 0x0000000000000def     : local variable
      0x00007fffeeeeeee8: 0x0000000000000123     : local variable or saved =
reg
      0x00007fffeeeeeee4: 0x0000000000000456     : local variable or saved =
reg
      0x00007fffeeeeeee0: 0x0000000000000789     : local variable or saved =
reg
  0x00007fff4056f870: 0x00007fff4056f7e0
  0x00007fff4056f868: 0x0000000000000000
  0x00007fff4056f860: 0x00000038a11c0123
  0x00007fff4056f858: 0x0000000000000083
  0x00007fff4056f850: 0x00007fff16a864c8
  0x00007fff4056f848: 0x0000000000000000
  0x00007fff4056f840: 0x00000000a11ccdef
  0x00007fff4056f838-0x00007fff4056f808: 0x0000000000000000
  0x00007fff4056f800: 0x0000000000429867
  0x00007fff4056f7f8: 0x00007fff4056f860
  0x00007fff4056f7f0: 0x00007fff40567100
  0x00007fff4056f7e8: 0x0000000000000000
  0x00007fff4056f7e0: 0x00000030a11c0123
  0x00007fff4056f7d8: 0x0000000000000083
  0x00007fff4056f7d0: 0x00007fff16a864c8
  0x00007fff4056f7c8: 0x0000000000000000
  0x00007fff4056f7c0: 0x00000000a11ccdef
  0x00007fff4056f7b8: 0x0fffffff0fffffff
  0x00007fff4056f7b0-0x00007fff4056f7a8: 0x0000000000000000
  0x00007fff4056f7a0: 0x00000000062cc8a0
  0x00007fff4056f798: 0x0000000000000000
  0x00007fff4056f790: 0x00007fff4056f6e0
  0x00007fff4056f788: 0x00007fff4056f758
  0x00007fff4056f780: 0x0000000000000000
  0x00007fff4056f778: 0x00007fff3ff48620
  0x00007fff4056f770-0x00007fff4056f730: 0x0000000000000000
  0x00007fff4056f728: 0x0000000004d14940
  0x00007fff4056f720: 0x000000000041d690
  0x00007fff4056f718: 0x0000000002777640
  0x00007fff4056f710: 0x0000000200010010
  0x00007fff4056f708: 0x0000000006c17d40
  0x00007fff4056f700: 0x00007fff4056f6e0
  0x00007fff4056f6f8: 0x00007fff40150e80
  0x00007fff4056f6f0: 0x000000000638e598
  0x00007fff4056f6e8: 0x00007fff3ff48620
  0x00007fff4056f6e0: 0x00007fff4056f778
  0x00007fff4056f6d8: 0x00000000deadfeed
  0x00007fff4056f6d0-0x00007fff4056f6c8: 0x0000000000000000
  0x00007fff4056f6c0: 0x000000000041e1f6
  0x00007fff4056f6b8: 0x00007fff40571fd0
  0x00007fff4056f6b0: 0x00007fff40560cf0
  0x00007fff4056f6a8: 0x0000000000000000
  0x00007fff4056f6a0: 0x000000f0a11c0123
  0x00007fff4056f698: 0x0000000000000143
  0x00007fff4056f690: 0x00007fff16a864c8
  0x00007fff4056f688: 0x0000000000000000
  0x00007fff4056f680: 0x00000000a11ccdef
  0x00007fff4056f678-0x00007fff4056f660: 0x0000000000000000 =3D=3DF5
  0x00007fff4056f658: 0x000000009abcdef0
  0x00007fff4056f650-0x00007fff4056f5b8: 0x123456789abcdef0
  0x00007fff4056f5b0: 0x0000000000428a01
  0x00007fff4056f5a8: 0x00007fff4056f570
  0x00007fff4056f5a0-0x00007fff4056f590: 0x0000000000000000
  0x00007fff4056f588: 0xffffffffffffdf98
  0x00007fff4056f580: 0x00007fff4056f670
  0x00007fff4056f578: 0x00007fff3ff48370
  0x00007fff4056f570: 0x0000000000000000
  0x00007fff4056f568: 0x0000000000428a15
  0x00007fff4056f560: 0x00007fff4056f670 =3D=3DF4
  0x00007fff4056f558: 0x00000000008fd361
  0x00007fff4056f550: 0x00007fff4056f560 =3D=3DF3
  0x00007fff4056f548: 0x00000000008f5a2b
  0x00007fff4056f540: 0x00007fff4056f550 =3D=3DF2
  0x00007fff4056f538: 0x0000000000000000
  0x00007fff4056f530: 0xffffffffffffdf98
  0x00007fff4056f528: 0x00007fff3ff48370
  0x00007fff4056f520: 0x00000000008fba90
  0x00007fff4056f518: 0x00000000008fb908
  0x00007fff4056f510: 0x00007fff4056f550
  0x00007fff4056f508: 0x00000000008fb87e
  0x00007fff4056f500: 0x00007fff4056f510
  0x00007fff4056f4f8: 0x0000000000000000
  0x00007fff4056f4f0: 0xffffffffffffdf98
  0x00007fff4056f4e8: 0x0000000000558d85
  0x00007fff4056f4e0: 0x00007fff4056f540 =3D=3DF1
  0x00007fff4056f4d8-0x00007fff4056f4d0: 0x0000000000000000
  0x00007fff4056f4c8: 0x0000000000000001
  0x00007fff4056f4c0-0x00007fff4056f4b8: 0x00000000062ebfc0
  0x00007fff4056f4b0: 0x0000000000000000 *
  0x00007fff4056f4a8: 0x00000000008fd973
  0x00007fff4056f4a0: 0x00007fff4056f4d0
  0x00007fff4056f498: 0x00007fff40563908
  0x00007fff4056f490: 0x00007fff4056f4d0
  0x00007fff4056f488: 0x00000000009d4b01
  0x00007fff4056f480: 0x00007fff4056f4a0
  0x00007fff4056f478-0x00007fff4056f470: 0x0000000000000000
  0x00007fff4056f468: 0x00007fff418d6390
  0x00007fff4056f460: 0x0000000000000000
  0x00007fff4056f458: 0x000000000201b9f8
  0x00007fff4056f450: 0x00007fff4056f480
  0x00007fff4056f448: 0x00007fff40563908
  0x00007fff4056f440: 0x0000000000000001
  0x00007fff4056f438: 0x00007fff405619a0
  0x00007fff4056f430: 0x00007fff40563908
  0x00007fff4056f428: 0x0000000000000001
  0x00007fff4056f420: 0x0000000000000000
  0x00007fff4056f418: 0x0000000001627125
  0x00007fff4056f410: 0x00007fff4056f450
  0x00007fff4056f408: 0x00007fff3fa8b010
  0x00007fff4056f400: 0x00007fff46505845
  0x00007fff4056f3f8-0x00007fff4056f3c8: 0x0000000000000000
  0x00007fff4056f3c0: 0x0000000000000003
  0x00007fff4056f3b8-0x00007fff4056f3a8: 0x0000000000000000
  0x00007fff4056f3a0: 0x0000000000000240
  0x00007fff4056f398: 0x0000000000000003
  0x00007fff4056f390: 0x0000024446505853
  0x00007fff4056f388-0x00007fff4056f310: 0x0000000000000000
  0x00007fff4056f308: 0x424b7e25fece8fc2
  0x00007fff4056f300: 0x2cc4f98473045e95
  0x00007fff4056f2f8: 0x18fa9b6c57ca0e78
  0x00007fff4056f2f0: 0x081e2a254ab96aa4
  0x00007fff4056f2e8: 0x0000000300000000

  Begin to dump crashinfo to flash....

  core0: An internal error occurred.  Specifically, a programming assertion
  was
  violated.  Copy the error message exactly as it appears, and get the
  output of the show version command and the contents of the configuration
  file.  Then call your technical support representative.

  assertion "_vf_mode_init" failed: file "vf_api.c", line 136
  core0 same core snap_count=3D1 signo=3D6 RIP=3D7ffffecd43fb

  =

  -----------------------------------------------
  Traceback output aborted.
  Flushing first exception frame:
  Page fault: Unknown
          r8 0x0000000000000790
          r9 0x00007fff3fa8b000
         r10 0x0000000000000001
         r11 0x000000000210e130
         r12 0x00000000062ebfc0
         r13 0x0000000000010001
         r14 0x0000000000000000
         r15 0x00000000062ebfc0
         rdi 0x00000000062ebfc0
         rsi 0x0000000006c17c20
         rbp 0x00007fff4056f4e0
         rbx 0x00000000062ebfc0
         rdx 0x00007fff40566f10
         rax 0x0000000000000001
         rcx 0x0000000000010001
         rsp 0x00007fff4056f4b0
         rip 0x0000000001581130
      eflags 0x0000000000013202
      csgsfs 0x0000000000000033
  error code 0x0000000000000000
      vector 0x000000000000000d
    old mask 0xffffffde3e3b5a05
         cr2 0x0000000000000000
  Nested traceback attempted via signal, from:
  Abort: Unknown
          r8 0x000000000000003c
          r9 0x0000000005097a27
         r10 0x00007fff4056de28
         r11 0x0000000000003206
         r12 0x0000000000000001
         r13 0x00007fff4056df80
         r14 0x0000000000000000
         r15 0x0000000000000006
         rdi 0x0000000000000008
         rsi 0x00007fff4056df80
         rbp 0x00007fff4056dfc0
         rbx 0x00007fff29f6b780
         rdx 0x0000000000000010
         rax 0x0000000000000010
         rcx 0xffffffffffffffff
         rsp 0x00007fff4056df50
         rip 0x00007ffffecd43fb
      eflags 0x0000000000003206
      csgsfs 0x1234000000000033
  error code 0x0000000000000000
      vector 0x000000000000000d
    old mask 0xffffffde3e3b5a05
         cr2 0x0000000000000000

  Cisco Adaptive Security Appliance Software Version 9.3(1)

  Compiled on Wed 23-Jul-14 18:16 PDT by builders
  Hardware:   ASAv
  Crashinfo collected on 03:42:24.059 UTC Tue Nov 28 2017

  Traceback:
  0: 0x0000000000422118
  1: 0x00000000004221f8
  2: 0x000000000042226d
  3: 0x0000000001587076
  4: 0x00007ffffecd55f0
  5: 0x00000000015820a0
  6: 0x000000000212d482
  7: 0x000000000139f304
  8: 0x000000000213f315
  9: 0x0000000001460873
  10: 0x0000000001488625
  11: 0x0000000000423e7a
  12: 0x00000000004244dc
  13: 0x00000000015874a9
  14: 0x00007ffffecd55f0
  15: 0x0000000000558d85
  16: 0x00000000008f5a2b
  17: 0x00000000008fd361
  18: 0x0000000000428a15
  -----------------------------------------------
  Process shutdown finished
  Rebooting.....

  Thanks in advance for your help! :)

  Regards,
  Abdullah Alhaddad

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835694/+subscriptions

