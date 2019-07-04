Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C109C06510
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 03:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4542B2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 03:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4542B2189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hisdo-0003Kw-1T
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 23:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53933)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hiscp-0002Z6-P1
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hiscm-0002lr-V3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:41:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:43302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hiscm-0002ky-PJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:41:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hiscd-0005pX-9O
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 03:41:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 449E32E806E
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 03:41:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jul 2019 03:25:53 -0000
From: David Gibson <1826827@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: asurati dwg
X-Launchpad-Bug-Reporter: Amol Surati (asurati)
X-Launchpad-Bug-Modifier: David Gibson (dwg)
References: <155651553398.6774.264581366962353554.malonedeb@chaenomeles.canonical.com>
Message-Id: <156221075315.3076.7571761127782709436.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e792b67567cf2665bfd74c23be5df38d29f8e1ff
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1826827] Re: dtc crash;
 pnv_dt_serial cannot find lpc's phandle
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
Reply-To: Bug 1826827 <1826827@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This assertion should be fixed by upstream commit 8f695676227 "Avoid
assertion in check_interrupts_property()".  That should be included in
dtc v1.5.1 which I hope to release soon.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826827

Title:
  dtc crash; pnv_dt_serial cannot find lpc's phandle

Status in QEMU:
  New

Bug description:
  Qemu version:
  QEMU emulator version 4.0.50 (v4.0.0-142-ge0fb2c3d89)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  dtc version:
  Version: DTC 1.5.0-g5c3513f6

  -------------------------------------------------------------------------
  pnv_dt_serial has a line which is supposed to set the interrupt-parent of=
 the "isa-serial@i3f8" node to the phandle of "lpc@0".

  To that end, it calls fdt_get_phandle as shown below:
  _FDT((fdt_setprop_cell(fdt, node, "interrupt-parent", fdt_get_phandle(fdt=
, lpc_off))));

  The function fdt_get_phandle fails to find the property "phandle" (or
  "linux,phandle") for the lpc node. Consequently, pnv_dt_serial sets
  the interrupt-parent to 0.

  Now boot the qemu-system-ppc64 powernv machine, and extract the fdt by
  using the qemu monitor's pmemsave command, taking help of the OPAL
  firmware's messages to locate the fdt in the physical ram.

  qemu-system-ppc64 -m 1g -machine powernv,num-chips=3D1 \
  -cpu power9 -smp 2,cores=3D2,threads=3D1 -accel tcg,thread=3Dmulti \
  -kernel ./vmlinux \
  -append 'disable_radix' \
  -serial mon:stdio -nographic -nodefaults

  The kernel vmlinux contains nothing but a single instruction which
  loops infintely, so that we can gather OPAL's messages, especially the
  one below:

  [    0.168845963,5] INIT: Starting kernel at 0x20000000, fdt at
  0x304b0b70 14404 bytes

  Once the fdt is dumped to a file, run the following:

  'dtc -O dtb -I dts -o out.dts dtb'

  After a few warnings, the dtc application crashes because an assertion
  was fired.

  out.dts: Warning (unit_address_vs_reg): /lpcm-opb@6030000000000/lpc@0: no=
de has a unit name, but no reg property
  out.dts: Warning (simple_bus_reg): /lpcm-opb@6030000000000/lpc@0: missing=
 or empty reg/ranges property
  out.dts: Warning (avoid_unnecessary_addr_size): /ibm,opal: unnecessary #a=
ddress-cells/#size-cells without "ranges" or child "reg" property
  out.dts: Warning (unique_unit_address): /interrupt-controller@0: duplicat=
e unit-address (also used in node /memory@0)
  out.dts: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Us=
e 'stdout-path' instead
  dtc: livetree.c:575: get_node_by_phandle: Assertion `generate_fixups' fai=
led.
  Aborted (core dumped)

  The assertion is fired because get_node_by_phandle receives a phandle
  value of 0, which is unexpected, unless fixups are needed (They are
  not, when running the dtc command).

  Back inside pnv_dt_serial, if the line that sets "interrupt-parent"
  for the serial device node is commented out, the dtc crash is
  prevented. Looking at hw/ppc/e500.c, it takes care of allocating
  necessary phandle values in the nodes, so a similar method can be
  adopted for powernv.

  The dtb is attached.

  Edit: Add version, Correct filenames.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826827/+subscriptions

