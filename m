Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C188C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4187F21569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4187F21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itv3w-0006T5-Uj
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ituux-00067q-0Y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ituut-0006a7-Dk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:54:10 -0500
Received: from indium.canonical.com ([91.189.90.7]:36954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ituut-0006Ze-86
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:54:07 -0500
Received: from wampee.canonical.com ([91.189.89.61])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ituur-0002gB-OS
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 14:54:05 +0000
Received: from wampee.canonical.com (localhost [127.0.0.1])
 by wampee.canonical.com (Postfix) with ESMTPS id A6CF63B0150
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 14:54:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jan 2020 14:54:04 -0000
From: Launchpad Bug Tracker <1859656@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=maas; status=Incomplete; importance=Undecided;
 assignee=lee.trager@canonical.com; 
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: product=ubuntu-z-systems; status=Triaged; importance=High;
 assignee=maas; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ltrager sfeole
X-Launchpad-Bug-Reporter: Sean Feole (sfeole)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <157902669328.14768.4315907500950527119.malonedeb@wampee.canonical.com>
Subject: [Bug 1859656] [NEW] [2.6] Unable to reboot s390x KVM machine after
 initial deploy
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Message-Id: <157961844440.4634.12267071627760125616.launchpad@wampee.canonical.com>
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f1052173880d8dae43faa7c2fc45da1b42227143";
 Instance="appserver-secrets-lazr.conf"
X-Launchpad-Hash: d50ec6d6c13d4c8070f88431c67e07f314c623c3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1859656 <1859656@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You have been subscribed to a public bug:

MAAS version: 2.6.1 (7832-g17912cdc9-0ubuntu1~18.04.1)
Arch: S390x

Appears that MAAS can not find the s390x bootloader to boot from the
disk, not sure how maas determines this.  However this was working in
the past. I had originally thought that if the maas machine was deployed
then it defaulted to boot from disk.

If I force the VM to book from disk, the VM starts up as expected.

Reproduce:

- Deploy Disco on S390x KVM instance
- Reboot it

on the KVM console...

Connected to domain s2lp6g001
Escape character is ^]
done
=C2=A0=C2=A0Using IPv4 address: 10.246.75.160
=C2=A0=C2=A0Using TFTP server: 10.246.72.3
=C2=A0=C2=A0Bootfile name: 'boots390x.bin'
=C2=A0=C2=A0Receiving data:  0 KBytes
=C2=A0=C2=A0TFTP error: file not found: boots390x.bin
Trying pxelinux.cfg files...
=C2=A0=C2=A0Receiving data:  0 KBytes
=C2=A0=C2=A0Receiving data:  0 KBytes
Failed to load OS from network

=3D=3D> /var/log/maas/rackd.log <=3D=3D
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] boots390x=
.bin requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/65a=
9ca43-9541-49be-b315-e2ca85936ea2 requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/01-=
52-54-00-e5-d7-bb requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64BA0 requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64BA requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64B requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64 requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
6 requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
 requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0A =
requested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0 r=
equested by 10.246.75.160
2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/def=
ault requested by 10.246.75.160

** Affects: maas
     Importance: Undecided
     Assignee: Lee Trager (ltrager)
         Status: Incomplete

** Affects: qemu
     Importance: Undecided
         Status: New

** Affects: ubuntu-z-systems
     Importance: High
     Assignee: MAAS (maas)
         Status: Triaged

-- =

[2.6] Unable to reboot s390x KVM machine after initial deploy
https://bugs.launchpad.net/bugs/1859656
You received this bug notification because you are a member of qemu-devel-m=
l, which is subscribed to QEMU.

