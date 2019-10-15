Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D40ECE58C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 03:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC10F20873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 03:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC10F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKDLC-0000Dz-4q
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 23:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKDK9-0007ZZ-R6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 23:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKDK7-0007Mt-Th
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 23:16:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:34171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iKDK0-0006Wv-5Z; Mon, 14 Oct 2019 23:16:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Oct 2019 20:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,297,1566889200"; d="scan'208";a="207412346"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 14 Oct 2019 20:14:22 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: kwolf@redhat.com, mreitz@redhat.com, jasowang@redhat.com,
 alex.bennee@linaro.org, dgilbert@redhat.com, richard.henderson@linaro.org
Subject: [PATCH 1/2] tests/tcg/multiarch: fix code style in function main of
 test-mmap.c
Date: Tue, 15 Oct 2019 11:13:49 +0800
Message-Id: <20191015031350.4345-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015031350.4345-1-richardw.yang@linux.intel.com>
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This file uses quite a different code style and changing just one line
would leads to some awkward appearance.

This is a preparation for the following replacement of
sysconf(_SC_PAGESIZE).

BTW, to depress ERROR message from checkpatch.pl, this patch replaces
strtoul with qemu_strtoul.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 tests/tcg/multiarch/test-mmap.c | 67 ++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 11d0e777b1..9ea49e2307 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -456,49 +456,54 @@ void check_invalid_mmaps(void)
 
 int main(int argc, char **argv)
 {
-	char tempname[] = "/tmp/.cmmapXXXXXX";
-	unsigned int i;
-
-	/* Trust the first argument, otherwise probe the system for our
-	   pagesize.  */
-	if (argc > 1)
-		pagesize = strtoul(argv[1], NULL, 0);
-	else
-		pagesize = sysconf(_SC_PAGESIZE);
+    char tempname[] = "/tmp/.cmmapXXXXXX";
+    unsigned int i;
+
+    /*
+     * Trust the first argument, otherwise probe the system for our
+     * pagesize.
+     */
+    if (argc > 1) {
+        qemu_strtoul(argv[1], NULL, 0, &pagesize);
+    } else {
+        pagesize = sysconf(_SC_PAGESIZE);
+    }
 
-	/* Assume pagesize is a power of two.  */
-	pagemask = pagesize - 1;
-	dummybuf = malloc (pagesize);
-	printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
+    /* Assume pagesize is a power of two.  */
+    pagemask = pagesize - 1;
+    dummybuf = malloc(pagesize);
+    printf("pagesize=%u pagemask=%x\n", pagesize, pagemask);
 
-	test_fd = mkstemp(tempname);
-	unlink(tempname);
+    test_fd = mkstemp(tempname);
+    unlink(tempname);
 
-	/* Fill the file with int's counting from zero and up.  */
+    /* Fill the file with int's counting from zero and up.  */
     for (i = 0; i < (pagesize * 4) / sizeof i; i++) {
         checked_write(test_fd, &i, sizeof i);
     }
 
-	/* Append a few extra writes to make the file end at non 
-	   page boundary.  */
+    /*
+     * Append a few extra writes to make the file end at non
+     * page boundary.
+     */
     checked_write(test_fd, &i, sizeof i); i++;
     checked_write(test_fd, &i, sizeof i); i++;
     checked_write(test_fd, &i, sizeof i); i++;
 
-	test_fsize = lseek(test_fd, 0, SEEK_CUR);
+    test_fsize = lseek(test_fd, 0, SEEK_CUR);
 
-	/* Run the tests.  */
-	check_aligned_anonymous_unfixed_mmaps();
-	check_aligned_anonymous_unfixed_colliding_mmaps();
-	check_aligned_anonymous_fixed_mmaps();
-	check_file_unfixed_mmaps();
-	check_file_fixed_mmaps();
-	check_file_fixed_eof_mmaps();
-	check_file_unfixed_eof_mmaps();
-	check_invalid_mmaps();
+    /* Run the tests.  */
+    check_aligned_anonymous_unfixed_mmaps();
+    check_aligned_anonymous_unfixed_colliding_mmaps();
+    check_aligned_anonymous_fixed_mmaps();
+    check_file_unfixed_mmaps();
+    check_file_fixed_mmaps();
+    check_file_fixed_eof_mmaps();
+    check_file_unfixed_eof_mmaps();
+    check_invalid_mmaps();
 
-	/* Fails at the moment.  */
-	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
+    /* Fails at the moment.  */
+    /* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
 
-	return EXIT_SUCCESS;
+    return EXIT_SUCCESS;
 }
-- 
2.17.1


