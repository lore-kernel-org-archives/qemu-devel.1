Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F3FC43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80282084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80282084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKM6z-0000oO-A2
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKM34-000705-Rv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:40:06 -0400
Received: from relay64.bu.edu ([128.197.228.104]:43091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKM32-0004C0-So
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:40:06 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 08LDceaE028915
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Sep 2020 09:38:43 -0400
Date: Mon, 21 Sep 2020 09:38:40 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Issue 25514 in oss-fuzz: qemu: Coverage build failure
Message-ID: <20200921133840.sby75zn7unds2q3a@mozz.bu.edu>
References: <0=0a88cf92d34dc9db91727cc9bd0dc58b=d9ca53ad17e3d19752f355e6c3ba1ecc=oss-fuzz@monorail-prod.appspotmail.com>
 <0000000000003aa8d805afd00f24@google.com>
 <995b1aa7-8efc-57d2-a85e-5520fab0755b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995b1aa7-8efc-57d2-a85e-5520fab0755b@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 09:40:03
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200921 1410, Paolo Bonzini wrote:
> On 21/09/20 12:10, ClusterFuzz-External via monorail wrote:
> > 
> > Comment #2 on issue 25514 by ClusterFuzz-External: qemu: Coverage build
> > failure
> > https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=25514#c2
> > 
> > Friendly reminder that the the build is still failing.
> > Please try to fix this failure to ensure that fuzzing remains productive.
> > Latest build log:
> > https://oss-fuzz-build-logs.storage.googleapis.com/log-632125f2-e66b-4480-9504-c1097198069a.txt
> > 
> > -- 
> > You received this message because:
> > 1. You were specifically CC'd on the issue
> > 
> > You may adjust your notification preferences at:
> > https://bugs.chromium.org/hosting/settings
> > 
> > Reply to this email to add a comment.
> 
> It's now failing with:
> 
> Step #3: /usr/bin/ld: section .interp loaded at
> [00000000000002a8,00000000000002c3] overlaps section .data.fuzz_ordered
> loaded at [0000000000000000,000000000016ebff]
> 
> Do you know what's going on?  Also, should we make
> scripts/oss-fuzz/build.sh use "make V=1"?

Hi Paolo,
These are the builds with clang coverage enabled.
The normal fuzzing builds are succeeding now (log from this morning:
https://oss-fuzz-build-logs.storage.googleapis.com/log-a426424c-cae4-407a-ae7b-205a9ae59286.txt
)

I already send a patch that seems to fix the coverage build failure, but
I can't explain why it does the trick. 
Message-Id: <20200909220516.614222-1-alxndr@bu.edu>
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg03639.html

-Alex

> 
> Paolo
> 

