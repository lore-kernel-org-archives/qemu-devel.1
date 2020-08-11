Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71DCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8103B20678
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8103B20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5POh-0005t2-M2
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 04:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5POA-0005Sr-5Q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:12:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5PO7-00080j-8p
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:12:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3CA64AB9F;
 Tue, 11 Aug 2020 08:12:21 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Subject: [RFC v3] checkpatch: detect missing changes to trace-events
Date: Tue, 11 Aug 2020 10:11:58 +0200
Message-Id: <20200811081158.4893-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:05:49
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
 scripts/checkpatch.pl | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

v2 -> v3 :

* move the check for missing changes to MAINTAINERS and trace-events
  later on, as otherwise the check for in_commit_log will not be done
  on an up to date value, causing fromfile and realfile to not be set,
  and matching unwanted strings inside the commit log.

* Ensure that at least one file name is passed to grep.


----

v1 -> v2 :

* track the "from" file in addition to the "to" file,
  and grep into both (if they exist), looking for trace.h, trace-root.h

  If files are reachable and readable, emit a warning if there is no
  update to trace-events.


diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd3faa154c..f63013bc35 100755
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
@@ -1524,15 +1536,9 @@ sub process {
 		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
 			$reported_maintainer_file = 1;
 		}
-
-# Check for added, moved or deleted files
-		if (!$reported_maintainer_file && !$in_commit_log &&
-		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
-		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
-		      (defined($1) || defined($2))))) {
-			$reported_maintainer_file = 1;
-			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+# similar check for trace-events
+		if ($line =~ /^\s*trace-events\s*\|/) {
+			$reported_trace_events_file = 1;
 		}
 
 # Check for wrappage within a valid hunk of the file
@@ -1605,6 +1611,24 @@ sub process {
 			$rpt_cleaners = 1;
 		}
 
+# Check for added, moved or deleted files
+		if (!$in_commit_log &&
+		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
+		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
+		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
+		      (defined($1) || defined($2))))) {
+			if (!$reported_maintainer_file) {
+				$reported_maintainer_file = 1;
+				WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+			}
+			if (!$reported_trace_events_file &&
+			    ($fromfile ne '' || $realfile ne '') &&
+			    (`grep -F -s -e trace.h -e trace-root.h ${fromfile} ${realfile}` ne '')) {
+				$reported_trace_events_file = 1;
+				WARN("added, moved or deleted file(s), does trace-events need updating?\n" . $herecurr);
+			}
+		}
+
 # checks for trace-events files
 		if ($realfile =~ /trace-events$/ && $line =~ /^\+/) {
 			if ($rawline =~ /%[-+ 0]*#/) {
-- 
2.16.4


