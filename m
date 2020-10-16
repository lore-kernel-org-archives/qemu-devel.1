Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A40AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A6F20829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A6F20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSmf-0003pG-6n
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTShu-0007um-9m
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:35:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:57326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTShm-0002dq-F7
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kTShb-0000e1-Uh
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 16:35:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DA8852E8133
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 16:35:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2020 16:29:12 -0000
From: vak <1900122@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: aarch64 docker ioctl video
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: khamenya
X-Launchpad-Bug-Reporter: vak (khamenya)
X-Launchpad-Bug-Modifier: vak (khamenya)
References: <160284373799.25039.16464171690101536645.malonedeb@soybean.canonical.com>
Message-Id: <160286575303.22344.13289815981696419116.launchpad@gac.canonical.com>
Subject: [Bug 1900122] Re: Unsupported ioctl: cmd=0xffffffff80685600 when
 accessing /dev/video* in aarch64 guest
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="58bb2f3096f16f0e0acc917602669aecb4ffaf54"; Instance="production"
X-Launchpad-Hash: 199d4a9989189e23fe6479704d5996d26dcc037f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 10:55:36
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
Reply-To: Bug 1900122 <1900122@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  **Description:**
  Any attempt to work with video in aarch64 architecture emulated on x86_64=
 leads currently to the error "Function not implemented". For example:
  =

  ```
  # v4l2-ctl -l --verbose
  Failed to open /dev/video0: Function not implemented
  =

  root@12dd9b6fcfcb:/# ll /dev/video*
  crw-rw---- 1 root video 81, 0 Oct 16 09:23 /dev/video0
  crw-rw---- 1 root video 81, 1 Oct 16 09:23 /dev/video1
  =

  ```
  =

  **Steps to reproduce the issue:**
  =

  I have a following setup:
  =

  Host Hardware: x86_64 equipped with a webcam (tried different webcams)
- Host OS: Ubuntu 20.04.1 =

+ Host OS: Ubuntu 20.04.1
  =

  Guest Architecture: aarch64
  Guest OS: Ubuntu 20.04 (also tried 16.x and 18.x)
  =

  Emulation: quemu-user-static (also tried binfmt)
  =

  Guest OS is running via Docker + QEMU
  =

  ```
  =E2=9E=9C cat /proc/sys/fs/binfmt_misc/qemu-aarch64
  enabled
  interpreter /usr/bin/qemu-aarch64-static
  flags: F
  offset 0
  magic 7f454c460201010000000000000000000200b700
  mask ffffffffffffff00fffffffffffffffffeffffff
  ```
  =

  **Results received:**
  see desrciption.
  =

+ =

  **Environment:**
  =

- <!-- The host architecture is available for only x86_64 -->
  * QEMU version: (if you can know it):
  =

  ipxe-qemu-256k-compat-efi-roms/focal,now 1.0.0+git-20150424.a25a16d-0ubun=
tu4 all [installed,automatic]
  ipxe-qemu/focal-updates,now 1.0.0+git-20190109.133f4c4-0ubuntu3.2 all [in=
stalled,automatic]
  qemu-block-extra/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,auto=
matic]
  qemu-kvm/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed]
  qemu-system-common/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,au=
tomatic]
  qemu-system-data/focal-updates,now 1:4.2-3ubuntu6.7 all [installed,automa=
tic]
  qemu-system-gui/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,autom=
atic]
  qemu-system-x86/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,autom=
atic]
  qemu-user-binfmt/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,auto=
