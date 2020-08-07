Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC090C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B1520866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B1520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xO0-0004A9-VO
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3xNA-0003dl-Sg
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:05:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:56640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3xN9-0000la-0D
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:05:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3xN6-0003jE-4T
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 08:05:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 203FA2E8081
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 08:05:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 07:55:16 -0000
From: Thomas Huth <897466@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu-kvm; component=main; 
 status=Incomplete; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=precise;
 sourcepackage=qemu-kvm; component=main; status=Incomplete; importance=Medium; 
 assignee=None; 
X-Launchpad-Bug-Tags: regression-release
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jdstrand serge-hallyn th-huth
X-Launchpad-Bug-Reporter: Jamie Strandboge (jdstrand)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20111128231908.14324.64245.malonedeb@gac.canonical.com>
Message-Id: <159678691685.10180.13082185694551543235.malone@chaenomeles.canonical.com>
Subject: [Bug 897466] Re: UHCI Host Controller no longer present with -usb
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6e4b47489d3639bcc30fc804753c61ab76891c6b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Looking through old bug tickets... is this still an issue with the
latest version of QEMU, or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu-kvm (Ubuntu)
       Status: Confirmed =3D> Incomplete

** Changed in: qemu-kvm (Ubuntu Precise)
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/897466

Title:
  UHCI Host Controller no longer present with -usb

Status in QEMU:
  Incomplete
Status in qemu-kvm package in Ubuntu:
  Incomplete
Status in qemu-kvm source package in Precise:
  Incomplete

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

