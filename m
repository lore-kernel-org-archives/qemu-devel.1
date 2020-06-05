Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16014C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0592074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0592074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFGC-0005Ho-3q
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhFFC-000466-Fo
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:30:58 -0400
Received: from relay68.bu.edu ([128.197.228.73]:57146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhFFB-0005Zp-B2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:30:57 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 055GU0Ch024572
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 5 Jun 2020 12:30:10 -0400
Date: Fri, 5 Jun 2020 12:30:00 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Reviewing QEMU OSS-Fuzz Integration PR
Message-ID: <20200605163000.zj6t3inhvbbrypxa@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 12:30:55
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
I submitted a Github PR to integrate QEMU into OSS-Fuzz. This is made
up of a Dockerfile and a build-script that builds all of the
virtual-device fuzzers and copies them to an output directory, along
with the dynamic-library and pc-bios images that they depend on.

Since this is maintained outside the qemu.git repo, and these changes
didn't go through the mailing list, can anyone provide feedback on this
PR?

https://github.com/google/oss-fuzz/pull/3935

Let me know if I can provide more details about the OSS-Fuzz Build
system.

These details are copied from an older email:
On oss-fuzz, the build and execution happens in two separate containers.

1.) In the build container, we can do whatever we want, but we must
place the executable(s) we produce at the root of a directory /out/.
e.g. one output executable is /out/qemu-system-target-i440fx-fuzz

2.) In the runner, this "build artifact" directory is mounted at
some location(we can't assume the location). This runner container
automatically identifies the executable within the root of the  "build
artifact" dir and runs it. The path to the executable could now be
/somedir/qemu-system-target-i440fx-fuzz

In the runner container we only have control over the files in /somedir/
(which was /out/ in the builder). Thus, in addition to copying over
shared-libs to /out/ we need to copy any data (pc-bios) that the binary
relies on. The problem is that we have to point qemu towards the
location of the bios. Normally qemu checks the /usr/share/... dir. For
local builds, qemu also examines the executable path and looks in
$executable_path/../pc-bios/. On the oss-fuzz runner we dont control
/somedir/../pc-bios, so we can't rely on this. This patch allows us to
specify /somedir/pc-bios as the datadir.

Thank you
-Alex

