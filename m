Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F7920735
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F7920735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaS1Z-0005H5-L7
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 18:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaS0e-000472-RL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:16:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:41026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaS0c-0002Z7-Q8
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:16:08 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaS0Z-0001Ca-RN
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 23:16:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 33C792E813E
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 23:16:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 23:09:39 -0000
From: John Snow <1826200@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=berrange@redhat.com; 
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange jnsnow lersek
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <155610584995.13565.1262636932024040431.malonedeb@wampee.canonical.com>
Message-Id: <160453137912.18915.5426777679998496960.malone@wampee.canonical.com>
Subject: [Bug 1826200] Re: RFE: populate "OEM Strings" (type 11) SMBIOS table
 strings from regular files
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 61285ce3cfa313dd3dbbae788162cc8ebaf78e17
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 17:35:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1826200 <1826200@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merged:
https://patchew.org/QEMU/20200923133804.2089190-1-berrange@redhat.com/

Commits:

https://gitlab.com/qemu-project/qemu/-/commit/bb99f4772f54017490e3356ecbb3d=
f25c5d4537f
https://gitlab.com/qemu-project/qemu/-/commit/10c3666658f53c5ec8fd9ec27cdf5=
c393ff814a0
https://gitlab.com/qemu-project/qemu/-/commit/48a7ff4d516c92323ca7bd88df90e=
bb974bc0a9a

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826200

Title:
  RFE: populate "OEM Strings" (type 11) SMBIOS table strings from
  regular files

Status in QEMU:
  Fix Committed

Bug description:
  The feature added in

  https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D2d6dcbf93fb01b4a7f4=
5a93d276d4d74b16392dd

  and exposed by libvirt as

    https://libvirt.org/formatdomain.html#elementsSysinfo

  allows the user to specify up to 255 strings in the unofmatted area of
  the Type 11 SMBIOS table, where each string may be of arbitrary
  length. This feature is useful for exposing arbitrary text to
  arbitrary guest components (in particular when strings are prefixed
  with "application identifiers").

  Right now, strings can only be specified on the QEMU command line,
  which limits the amount of data that can be passed. Please enable
  users to pass data from regular files too.

  For example:

    $QEMU -smbios
  type=3D11,value=3DHello,txtfile=3Dfile1.txt,txtfile=3Dfile2.txt

  where "file1.txt" and "file2.txt" could be text files containing ASCII
  application prefixes, followed by base64-encoded binary data.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826200/+subscriptions

