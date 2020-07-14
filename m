Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C8020773
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C8020773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCXD-00070u-5R
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvCWW-0006Yr-FE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:26:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:39466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvCWS-00007h-T0
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:26:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jvCWP-0001ns-3l
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:26:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 861482E8211
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:26:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2020 04:17:18 -0000
From: Launchpad Bug Tracker <1686980@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange janitor rjones-redhat th-huth
X-Launchpad-Bug-Reporter: Richard Jones (rjones-redhat)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20170428101422.23122.24568.malonedeb@wampee.canonical.com>
Message-Id: <159470023906.29739.8832618186375049111.malone@loganberry.canonical.com>
Subject: [Bug 1686980] Re: qemu is very slow when adding 16,
 384 virtio-scsi drives
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ec4d34079bad28f89b0a01578f4d9718051563fc
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 00:26:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1686980 <1686980@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686980

Title:
  qemu is very slow when adding 16,384 virtio-scsi drives

Status in QEMU:
  Expired

Bug description:
  qemu runs very slowly when adding many virtio-scsi drives.  I have
  attached a small reproducer shell script which demonstrates this.

  Using perf shows the following stack trace taking all the time:

      72.42%    71.15%  qemu-system-x86  qemu-system-x86_64       [.] drive=
_get
              |          =

               --72.32%--drive_get
                         |          =

                          --1.24%--__irqentry_text_start
                                    |          =

                                     --1.22%--smp_apic_timer_interrupt
                                               |          =

                                                --1.00%--local_apic_timer_i=
nterrupt
                                                          |          =

                                                           --1.00%--hrtimer=
_interrupt
                                                                     |     =
     =

                                                                      --0.8=
3%--__hrtimer_run_queues
                                                                           =
     |          =

                                                                           =
      --0.64%--tick_sched_timer

      21.70%    21.34%  qemu-system-x86  qemu-system-x86_64       [.] blk_l=
egacy_dinfo
              |
              ---blk_legacy_dinfo

       3.65%     3.59%  qemu-system-x86  qemu-system-x86_64       [.] blk_n=
ext
              |
              ---blk_next

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686980/+subscriptions

