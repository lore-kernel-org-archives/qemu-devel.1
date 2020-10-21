Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,RCVD_DOTEDU_SUSP,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18ECC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2CD22248
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2CD22248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVEjm-0005vm-H1
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVEih-0005FE-4h
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:04:03 -0400
Received: from relay64.bu.edu ([128.197.228.104]:34438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVEie-0000SS-PF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:04:02 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 09LE2k0F006585
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 21 Oct 2020 10:02:50 -0400
Date: Wed, 21 Oct 2020 10:02:46 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [Fwd] Issue 26558 in oss-fuzz: qemu: Fuzzing build failure
Message-ID: <20201021140246.jaukysfzbyjinurm@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:03:58
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.454, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: darren.kenny@oracle.com, bsd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

oops.. looks like we need to install ninja on the oss-fuzz build docker.
I'll send a PR to oss-fuzz.

-Alex

----- Forwarded message from ClusterFuzz-External via monorail <monorail+v2.382749006@chromium.org> -----

Date: Wed, 21 Oct 2020 03:16:20 -0700
From: ClusterFuzz-External via monorail <monorail+v2.382749006@chromium.org>
To: alxndr@bu.edu
Subject: Issue 26558 in oss-fuzz: qemu: Fuzzing build failure

Status: New
Owner: ----
CC: b...@redhat.com, stefa...@redhat.com, alx...@bu.edu, pbonz...@redhat.com, darre...@oracle.com 
Labels: Proj-qemu
Type: Build-Failure

New issue 26558 by ClusterFuzz-External: qemu: Fuzzing build failure
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=26558

The last 2 builds for qemu have been failing.
Build log: https://oss-fuzz-build-logs.storage.googleapis.com/log-fd076577-292c-45f5-8c56-b5993850d2bb.txt
Build type: fuzzing

To reproduce locally, please see: https://google.github.io/oss-fuzz/advanced-topics/reproducing#reproducing-build-failures

This bug tracker is not being monitored by OSS-Fuzz team. If you have any questions, please create an issue at https://github.com/google/oss-fuzz/issues/new.

**This bug will be automatically closed within a day once it is fixed.**

-- 
You received this message because:
  1. You were specifically CC'd on the issue

You may adjust your notification preferences at:
https://bugs.chromium.org/hosting/settings

Reply to this email to add a comment.

----- End forwarded message -----

