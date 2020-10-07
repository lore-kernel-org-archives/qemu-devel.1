Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D200C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EE6208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EE6208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1OR-0004lI-Pg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15i-0002dP-9h
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:30:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:38160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15e-0005Ta-13
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:30:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQ15K-0002Cd-O8
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:29:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 39C972E812C
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 04:29:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 04:17:19 -0000
From: Launchpad Bug Tracker <897466@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu-kvm; component=main; 
 status=Expired; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=precise;
 sourcepackage=qemu-kvm; component=main; status=Expired; importance=Medium;
 assignee=None; 
X-Launchpad-Bug-Tags: regression-release
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor jdstrand serge-hallyn th-huth
X-Launchpad-Bug-Reporter: Jamie Strandboge (jdstrand)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20111128231908.14324.64245.malonedeb@gac.canonical.com>
Message-Id: <160204423980.20421.4700954759354775935.malone@loganberry.canonical.com>
Subject: [Bug 897466] Re: UHCI Host Controller no longer present with -usb
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 1d10e731dd4c1c588fbe5c0e03ab9e8abcc0e979
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 22:50:47
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
Reply-To: Bug 897466 <897466@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for qemu-kvm (Ubuntu Precise) because there has been no
activity for 60 days.]

** Changed in: qemu-kvm (Ubuntu Precise)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/897466

Title:
  UHCI Host Controller no longer present with -usb

Status in QEMU:
  Expired
Status in qemu-kvm package in Ubuntu:
  Expired
Status in qemu-kvm source package in Precise:
  Expired

Bug description:
  If on an up to date 12.04 install and I start a VM with:
  $ qemu -m 192 -serial none -chardev null,id=3Dchardevmon -pidfile /tmp/pi=
d -daemonize -nographic -monitor tcp:127.0.0.1:4444,server,nowait -net user=
,hostfwd=3Dtcp:127.0.0.1:4422-:22 -usb -rtc base=3Dutc -name qatest-vm -uui=
d ded3a46b-bb60-43f4-8113-d041aeb93cdf -hda libvirt/qatest/qatest.qcow2

  Then use the 'info usbhost' in the monitor, I get:
  $ echo 'info usbhost' | nc -q 1 127.0.0.1 4444
  (qemu) info usbhost
  husb: using sys file-system with /dev/bus/usb
  $

  In Oneiric and eariler, 'info usbhost' would show a UHCI Host Controller.=
 Eg:
  $ qemu -m 192 -serial none -chardev null,id=3Dchardevmon -pidfile /tmp/pi=
d -daemonize -nographic -monitor tcp:127.0.0.1:4444,server,nowait -net user=
,hostfwd=3Dtcp:127.0.0.1:4422-:22 -usb -rtc base=3Dutc -name qatest-vm -uui=
d ded3a46b-bb60-43f4-8113-d041aeb93cdf -hda libvirt/qatest/qatest.qcow2
  $ echo 'info usbhost' | nc -q 1 127.0.0.1 4444
  QEMU 0.14.1 monitor - type 'help' for more information
  (qemu) info usbhost
  husb: using sys file-system with /dev/bus/usb
  =C2=A0=C2=A0Device 1.1, speed 12 Mb/s
  =C2=A0=C2=A0=C2=A0=C2=A0Hub: USB device 1d6b:0001, UHCI Host Controller

  This breaks QRT/scripts/test-qemu.py and appears to be a regression,
  but I am not sure if it is a 3.2 kernel issue or a 0.14.1 vs 0.15
  issue. I should mention this is happening with qemu without /dev/kvm
  available (ie, I am running test-qemu.py in an up to date precise VM).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/897466/+subscriptions

