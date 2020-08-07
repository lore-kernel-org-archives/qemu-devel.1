Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA79C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E3A2075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E3A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Mk-0004NL-VK
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k40Kw-0002wr-7L
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:14:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:46210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k40Ku-00076j-DY
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:14:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9B001B6C8;
 Fri,  7 Aug 2020 11:15:12 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Subject: [RFC v2] checkpatch: detect missing changes to trace-events
Date: Fri,  7 Aug 2020 13:14:47 +0200
Message-Id: <20200807111447.15599-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 23:38:33
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 scripts/checkpatch.pl | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

v1 -> v2 :

* track the "from" file in addition to the "to" file,
  and grep into both (if they exist), looking for trace.h, trace-root.h

  If files are reachable and readable, emit a warning if there is no
  update to trace-events.


diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd3faa154c..37db212fc6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1300,6 +1300,7 @@ sub process {
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $reported_maintainer_file = 0;
+	my $reported_trace_events_file = 0;
 	my $non_utf8_charset = 0;
 
 	our @report = ();
@@ -1309,6 +1310,7 @@ sub process {
 	our $cnt_chk = 0;
 
 	# Trace the real file/line as we go.
+	my $fromfile = '';
 	my $realfile = '';
 	my $realline = 0;
 	my $realcnt = 0;
@@ -1454,10 +1456,15 @@ sub process {
 		$here = "#$realline: " if ($file);
 
 		# extract the filename as it passes
-		if ($line =~ /^diff --git.*?(\S+)$/) {
-			$realfile = $1;
-			$realfile =~ s@^([^/]*)/@@ if (!$file);
+		if ($line =~ /^diff --git.*?(\S+).*?(\S+)$/) {
+			$fromfile = $1;
+			$realfile = $2;
+			if (!$file) {
+				$fromfile =~ s@^([^/]*)/@@ ;
+				$realfile =~ s@^([^/]*)/@@ ;
+			}
 	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
+
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
@@ -1470,6 +1477,11 @@ sub process {
 			}
 
 			next;
+
+		} elsif ($line =~ /^---\s+(\S+)/) {
+			$fromfile = $1;
+			$fromfile =~ s@^([^/]*)/@@ if (!$file);
+			next;
 		}
 
 		$here .= "FILE: $realfile:$realline:" if ($realcnt != 0);
@@ -1524,15 +1536,26 @@ sub process {
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
+				if (`grep -F -s -e trace.h -e trace-root.h ${fromfile} ${realfile}` ne '') {
+					$reported_trace_events_file = 1;
+					WARN("added, moved or deleted file(s), does trace-events need updating?\n" . $herecurr);
+				}
+			}
 		}
 
 # Check for wrappage within a valid hunk of the file
-- 
2.16.4


