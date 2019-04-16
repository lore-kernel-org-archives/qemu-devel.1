Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040C7C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED7D21B26
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED7D21B26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=centrum.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOa9-0001Kl-1M
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:57:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGOYi-0000N9-9p
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGOYh-0006Pv-7D
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:55:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:38828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGOYh-0006PR-0S
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:55:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGOYf-0001rG-N7
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 13:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ADFD92E80C0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 13:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 13:39:16 -0000
From: John Doe <maildir@centrum.cz>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: maildir-2 th-huth
X-Launchpad-Bug-Reporter: John Doe (maildir-2)
X-Launchpad-Bug-Modifier: John Doe (maildir-2)
References: <20160208150110.15874.66099.malonedeb@gac.canonical.com>
Message-Id:
 <155542195661.20393.16865013643813448698.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 6be592aad7fb88d43ee01f29dc21ddc4e78ed295
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1543163] Re: VMs unable to boot from network with
 e1000 since 2.2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1543163 <1543163@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416133916.j09XeQ3kGG1J3r4fvylrYLyYa70THTTixP6ZFJQONwo@z>

I have 3.10 and I managed to boot with e1000 at least in BIOS mode. I am no=
t sure about UEFI mode, because I get no output on "screen" for whatever, p=
erhaps unrelated reason.
Anyway, I think we may close it for now.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1543163

Title:
  VMs unable to boot from network with e1000 since 2.2

Status in QEMU:
  Incomplete

Bug description:
  With KVM/QEMU version 1.4, using e1000 NIC, virtual machines boot from
  network alright; they get an IP from DHCP server (machine A), then
  connect to Microsoft System Center (machine B) and proceed to boot
  into Windows PE, install images etc.

  However, with versions at least 2.2 and 2.5, using same NIC, virtual
  machines fail to boot from network; they still get an IP from A, but
  then fail "contacting B using gateway (0.0.0.0). Different NICs do not
  help except for i82551, which however causes problems further down the
  road (presumably because there is no driver for that card in PE (based
  on Windows 7/8/10)).

  Note that actual physical machines work.

  Wireshark reveals this:

  QEMU 1.4 + Intel e1000
  **********************
  1) client sends DHCP discover
  2) machine A answers, offers an IP, gateway and itself as next server
  3) machine B answers, offers no IP, but gateway and itself as next server
  4) client requests the IP
  5) machine A ACKs
  6) client sends unicast request for ??? to B
  7) B offers (unicast) a boot file (some .com)
  8) client sends another unicast request for ??? to B
  9) B again offers the boot file
  (then they chat a bit, B offers another file, client downloads some stuff=
 via TFTP etc.)

  =

  QEMU 2.2/2.5 + Intel e1000
  **************************
  1) client sends DHCP discover
  2) machine A answers, offers an IP, gateway and itself as next server
  3) machine B answers, offers no IP, but gateway and itself as next server
  4) client requests the IP
  5) machine A ACKs
  6) client sends _broadcast_ request for ??? to B
  7) B offers (likewise broadcast) a boot file
  8) client sends another request, this time unicast and claims "Client IP =
address =3D 0.0.0.0"
  (and it basically hangs)

  =

  So, since some time after 1.4, QEMUlated machines with otherwise trusty e=
1000 can no longer boot from network and it might be due to different behav=
iour.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1543163/+subscriptions

