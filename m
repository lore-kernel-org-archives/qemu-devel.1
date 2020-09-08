Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF442177B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF442177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYUh-0003sc-RS
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFYU2-00039j-BS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:56:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:44938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFYU0-0006sB-3y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:56:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kFYTw-0007wr-PT
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:56:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 074F82E810B
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:56:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2020 07:47:23 -0000
From: "Laszlo Ersek \(Red Hat\)" <1852196@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=lersek@redhat.com; 
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lersek philmd
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
References: <157355353271.7205.5763587027166419396.malonedeb@gac.canonical.com>
Message-Id: <159955124335.11462.2457354770405854578.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1852196] Re: update edk2 submodule & binaries to
 edk2-stable202008
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: ef0f7ee29f9df26893a592e3bbcd8c068864f5a3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:20:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1852196 <1852196@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

- edk2-stable202005 has been tagged:
+ Consume the following upstream edk2 releases:
  =

- =C2=A0=C2=A0https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-=
Release-
- Planning
+ https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
+ https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
+ https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
+ https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
+ https://github.com/tianocore/edk2/releases/tag/edk2-stable202008
  =

- =C2=A0=C2=A0https://github.com/tianocore/edk2/releases/tag/edk2-stable202=
005
+ Worth mentioning (in random order):
  =

- Relevant fixes / features in edk2, since edk2-stable201905 (which is
- what QEMU bundles at the moment, from LP#1831477):
+ - various CVE fixes [*]
+ - OpenSSL-1.1.1g
+ - UEFI HTTPS Boot for ARM/AARCH64
+ - TPM2 for ARM/AARCH64
+ - VCPU hotplug with SMI
+ - support for Linux v5.7+ initrd and mixed mode loading
+ - Fusion-MPT SCSI driver in OVMF
+ - VMware PVSCSI driver in OVMF
+ - PXEv4 / PXEv6 boot possible to disable on the QEMU command line
+ - SEV-ES support
  =

- - enable UEFI HTTPS Boot in ArmVirtQemu* platforms
- =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D1009
- =C2=A0=C2=A0(this is from edk2-stable201908)
+ [*] the below list has been collected simply from the subject lines in
+ commit range edk2-stable201905..edk2-stable202008:
  =

- - fix CVE-2019-14553 (Invalid server certificate accepted in HTTPS Boot)
- =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D960
+   CVE-2019-11098 CVE-2019-14553 CVE-2019-14558 CVE-2019-14559
+   CVE-2019-14562 CVE-2019-14563 CVE-2019-14575 CVE-2019-14586
+   CVE-2019-14587
  =

- - consume OpenSSL-1.1.1d, for fixing CVE-2019-1543, CVE-2019-1552 and
- =C2=A0=C2=A0CVE-2019-1563
- =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226
+ (Note that any given CVE from the above list may or may not affect the
+ firmware binaries packaged with upstream QEMU; consult the upstream
+ TianoCore bug tracker at <https://bugzilla.tianocore.org/> for details.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852196

Title:
  update edk2 submodule & binaries to edk2-stable202008

Status in QEMU:
  In Progress

Bug description:
  Consume the following upstream edk2 releases:

  https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
  https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202008

  Worth mentioning (in random order):

  - various CVE fixes [*]
  - OpenSSL-1.1.1g
  - UEFI HTTPS Boot for ARM/AARCH64
  - TPM2 for ARM/AARCH64
  - VCPU hotplug with SMI
  - support for Linux v5.7+ initrd and mixed mode loading
  - Fusion-MPT SCSI driver in OVMF
  - VMware PVSCSI driver in OVMF
  - PXEv4 / PXEv6 boot possible to disable on the QEMU command line
  - SEV-ES support

  [*] the below list has been collected simply from the subject lines in
  commit range edk2-stable201905..edk2-stable202008:

    CVE-2019-11098 CVE-2019-14553 CVE-2019-14558 CVE-2019-14559
    CVE-2019-14562 CVE-2019-14563 CVE-2019-14575 CVE-2019-14586
    CVE-2019-14587

  (Note that any given CVE from the above list may or may not affect the
  firmware binaries packaged with upstream QEMU; consult the upstream
  TianoCore bug tracker at <https://bugzilla.tianocore.org/> for details.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1852196/+subscriptions

