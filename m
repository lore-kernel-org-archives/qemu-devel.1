Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6861C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC27E206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC27E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGLIh-0000VS-Vw
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 06:26:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGLHt-00008z-Fg
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGLHs-0003s9-EV
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:26:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:46276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGLHs-0003r6-5j
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:26:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGLHo-0006vo-G9
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:25:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DF92D2E81A0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:25:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 10:16:31 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange pmaydell sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Satheesh Rajendran (sathnaga)
References: <155507354518.20682.14175680260454866144.malonedeb@soybean.canonical.com>
Message-Id:
 <155540979138.21524.11685983736784473474.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 45149b261dfa7625baf8ef689b24045a2d58050e
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
Message-ID: <20190416101631.ZBpR-e_2DiSldH5sbNTRLyyJdaBKv9OBXWLRK5ERDp4@z>

Sure, Thanks, using the workaround to proceed.

Good if each commit goes through a automated build test across different
platforms vs gcc versions.

Regards,
-Satheesh.

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
  New

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

