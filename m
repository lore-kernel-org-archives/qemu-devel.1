Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA91C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8C8218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8C8218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFPe-0004Jw-L5
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:46:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJFLS-000114-98
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJFLQ-0000yP-TU
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:41:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:35516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJFLQ-0000xp-Nd
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:41:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJFLP-0006MA-IE
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:41:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 88ECF2E800F
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:41:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 10:33:12 -0000
From: yuchenlin <1809304@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: dmg qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jcfaracco npes87184 th-huth
X-Launchpad-Bug-Reporter: Julio Faracco (jcfaracco)
X-Launchpad-Bug-Modifier: yuchenlin (npes87184)
References: <154533506483.19401.8849680441407310900.malonedeb@soybean.canonical.com>
Message-Id:
 <155610199227.17469.5809680321766083140.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e85bef1378693c2c47c4cc729ac5a9e9638ba880
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1809304] Re: qemu-img convert is freezing for
 some DMG files.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1809304 <1809304@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424103312.lDyxt40riL7W5AG6jReE7Z_hCRavCclTL9T2Q1mpGYs@z>

I re-test the dmg img with QEMU 4.0 again, and it works.

In my opinion, the bug can be closed as "Fix released".

Thanks.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809304

Title:
  qemu-img convert is freezing for some DMG files.

Status in QEMU:
  Fix Committed

Bug description:
  Recently, I created a file using hdiutil from MacOS (using Zlib
  compression):

  $ hdiutil create -volname MyVolName -srcfolder /path/to/my/vol/ -ov
  -format UDZO myvolname.dmg

  But, when I try to convert this volume using qemu-img convert, this
  command is freezing.

  I'm using the upstream version to test it.

  It is freezing inside the binary search method to retrieve the chunk.

  But, I still don't know why.

  I'm attaching the file as an example.

  It can be mounted using MacOS or other Linux apps like hfsleuth and
  darling-dmg.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809304/+subscriptions

