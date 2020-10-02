Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73B0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E269B206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E269B206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMZf-0006Sa-Nq
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kOMJi-0003qY-5U
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:45:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:41582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kOMJc-0004nN-D1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:45:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kOMJW-0007Dx-8F
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 14:45:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 37B4C2E80E8
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2020 14:45:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2020 14:40:12 -0000
From: Frederic Bezies <1898215@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fredb74
X-Launchpad-Bug-Reporter: Frederic Bezies (fredb74)
X-Launchpad-Bug-Modifier: Frederic Bezies (fredb74)
Message-Id: <160164961305.8642.6420581526403273155.malonedeb@wampee.canonical.com>
Subject: [Bug 1898215] [NEW] [git][archlinux]Build process is busted in
 spice-display.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 295e1cbb727a5895399923bc3cf12f3da7f1f295
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 10:45:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1898215 <1898215@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Linux distribution: Archlinux. Crash log added is based on a build from
scratch.

Gcc version: 10.2.0

Configure options used:

configure \
    --prefix=3D/usr \
    --sysconfdir=3D/etc \
    --localstatedir=3D/var \
    --libexecdir=3D/usr/lib/qemu \
    --extra-ldflags=3D"$LDFLAGS" \
    --smbd=3D/usr/bin/smbd \
    --enable-modules \
    --enable-sdl \
    --disable-werror \
    --enable-slirp=3Dsystem \
    --enable-xfsctl \
    --audio-drv-list=3D"pa alsa sdl"

Crash log:

../ui/spice-display.c: In function 'interface_client_monitors_config':
../ui/spice-display.c:682:25: error: 'VD_AGENT_CONFIG_MONITORS_FLAG_PHYSICA=
L_SIZE' undeclared (first use in this function); did you mean 'VD_AGENT_CON=
FIG_MONITORS_FLAG_USE_POS'?
  682 |         if (mc->flags & VD_AGENT_CONFIG_MONITORS_FLAG_PHYSICAL_SIZE=
) {
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                         VD_AGENT_CONFIG_MONITORS_FLAG_USE_POS
../ui/spice-display.c:682:25: note: each undeclared identifier is reported =
only once for each function it appears in
../ui/spice-display.c:683:13: error: unknown type name 'VDAgentMonitorMM'
  683 |             VDAgentMonitorMM *mm =3D (void *)&mc->monitors[mc->num_=
of_monitors];
      |             ^~~~~~~~~~~~~~~~
../ui/spice-display.c:684:37: error: request for member 'width' in somethin=
g not a structure or union
  684 |             info.width_mm =3D mm[head].width;
      |                                     ^
../ui/spice-display.c:685:38: error: request for member 'height' in somethi=
ng not a structure or union
  685 |             info.height_mm =3D mm[head].height;
      |                                      ^
make: *** [Makefile.ninja:2031: libcommon.fa.p/ui_spice-display.c.o] Error 1
make: *** Waiting for unfinished jobs....

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1898215

Title:
  [git][archlinux]Build process is busted in spice-display.c

Status in QEMU:
  New

Bug description:
  Linux distribution: Archlinux. Crash log added is based on a build
  from scratch.

  Gcc version: 10.2.0

  Configure options used:

  configure \
      --prefix=3D/usr \
      --sysconfdir=3D/etc \
      --localstatedir=3D/var \
      --libexecdir=3D/usr/lib/qemu \
      --extra-ldflags=3D"$LDFLAGS" \
      --smbd=3D/usr/bin/smbd \
      --enable-modules \
      --enable-sdl \
      --disable-werror \
      --enable-slirp=3Dsystem \
      --enable-xfsctl \
      --audio-drv-list=3D"pa alsa sdl"

  Crash log:

  ../ui/spice-display.c: In function 'interface_client_monitors_config':
  ../ui/spice-display.c:682:25: error: 'VD_AGENT_CONFIG_MONITORS_FLAG_PHYSI=
CAL_SIZE' undeclared (first use in this function); did you mean 'VD_AGENT_C=
ONFIG_MONITORS_FLAG_USE_POS'?
    682 |         if (mc->flags & VD_AGENT_CONFIG_MONITORS_FLAG_PHYSICAL_SI=
ZE) {
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
        |                         VD_AGENT_CONFIG_MONITORS_FLAG_USE_POS
  ../ui/spice-display.c:682:25: note: each undeclared identifier is reporte=
d only once for each function it appears in
  ../ui/spice-display.c:683:13: error: unknown type name 'VDAgentMonitorMM'
    683 |             VDAgentMonitorMM *mm =3D (void *)&mc->monitors[mc->nu=
m_of_monitors];
        |             ^~~~~~~~~~~~~~~~
  ../ui/spice-display.c:684:37: error: request for member 'width' in someth=
ing not a structure or union
    684 |             info.width_mm =3D mm[head].width;
        |                                     ^
  ../ui/spice-display.c:685:38: error: request for member 'height' in somet=
hing not a structure or union
    685 |             info.height_mm =3D mm[head].height;
        |                                      ^
  make: *** [Makefile.ninja:2031: libcommon.fa.p/ui_spice-display.c.o] Erro=
r 1
  make: *** Waiting for unfinished jobs....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1898215/+subscriptions

