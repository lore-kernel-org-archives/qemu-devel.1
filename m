Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F7C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FDD20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FDD20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuNS-0001hv-PQ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtuMn-0000rr-9M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:51:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:43478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtuMk-0007ua-Qf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:51:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jtuMh-000124-NU
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 14:51:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 41E982E8113
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 14:51:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2020 14:41:34 -0000
From: Heiko Sieger <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger janklos
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Heiko Sieger (h-sieger)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <159439209432.13087.1244059823844611715.malone@gac.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c9e977d130860646050e8d4388247a380b03cc26
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 10:51:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

@Jan: this coreinfo output looks good.

I finally managed to get the core /cache alignment right, I believe:

  <vcpu placement=3D"static" current=3D"24">32</vcpu>
  <vcpus>
    <vcpu id=3D"0" enabled=3D"yes" hotpluggable=3D"no"/>
    <vcpu id=3D"1" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"2" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"3" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"4" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"5" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"6" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"7" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"8" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"9" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"10" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"11" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"12" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"13" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"14" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"15" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"16" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"17" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"18" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"19" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"20" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"21" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"22" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"23" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"24" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"25" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"26" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"27" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"28" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"29" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"30" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"31" enabled=3D"no" hotpluggable=3D"yes"/>
  </vcpus>
  <cputune>
    <vcpupin vcpu=3D"0" cpuset=3D"0"/>
    <vcpupin vcpu=3D"1" cpuset=3D"12"/>
    <vcpupin vcpu=3D"2" cpuset=3D"1"/>
    <vcpupin vcpu=3D"3" cpuset=3D"13"/>
    <vcpupin vcpu=3D"4" cpuset=3D"2"/>
    <vcpupin vcpu=3D"5" cpuset=3D"14"/>
    <vcpupin vcpu=3D"8" cpuset=3D"3"/>
    <vcpupin vcpu=3D"9" cpuset=3D"15"/>
    <vcpupin vcpu=3D"10" cpuset=3D"4"/>
    <vcpupin vcpu=3D"11" cpuset=3D"16"/>
    <vcpupin vcpu=3D"12" cpuset=3D"5"/>
    <vcpupin vcpu=3D"13" cpuset=3D"17"/>
    <vcpupin vcpu=3D"16" cpuset=3D"6"/>
    <vcpupin vcpu=3D"17" cpuset=3D"18"/>
    <vcpupin vcpu=3D"18" cpuset=3D"7"/>
    <vcpupin vcpu=3D"19" cpuset=3D"19"/>
    <vcpupin vcpu=3D"20" cpuset=3D"8"/>
    <vcpupin vcpu=3D"21" cpuset=3D"20"/>
    <vcpupin vcpu=3D"24" cpuset=3D"9"/>
    <vcpupin vcpu=3D"25" cpuset=3D"21"/>
    <vcpupin vcpu=3D"26" cpuset=3D"10"/>
    <vcpupin vcpu=3D"27" cpuset=3D"22"/>
    <vcpupin vcpu=3D"28" cpuset=3D"11"/>
    <vcpupin vcpu=3D"29" cpuset=3D"23"/>
  </cputune>

...
  <cpu mode=3D"host-passthrough" check=3D"none">
    <topology sockets=3D"1" dies=3D"1" cores=3D"16" threads=3D"2"/>
    <cache mode=3D"passthrough"/>


The Windows Coreinfo output is this:

Logical to Physical Processor Map:
**----------------  Physical Processor 0 (Hyperthreaded)
--**--------------  Physical Processor 1 (Hyperthreaded)
----**------------  Physical Processor 2 (Hyperthreaded)
------**----------  Physical Processor 3 (Hyperthreaded)
--------**--------  Physical Processor 4 (Hyperthreaded)
----------**------  Physical Processor 5 (Hyperthreaded)
------------**----  Physical Processor 6 (Hyperthreaded)
--------------**--  Physical Processor 7 (Hyperthreaded)
----------------**  Physical Processor 8 (Hyperthreaded)

Logical Processor to Socket Map:
******************  Socket 0

Logical Processor to NUMA Node Map:
******************  NUMA Node 0

No NUMA nodes.

Logical Processor to Cache Map:
**----------------  Data Cache          0, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
**----------------  Instruction Cache   0, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
**----------------  Unified Cache       0, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
******------------  Unified Cache       1, Level 3,   16 MB, Assoc  16, Lin=
eSize  64
--**--------------  Data Cache          1, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
--**--------------  Instruction Cache   1, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
--**--------------  Unified Cache       2, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
----**------------  Data Cache          2, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
----**------------  Instruction Cache   2, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
----**------------  Unified Cache       3, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
------**----------  Data Cache          3, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
------**----------  Instruction Cache   3, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
------**----------  Unified Cache       4, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
------******------  Unified Cache       5, Level 3,   16 MB, Assoc  16, Lin=
eSize  64
--------**--------  Data Cache          4, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
--------**--------  Instruction Cache   4, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
--------**--------  Unified Cache       6, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
----------**------  Data Cache          5, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
----------**------  Instruction Cache   5, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
----------**------  Unified Cache       7, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
------------**----  Data Cache          6, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
------------**----  Instruction Cache   6, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
------------**----  Unified Cache       8, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
------------******  Unified Cache       9, Level 3,   16 MB, Assoc  16, Lin=
eSize  64
--------------**--  Data Cache          7, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
--------------**--  Instruction Cache   7, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
--------------**--  Unified Cache      10, Level 2,  512 KB, Assoc   8, Lin=
eSize  64
----------------**  Data Cache          8, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
----------------**  Instruction Cache   8, Level 1,   32 KB, Assoc   8, Lin=
eSize  64
----------------**  Unified Cache      11, Level 2,  512 KB, Assoc   8, Lin=
eSize  64

Logical Processor to Group Map:
******************  Group 0


Haven't been able to test if it performs as expected. Need to do that.

Of course it would be great if QEMU was patched to recognize correct CCX
alignment as I'm not sure if and what will be the penalty of this weird
setup.

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

