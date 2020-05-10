Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F6C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1308B206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1308B206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXsNX-0001mJ-92
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 16:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jXsMQ-0000nq-Hp
 for qemu-devel@nongnu.org; Sun, 10 May 2020 16:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:36838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jXsMO-0003C8-Hk
 for qemu-devel@nongnu.org; Sun, 10 May 2020 16:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jXsMM-0000l3-8I
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 20:15:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D8C272E8079
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 20:15:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 May 2020 20:01:51 -0000
From: Heiko Sieger <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Heiko Sieger (h-sieger)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <158914091142.4693.6888270013870332292.malone@soybean.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6ae9b68bf4a90c2b8c438d9190af65a666c0aa0a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 13:55:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Bug 1856335 <1856335@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I upgraded to QEMU emulator version 5.0.50
Using q35-5.1 (the latest) and the following libvirt configuration:

  <memory unit=3D"KiB">50331648</memory>
  <currentMemory unit=3D"KiB">50331648</currentMemory>
  <memoryBacking>
    <hugepages/>
  </memoryBacking>
  <vcpu placement=3D"static">24</vcpu>
  <cputune>
    <vcpupin vcpu=3D"0" cpuset=3D"0"/>
    <vcpupin vcpu=3D"1" cpuset=3D"12"/>
    <vcpupin vcpu=3D"2" cpuset=3D"1"/>
    <vcpupin vcpu=3D"3" cpuset=3D"13"/>
    <vcpupin vcpu=3D"4" cpuset=3D"2"/>
    <vcpupin vcpu=3D"5" cpuset=3D"14"/>
    <vcpupin vcpu=3D"6" cpuset=3D"3"/>
    <vcpupin vcpu=3D"7" cpuset=3D"15"/>
    <vcpupin vcpu=3D"8" cpuset=3D"4"/>
    <vcpupin vcpu=3D"9" cpuset=3D"16"/>
    <vcpupin vcpu=3D"10" cpuset=3D"5"/>
    <vcpupin vcpu=3D"11" cpuset=3D"17"/>
    <vcpupin vcpu=3D"12" cpuset=3D"6"/>
    <vcpupin vcpu=3D"13" cpuset=3D"18"/>
    <vcpupin vcpu=3D"14" cpuset=3D"7"/>
    <vcpupin vcpu=3D"15" cpuset=3D"19"/>
    <vcpupin vcpu=3D"16" cpuset=3D"8"/>
    <vcpupin vcpu=3D"17" cpuset=3D"20"/>
    <vcpupin vcpu=3D"18" cpuset=3D"9"/>
    <vcpupin vcpu=3D"19" cpuset=3D"21"/>
    <vcpupin vcpu=3D"20" cpuset=3D"10"/>
    <vcpupin vcpu=3D"21" cpuset=3D"22"/>
    <vcpupin vcpu=3D"22" cpuset=3D"11"/>
    <vcpupin vcpu=3D"23" cpuset=3D"23"/>
  </cputune>
  <os>
    <type arch=3D"x86_64" machine=3D"pc-q35-5.1">hvm</type>
    <loader readonly=3D"yes" type=3D"pflash">/usr/share/OVMF/x64/OVMF_CODE.=
fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/win10_VARS.fd</nvram>
    <boot dev=3D"hd"/>
    <bootmenu enable=3D"no"/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <hyperv>
      <relaxed state=3D"on"/>
      <vapic state=3D"on"/>
      <spinlocks state=3D"on" retries=3D"8191"/>
      <vpindex state=3D"on"/>
      <synic state=3D"on"/>
      <stimer state=3D"on"/>
      <vendor_id state=3D"on" value=3D"AuthenticAMD"/>
      <frequencies state=3D"on"/>
    </hyperv>
    <kvm>
      <hidden state=3D"on"/>
    </kvm>
    <vmport state=3D"off"/>
    <ioapic driver=3D"kvm"/>
  </features>
  <cpu mode=3D"host-passthrough" check=3D"none">
    <topology sockets=3D"1" cores=3D"12" threads=3D"2"/>
    <cache mode=3D"passthrough"/>
    <feature policy=3D"require" name=3D"invtsc"/>
    <feature policy=3D"require" name=3D"hypervisor"/>
    <feature policy=3D"require" name=3D"topoext"/>
    <numa>
      <cell id=3D"0" cpus=3D"0-2,12-14" memory=3D"12582912" unit=3D"KiB"/>
      <cell id=3D"1" cpus=3D"3-5,15-17" memory=3D"12582912" unit=3D"KiB"/>
      <cell id=3D"2" cpus=3D"6-8,18-20" memory=3D"12582912" unit=3D"KiB"/>
      <cell id=3D"3" cpus=3D"9-11,21-23" memory=3D"12582912" unit=3D"KiB"/>
    </numa>
  </cpu>

...

/var/log/libvirt/qemu/win10.log:

