Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7038C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B2D2065E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B2D2065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCC3-0008K9-Qr
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyCBL-0007rv-DG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:41:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:59304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyCBI-0001kd-HY
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:41:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jyCBG-0007mK-1E
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 10:40:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B9B0C2E8052
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 10:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2020 10:27:29 -0000
From: ZhaoSQ-CH <1888492@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: zhaosq
X-Launchpad-Bug-Reporter: ZhaoSQ-CH (zhaosq)
X-Launchpad-Bug-Modifier: ZhaoSQ-CH (zhaosq)
Message-Id: <159541364991.32738.5508954702379988107.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1888492] [NEW] After installing Ubuntu,
 restart and pop up the CMD command prompt
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c17055d105dc9c6be821ce00df7adf31314d72f3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 04:15:39
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
Reply-To: Bug 1888492 <1888492@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

QEMU release version=EF=BC=9A V5.1.0
time=EF=BC=9A2020=E5=B9=B47=E6=9C=8822=E6=97=A510:34:40
Operation: =E5=AE=89=E8=A3=85=E5=AE=8CUbuntu=E5=90=8E=E9=87=8D=E6=96=B0=E5=
=90=AF=E5=8A=A8=EF=BC=8C=E5=B9=B6=E5=BC=B9=E5=87=BACMD=E5=91=BD=E4=BB=A4=E6=
=8F=90=E7=A4=BA=E7=AC=A6
use Ubuntu release version =EF=BC=9AV20.04-desktop.
use windows release version: windows 10.
Question:
Command used=EF=BC=9Aqemu-system-x86_64.exe -name test -m 4096 -machine acc=
el=3Dhax -cdrom .\workspace\ubuntu\ubuntu-20.04-desktop-amd64.iso .\workspa=
ce\img\ubuntu.img
HAX is working and emulator runs in fast virt mode.
*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

*** BUG ***
In pixman_region32_init_rect: Invalid rectangle passed
Set a breakpoint on '_pixman_log_error' to debug

(qemu:660): Gtk-WARNING **: Negative content width -7 (allocation 1,
extents 4x4) while allocating gadget (node headerbar, owner
GtkHeaderBar)

(qemu:660): Gtk-WARNING **: gtk_widget_size_allocate(): attempt to
allocate widget with width -102 and height 16

(qemu:660): Gtk-WARNING **: Negative content width -23 (allocation 1, exten=
ts 12x12) while allocating gadget (node label, owner GtkLabel)
qemu-system-x86_64.exe: Gtk: gtk_distribute_natural_allocation: assertion '=
extra_space >=3D 0' failed

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: windows

** Tags added: windows

** Description changed:

  QEMU release version=EF=BC=9A V5.1.0
  time=EF=BC=9A2020=E5=B9=B47=E6=9C=8822=E6=97=A510:34:40
  Operation: =E5=AE=89=E8=A3=85=E5=AE=8CUbuntu=E5=90=8E=E9=87=8D=E6=96=B0=
=E5=90=AF=E5=8A=A8=EF=BC=8C=E5=B9=B6=E5=BC=B9=E5=87=BACMD=E5=91=BD=E4=BB=A4=
=E6=8F=90=E7=A4=BA=E7=AC=A6
+ use Ubuntu release version =EF=BC=9AV20.04-desktop.
+ use windows release version: windows 10.
  Question:
  Command used=EF=BC=9Aqemu-system-x86_64.exe -name test -m 4096 -machine a=
ccel=3Dhax -cdrom .\workspace\ubuntu\ubuntu-20.04-desktop-amd64.iso .\works=
pace\img\ubuntu.img
  HAX is working and emulator runs in fast virt mode.
  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug
  =

- =

- (qemu:660): Gtk-WARNING **: Negative content width -7 (allocation 1, exte=
nts 4x4) while allocating gadget (node headerbar, owner GtkHeaderBar)
+ (qemu:660): Gtk-WARNING **: Negative content width -7 (allocation 1,
+ extents 4x4) while allocating gadget (node headerbar, owner
+ GtkHeaderBar)
  =

  (qemu:660): Gtk-WARNING **: gtk_widget_size_allocate(): attempt to
  allocate widget with width -102 and height 16
  =

  (qemu:660): Gtk-WARNING **: Negative content width -23 (allocation 1, ext=
ents 12x12) while allocating gadget (node label, owner GtkLabel)
  qemu-system-x86_64.exe: Gtk: gtk_distribute_natural_allocation: assertion=
 'extra_space >=3D 0' failed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888492

Title:
  After installing Ubuntu, restart and pop up the CMD command prompt

Status in QEMU:
  New

Bug description:
  QEMU release version=EF=BC=9A V5.1.0
  time=EF=BC=9A2020=E5=B9=B47=E6=9C=8822=E6=97=A510:34:40
  Operation: =E5=AE=89=E8=A3=85=E5=AE=8CUbuntu=E5=90=8E=E9=87=8D=E6=96=B0=
=E5=90=AF=E5=8A=A8=EF=BC=8C=E5=B9=B6=E5=BC=B9=E5=87=BACMD=E5=91=BD=E4=BB=A4=
=E6=8F=90=E7=A4=BA=E7=AC=A6
  use Ubuntu release version =EF=BC=9AV20.04-desktop.
  use windows release version: windows 10.
  Question:
  Command used=EF=BC=9Aqemu-system-x86_64.exe -name test -m 4096 -machine a=
ccel=3Dhax -cdrom .\workspace\ubuntu\ubuntu-20.04-desktop-amd64.iso .\works=
pace\img\ubuntu.img
  HAX is working and emulator runs in fast virt mode.
  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  *** BUG ***
  In pixman_region32_init_rect: Invalid rectangle passed
  Set a breakpoint on '_pixman_log_error' to debug

  (qemu:660): Gtk-WARNING **: Negative content width -7 (allocation 1,
  extents 4x4) while allocating gadget (node headerbar, owner
  GtkHeaderBar)

  (qemu:660): Gtk-WARNING **: gtk_widget_size_allocate(): attempt to
  allocate widget with width -102 and height 16

  (qemu:660): Gtk-WARNING **: Negative content width -23 (allocation 1, ext=
ents 12x12) while allocating gadget (node label, owner GtkLabel)
  qemu-system-x86_64.exe: Gtk: gtk_distribute_natural_allocation: assertion=
 'extra_space >=3D 0' failed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888492/+subscriptions

