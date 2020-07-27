Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5669CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7332070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7332070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k040k-0005iZ-DS
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k03zt-0004t0-FP
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:20:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:53096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k03zr-00088k-1T
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:20:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k03zo-0007um-5T
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:20:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 277AB2E80EE
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2020 14:11:32 -0000
From: Max Reitz <1888467@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: arrowfeng xanclic
X-Launchpad-Bug-Reporter: dunfeng zhang (arrowfeng)
X-Launchpad-Bug-Modifier: Max Reitz (xanclic)
References: <159540494097.10238.3390638369680947345.malonedeb@gac.canonical.com>
Message-Id: <159585909218.29426.3265733007008207026.malone@chaenomeles.canonical.com>
Subject: [Bug 1888467] Re: qemu-img http convert bug
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e85d0ab92e2924d39b8285aeae075a01d25eff06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d4d4e897d546cd0b7749ecda10e7480c6582b970
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 09:56:02
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
Reply-To: Bug 1888467 <1888467@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OK, that=E2=80=99s interesting. To be honest, I have no idea. I=E2=80=99ll =
keep this in
mind and I=E2=80=99ll try to play around with it, but I can=E2=80=99t promi=
se anything.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888467

Title:
  qemu-img http convert bug

Status in QEMU:
  New

Bug description:
  Hello, Why the file sizes of http conversion and local conversion are
  inconsistent?

  Use the http method of qemu-img for conversion. The size of some formats =
after conversion is different from the local method of qemu-img. Such as vh=
d, vdi. qcow2 and vmdk are normal=E3=80=82
  My image size is 40 G, raw format.

  The source is the same file, but the access method is different
  http method of qemu-img=EF=BC=9A qemu-img convert -f raw -O vdi http://xx=
x xxx.vdi=EF=BC=8819G=EF=BC=8Cafter conversion=EF=BC=89
  local method of qemu-img=EF=BC=9A qemu-img convert -f raw -O vdi xxx.raw =
xxx.vdi=EF=BC=883G=EF=BC=8Cafter conversion=EF=BC=89

  thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888467/+subscriptions

