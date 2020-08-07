Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B290CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87ED422D73
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ED422D73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42zu-0003uf-Nq
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k42zJ-0003Tn-6D
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:04:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:46616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k42zH-0002Cb-0m
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:04:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k42zF-0004oG-2r
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 14:04:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F07522E809C
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 14:04:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 13:53:59 -0000
From: John Snow <1219234@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crobinso jnsnow th-huth
X-Launchpad-Bug-Reporter: Cole Robinson (crobinso)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <20130831150404.10743.73717.malonedeb@gac.canonical.com>
Message-Id: <159680843906.26262.16803249989681185887.malone@gac.canonical.com>
Subject: [Bug 1219234] Re: -device ide-hd will assign bus with with no free
 units
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 92a219a127b44cda60e988f5253e27b9561cf4e1
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
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
Reply-To: Bug 1219234 <1219234@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'll re-investigate. I definitely fixed some of this (there is if=3DIDE
for AHCI now), but I recall Markus mentioning recently that there are a
lot of weird things quite broken with AHCI and bus assignment.

I'm working on several other IDE fixes for the next release, so we can
add this one to the pile. I will leave it as "incomplete" for now since
I need to re-assess.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1219234

Title:
  -device ide-hd will assign bus with with no free units

Status in QEMU:
  Incomplete

Bug description:
  Originally filed here:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1000118

  ./x86_64-softmmu/qemu-system-x86_64 -device ahci -drive id=3Daa,file=3D/t=
mp/foo,if=3Dnone -drive id=3Dbb,file=3D/tmp/foo,if=3Dnone -device ide-hd,dr=
ive=3Daa -device ide-hd,drive=3Dbb
  qemu-system-x86_64: -device ide-hd,drive=3Dbb: Can't create IDE unit 1, b=
us supports only 1 units
  qemu-system-x86_64: -device ide-hd,drive=3Dbb: Device initialization fail=
ed.
  qemu-system-x86_64: -device ide-hd,drive=3Dbb: Device 'ide-hd' could not =
be initialized

  If a bus isn't specified for -device ide-hd, it just uses the first
  bus it finds, not taking into account if that bus was already assigned
  for another device. So users are forced to do -device ide-hd,bus=3Dide.0
  -device ide-hd,bus=3Dide.1, etc.

  This isn't specific to -device ahci, but it's worse there since there
  isn't any -drive if=3DIDE or -hda convenience option, which both seem to
  get the logic correct.

  I know -device is the 'build it yourself' approach so I understand if
  this is WONTFIX.

  This is affects qemu.git as of today (8-31-2013)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1219234/+subscriptions

