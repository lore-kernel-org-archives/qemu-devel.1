Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2BBC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 20:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80839206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 20:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80839206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijUkP-0005lY-LD
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 15:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ijUjq-0005Jm-4D
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 15:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ijUjo-0007a7-S3
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 15:55:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:47770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ijUjo-0007Yk-MH
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 15:55:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ijUjn-00074B-3t
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 20:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0645B2E80C0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 20:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2019 20:45:54 -0000
From: John Snow <1808928@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Tags: bitmaps block dirt qcow2
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: catborise jnsnow
X-Launchpad-Bug-Reporter: Ali Sag (catborise)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <154511858636.8591.3431958243733477284.malonedeb@gac.canonical.com>
Message-Id: <157713395504.27144.6964390047628970306.malone@chaenomeles.canonical.com>
Subject: [Bug 1808928] Re: Bitmap Extra data is not supported
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e833cf832a707161ea6009415344746614badf91
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
Reply-To: Bug 1808928 <1808928@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now, QEMU cannot accept images with extra bitmap data, because QEMU
isn't aware of the semantics of those fields, so we cannot even allow
the image to load, just in case.

However, we SHOULD allow qemu-img check --repair to detect such bitmaps
as corruption so that images can be scrubbed and recovered. I will add
that to my TODO list.

Meanwhile, I believe the root cause of your problem here is a data
corruption event, but it's hard to tell exactly what it might be because
of the extra_data flag ... I can try to have some patches ready for you
in January that try to "ignore" the data and analyze the rest of the
image as best as possible, which might help us see what else went wrong.

** Changed in: qemu
     Assignee: (unassigned) =3D> John Snow (jnsnow)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1808928

Title:
  Bitmap Extra data is not supported

Status in QEMU:
  New

Bug description:
  i am using dirty bitmaps and drive-backup. It works as aspected.

  Lately, i encounter a disastrous error. There is not any information
  about that situation. I cannot reach/open/attach/info or anything with
  a qcow2 file.

  virsh version
  Compiled against library: libvirt 4.10.0
  Using library: libvirt 4.10.0
  Using API: QEMU 4.10.0
  Running hypervisor: QEMU 2.12.0

  "qemu-img: Could not open '/var/lib/libvirt/images/test.qcow2': Bitmap
  extra data is not supported"

  what is that mean? what should i do?
  i cannot remove bitmap. i cannot open image or query.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1808928/+subscriptions

