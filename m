Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC81C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77836206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77836206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOp6B-0004mP-IJ
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 16:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jOp5a-0004LB-2o
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 16:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jOp5Y-0004h7-Ni
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 16:56:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:33914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jOp5Y-0004gb-If
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 16:56:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jOp5W-0008Mw-Um
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 20:56:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BC08E2E810C
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 20:56:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2020 20:46:00 -0000
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
Message-Id: <158698356066.28316.10188353461802151709.malone@gac.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0836c33b4f8894d79ba57d2cb3224bb69143e38d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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

Same problem for Ryzen 9 3900X. There should be 4x L3 caches, but there
are only 3.

Same results with "host-passthrough" and "EPYC-IBPB". Windows doesn't
recognize the correct L3 cache layout.

>From coreinfo.exe:

Logical Processor to Cache Map:
**----------------------  Data Cache          0, Level 1,   32 KB, Assoc   =
8, LineSize  64
**----------------------  Instruction Cache   0, Level 1,   32 KB, Assoc   =
8, LineSize  64
**----------------------  Unified Cache       0, Level 2,  512 KB, Assoc   =
8, LineSize  64
********----------------  Unified Cache       1, Level 3,   16 MB, Assoc  1=
6, LineSize  64
--**--------------------  Data Cache          1, Level 1,   32 KB, Assoc   =
8, LineSize  64
--**--------------------  Instruction Cache   1, Level 1,   32 KB, Assoc   =
8, LineSize  64
--**--------------------  Unified Cache       2, Level 2,  512 KB, Assoc   =
8, LineSize  64
----**------------------  Data Cache          2, Level 1,   32 KB, Assoc   =
8, LineSize  64
----**------------------  Instruction Cache   2, Level 1,   32 KB, Assoc   =
8, LineSize  64
----**------------------  Unified Cache       3, Level 2,  512 KB, Assoc   =
8, LineSize  64
------**----------------  Data Cache          3, Level 1,   32 KB, Assoc   =
8, LineSize  64
------**----------------  Instruction Cache   3, Level 1,   32 KB, Assoc   =
8, LineSize  64
------**----------------  Unified Cache       4, Level 2,  512 KB, Assoc   =
8, LineSize  64
--------**--------------  Data Cache          4, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------**--------------  Instruction Cache   4, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------**--------------  Unified Cache       5, Level 2,  512 KB, Assoc   =
8, LineSize  64
--------********--------  Unified Cache       6, Level 3,   16 MB, Assoc  1=
6, LineSize  64
----------**------------  Data Cache          5, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------**------------  Instruction Cache   5, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------**------------  Unified Cache       7, Level 2,  512 KB, Assoc   =
8, LineSize  64
------------**----------  Data Cache          6, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------**----------  Instruction Cache   6, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------**----------  Unified Cache       8, Level 2,  512 KB, Assoc   =
8, LineSize  64
--------------**--------  Data Cache          7, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------**--------  Instruction Cache   7, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------**--------  Unified Cache       9, Level 2,  512 KB, Assoc   =
8, LineSize  64
----------------**------  Data Cache          8, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------**------  Instruction Cache   8, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------**------  Unified Cache      10, Level 2,  512 KB, Assoc   =
8, LineSize  64
----------------********  Unified Cache      11, Level 3,   16 MB, Assoc  1=
6, LineSize  64
------------------**----  Data Cache          9, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------------**----  Instruction Cache   9, Level 1,   32 KB, Assoc   =
8, LineSize  64
------------------**----  Unified Cache      12, Level 2,  512 KB, Assoc   =
8, LineSize  64
--------------------**--  Data Cache         10, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------------**--  Instruction Cache  10, Level 1,   32 KB, Assoc   =
8, LineSize  64
--------------------**--  Unified Cache      13, Level 2,  512 KB, Assoc   =
8, LineSize  64
----------------------**  Data Cache         11, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------------**  Instruction Cache  11, Level 1,   32 KB, Assoc   =
8, LineSize  64
----------------------**  Unified Cache      14, Level 2,  512 KB, Assoc   =
8, LineSize  64

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