matic]
  qemu-user/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed]
  qemu-utils/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,automatic]
  qemu/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed]
  =

  * Container application: Docker
  =

  **Output of `docker version`, `podman version` or `singularity
  version`**
  =

  ```
  =E2=9E=9C docker version
  Client: Docker Engine - Community
-  Version:           20.10.0-beta1
-  API version:       1.40
-  Go version:        go1.13.15
-  Git commit:        ac365d7
-  Built:             Tue Oct 13 18:15:22 2020
-  OS/Arch:           linux/amd64
-  Context:           default
-  Experimental:      true
+ =C2=A0Version:           20.10.0-beta1
+ =C2=A0API version:       1.40
+ =C2=A0Go version:        go1.13.15
+ =C2=A0Git commit:        ac365d7
+ =C2=A0Built:             Tue Oct 13 18:15:22 2020
+ =C2=A0OS/Arch:           linux/amd64
+ =C2=A0Context:           default
+ =C2=A0Experimental:      true
  =

  Server: Docker Engine - Community
-  Engine:
-   Version:          19.03.13
-   API version:      1.40 (minimum version 1.12)
-   Go version:       go1.13.15
-   Git commit:       4484c46d9d
-   Built:            Wed Sep 16 17:01:20 2020
-   OS/Arch:          linux/amd64
-   Experimental:     false
-  containerd:
-   Version:          1.4.1
-   GitCommit:        c623d1b36f09f8ef6536a057bd658b3aa8632828
-  runc:
-   Version:          1.0.0-rc92
-   GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
-  docker-init:
-   Version:          0.18.0
-   GitCommit:        fec3683
+ =C2=A0Engine:
+ =C2=A0=C2=A0Version:          19.03.13
+ =C2=A0=C2=A0API version:      1.40 (minimum version 1.12)
+ =C2=A0=C2=A0Go version:       go1.13.15
+ =C2=A0=C2=A0Git commit:       4484c46d9d
+ =C2=A0=C2=A0Built:            Wed Sep 16 17:01:20 2020
+ =C2=A0=C2=A0OS/Arch:          linux/amd64
+ =C2=A0=C2=A0Experimental:     false
+ =C2=A0containerd:
+ =C2=A0=C2=A0Version:          1.4.1
+ =C2=A0=C2=A0GitCommit:        c623d1b36f09f8ef6536a057bd658b3aa8632828
+ =C2=A0runc:
+ =C2=A0=C2=A0Version:          1.0.0-rc92
+ =C2=A0=C2=A0GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
+ =C2=A0docker-init:
+ =C2=A0=C2=A0Version:          0.18.0
+ =C2=A0=C2=A0GitCommit:        fec3683
  =

  ```
  =

  Guest aarch64 runs in privileged mode:
  =

  `docker run --privileged --device=3D/dev/video0:/dev/video0 --env
  DISPLAY=3Dunix$DISPLAY -v $XAUTH:/root/.Xauthority  -v
  /tmp/.X11-unix:/tmp/.X11-unix -it --rm arm64v8/ubuntu:20.04 bash`
  =

  **Additional information:**
  I tried also binfmt way to register emulators. The output of `v4l-ctl` wa=
s a little bit different:
  =

  ```
- # v4l2-ctl -l    =

+ # v4l2-ctl -l
  Unsupported ioctl: cmd=3D0xffffffff80685600
  Failed to open /dev/video0: Function not implemented
  =

  ```

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1900122

Title:
  Unsupported ioctl: cmd=3D0xffffffff80685600 when accessing /dev/video*
  in aarch64 guest

Status in QEMU:
  New

