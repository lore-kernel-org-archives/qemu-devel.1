Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8631C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87624206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87624206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNKJ-00070p-99
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:36:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGNJQ-0006gZ-Kq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGNJP-0003My-Ku
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:35:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:43482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGNJP-0003ME-Dt
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:35:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGNJN-00050W-WC
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:35:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EAE572E80CB
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:35:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 12:28:50 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: compilation gcc9
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange pmaydell sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Satheesh Rajendran (sathnaga)
References: <155507354518.20682.14175680260454866144.malonedeb@soybean.canonical.com>
Message-Id:
 <155541773082.21149.6658994690792683342.launchpad@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b0e32d2ea60309ac63ede3eb80ab97be594e29cb
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
Message-ID: <20190416122850.zv7ft2pjgFlbKCPUwhpQDncidlJMV27x_1D9q6N82xU@z>

** Tags added: compilation gcc9

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

