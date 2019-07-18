Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A190C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B532080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B532080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho7uM-0007ck-9f
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38990)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1ho7u9-0007AP-OX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ho7u8-0007qT-E9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:01:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:33138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ho7u8-0007pd-7t
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:01:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ho7u6-0000DW-25
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 15:01:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0D9012E8055
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 15:01:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jul 2019 14:48:18 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: manuelbaesler pmaydell
X-Launchpad-Bug-Reporter: manuel baesler (manuelbaesler)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156021221413.18114.3680605096232908394.malonedeb@wampee.canonical.com>
Message-Id: <156346129905.30054.2507538249767339654.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 68cdad4657b628475d70ae0e0e7af6ac55257b56
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1832281] Re: tcg bug master / 4.0.0 v8 operation
 >>> and |=
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
Reply-To: Bug 1832281 <1832281@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This might be the same underlying problem as LP:1815423 which also
mentions some issues with Javascript calculations involving arithmetic
operations on a js "undefined" value. That bug has a C-only reproduce
case so is probably a good place to start for anybody interesting in
investigating and fixing it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832281

Title:
  tcg bug master / 4.0.0 v8 operation >>> and |=3D

Status in QEMU:
  New

Bug description:
  vm guest is linux, executed with tcg
  running this Node.js snippet leads to

  $ node
  > a =3D undefined
  undefined
  > a >>> 0
  4294967295

  host node
  $ node
  > a =3D undefined
  undefined
  > a >>> 0
  0

  same with |=3D

  node
  Welcome to Node.js v12.4.0.
  Type ".help" for more information.
  > let buffer
  undefined
  > buffer |=3D 0
  0

  vm with tcg:

  $ ./out/Release/node --version
  v12.4.0
  ./out/Release/node -e "let buffer; buffer |=3D 0; console.log(buffer);"
  -1

  vm guest is debian x86_64 latest release
  vm guest is started with ./x86_64-softmmu/qemu-system-x86_64 -vnc :0 -cdr=
om debian-9.9.0-amd64-netinst.iso -m 4G -smp cores=3D6,threads=3D1,sockets=
=3D1 -nic user,hostfwd=3Dtcp:ipv4addr:2233-:22 -cpu qemu64 debian.img

  git tag v4.0.0 and master, commit
  a578cdfbdd8f9beff5ced52b7826ddb1669abbbf, for building qemu-system-
  x86_64 was used.

  Node.js is compiled on the vm guest (v12.4.0 / master)

  see also
  https://github.com/nodejs/node/issues/19348#issuecomment-500465502

  I need further assistance to track down the cause of the bug.

  Kind regards
  Manuel

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1832281/+subscriptions

