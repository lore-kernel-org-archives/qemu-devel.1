Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F074FC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82042068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82042068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQudZ-0004nf-Ch
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQucl-0004Lq-Hr
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQuck-0001R6-QT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:15:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:59016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jQuck-0001Oz-CB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:15:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jQuci-0003dR-54
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 15:15:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 246562E8109
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 15:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2020 15:08:09 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1874073@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mliska philmd pmaydell
X-Launchpad-Bug-Reporter: Martin Liska (mliska)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158747496330.1952.6391008472811579405.malonedeb@chaenomeles.canonical.com>
Message-Id: <158748168930.24243.15201885558403052718.malone@gac.canonical.com>
Subject: [Bug 1874073] Re: openrisc_sim.c:87:42: error: 'cpu_irqs[0]' may be
 used uninitialized in this function [-Werror=maybe-uninitialized]
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="aad6b57d58e2f621954298e262c1cc904860f5d2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0074ce5164abf4a3fb70521ff84d667013f377df
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 07:50:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1874073 <1874073@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Confirming Peter's suggestion does silent the warning.

-- >8 --
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index d08ce61811..02f5259e5e 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -134,6 +134,7 @@ static void openrisc_sim_init(MachineState *machine)
     int n;
     unsigned int smp_cpus =3D machine->smp.cpus;
 =

+    assert(smp_cpus >=3D 1 && smp_cpus <=3D 2);
     for (n =3D 0; n < smp_cpus; n++) {
         cpu =3D OPENRISC_CPU(cpu_create(machine->cpu_type));
         if (cpu =3D=3D NULL) {
---

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874073

Title:
  openrisc_sim.c:87:42: error: 'cpu_irqs[0]' may be used uninitialized
  in this function [-Werror=3Dmaybe-uninitialized]

Status in QEMU:
  New

Bug description:
  I see the warning since gcc10:

  static void openrisc_sim_init(MachineState *machine):
  ...
      qemu_irq *cpu_irqs[2];
  ...

  =

      serial_mm_init(get_system_memory(), 0x90000000, 0, serial_irq,
                     115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);

  I would initialize cpu_irqs[2] with {}.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874073/+subscriptions

