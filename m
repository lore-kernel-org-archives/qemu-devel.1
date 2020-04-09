Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28E2206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28E2206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYXN-0005hd-SX
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jMYWV-0004u2-Vn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jMYWU-0001Cy-HH
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:51:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:38900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jMYWU-0001Ce-Bt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:51:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jMYWS-0000zb-Ba
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:51:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 555C52E8107
 for <qemu-devel@nongnu.org>; Thu,  9 Apr 2020 14:51:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2020 14:34:59 -0000
From: Sean Feole <sean.feole@canonical.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=maas; status=Triaged; importance=Low;
 assignee=lee.trager@canonical.com; 
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=ubuntu-z-systems; status=Triaged; importance=High;
 assignee=maas; 
X-Launchpad-Bug-Tags: s390x
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrew-cloke fheimes ltrager paelzer sfeole
X-Launchpad-Bug-Reporter: Sean Feole (sfeole)
X-Launchpad-Bug-Modifier: Sean Feole (sfeole)
References: <157902669328.14768.4315907500950527119.malonedeb@wampee.canonical.com>
Message-Id: <158644289924.11806.6253987034588526277.malone@soybean.canonical.com>
Subject: [Bug 1859656] Re: [2.6] Unable to reboot s390x KVM machine after
 initial deploy
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ea805b821bdcdd411b1cad841fc4517e5cd6d58b
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
Reply-To: Bug 1859656 <1859656@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It would appear that this bug is once again causing problems with some of o=
ur automated testing.  =

S390x KVM deployments are failing for Focal. When attempting to investigate=
 a big I found that it is indeed this bug. =


Our MAAS Server is Version:

maas:
  Installed: 2.7.0-8232-g.6e1dba4ab-0ubuntu1~18.04.1
  Candidate: 2.7.0-8232-g.6e1dba4ab-0ubuntu1~18.04.1
  Version table:


I've attached the console log of the -KVM machine deploying.

On MAAS the rack controller reports the following:
sfeole@bsg75:~$ cat focal-s390x-maas.txt =

=3D=3D> rackd.log <=3D=3D
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] boots390x=
.bin requested by 10.246.75.177
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] s390x/65a=
9ca43-9541-49be-b315-e2ca85936ea2 requested by 10.246.75.177
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] s390x/01-=
52-54-00-e5-d7-bb requested by 10.246.75.177

=3D=3D> regiond.log <=3D=3D
2020-04-09 14:14:59 maasserver.rpc.leases: [info] Lease update: commit for =
10.246.75.177 on 52:54:0:e5:d7:bb at 2020-04-09 14:14:59 (lease time: 600s)

=3D=3D> rackd.log <=3D=3D
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64BB1 requested by 10.246.75.177
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64BB requested by 10.246.75.177
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64B requested by 10.246.75.177
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
64 requested by 10.246.75.177
2020-04-09 14:14:59 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
6 requested by 10.246.75.177
2020-04-09 14:15:00 provisioningserver.rackdservices.tftp: [info] s390x/0AF=
 requested by 10.246.75.177
2020-04-09 14:15:00 provisioningserver.rackdservices.tftp: [info] s390x/0A =
requested by 10.246.75.177
2020-04-09 14:15:00 provisioningserver.rackdservices.tftp: [info] s390x/0 r=
equested by 10.246.75.177
2020-04-09 14:15:00 provisioningserver.rackdservices.tftp: [info] s390x/def=
ault requested by 10.246.75.177


** Attachment added: "focal-s390x-deploy.txt"
   https://bugs.launchpad.net/maas/+bug/1859656/+attachment/5350338/+files/=
focal-s390x-deploy.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859656

Title:
  [2.6] Unable to reboot s390x KVM machine after initial deploy

Status in MAAS:
  Triaged
Status in QEMU:
  Incomplete
Status in Ubuntu on IBM z Systems:
  Triaged

Bug description:
  MAAS version: 2.6.1 (7832-g17912cdc9-0ubuntu1~18.04.1)
  Arch: S390x

  Appears that MAAS can not find the s390x bootloader to boot from the
  disk, not sure how maas determines this.  However this was working in
  the past. I had originally thought that if the maas machine was
  deployed then it defaulted to boot from disk.

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
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] boots39=
0x.bin requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/6=
5a9ca43-9541-49be-b315-e2ca85936ea2 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
1-52-54-00-e5-d7-bb requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64BA0 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64BA requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64B requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF6 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
A requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/d=
efault requested by 10.246.75.160

To manage notifications about this bug go to:
https://bugs.launchpad.net/maas/+bug/1859656/+subscriptions

