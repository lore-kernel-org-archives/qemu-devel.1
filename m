Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C507C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4029206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4029206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikCy-0000Sf-32
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jikBo-0008NR-Ib
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 15:45:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:47896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jikBn-0000ha-6g
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 15:45:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jikBl-0002KG-86
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 19:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 275162E810A
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 19:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2020 19:37:54 -0000
From: Thomas Huth <1882784@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=High;
 assignee=th.huth@posteo.de; 
X-Launchpad-Bug-Tags: assign igd quirk
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sshaikh th-huth thecatfelix
X-Launchpad-Bug-Reporter: Shak (sshaikh)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <159171166832.31735.6432186230204851906.malonedeb@gac.canonical.com>
Message-Id: <159173147557.4871.7214609551046522656.launchpad@soybean.canonical.com>
Subject: [Bug 1882784] Re: Legacy IGD passthrough in QEMU 5 disabled
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 68f2da0b3d63d7880a87eba83f3cc34720d5c1b3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:15:37
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
Reply-To: Bug 1882784 <1882784@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
   Importance: Undecided =3D> High

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
     Assignee: (unassigned) =3D> Thomas Huth (th-huth)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882784

Title:
  Legacy IGD passthrough in QEMU 5 disabled

Status in QEMU:
  Confirmed

Bug description:
  Bug with tag v5.0.0, or commit
  fdd76fecdde1ad444ff4deb7f1c4f7e4a1ef97d6

  As of QEMU 5 Legacy IGD PT is no longer working.

  Host is a Xeon E3-1226 v3 and my method to test is to run the
  following:

  ./qemu-system-x86_64 \
    -device 'pci-bridge,id=3Dpci.1,chassis_nr=3D1,bus=3Dpci.0,addr=3D0x1f' \
    -device 'vfio-pci,host=3D00:02.0,addr=3D02.0' \
    -L '/usr/share/kvm' \
    -nographic \
    -vga none \
    -nodefaults

  in the hope of seeing a "IGD device 0000:00:02.0 cannot support legacy
  mode due to existing devices at address 1f.0" error.

  The culprit appears to be this commit:

  https://github.com/qemu/qemu/commit/29d62771c81d8fd244a67c14a1d968c268d3f=
b19

  Specifically the following block in pci-quirks.c:

  #ifdef CONFIG_VFIO_IGD
      vfio_probe_igd_bar4_quirk(vdev, nr);
  #endif

  as the kconfig variable CONFIG_VFIO_IGD doesn't appear to be available
  outside of makefiles as described here:
  https://qemu.weilnetz.de/doc/devel/kconfig.html. I can confirm that
  the igd code is being pulled in as removing this check, as would
  defining the variable I presume, makes Legacy IGD PT work again (ie I
  see the expected "existing devices" error).

  I first spotted this in Proxmox, but have confirmed the bug by
  building QEMU sources.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882784/+subscriptions

