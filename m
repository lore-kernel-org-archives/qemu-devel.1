Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A853C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5C020663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5C020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0Mr-0006eJ-V0
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jT0LA-0005LH-KP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jT0L9-0000XX-CP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:46:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:56838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jT0L8-0000XG-UA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:46:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jT0L5-0004Lk-Nl
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 09:46:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B2D4B2E8029
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 09:46:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2020 09:32:17 -0000
From: Daniel Berrange <1875139@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: avschie berrange
X-Launchpad-Bug-Reporter: A van Schie (avschie)
X-Launchpad-Bug-Modifier: Daniel Berrange (berrange)
References: <158788589324.18152.6333525201430073299.malonedeb@wampee.canonical.com>
Message-Id: <158797993725.17831.13213290853647082757.malone@wampee.canonical.com>
Subject: [Bug 1875139] Re: Domain fails to start when 'readonly' device not
 writable
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 36ec1156d397decc58b20bcc941db8c18f5304a7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 05:15:42
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
Reply-To: Bug 1875139 <1875139@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> This issue is introduced in QEMU 4.2.0 (4.1.0 is working fine)

That's not neccessarily the case - with QEMU 4.2.0, libvirt switched
over to using the new -blockdev command line syntax. When you were
testing with 4.1.0, it would have been using the legacy -drive syntax.
So the change in behaviour is more likely related to the usage of
-blockdev, than any bug introduced in QEMU.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1875139

Title:
  Domain fails to start when 'readonly' device not writable

Status in QEMU:
  New

Bug description:
  This issue is introduced in QEMU 4.2.0 (4.1.0 is working fine)

  My root disk is a LVM2 volume thin snapshot that is marked as read-only
  But when I try to start the domain (using virt-manager) I get the followi=
ng error:

  Error starting domain: internal error: process exited while connecting
  to monitor: 2020-04-26T06:55:06.342700Z qemu-system-x86_64: -blockdev
  {"driver":"host_device","filename":"/dev/vg/vmroot-20200425","aio":"native
  ","node-name":"libvirt-3-storage","cache":{"direct":true,"no-
  flush":false},"auto-read-only":true,"discard":"unmap"} The device is
  not writable: Permission denied

  Changing the lvm snapshot to writeable allows me to start the domain.
  (Making it changes possible during domain is running)

  I don't think QEMU should fail when it can't open a (block) device when t=
he read-only option is set.
  (why is write access needed?)

  Reproduce steps:
  * Create LVM read-only volume (I don't think any data is needed)
  * Create domain with read-only volume as block device
  * Try to start the domain

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1875139/+subscriptions

