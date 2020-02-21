Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E167FC35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EED24656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EED24656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j55I7-0003uT-Vp
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 05:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j55HU-00032Y-Es
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j55HT-00040e-4N
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:11:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:51464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j55HS-0003yo-Uw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:11:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j55HR-00076W-4l
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 10:11:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EDAFD2E80D4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 10:11:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Feb 2020 09:58:40 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crockabiscuit laurent-vivier
X-Launchpad-Bug-Reporter: crocket (crockabiscuit)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <157762661516.5433.16221584605990009162.malonedeb@gac.canonical.com>
Message-Id: <158227912075.29100.1280761767290852312.malone@chaenomeles.canonical.com>
Subject: [Bug 1857811] Re: qemu user static binary seems to lack support for
 network namespace.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7e216c995778f4285b0ebec796951bff0b288437
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1857811 <1857811@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, it's fixed in v4.2.0, and with the help of your test program I've
bisect to the fix:

commit 1645fb5a1e537f85eda744bfa6e9d3dda047ba28
Author: Shu-Chun Weng <scw@google.com>
Date:   Thu Oct 17 17:19:20 2019 -0700

    Fix unsigned integer underflow in fd-trans.c
    =

    In any of these `*_for_each_*` functions, the last entry in the buffer =
(so the
    "remaining length in the buffer" `len` is equal to the length of the
    entry `nlmsg_len`/`nla_len`/etc) has size that is not a multiple of the
    alignment, the aligned lengths `*_ALIGN(*_len)` will be greater than `l=
en`.
    Since `len` is unsigned (`size_t`), it underflows and the loop will read
    pass the buffer.
    =

    This may manifest as random EINVAL or EOPNOTSUPP error on IO or network
    system calls.
    =

    Signed-off-by: Shu-Chun Weng <scw@google.com>
    Reviewed-by: Laurent Vivier <laurent@vivier.eu>
    Message-Id: <20191018001920.178283-1-scw@google.com>
    Signed-off-by: Laurent Vivier <laurent@vivier.eu>


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857811

Title:
  qemu user static binary seems to lack support for network namespace.

Status in QEMU:
  Fix Released

Bug description:
  Whenever I execute emerge in gentoo linux in qemu-aarch64 chroot, I
  see the following error message.

  Unable to configure loopback interface: Operation not supported

  If I disable emerge's network-sandbox which utilizes network
  namespace, the error disappears.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857811/+subscriptions

