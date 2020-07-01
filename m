Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775BFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5051420722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5051420722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZ0j-0000Bi-HY
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jqYzu-0007mh-5G
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:41384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jqYzr-0004uk-Nt
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:25:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jqYzp-0005fR-LB
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9A6D32E810B
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 09:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2020 09:19:18 -0000
From: santhosh kumar <1885889@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: santhoshht
X-Launchpad-Bug-Reporter: santhosh kumar (santhoshht)
X-Launchpad-Bug-Modifier: santhosh kumar (santhoshht)
Message-Id: <159359515867.16429.1432427219999923792.malonedeb@soybean.canonical.com>
Subject: [Bug 1885889] [NEW] ERROR: core-image-minimal-1.0-r0 do_rootfs: The
 postinstall intercept hook 'update_font_cache' failed, 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 24138920f4ebb8db5434a9b25b97927f287234a6
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 03:10:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1885889 <1885889@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,

I am trying to build bitbake core-image-minimal getting following error.

santhosh@santhosh-VirtualBox:~/Denverton/Source/BSP/poky/build$ bitbake cor=
e-image-minimal
Loading cache: 100% |######################################################=
#########################################| Time: 0:00:00
Loaded 1370 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           =3D "1.44.0"
BUILD_SYS            =3D "x86_64-linux"
NATIVELSBSTRING      =3D "universal"
TARGET_SYS           =3D "x86_64-poky-linux"
MACHINE              =3D "ddsmdnv"
DISTRO               =3D "poky"
DISTRO_VERSION       =3D "3.0.2"
TUNE_FEATURES        =3D "m64 corei7"
TARGET_FPU           =3D ""
meta                 =

meta-poky            =

meta-ddsmdnv         =3D "DDSM_Denverton_PHASE_1_FDJ_Release:471fec241d3a1a=
4b70ad58135fe229eab2b6a196"

Initialising tasks: 100% |#################################################=
#########################################| Time: 0:00:05
Sstate summary: Wanted 413 Found 0 Missed 413 Current 937 (0% match, 69% co=
mplete)
NOTE: Executing Tasks
NOTE: Setscene tasks completed
ERROR: core-image-minimal-1.0-r0 do_rootfs: The postinstall intercept hook =
'update_font_cache' failed, details in /home/santhosh/Denverton/Source/BSP/=
poky/build/tmp/work/ddsmdnv-poky-linux/core-image-minimal/1.0-r0/temp/log.d=
o_rootfs
ERROR: Logfile of failure stored in: /home/santhosh/Denverton/Source/BSP/po=
ky/build/tmp/work/ddsmdnv-poky-linux/core-image-minimal/1.0-r0/temp/log.do_=
rootfs.9682
ERROR: Task (/home/santhosh/Denverton/Source/BSP/poky/meta-ddsmdnv/recipes-=
core/images/core-image-minimal.bb:do_rootfs) failed with exit code '1'


Could you please help me on how to fix this issue.

Thank you.

Santhosh

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1885889

Title:
  ERROR: core-image-minimal-1.0-r0 do_rootfs: The postinstall intercept
  hook 'update_font_cache' failed,

Status in QEMU:
  New

Bug description:
  Hello,

  I am trying to build bitbake core-image-minimal getting following
  error.

  santhosh@santhosh-VirtualBox:~/Denverton/Source/BSP/poky/build$ bitbake c=
ore-image-minimal
  Loading cache: 100% |####################################################=
###########################################| Time: 0:00:00
  Loaded 1370 entries from dependency cache.
  NOTE: Resolving any missing task queue dependencies

  Build Configuration:
  BB_VERSION           =3D "1.44.0"
  BUILD_SYS            =3D "x86_64-linux"
  NATIVELSBSTRING      =3D "universal"
  TARGET_SYS           =3D "x86_64-poky-linux"
  MACHINE              =3D "ddsmdnv"
  DISTRO               =3D "poky"
  DISTRO_VERSION       =3D "3.0.2"
  TUNE_FEATURES        =3D "m64 corei7"
  TARGET_FPU           =3D ""
  meta                 =

  meta-poky            =

  meta-ddsmdnv         =3D "DDSM_Denverton_PHASE_1_FDJ_Release:471fec241d3a=
1a4b70ad58135fe229eab2b6a196"

  Initialising tasks: 100% |###############################################=
###########################################| Time: 0:00:05
  Sstate summary: Wanted 413 Found 0 Missed 413 Current 937 (0% match, 69% =
complete)
  NOTE: Executing Tasks
  NOTE: Setscene tasks completed
  ERROR: core-image-minimal-1.0-r0 do_rootfs: The postinstall intercept hoo=
k 'update_font_cache' failed, details in /home/santhosh/Denverton/Source/BS=
P/poky/build/tmp/work/ddsmdnv-poky-linux/core-image-minimal/1.0-r0/temp/log=
.do_rootfs
  ERROR: Logfile of failure stored in: /home/santhosh/Denverton/Source/BSP/=
poky/build/tmp/work/ddsmdnv-poky-linux/core-image-minimal/1.0-r0/temp/log.d=
o_rootfs.9682
  ERROR: Task (/home/santhosh/Denverton/Source/BSP/poky/meta-ddsmdnv/recipe=
s-core/images/core-image-minimal.bb:do_rootfs) failed with exit code '1'

  =

  Could you please help me on how to fix this issue.

  Thank you.

  Santhosh

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1885889/+subscriptions

