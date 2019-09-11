Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F25AC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DDE20863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DDE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83ME-00024z-MF
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i83Kh-0000kO-DV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i83Kf-0004Hz-NS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:50314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i83Ke-0004H6-Nv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i83Kd-0005SJ-LG
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:10:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9FB6A2E802E
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:10:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2019 13:55:48 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1843590@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: block nbd
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156821007592.6835.16511682649180201953.malonedeb@soybean.canonical.com>
Message-Id: <156821014864.17538.17783471498050166171.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 94043000bc302ce05183a28b20eb0f2155cad61b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843590] Re: NBD tests use hardcoded port 10810
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
Reply-To: Bug 1843590 <1843590@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Could be due to concurrent builds on the same system:

$ git grep 10810 tests
tests/qemu-iotests/common.filter:125:        -e 's#nbd:127.0.0.1:10810#TEST=
_DIR/t.IMGFMT#g' \
tests/qemu-iotests/common.filter:161:        -e 's#nbd://127.0.0.1:10810$#T=
EST_DIR/t.IMGFMT#g' \
tests/qemu-iotests/common.rc:140:        TEST_IMG=3D"$DRIVER,file.driver=3D=
nbd,file.host=3D127.0.0.1,file.port=3D10810"
tests/qemu-iotests/common.rc:156:        TEST_IMG=3D"nbd:127.0.0.1:10810"
tests/qemu-iotests/common.rc:276:        eval "$QEMU_NBD -v -t -b 127.0.0.1=
 -p 10810 -f $IMGFMT -e 42 -x '' $TEST_IMG_FILE >/dev/null &"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843590

Title:
  NBD tests  use hardcoded port 10810

Status in QEMU:
  New

Bug description:
  QEMU v3.1.0

  $ ./configure --block-drv-rw-
  whitelist=3Dqcow2,raw,file,host_device,nbd,iscsi,rbd,blkdebug,luks,null-
  co,nvme,copy-on-read,throttle,vxhs,gluster [...]

  $ ./check -v -nbd 001 002 003 004 005 008 009 010 011 021 032 033 045 077=
 094 104 119 123 132 143 145 147 151 152 162 181 184 194 205 208 218 222
  [...]
  104         - output mismatch (see 104.out.bad)
  --- tests/qemu-iotests/104.out	2018-12-11 17:44:35.000000000 +0000
  +++ tests/qemu-iotests/104.out.bad	2019-09-11 11:59:11.822058653 +0000
  @@ -6,7 +6,7 @@
   file format: IMGFMT
   virtual size: 1.0K (1024 bytes)
   Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1234
  -image: TEST_DIR/t.IMGFMT
  -file format: IMGFMT
  -virtual size: 1.5K (1536 bytes)
  +Failed to find an available port: Address already in use
  +qemu-img: Could not open 'nbd:127.0.0.1:10810': Failed to connect socket=
: Connection refused
  +./common.rc: line 203: kill: (28391) - No such process
   ***done
  Failed 1 of 32 tests

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843590/+subscriptions