-machine pc-q35-5.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Dof=
f,kernel_irqchip=3Don,pflash0=3Dlibvirt-pflash0-format,pflash1=3Dlibvirt-pf=
lash1-format \
-cpu host,invtsc=3Don,hypervisor=3Don,topoext=3Don,hv-time,hv-relaxed,hv-va=
pic,hv-spinlocks=3D0x1fff,hv-vpindex,hv-synic,hv-stimer,hv-vendor-id=3DAuth=
enticAMD,hv-frequencies,hv-crash,kvm=3Doff,host-cache-info=3Don,l3-cache=3D=
off \
-m 49152 \
-overcommit mem-lock=3Doff \
-smp 24,sockets=3D1,cores=3D12,threads=3D2 \
-mem-prealloc \
-mem-path /dev/hugepages/libvirt/qemu/3-win10 \
-numa node,nodeid=3D0,cpus=3D0-2,cpus=3D12-14,mem=3D12288 \
-numa node,nodeid=3D1,cpus=3D3-5,cpus=3D15-17,mem=3D12288 \
-numa node,nodeid=3D2,cpus=3D6-8,cpus=3D18-20,mem=3D12288 \
-numa node,nodeid=3D3,cpus=3D9-11,cpus=3D21-23,mem=3D12288 \
...

For some reason I always get l3-cache=3Doff.

CoreInfo.exe in Windows 10 then produces the following report
(shortened):

Logical to Physical Processor Map:
**----------------------  Physical Processor 0 (Hyperthreaded)
--*---------------------  Physical Processor 1
---*--------------------  Physical Processor 2
----**------------------  Physical Processor 3 (Hyperthreaded)
------**----------------  Physical Processor 4 (Hyperthreaded)
--------*---------------  Physical Processor 5
---------*--------------  Physical Processor 6
----------**------------  Physical Processor 7 (Hyperthreaded)
------------**----------  Physical Processor 8 (Hyperthreaded)
--------------*---------  Physical Processor 9
---------------*--------  Physical Processor 10
----------------**------  Physical Processor 11 (Hyperthreaded)
------------------**----  Physical Processor 12 (Hyperthreaded)
--------------------*---  Physical Processor 13
---------------------*--  Physical Processor 14
----------------------**  Physical Processor 15 (Hyperthreaded)

Logical Processor to Socket Map:
************************  Socket 0

Logical Processor to NUMA Node Map:
***---------***---------  NUMA Node 0
---***---------***------  NUMA Node 1
------***---------***---  NUMA Node 2
---------***---------***  NUMA Node 3

Approximate Cross-NUMA Node Access Cost (relative to fastest):
     00  01  02  03
00: 1.4 1.2 1.1 1.2
01: 1.1 1.1 1.3 1.1
02: 1.0 1.1 1.0 1.2
03: 1.1 1.2 1.2 1.2

