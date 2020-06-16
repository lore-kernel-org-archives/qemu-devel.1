Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A25C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A39220882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmOUrGKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A39220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCnL-0004Ip-MY
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQE-00030h-RH; Tue, 16 Jun 2020 10:18:46 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:33084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQD-0006to-9U; Tue, 16 Jun 2020 10:18:42 -0400
Received: by mail-ot1-x331.google.com with SMTP id n6so16067638otl.0;
 Tue, 16 Jun 2020 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Z/IEPTuPLem1LbcsQ8EirE06h15XALksmXQzNW0/kN0=;
 b=HmOUrGKUSQaGJnZWkCXwLwn84XIjmPrDe7NxQfcT6r8CHjdZKz9gI0wqjA8RC5oPO9
 zTnZUcmJM1YRYdqa+brIF3VnIdvy2v2UmfSVzMhU7xp+uepuse471+SVx3Qgk+qDjyr0
 vLLm94Mw2Y/OO+L6m7HE9fa4MW+Lz7up6fFyZJ0agaBPMKdGZOjXy+NnDuE1T1aKSXv0
 PjPL9wxiNlmFnHaIVwJJ7UdVhx+rPSLVHcadk5OkOk6kXgPu1+LPnzOFJ35YZlxjvvmV
 PASnr92fzPu0KMn/rwWjl7g3jKif0KF9dFOClf1xr8cPRTm+ZrCLxbGNHS3butuBhdWn
 A5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Z/IEPTuPLem1LbcsQ8EirE06h15XALksmXQzNW0/kN0=;
 b=TPTbmoclPjGWQEN+WcBxvIiy1k1nXNvRm3bzrkDb66OYa1jC8KETUC9UnbpcDlgJt7
 e0yYM1PMz7iNbir+agL1aVOYXJSjf6YNvWC13SW4IDSawbYMLxyfcOor4HyFtlBKwg1g
 dhiIEBa/pfEkb1dDAy8PUchbfsHdWRKb1tAy0RkBld/xDRc4BNhvL+IbQTkeysMFcPWV
 mQLF8uSTF7cFiDAZ+Mb9/xfnGJb/CyQQIOl4LjnCUql7qb5Rvsocn/FFkfeDvJ0Oqbar
 2Xoua5kt4evlyfeS1tKLQGctskK/EH0Qxngvty0s18np5LcjWh22P1lxQ5Dydf52ikPY
 9XkA==
X-Gm-Message-State: AOAM533FXhhI0ZrsTXWfQWDyDz3aPj15YagloZqRRQ4UVrKFYGBPi5lP
 BPoLBUuC+2NSfOd78KDi7L4523QD
X-Google-Smtp-Source: ABdhPJyN7+rmq1LVwe42qIaf+uH2LQcWEs+Qj8d6O78YIuEoUEk7LrSp9P2vy1X+JszvFCKdo6d6bA==
X-Received: by 2002:a05:6830:1512:: with SMTP id
 k18mr2616069otp.37.1592317119076; 
 Tue, 16 Jun 2020 07:18:39 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x6sm2880173ooe.5.2020.06.16.07.18.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:38 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/78] iotests/026: Test EIO on preallocated zero cluster
Date: Tue, 16 Jun 2020 09:15:17 -0500
Message-Id: <20200616141547.24664-49-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Test what happens when writing data to a preallocated zero cluster, but
the data write fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200225143130.111267-3-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 31ab00f3747c00fdbb9027cea644b40dd1405480)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/026             | 21 +++++++++++++++++++++
 tests/qemu-iotests/026.out         | 10 ++++++++++
 tests/qemu-iotests/026.out.nocache | 10 ++++++++++
 3 files changed, 41 insertions(+)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 3430029ed6..d89729697f 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -215,6 +215,27 @@ _make_test_img 64M
 $QEMU_IO -c "write 0 1M" -c "write 0 1M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
 _check_test_img
 
+echo
+echo === Avoid freeing preallocated zero clusters on failure ===
+echo
+
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event = "write_aio"
+errno = "5"
+once = "on"
+EOF
+
+_make_test_img $CLUSTER_SIZE
+# Create a preallocated zero cluster
+$QEMU_IO -c "write 0 $CLUSTER_SIZE" -c "write -z 0 $CLUSTER_SIZE" "$TEST_IMG" \
+    | _filter_qemu_io
+# Try to overwrite it (prompting an I/O error from blkdebug), thus
+# triggering the alloc abort code
+$QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index ff0817b6f2..83989996ff 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -643,4 +643,14 @@ write failed: Input/output error
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+
+=== Avoid freeing preallocated zero clusters on failure ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+write failed: Input/output error
+No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 495d013007..9359d26d7e 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -651,4 +651,14 @@ write failed: Input/output error
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+
+=== Avoid freeing preallocated zero clusters on failure ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+write failed: Input/output error
+No errors were found on the image.
 *** done
-- 
2.17.1


