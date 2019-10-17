Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C28FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0192082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0192082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL52h-0008VX-Da
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iL50M-0005Xy-7Z
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iL50K-0006Mq-Nc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:35:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:34258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iL50K-0006MV-Ha
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:35:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iL50I-0003K7-W4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 12:35:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F09D92E80C9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 12:35:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2019 12:27:26 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1838569@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=cloud-archive; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bjoern-teipel dgilbert-h dpreussker janitor paelzer
X-Launchpad-Bug-Reporter: Bjoern Teipel (bjoern-teipel)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <156460681322.6584.3709701644111615718.malonedeb@soybean.canonical.com>
 <157131000230.25166.8865857649571304359.malone@chaenomeles.canonical.com>
Message-Id: <CAATJJ0La_gNGTOtWUN3BWzOTnWe2L_EpcUqXbGgTAePG9Y0m4g@mail.gmail.com>
Subject: [Bug 1838569] Re: virtio-balloon change breaks post 4.0 upgrade
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5337dd175f56246c273aec395b08087a2033bb82
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
Reply-To: Bug 1838569 <1838569@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> I'd bet on this being the one fixed by
> 2bbadb08ce272d65e1f78621002008b07d1e0f03

But wasn't the breakage this fixes only added in qemu 4.0?
He reports his change is from qemu 2.10 to 2.11.

Unfortunately 2bbadb08 doesn't have a "fixes" line, maybe Ubuntu has
something backported that makes the Ubuntu 2.11 being affected by it.
I checked the Delta but there was nothing related backported that I
could identify.

But I agree, that first of all this should be a new bug instead of
reviving the old one here.


** Also affects: cloud-archive
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838569

Title:
  virtio-balloon change breaks post 4.0 upgrade

Status in Ubuntu Cloud Archive:
  New
Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  We upgraded the libvirt UCA packages from 3.6 to 4.0 and qemu 2.10 to 2.1=
1  as part of a queens upgrade and noticed that
  virtio-ballon is broken when instances live migrate (started with a prior=
 3.6 version)  with:

  2019-07-24T06:46:49.487109Z qemu-system-x86_64: warning: Unknown firmware=
 file in legacy mode: etc/msr_feature_control
  2019-07-24T06:47:22.187749Z qemu-system-x86_64: VQ 2 size 0x80 < last_ava=
il_idx 0xb57 - used_idx 0xb59
  2019-07-24T06:47:22.187768Z qemu-system-x86_64: Failed to load virtio-bal=
loon:virtio
  2019-07-24T06:47:22.187771Z qemu-system-x86_64: error while loading state=
 for instance 0x0 of device '0000:00:05.0/virtio-balloon'
  2019-07-24T06:47:22.188194Z qemu-system-x86_64: load of migration failed:=
 Operation not permitted
  2019-07-24 06:47:22.430+0000: shutting down, reason=3Dfailed

  This seem to be the exact problem as reported by
  https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02228.html

  Listed the packages which changed:

  Start-Date: 2019-07-06  06:40:55
  Commandline: /usr/bin/apt-get -y -o Dpkg::Options::=3D--force-confdef -o =
Dpkg::Options::=3D--force-confold install libvirt-bin python-libvirt qemu q=
emu-utils qemu-system qemu-system-arm qemu-system-mips qemu-system-ppc qemu=
-system-sparc qemu-system-x86 qemu-system-misc qemu-block-extra qemu-utils =
qemu-user qemu-kvm
  Install: librdmacm1:amd64 (17.1-1ubuntu0.1~cloud0, automatic), libvirt-da=
emon-driver-storage-rbd:amd64 (4.0.0-1ubuntu8.10~cloud0, automatic), ipxe-q=
emu-256k-compat-efi-roms:amd64 (1.0.0+git-20150424.a25a16d-0ubuntu2~cloud0,=
 automatic)
  Upgrade: qemu-system-mips:amd64 (1:2.10+dfsg-0ubuntu3.8~cloud1, 1:2.11+df=
sg-1ubuntu7.13~cloud0), qemu-system-misc:amd64 (1:2.10+dfsg-0ubuntu3.8~clou=
d1, 1:2.11+dfsg-1ubuntu7.13~cloud0), qemu-system-ppc:amd64 (1:2.10+dfsg-0ub=
untu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), python-libvirt:amd64 (3.5.=
0-1build1~cloud0, 4.0.0-1~cloud0), qemu-system-x86:amd64 (1:2.10+dfsg-0ubun=
tu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), libvirt-clients:amd64 (3.6.0=
-1ubuntu6.8~cloud0, 4.0.0-1ubuntu8.10~cloud0), qemu-user:amd64 (1:2.10+dfsg=
-0ubuntu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), libvirt-bin:amd64 (3.6=
.0-1ubuntu6.8~cloud0, 4.0.0-1ubuntu8.10~cloud0), qemu:amd64 (1:2.10+dfsg-0u=
buntu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), qemu-utils:amd64 (1:2.10+=
dfsg-0ubuntu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), libvirt-daemon-sys=
tem:amd64 (3.6.0-1ubuntu6.8~cloud0, 4.0.0-1ubuntu8.10~cloud0), qemu-system-=
sparc:amd64 (1:2.10+dfsg-0ubuntu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0)=
, qemu-user-binfmt:amd64 (1:2.10+dfsg-0ubuntu3.8~cloud1, 1:2.11+dfsg-1ubunt=
u7.13~cloud0), qemu-kvm:amd64 (1:2.10+dfsg-0ubuntu3.8~cloud1, 1:2.11+dfsg-1=
ubuntu7.13~cloud0), libvirt0:amd64 (3.6.0-1ubuntu6.8~cloud0, 4.0.0-1ubuntu8=
.10~cloud0), qemu-system-arm:amd64 (1:2.10+dfsg-0ubuntu3.8~cloud1, 1:2.11+d=
fsg-1ubuntu7.13~cloud0), qemu-block-extra:amd64 (1:2.10+dfsg-0ubuntu3.8~clo=
ud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), qemu-system-common:amd64 (1:2.10+dfsg=
-0ubuntu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), qemu-system:amd64 (1:2=
.10+dfsg-0ubuntu3.8~cloud1, 1:2.11+dfsg-1ubuntu7.13~cloud0), libvirt-daemon=
:amd64 (3.6.0-1ubuntu6.8~cloud0, 4.0.0-1ubuntu8.10~cloud0)
  End-Date: 2019-07-06  06:41:08

  At this point the instances would have to be hard rebooted or
  stopped/started to fix the issue for future live migration attemps

To manage notifications about this bug go to:
https://bugs.launchpad.net/cloud-archive/+bug/1838569/+subscriptions

