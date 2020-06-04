Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166BFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF575207D8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF575207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgrI5-0005iG-57
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jgrHV-0005Bx-M7
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:55:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:38146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jgrHU-0004Tr-BT
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:55:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jgrHS-0000Bj-BZ
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 14:55:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4F2812E810B
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 14:55:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2020 14:47:22 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1852196@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lersek philmd
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <157355353271.7205.5763587027166419396.malonedeb@gac.canonical.com>
Message-Id: <159128204271.5039.13041302654142178974.launchpad@soybean.canonical.com>
Subject: [Bug 1852196] Re: update edk2 submodule & binaries to
 edk2-stable202005
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 96037b496c28fc0bc0b7e460a38c53b91eaccbdd
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 10:55:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

** Summary changed:

- update edk2 submodule & binaries to edk2-stable201911
+ update edk2 submodule & binaries to edk2-stable202005

** Description changed:

- edk2-stable201911 will be tagged soon:
+ edk2-stable202005 has been tagged:
  =

-   https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-Release-
+ =C2=A0=C2=A0https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-=
Release-
  Planning
  =

-   https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
-   [upcoming link]
- =

- It should be picked up by QEMU, after the v4.2.0 release.
+ =C2=A0=C2=A0https://github.com/tianocore/edk2/releases/tag/edk2-stable202=
005
  =

  Relevant fixes / features in edk2, since edk2-stable201905 (which is
  what QEMU bundles at the moment, from LP#1831477):
  =

  - enable UEFI HTTPS Boot in ArmVirtQemu* platforms
-   https://bugzilla.tianocore.org/show_bug.cgi?id=3D1009
-   (this is from edk2-stable201908)
+ =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D1009
+ =C2=A0=C2=A0(this is from edk2-stable201908)
  =

  - fix CVE-2019-14553 (Invalid server certificate accepted in HTTPS Boot)
-   https://bugzilla.tianocore.org/show_bug.cgi?id=3D960
+ =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D960
  =

  - consume OpenSSL-1.1.1d, for fixing CVE-2019-1543, CVE-2019-1552 and
-   CVE-2019-1563
-   https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226
+ =C2=A0=C2=A0CVE-2019-1563
+ =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852196

Title:
  update edk2 submodule & binaries to edk2-stable202005

Status in QEMU:
  In Progress

Bug description:
  edk2-stable202005 has been tagged:

  =C2=A0=C2=A0https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-
  Release-Planning

  =C2=A0=C2=A0https://github.com/tianocore/edk2/releases/tag/edk2-stable202=
005

  Relevant fixes / features in edk2, since edk2-stable201905 (which is
  what QEMU bundles at the moment, from LP#1831477):

  - enable UEFI HTTPS Boot in ArmVirtQemu* platforms
  =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D1009
  =C2=A0=C2=A0(this is from edk2-stable201908)

  - fix CVE-2019-14553 (Invalid server certificate accepted in HTTPS Boot)
  =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D960

  - consume OpenSSL-1.1.1d, for fixing CVE-2019-1543, CVE-2019-1552 and
  =C2=A0=C2=A0CVE-2019-1563
  =C2=A0=C2=A0https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1852196/+subscriptions

