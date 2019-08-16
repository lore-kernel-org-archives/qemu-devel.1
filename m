Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4ECC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017FE206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017FE206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUml-0000gH-8E
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUk9-0006wF-4J
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUk7-0004UN-TV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:25:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:54326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUk7-0004Tn-OG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:25:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUk7-0004xi-1i
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:25:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0737E2E80C8
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:25:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 05:16:52 -0000
From: Thomas Huth <1824528@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: compilation gcc9
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange pmaydell sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155507354518.20682.14175680260454866144.malonedeb@soybean.canonical.com>
Message-Id: <156593261314.16226.7097224540318480975.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: c3c02c1b0631c54db76310361fa656731175c96b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1824528=5D_Re=3A_qemu_fails_to_comp?=
 =?utf-8?q?ile_on_gcc_9_=60error=3A_taking_address_of_packed_member_of_?=
 =?utf-8?q?=E2=80=98struct_=3Canonymous=3E=E2=80=99_may_result_in_an_unali?=
 =?utf-8?q?gned_pointer_value_=5B-Werror=3Daddress-of-packed-member=5D=60?=
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
Reply-To: Bug 1824528 <1824528@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824528

Title:
  qemu fails to compile on gcc 9 `error: taking address of packed member
  of =E2=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointe=
r value
  [-Werror=3Daddress-of-packed-member]`

Status in QEMU:
  Fix Released

Bug description:
  Qemu compilation fails with below error on ppc64le host with gcc 9(9.0.1 =
20190328)
  repo: https://github.com/qemu/qemu.git
  branch: master
  commit e1be98540ee672ef93292b65a986055512237c35

  =

    CC      net/dump.o
  hw/usb/dev-mtp.c: In function =E2=80=98usb_mtp_write_metadata=E2=80=99:
  hw/usb/dev-mtp.c:1708:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer value =
[-Werror=3Daddress-of-packed-member]
   1708 |                             dataset->filename);
        |                             ~~~~~~~^~~~~~~~~~
  cc1: all warnings being treated as errors
    CC      net/eth.o
  make: *** [/home/kvmci/qemu-main/rules.mak:69: hw/usb/dev-mtp.o] Error 1
  make: *** Waiting for unfinished jobs....
    CC      net/announce.o

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824528/+subscriptions

