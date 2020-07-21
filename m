Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72204C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4127C20720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYKMCBUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4127C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnPd-0004Qh-Fq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMn-0007hO-Ip
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMl-0004Kq-Oa
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Ed8qjShg83j6iJdRGGW66/wVId0nejMjJmWAPtjIA/c=;
 b=ZYKMCBUCDtX75AMjCv+zTSjkEftzti+V5wfOK+MPLm6dtWanqfFa29xeoa43jCnVIdfRXh
 tT8Mnb5UMtQV7AgS+9+N+2Sb7iLJaI62TyML2KNdzQYJt9SpM4ZnZKndI2MfrJPhnpWFgo
 NDm5wy9aXTg2QgdPm6wi8xLZrWTElRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-0VIbiRXROm23p4R5se3Edw-1; Tue, 21 Jul 2020 04:11:08 -0400
X-MC-Unique: 0VIbiRXROm23p4R5se3Edw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5F9107ACCA;
 Tue, 21 Jul 2020 08:11:07 +0000 (UTC)
Received: from thuth.com (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 137CA2DE68;
 Tue, 21 Jul 2020 08:11:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/10] docs/fuzz: add information about useful libFuzzer flags
Date: Tue, 21 Jul 2020 10:10:51 +0200
Message-Id: <20200721081055.14073-7-thuth@redhat.com>
In-Reply-To: <20200721081055.14073-1-thuth@redhat.com>
References: <20200721081055.14073-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200706195534.14962-4-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/fuzzing.txt | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 12bf6aa0ca..6d18115239 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -48,6 +48,43 @@ Information about these is available by passing -help=1
 Now the only thing left to do is wait for the fuzzer to trigger potential
 crashes.
 
+== Useful libFuzzer flags ==
+
+As mentioned above, libFuzzer accepts some arguments. Passing -help=1 will list
+the available arguments. In particular, these arguments might be helpful:
+
+$CORPUS_DIR/ : Specify a directory as the last argument to libFuzzer. libFuzzer
+stores each "interesting" input in this corpus directory. The next time you run
+libFuzzer, it will read all of the inputs from the corpus, and continue fuzzing
+from there. You can also specify multiple directories. libFuzzer loads existing
+inputs from all specified directories, but will only write new ones to the
+first one specified.
+
+-max_len=4096 : specify the maximum byte-length of the inputs libFuzzer will
+generate.
+
+-close_fd_mask={1,2,3} : close, stderr, or both. Useful for targets that
+trigger many debug/error messages, or create output on the serial console.
+
+-jobs=4 -workers=4 : These arguments configure libFuzzer to run 4 fuzzers in
+parallel (4 fuzzing jobs in 4 worker processes). Alternatively, with only
+-jobs=N, libFuzzer automatically spawns a number of workers less than or equal
+to half the available CPU cores. Replace 4 with a number appropriate for your
+machine. Make sure to specify a $CORPUS_DIR, which will allow the parallel
+fuzzers to share information about the interesting inputs they find.
+
+-use_value_profile=1 : For each comparison operation, libFuzzer computes 
+(caller_pc&4095) | (popcnt(Arg1 ^ Arg2) << 12) and places this in the coverage
+table. Useful for targets with "magic" constants. If Arg1 came from the fuzzer's
+input and Arg2 is a magic constant, then each time the Hamming distance
+between Arg1 and Arg2 decreases, libFuzzer adds the input to the corpus.
+
+-shrink=1 : Tries to make elements of the corpus "smaller". Might lead to
+better coverage performance, depending on the target.
+
+Note that libFuzzer's exact behavior will depend on the version of
+clang and libFuzzer used to build the device fuzzers.
+
 == Adding a new fuzzer ==
 Coverage over virtual devices can be improved by adding additional fuzzers.
 Fuzzers are kept in tests/qtest/fuzz/ and should be added to
-- 
2.18.1