Logical Processor to Cache Map:
**----------------------  Data Cache          0, Level 1,   32 KB, Assoc   =
8, LineSize  64
**----------------------  Instruction Cache   0, Level 1,   32 KB, Assoc   =
8, LineSize  64
**----------------------  Unified Cache       0, Level 2,  512 KB, Assoc   =
8, LineSize  64
***---------------------  Unified Cache       1, Level 3,   16 MB, Assoc  1=
6, LineSize  64
--*---------------------  Data Cache          1, Level 1,   32 KB, Assoc   =
8, LineSize  64
--*---------------------  Instruction Cache   1, Level 1,   32 KB, Assoc   =
8, LineSize  64
--*---------------------  Unified Cache       2, Level 2,  512 KB, Assoc   =
8, LineSize  64
---*--------------------  Data Cache          2, Level 1,   32 KB, Assoc   =
8, LineSize  64
---*--------------------  Instruction Cache   2, Level 1,   32 KB, Assoc   =
8, LineSize  64
---*--------------------  Unified Cache       3, Level 2,  512 KB, Assoc   =
8, LineSize  64
---***------------------  Unified Cache       4, Level 3,   16 MB, Assoc  1=
6, LineSize  64
----**------------------  Data Cache          3, Level 1,   32 KB, Assoc   =
8, LineSize  64
----**------------------  Instruction Cache   3, Level 1,   32 KB, Assoc   =
8, LineSize  64
----**------------------  Unified Cache       5, Level 2,  512 KB, Assoc   =
8, LineSize  64
------**----------------  Data Cache          4, Level 1,   32 KB, Assoc   =
8, LineSize  64
------**----------------  Instruction Cache   4, Level 1,   32 KB, Assoc   =
8, LineSize  64
------**----------------  Unified Cache       6, Level 2,  512 KB, Assoc   =
8, LineSize  64
------**----------------  Unified Cache       7, Level 3,   16 MB, Assoc  1=
6, LineSize  64
--------*---------------  Data Cache          5, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------*---------------  Instruction Cache   5, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------*---------------  Unified Cache       8, Level 2,  512 KB, Assoc   =
8, LineSize  64
--------*---------------  Unified Cache       9, Level 3,   16 MB, Assoc  1=
6, LineSize  64
---------*--------------  Data Cache          6, Level 1,   32 KB, Assoc   =
8, LineSize  64
---------*--------------  Instruction Cache   6, Level 1,   32 KB, Assoc   =
8, LineSize  64
---------*--------------  Unified Cache      10, Level 2,  512 KB, Assoc   =
8, LineSize  64
---------***------------  Unified Cache      11, Level 3,   16 MB, Assoc  1=
6, LineSize  64
----------**------------  Data Cache          7, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------**------------  Instruction Cache   7, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------**------------  Unified Cache      12, Level 2,  512 KB, Assoc   =
8, LineSize  64
------------**----------  Data Cache          8, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------**----------  Instruction Cache   8, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------**----------  Unified Cache      13, Level 2,  512 KB, Assoc   =
8, LineSize  64
------------***---------  Unified Cache      14, Level 3,   16 MB, Assoc  1=
6, LineSize  64
--------------*---------  Data Cache          9, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------*---------  Instruction Cache   9, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------*---------  Unified Cache      15, Level 2,  512 KB, Assoc   =
8, LineSize  64
---------------*--------  Data Cache         10, Level 1,   32 KB, Assoc   =
8, LineSize  64
---------------*--------  Instruction Cache  10, Level 1,   32 KB, Assoc   =
8, LineSize  64
---------------*--------  Unified Cache      16, Level 2,  512 KB, Assoc   =
8, LineSize  64
---------------*--------  Unified Cache      17, Level 3,   16 MB, Assoc  1=
6, LineSize  64
----------------**------  Data Cache         11, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------**------  Instruction Cache  11, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------**------  Unified Cache      18, Level 2,  512 KB, Assoc   =
8, LineSize  64
----------------**------  Unified Cache      19, Level 3,   16 MB, Assoc  1=
6, LineSize  64
------------------**----  Data Cache         12, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------------**----  Instruction Cache  12, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------------**----  Unified Cache      20, Level 2,  512 KB, Assoc   =
8, LineSize  64
------------------***---  Unified Cache      21, Level 3,   16 MB, Assoc  1=
6, LineSize  64
--------------------*---  Data Cache         13, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------------*---  Instruction Cache  13, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------------*---  Unified Cache      22, Level 2,  512 KB, Assoc   =
8, LineSize  64
---------------------*--  Data Cache         14, Level 1,   32 KB, Assoc   =
8, LineSize  64
---------------------*--  Instruction Cache  14, Level 1,   32 KB, Assoc   =
8, LineSize  64
---------------------*--  Unified Cache      23, Level 2,  512 KB, Assoc   =
8, LineSize  64
---------------------***  Unified Cache      24, Level 3,   16 MB, Assoc  1=
6, LineSize  64
----------------------**  Data Cache         15, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------------**  Instruction Cache  15, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------------**  Unified Cache      25, Level 2,  512 KB, Assoc   =
8, LineSize  64

Logical Processor to Group Map:
************************  Group 0


The above result is even further away from the actual L3 cache configuratio=
n.

So numatune doesn't produce the expected outcome.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856335

Title:
  Cache Layout wrong on many Zen Arch CPUs

Status in QEMU:
  New

Bug description:
  AMD CPUs have L3 cache per 2, 3 or 4 cores. Currently, TOPOEXT seems
  to always map Cache ass if it was an 4-Core per CCX CPU, which is
  incorrect, and costs upwards 30% performance (more realistically 10%)
  in L3 Cache Layout aware applications.

  Example on a 4-CCX CPU (1950X /w 8 Cores and no SMT):

  =C2=A0=C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'8' threads=3D'1'=
/>

  In windows, coreinfo reports correctly:

  ****----  Unified Cache 1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----****  Unified Cache 6, Level 3,    8 MB, Assoc  16, LineSize  64

  On a 3-CCX CPU (3960X /w 6 cores and no SMT):

  =C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'6' threads=3D'1'=
/>

  in windows, coreinfo reports incorrectly:

  ****--  Unified Cache  1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----**  Unified Cache  6, Level 3,    8 MB, Assoc  16, LineSize  64

  Validated against 3.0, 3.1, 4.1 and 4.2 versions of qemu-kvm.

  With newer Qemu there is a fix (that does behave correctly) in using the =
dies parameter:
  =C2=A0<qemu:arg value=3D'cores=3D3,threads=3D1,dies=3D2,sockets=3D1'/>

  The problem is that the dies are exposed differently than how AMD does
  it natively, they are exposed to Windows as sockets, which means, that
  if you are nto a business user, you can't ever have a machine with
  more than two CCX (6 cores) as consumer versions of Windows only
  supports two sockets. (Should this be reported as a separate bug?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856335/+subscriptions

