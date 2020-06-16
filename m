Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE73208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMyCatf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE73208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCto-0000ZL-GU
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQK-00036B-JM; Tue, 16 Jun 2020 10:18:48 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:44003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQI-0006u6-TZ; Tue, 16 Jun 2020 10:18:48 -0400
Received: by mail-oi1-x22f.google.com with SMTP id j189so19335373oih.10;
 Tue, 16 Jun 2020 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uvyAq22LZpRLFDPeqbXH7QRTPLBpYz1NSiWqpfZpfYg=;
 b=BMyCatf75+tnK8vU/KBC59W0QgZqlGVForqrSq1Q6xc8DuCTyPFcAUWu9Jm6yonbqQ
 TExSublKlZ8iXV5mDvtTdH6UYnMCmTEVYjv1ku6Mlhpm1bjJv5h9ifEZ88CQNjI2Hv3y
 otgKAmbykqsxx1livqpeNRiVnM0UyxkHHwC8yXrxO9d34A9GaOc/moaWO6oSCSscLbR7
 5KhH7aEnzBH3yxR2so4oLc9rjBT+Mj3nqdMUHHWs8aMM1dE9scwCnNnPmv7kGJPiV+mp
 VvgaDZPwd3rKbP72Wxl+jb99tuki+Qvsw+E1xLKlzvKG2a3EYpLpAzvBddTFf8MzobqZ
 K7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=uvyAq22LZpRLFDPeqbXH7QRTPLBpYz1NSiWqpfZpfYg=;
 b=iRlEh5qOj1rPmagd4q1hUtqAkLKhGDP57zNGP9e7IpUzIt+qNPrhG5WRlRamseuFrE
 ku1yMfOQaidLjeluAciRs9j3bH3mplrpR4T7nSjvHaXg4Xd81ma/7Rby6WlZ1h4ecNS5
 Yh+vxf6666+B9Z04fzhYOF/hyCwtH5eh+oHDvd4NnV0X/gy01sjMhwqoGDUrIXbSOT+E
 bmzEIcHQbdUbCuZyj2ipgv2crMpz/UWjGcFH1/sfs887FXn4qHcDWy88EKF+9MAux0UQ
 AGVJumJKM1/3qPwv9Q79XjmV5tGllscqwNfq2hZcSrD6a3xU45HmKIeCnggy28ifI1pZ
 7fBA==
X-Gm-Message-State: AOAM533GjCLm70AoGNaedLnVxiFZ3IO1FkrbO4YzxCxliOz9NlSVGXKI
 OMp0CijOmhHgCf8PzINIK6alLdj/
X-Google-Smtp-Source: ABdhPJzCkYT8mgvg/PpJRcol5Oad5nfYzaKSveTXknJISbylDgZ0tl5j5EEhRrxv4pLdWL+5MFuzfg==
X-Received: by 2002:a05:6808:4b:: with SMTP id
 v11mr3387714oic.31.1592317121076; 
 Tue, 16 Jun 2020 07:18:41 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m94sm4078517otm.19.2020.06.16.07.18.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:39 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/78] iotests/026: Test EIO on allocation in a data-file
Date: Tue, 16 Jun 2020 09:15:18 -0500
Message-Id: <20200616141547.24664-50-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22f.google.com
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

Test what happens when writing data to an external data file, where the
write requires an L2 entry to be allocated, but the data write fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200225143130.111267-4-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 81311255f217859413c94f2cd9cebf2684bbda94)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/026             | 32 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/026.out         |  6 ++++++
 tests/qemu-iotests/026.out.nocache |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index d89729697f..c1c96a41d9 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -30,6 +30,7 @@ _cleanup()
 {
 	_cleanup_test_img
     rm "$TEST_DIR/blkdebug.conf"
+    rm -f "$TEST_IMG.data_file"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -236,6 +237,37 @@ $QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_IMG" | _filter_qemu_io
 
 _check_test_img
 
+echo
+echo === Avoid freeing external data clusters on failure ===
+echo
+
+# Similar test as the last one, except we test what happens when there
+# is an error when writing to an external data file instead of when
+# writing to a preallocated zero cluster
+_make_test_img -o "data_file=$TEST_IMG.data_file" $CLUSTER_SIZE
+
+# Put blkdebug above the data-file, and a raw node on top of that so
+# that blkdebug will see a write_aio event and emit an error
+$QEMU_IO -c "write 0 $CLUSTER_SIZE" \
+    "json:{
+         'driver': 'qcow2',
+         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
+         'data-file': {
+             'driver': 'raw',
+             'file': {
+                 'driver': 'blkdebug',
+                 'config': '$TEST_DIR/blkdebug.conf',
+                 'image': {
+                     'driver': 'file',
+                     'filename': '$TEST_IMG.data_file'
+                 }
+             }
+         }
+     }" \
+    | _filter_qemu_io
+
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 83989996ff..c1b3b58482 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -653,4 +653,10 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
+
+=== Avoid freeing external data clusters on failure ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024 data_file=TEST_DIR/t.IMGFMT.data_file
+write failed: Input/output error
+No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 9359d26d7e..8d5001648a 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -661,4 +661,10 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
+
+=== Avoid freeing external data clusters on failure ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024 data_file=TEST_DIR/t.IMGFMT.data_file
+write failed: Input/output error
+No errors were found on the image.
 *** done
-- 
2.17.1


