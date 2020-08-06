Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F092310D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F092310D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hui-0006OM-4C
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3htn-0005aQ-Q2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:33:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3htk-0003se-VZ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:33:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6E174AC7C;
 Thu,  6 Aug 2020 15:33:56 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC] checkpatch: detect missing changes to trace-events
Date: Thu,  6 Aug 2020 17:33:31 +0200
Message-Id: <20200806153331.23907-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 23:10:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 scripts/checkpatch.pl | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

We could do something similar to MAINTAINERS for trace-events,
ie warning about files added, moved, deleted if we don't see
an update to a trace-events file.

To make it more solid it would be better to check the
actual file contents for #include "trace.h" or "trace-root.h",
but I guess this is not possible/practice from checkpatch?

If we could only warn for files moved that actually include
trace.h or trace-root.h, we could avoid a lot of false positives.

Thanks,

Claudio

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd3faa154c..1c8afebed5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1300,6 +1300,7 @@ sub process {
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $reported_maintainer_file = 0;
+	my $reported_trace_events_file = 0;
 	my $non_utf8_charset = 0;
 
 	our @report = ();
@@ -1524,15 +1525,24 @@ sub process {
 		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
 			$reported_maintainer_file = 1;
 		}
-
+# similar check for trace-events
+		if ($line =~ /^\s*trace-events\s*\|/) {
+			$reported_trace_events_file = 1;
+		}
 # Check for added, moved or deleted files
-		if (!$reported_maintainer_file && !$in_commit_log &&
+		if (!$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
 		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
 		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
 		      (defined($1) || defined($2))))) {
-			$reported_maintainer_file = 1;
-			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+			if (!$reported_maintainer_file) {
+				$reported_maintainer_file = 1;
+				WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+			}
+			if (!$reported_trace_events_file) {
+				$reported_trace_events_file = 1;
+				WARN("added, moved or deleted file(s), does trace-events need updating?\n" . $herecurr);
+			}
 		}
 
 # Check for wrappage within a valid hunk of the file
-- 
2.16.4


