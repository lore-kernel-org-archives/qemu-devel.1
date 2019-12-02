Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D91C43215
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CEC20833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CEC20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmQN-0008G6-GZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ibmPW-0007mS-LM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ibmPV-0000VK-Ds
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:10:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:40000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ibmPV-0000V6-8D
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:10:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ibmPT-0002aC-SH
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 14:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D01892E8075
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 14:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Dec 2019 14:00:31 -0000
From: Yonggang Luo <1854738@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: luoyonggang
X-Launchpad-Bug-Reporter: Yonggang Luo (luoyonggang)
X-Launchpad-Bug-Modifier: Yonggang Luo (luoyonggang)
Message-Id: <157529523112.6529.3237994494675580627.malonedeb@gac.canonical.com>
Subject: [Bug 1854738] [NEW] ppc doesn't support for mttcg but ppc64 supported
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: dd2ba8098d1ddc50f58afff3ed7b0277f6aead8f
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
Reply-To: Bug 1854738 <1854738@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Currently ppc and ppc64abi32 doesn't suppport for mttcg, I am looking for s=
upport
```
  ppc)
    gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml power-s=
pe.xml"
  ;;
  ppc64)
    TARGET_BASE_ARCH=3Dppc
    TARGET_ABI_DIR=3Dppc
    mttcg=3Dyes
    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml power-vsx.xml"
  ;;
  ppc64le)
    TARGET_ARCH=3Dppc64
    TARGET_BASE_ARCH=3Dppc
    TARGET_ABI_DIR=3Dppc
    mttcg=3Dyes
    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml power-vsx.xml"
  ;;
  ppc64abi32)
    TARGET_ARCH=3Dppc64
    TARGET_BASE_ARCH=3Dppc
    TARGET_ABI_DIR=3Dppc
    echo "TARGET_ABI32=3Dy" >> $config_target_mak
    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml power-vsx.xml"
  ;;
```

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1854738

Title:
  ppc doesn't support for mttcg  but ppc64 supported

Status in QEMU:
  New

Bug description:
  Currently ppc and ppc64abi32 doesn't suppport for mttcg, I am looking for=
 support
  ```
    ppc)
      gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml"
    ;;
    ppc64)
      TARGET_BASE_ARCH=3Dppc
      TARGET_ABI_DIR=3Dppc
      mttcg=3Dyes
      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml"
    ;;
    ppc64le)
      TARGET_ARCH=3Dppc64
      TARGET_BASE_ARCH=3Dppc
      TARGET_ABI_DIR=3Dppc
      mttcg=3Dyes
      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml"
    ;;
    ppc64abi32)
      TARGET_ARCH=3Dppc64
      TARGET_BASE_ARCH=3Dppc
      TARGET_ABI_DIR=3Dppc
      echo "TARGET_ABI32=3Dy" >> $config_target_mak
      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml"
    ;;
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1854738/+subscriptions

