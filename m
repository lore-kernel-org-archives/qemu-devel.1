Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13754C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD1E206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD1E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfaF-0000Vb-5i
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjfYm-00085P-5K
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:01:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:36400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjfYi-000827-PQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:01:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jjfYg-0006Vu-Rr
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:01:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CFCB12E8023
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:01:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2020 08:53:16 -0000
From: Jan Klos <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger janklos
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Jan Klos (janklos)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <159195199690.5608.16213263197131540255.malone@chaenomeles.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8e5bca8b5183952a779368a7feb16d5557c185ae
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:25:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

The problem is caused by the fact that with Ryzen CPUs with disabled
cores, the APIC IDs are not sequential on host - in order for cache
topology to be configured properly, there is a 'hole' in APIC ID and
core ID numbering (I have added full output of cpuid for my 3900X).
Unfortunately, adding holes to the numbering is the only way to achieve
what is needed for 3 cores per CCX as CPUID Fn8000_001D_EAX
NumSharingCache parameter rounds to  powers of two (for Ryzen 3100 with
2 cores per CCX, lowering NumSharingCache should also work, correctly
setting the L3 cache cores with their IDs still being sequential).

A small hack in x86_apicid_from_topo_ids() in include/hw/i386/topology.h
can introduce a correct numbering (at least if you do not have epyc set
as your cpu, then _epyc variant of the functions are used). But to fix
this properly will probably require some thought - maybe introduce the
ability to assign APIC IDs directly somehow? Or the ability to specify
the 'holes' somehow in the -smt param, or maybe -cpu host,topoext=3Don
should do this automatically? I don't know...

e.g. For 3 core per CCX CPUs, to fix this, at
include/hw/i386/topology.h:220 change:

(topo_ids->core_id << apicid_core_offset(topo_info)) |

to

((topo_ids->core_id + (topo_ids->core_id / 3)) <<
apicid_core_offset(topo_info)) |


The cache topology is now correct (-cpu host,topoext=3Don,hv-time,hv-relaxe=
d,hv-vapic,hv-spinlocks=3D0x1fff,host-cache-info=3Don -smp 18,sockets=3D1,d=
ies=3D1,cores=3D9,threads=3D2), even in Windows:

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


** Attachment added: "cpuid.txt"
   https://bugs.launchpad.net/qemu/+bug/1856335/+attachment/5383184/+files/=
cpuid.txt

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

