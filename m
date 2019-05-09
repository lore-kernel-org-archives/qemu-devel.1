Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16662C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEA121019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEA121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmBq-0000rS-5t
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:46:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOmAr-0000FV-1j
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOmAp-0003V7-Vm
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:45:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:57958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hOmAp-0003Uu-Pw
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:45:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hOmAp-0007VG-42
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 16:45:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1ABAE2E800F
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 16:45:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 May 2019 16:35:47 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: compilation gcc9
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange pmaydell sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155507354518.20682.14175680260454866144.malonedeb@soybean.canonical.com>
Message-Id: <155741974716.32166.530786529094036840.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18961";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: a024e4317f178017f9449e1cb414e66e01785708
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1824528=5D_Re=3A_qemu_fails_to_comp?=
 =?utf-8?q?ile_on_gcc_9_=60error=3A_taking_address_of_packed_member_of_?=
 =?utf-8?q?=E2=80=98struct_=3Canonymous=3E=E2=80=99_may_result_in_an_unali?=
 =?utf-8?q?gned_pointer_value_=5B-Werror=3Daddress-of-packed-member=5D=60?=
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
Reply-To: Bug 1824528 <1824528@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fixes for this issue in dev-mtp.c are now in QEMU git master and
will be in the 4.1 release.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

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
  Fix Committed

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

