Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D649C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D880B206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D880B206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFazG-0005H1-SX
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFayS-0004PQ-U4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:35:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:56566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFayQ-0001fU-Cl
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:35:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kFayO-0005ai-El
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 10:35:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6D38C2E80DC
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 10:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2020 10:24:44 -0000
From: Derek Su <1894818@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dereksu
X-Launchpad-Bug-Reporter: Derek Su (dereksu)
X-Launchpad-Bug-Modifier: Derek Su (dereksu)
References: <159955977855.17769.18273034994411209537.malonedeb@soybean.canonical.com>
Message-Id: <159956068437.18516.7657768024428717767.launchpad@soybean.canonical.com>
Subject: [Bug 1894818] Re: COLO's guest VNC client hang after failover
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: 806f3a700fd172d20794186aaf147a7ec998fa63
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:20:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1894818 <1894818@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  Hello,
  =

  After setting up COLO's primary and secondary VMs,
  I installed the vncserver and xrdp (apt install tightvncserver xrdp) insi=
de the VM.
  =

  I access the VM from another PC via VNC/RDP client, and everything is OK.
  Then, kill the primary VM and issue the failover commands.
  =

  The expected result is that the VNC/RDP client can reconnect and resume
  automatically after failover. (I've confirmed the VNC/RDP client can
  reconnect automatically.)
  =

  But in my test, the VNC client's screen hangs and cannot be recovered no
  longer. (I need to restart VNC client by myself.)
  =

  BTW, it works well after killing SVM.
  =

+ Here is my QEMU networking device
+ ```
+ -device virtio-net-pci,id=3De0,netdev=3Dhn0 \
+ -netdev tap,id=3Dhn0,br=3Dbr0,vhost=3Doff,helper=3D/usr/local/libexec/qem=
u-bridge-helper \
+ ```
+ =

  Thanks.
  =

  Regards,
  Derek

** Description changed:

  Hello,
  =

  After setting up COLO's primary and secondary VMs,
  I installed the vncserver and xrdp (apt install tightvncserver xrdp) insi=
de the VM.
  =

  I access the VM from another PC via VNC/RDP client, and everything is OK.
  Then, kill the primary VM and issue the failover commands.
  =

  The expected result is that the VNC/RDP client can reconnect and resume
  automatically after failover. (I've confirmed the VNC/RDP client can
  reconnect automatically.)
  =

  But in my test, the VNC client's screen hangs and cannot be recovered no
- longer. (I need to restart VNC client by myself.)
+ longer. I need to restart VNC client by myself.
  =

  BTW, it works well after killing SVM.
  =

  Here is my QEMU networking device
  ```
  -device virtio-net-pci,id=3De0,netdev=3Dhn0 \
  -netdev tap,id=3Dhn0,br=3Dbr0,vhost=3Doff,helper=3D/usr/local/libexec/qem=
u-bridge-helper \
  ```
  =

  Thanks.
  =

  Regards,
  Derek

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894818

Title:
  COLO's guest VNC client hang after failover

Status in QEMU:
  New

Bug description:
  Hello,

  After setting up COLO's primary and secondary VMs,
  I installed the vncserver and xrdp (apt install tightvncserver xrdp) insi=
de the VM.

  I access the VM from another PC via VNC/RDP client, and everything is OK.
  Then, kill the primary VM and issue the failover commands.

  The expected result is that the VNC/RDP client can reconnect and
  resume automatically after failover. (I've confirmed the VNC/RDP
  client can reconnect automatically.)

  But in my test, the VNC client's screen hangs and cannot be recovered
  no longer. I need to restart VNC client by myself.

  BTW, it works well after killing SVM.

  Here is my QEMU networking device
  ```
  -device virtio-net-pci,id=3De0,netdev=3Dhn0 \
  -netdev tap,id=3Dhn0,br=3Dbr0,vhost=3Doff,helper=3D/usr/local/libexec/qem=
u-bridge-helper \
  ```

  Thanks.

  Regards,
  Derek

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894818/+subscriptions

