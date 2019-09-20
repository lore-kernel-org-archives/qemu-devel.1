Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CD2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E03C208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E03C208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLaC-0002mF-Fz
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iBLFz-0007er-Ss
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iBLFy-0007s7-1t
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:36886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iBLFx-0007rp-I4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:55:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iBLFw-0002Or-OD
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:55:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B0A322E80CB
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:55:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Sep 2019 15:48:16 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1844817@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: trace
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <156899449679.4991.3377250373042418918.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1844817] [NEW] trace: dynamic width format syntax not validated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 096545b6d416ad4d740516e58d7f05f5222ddfb2
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
Reply-To: Bug 1844817 <1844817@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The dtrace via stap backend cannot support the dynamic '*' width format.

Eric noted in https://lists.gnu.org/archive/html/qemu-
devel/2019-09/msg04720.html:

  https://sourceware.org/systemtap/langref.pdf

  section 9.2 printf, states:

  "The printf formatting directives are similar to those of C, except that
  they are fully checked for type by the translator."

  and does NOT list handling for '*' under precision or width.

Some trace events have been merged without checking this:

$ git ls-files|fgrep trace-event|xargs git grep '*\("\|x\)'
hw/block/trace-events:11:pflash_io_read(uint64_t offset, int width, int fmt=
_width, uint32_t value, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" =
width:%d value:0x%0*x cmd:0x%02x wcycle:%u"
hw/block/trace-events:12:pflash_io_write(uint64_t offset, int width, int fm=
t_width, uint32_t value, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d val=
ue:0x%0*x wcycle:%u"
hw/block/trace-events:13:pflash_data_read(uint64_t offset, int width, uint3=
2_t value) "data offset:0x%04"PRIx64" value:0x%0*x"
hw/block/trace-events:14:pflash_data_write(uint64_t offset, int width, uint=
32_t value, uint64_t counter) "data offset:0x%04"PRIx64" value:0x%0*x count=
er:0x%016"PRIx64
hw/mips/trace-events:2:gt64120_read(const char *regname, int width, uint64_=
t value) "gt64120 read %s value:0x%0*" PRIx64
hw/mips/trace-events:3:gt64120_write(const char *regname, int width, uint64=
_t value) "gt64120 write %s value:0x%0*" PRIx64

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: trace

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844817

Title:
  trace: dynamic width format syntax not validated

Status in QEMU:
  New

Bug description:
  The dtrace via stap backend cannot support the dynamic '*' width
  format.

  Eric noted in https://lists.gnu.org/archive/html/qemu-
  devel/2019-09/msg04720.html:

    https://sourceware.org/systemtap/langref.pdf

    section 9.2 printf, states:

    "The printf formatting directives are similar to those of C, except that
    they are fully checked for type by the translator."

    and does NOT list handling for '*' under precision or width.

  Some trace events have been merged without checking this:

  $ git ls-files|fgrep trace-event|xargs git grep '*\("\|x\)'
  hw/block/trace-events:11:pflash_io_read(uint64_t offset, int width, int f=
mt_width, uint32_t value, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64=
" width:%d value:0x%0*x cmd:0x%02x wcycle:%u"
  hw/block/trace-events:12:pflash_io_write(uint64_t offset, int width, int =
fmt_width, uint32_t value, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d v=
alue:0x%0*x wcycle:%u"
  hw/block/trace-events:13:pflash_data_read(uint64_t offset, int width, uin=
t32_t value) "data offset:0x%04"PRIx64" value:0x%0*x"
  hw/block/trace-events:14:pflash_data_write(uint64_t offset, int width, ui=
nt32_t value, uint64_t counter) "data offset:0x%04"PRIx64" value:0x%0*x cou=
nter:0x%016"PRIx64
  hw/mips/trace-events:2:gt64120_read(const char *regname, int width, uint6=
4_t value) "gt64120 read %s value:0x%0*" PRIx64
  hw/mips/trace-events:3:gt64120_write(const char *regname, int width, uint=
64_t value) "gt64120 write %s value:0x%0*" PRIx64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844817/+subscriptions

