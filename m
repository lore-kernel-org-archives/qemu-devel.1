Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4439C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BD7206F9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BD7206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kav2q-000461-P7
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 01:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kav2C-0003Yz-Sh; Fri, 06 Nov 2020 01:15:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kav2A-0008Gz-H0; Fri, 06 Nov 2020 01:15:40 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CS99Q2VS0zhdDS;
 Fri,  6 Nov 2020 14:15:22 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 14:15:18 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH] scripts/checkpatch.pl: Modify the line length limit of the
 code
Date: Thu, 5 Nov 2020 23:42:08 +0800
Message-ID: <20201105154208.12442-1-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=ganqixin@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 01:15:26
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, ganqixin@huawei.com,
 pbonzini@redhat.com, kuhn.chenqun@huawei.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify the rule that limit the length of lines according to the following ideas:

--add a variable max_line_length to indicate the limit of line length and set it to 100 by default
--when the line length exceeds max_line_length, output warning information instead of error
--if/while/etc brace do not go on next line whether the line length exceeds max_line_length or not

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 scripts/checkpatch.pl | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88c858f67c..84a72d47ad 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -35,6 +35,7 @@ my $summary_file = 0;
 my $root;
 my %debug;
 my $help = 0;
+my $max_line_length = 100;
 
 sub help {
 	my ($exitcode) = @_;
@@ -1628,17 +1629,13 @@ sub process {
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /$SrcFile/);
 
-#90 column limit; exempt URLs, if no other words on line
+#$max_line_length column limit; exempt URLs, if no other words on line
 		if ($line =~ /^\+/ &&
 		    !($line =~ /^\+\s*"[^"]*"\s*(?:\s*|,|\)\s*;)\s*$/) &&
 		    !($rawline =~ /^[^[:alnum:]]*https?:\S*$/) &&
-		    $length > 80)
+		    $length > $max_line_length)
 		{
-			if ($length > 90) {
-				ERROR("line over 90 characters\n" . $herecurr);
-			} else {
-				WARN("line over 80 characters\n" . $herecurr);
-			}
+			WARN("line over $max_line_length characters\n" . $herecurr);
 		}
 
 # check for spaces before a quoted newline
@@ -1831,13 +1828,8 @@ sub process {
 			#print "realcnt<$realcnt> ctx_cnt<$ctx_cnt>\n";
 			#print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
 
-			# The length of the "previous line" is checked against 80 because it
-			# includes the + at the beginning of the line (if the actual line has
-			# 79 or 80 characters, it is no longer possible to add a space and an
-			# opening brace there)
 			if ($#ctx == 0 && $ctx !~ /{\s*/ &&
-			    defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*\{/ &&
-			    defined($lines[$ctx_ln - 2]) && length($lines[$ctx_ln - 2]) < 80) {
+			    defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*\{/) {
 				ERROR("that open brace { should be on the previous line\n" .
 					"$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
 			}
-- 
2.23.0