Bug description:
  **Description:**
  Any attempt to work with video in aarch64 architecture emulated on x86_64=
 leads currently to the error "Function not implemented". For example:

  ```
  # v4l2-ctl -l --verbose
  Failed to open /dev/video0: Function not implemented

  root@12dd9b6fcfcb:/# ll /dev/video*
  crw-rw---- 1 root video 81, 0 Oct 16 09:23 /dev/video0
  crw-rw---- 1 root video 81, 1 Oct 16 09:23 /dev/video1

  ```

  **Steps to reproduce the issue:**

  I have a following setup:

  Host Hardware: x86_64 equipped with a webcam (tried different webcams)
  Host OS: Ubuntu 20.04.1

  Guest Architecture: aarch64
  Guest OS: Ubuntu 20.04 (also tried 16.x and 18.x)

  Emulation: quemu-user-static (also tried binfmt)

  Guest OS is running via Docker + QEMU

  ```
  =E2=9E=9C cat /proc/sys/fs/binfmt_misc/qemu-aarch64
  enabled
  interpreter /usr/bin/qemu-aarch64-static
  flags: F
  offset 0
  magic 7f454c460201010000000000000000000200b700
  mask ffffffffffffff00fffffffffffffffffeffffff
  ```

  **Results received:**
  see desrciption.

  =

  **Environment:**

  * QEMU version: (if you can know it):

  ipxe-qemu-256k-compat-efi-roms/focal,now 1.0.0+git-20150424.a25a16d-0ubun=
tu4 all [installed,automatic]
  ipxe-qemu/focal-updates,now 1.0.0+git-20190109.133f4c4-0ubuntu3.2 all [in=
stalled,automatic]
  qemu-block-extra/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,auto=
matic]
  qemu-kvm/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed]
  qemu-system-common/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,au=
tomatic]
  qemu-system-data/focal-updates,now 1:4.2-3ubuntu6.7 all [installed,automa=
tic]
  qemu-system-gui/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,autom=
atic]
  qemu-system-x86/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,autom=
atic]
  qemu-user-binfmt/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,auto=
matic]
  qemu-user/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed]
  qemu-utils/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed,automatic]
  qemu/focal-updates,now 1:4.2-3ubuntu6.7 amd64 [installed]

  * Container application: Docker

  **Output of `docker version`, `podman version` or `singularity
  version`**

  ```
  =E2=9E=9C docker version
  Client: Docker Engine - Community
  =C2=A0Version:           20.10.0-beta1
  =C2=A0API version:       1.40
  =C2=A0Go version:        go1.13.15
  =C2=A0Git commit:        ac365d7
  =C2=A0Built:             Tue Oct 13 18:15:22 2020
  =C2=A0OS/Arch:           linux/amd64
  =C2=A0Context:           default
  =C2=A0Experimental:      true

  Server: Docker Engine - Community
  =C2=A0Engine:
  =C2=A0=C2=A0Version:          19.03.13
  =C2=A0=C2=A0API version:      1.40 (minimum version 1.12)
  =C2=A0=C2=A0Go version:       go1.13.15
  =C2=A0=C2=A0Git commit:       4484c46d9d
  =C2=A0=C2=A0Built:            Wed Sep 16 17:01:20 2020
  =C2=A0=C2=A0OS/Arch:          linux/amd64
  =C2=A0=C2=A0Experimental:     false
  =C2=A0containerd:
  =C2=A0=C2=A0Version:          1.4.1
  =C2=A0=C2=A0GitCommit:        c623d1b36f09f8ef6536a057bd658b3aa8632828
  =C2=A0runc:
  =C2=A0=C2=A0Version:          1.0.0-rc92
  =C2=A0=C2=A0GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
  =C2=A0docker-init:
  =C2=A0=C2=A0Version:          0.18.0
  =C2=A0=C2=A0GitCommit:        fec3683

  ```

  Guest aarch64 runs in privileged mode:

  `docker run --privileged --device=3D/dev/video0:/dev/video0 --env
  DISPLAY=3Dunix$DISPLAY -v $XAUTH:/root/.Xauthority  -v
  /tmp/.X11-unix:/tmp/.X11-unix -it --rm arm64v8/ubuntu:20.04 bash`

  **Additional information:**
  I tried also binfmt way to register emulators. The output of `v4l-ctl` wa=
s a little bit different:

  ```
  # v4l2-ctl -l
  Unsupported ioctl: cmd=3D0xffffffff80685600
  Failed to open /dev/video0: Function not implemented

  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1900122/+subscriptions

