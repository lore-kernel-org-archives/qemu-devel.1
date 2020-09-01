Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517A9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B28206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B28206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3HA-0003a9-3f
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kD3GF-00022A-QB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:11:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:57440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kD3GD-00067Z-Qg
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:11:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kD3GC-0005g1-1w
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:11:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 014172E80ED
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 10:11:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2020 10:03:41 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1892540@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: sparc testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gson laurent-vivier mark-cave-ayland mst-0 philmd
X-Launchpad-Bug-Reporter: Andreas Gustafsson (gson)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159803735569.2614.10182276398047269277.malonedeb@chaenomeles.canonical.com>
 <20200822142127.1316231-1-f4bug@amsat.org>
 <24395.20047.450062.992384@guava.gson.org>
Message-ID: <5a7d94f9-eaec-c8f6-da4a-3ec0cfc68961@amsat.org>
Subject: [Bug 1892540] Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit
 accesses to framebuffer stippler and blitter
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: 12be59236fae8c10a7800f0a3cf181c2920cdf62
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 03:58:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1892540 <1892540@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200901100341.ivYHxuI_TzjYNRHEQr-Ty_jAe0dryyUI2S3bPaQQ0YY@z>

On 8/30/20 8:59 AM, Andreas Gustafsson wrote:
> Philippe Mathieu-Daud=C3=A9 wrote:
>> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
>> index 1fb45b1aab8..96c6898b149 100644
> =

> With this patch, the kernel boots successfully for me.

Thanks, can I add "Tested-by: Andreas Gustafsson <gson@gson.org>"
to the patch?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892540

Title:
  qemu can no longer boot NetBSD/sparc

Status in QEMU:
  New

Bug description:
  Booting NetBSD/sparc in qemu no longer works.  It broke between qemu
  version 5.0.0 and 5.1.0, and a bisection identified the following as
  the offending commit:

    [5d971f9e672507210e77d020d89e0e89165c8fc9] memory: Revert "memory:
  accept mismatching sizes in memory_region_access_valid"

  It's still broken as of 7fd51e68c34fcefdb4d6fd646ed3346f780f89f4.

  To reproduce, run

    wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-spar=
c.iso
    qemu-system-sparc -nographic -cdrom NetBSD-9.0-sparc.iso -boot d

  The expected behavior is that the guest boots to the prompt

    Installation medium to load the additional utilities from:

  The observed behavior is a panic:

    [   1.0000050] system[0]: trap 0x29: pc=3D0xf0046b14 sfsr=3D0xb6 sfva=
=3D0x54000000
    [   1.0000050] cpu0: data fault: pc=3D0xf0046b14 addr=3D0x54000000 sfsr=
=3D0xb6<PERR=3D0x0,LVL=3D0x0,AT=3D0x5,FT=3D0x5,FAV,OW>
    [   1.0000050] panic: kernel fault
    [   1.0000050] halted

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892540/+subscriptions

