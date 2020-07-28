Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0663AC433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C4E2075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C4E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0L0F-00018v-5u
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0KzV-0000Hg-7D
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:29:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:47604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0KzP-00017m-Mv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:29:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0KzO-0007um-3u
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 08:29:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1A0942E8106
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 08:29:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2020 08:15:37 -0000
From: Thomas Huth <1390520@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=libvirt; component=main;
 status=Confirmed; importance=Wishlist; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=trusty;
 sourcepackage=libvirt; component=main; status=Won't Fix; importance=Medium;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: arges fifo++ guitarrero janitor jnsnow paelzer
 serge-hallyn stefan-kuhn-da
X-Launchpad-Bug-Reporter: wolfgang (guitarrero)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20141107160655.5759.49372.malonedeb@chaenomeles.canonical.com>
Message-Id: <159592413878.10400.1782307773325334587.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1390520] Re: virtual machine fails to start with connected audio
 cd
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 446d4e36a2fcc810b093ba6a21c0cfd370f792c5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 02:15:06
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
Reply-To: Bug 1390520 <1390520@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1390520

Title:
  virtual machine fails to start with connected audio cd

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Confirmed
Status in libvirt source package in Trusty:
  Won't Fix

Bug description:
  when connecting a data cd with a virtual machine (IDE CDROM 1), the virtu=
al machine starts up and the data cd is accessable (for example to install =
software package or drivers),
  but connecting an audio cd the following error appears:

  -------------------------------------------------------------------------=
------------------------------------------------------
  cannot read header '/dev/sr0': Input/output error

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/details.py", line 2530, in _c=
hange_config_helper
      func(*args)
    File "/usr/share/virt-manager/virtManager/domain.py", line 850, in hotp=
lug_storage_media
      self.attach_device(devobj)
    File "/usr/share/virt-manager/virtManager/domain.py", line 798, in atta=
ch_device
      self._backend.attachDevice(devxml)
    File "/usr/lib/python2.7/dist-packages/libvirt.py", line 493, in attach=
Device
      if ret =3D=3D -1: raise libvirtError ('virDomainAttachDevice() failed=
', dom=3Dself)
  libvirtError: cannot read header '/dev/sr0': Input/output error
  -------------------------------------------------------------------------=
---------------------------------------------------

  Description:    Ubuntu 14.04.1 LTS
  Release:        14.04

  qemu:
    Installiert:           2.0.0+dfsg-2ubuntu1.6
    Installationskandidat: 2.0.0+dfsg-2ubuntu1.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1390520/+subscriptions

