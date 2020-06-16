Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3631FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BE320882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlOotZ7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BE320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCpj-0001oG-69
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQB-0002ru-Ta; Tue, 16 Jun 2020 10:18:39 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:41176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQA-0006t4-An; Tue, 16 Jun 2020 10:18:39 -0400
Received: by mail-oi1-x22d.google.com with SMTP id a21so19360519oic.8;
 Tue, 16 Jun 2020 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UHOhXDFptEyi8wAw25zqqNqwLR+Xm/W9JlxxPN8OX68=;
 b=dlOotZ7rQ45BnLt/QvJBJ2Z0M31uSmNFJsU/FN/FJmTVfwAbFk1895KMwfkQZ9eVL8
 NX3HO+K/G7UtISMg4OEgZ97fuHZyx3BSkItGLOXgOlcb1GCBb/KsvEQ3INl6jUYPg3yX
 ut0248g6QWdbCPY3WORPorbsfl+SXtZNjtXBGYq/hobn30BbT2DlnyLZ3LNciqAY7x3Z
 TL9c5TNL/cACaxX6LZ0ttoGQVhpaYzsMnjZN/TKV2t5eRzEifagFAabM8u/+HHspEbEx
 zZjLcJYIvXQB2/pFp1Xh7xi+hRHqesWRSOwFd0VNGVrffvQbklb691uohG4jKKjmR+SU
 ePpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UHOhXDFptEyi8wAw25zqqNqwLR+Xm/W9JlxxPN8OX68=;
 b=JdbdMhqdjBdTVzfWwdDQGCd8pJrGKgsxb3mgdNfbFANYnSdcP3VMzA6CY/Gn9FIk57
 6U8Xio7X86ETKuV6Nu+0pIT8eoa3rKUmZLHyuDjMYfAHifn8HiCjQzBr1uvMExGU213p
 RexmMf4GS5YHl9vbBfY1Mt1HsLzG7h1rILVhq3D49pYJGVemLjQjXyEk6sItGcva8K0l
 QJLruriMf+rED6ymNAUNbghXF6ZvbVFnRfub9Gp3mIuPV1oST3dfzrC1y4UwQ0ykSeUJ
 0OaBwJzD9afBFbUsEpzSpa104sOApwDNLg+GbrtvVDFRIphZLAsiBywSXZjiEclB0FP3
 lgQQ==
X-Gm-Message-State: AOAM533rBdBv9ZZC9B0aAbs0pFDkBIbobUBo+1rwlkvQOu2J01ubn1yk
 +r/qJdCQNtBXQvTBiotOtr5Tv8c2
X-Google-Smtp-Source: ABdhPJwUHwh1mTO4kJCmQSDDzGNiKVltI+Xy2LmhZqFNqBFv234w7jt4b5MBZesnku1mbD43Lklehw==
X-Received: by 2002:aca:5c54:: with SMTP id q81mr3434928oib.53.1592317116504; 
 Tue, 16 Jun 2020 07:18:36 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c10sm4120422ooq.30.2020.06.16.07.18.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:35 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/78] iotests: Test copy offloading with external data file
Date: Tue, 16 Jun 2020 09:15:15 -0500
Message-Id: <20200616141547.24664-47-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

This adds a test for 'qemu-img convert' with copy offloading where the
target image has an external data file. If the test hosts supports it,
it tests both the case where copy offloading is supported and the case
where it isn't (otherwise we just test unsupported twice).

More specifically, the case with unsupported copy offloading tests
qcow2_alloc_cluster_abort() with external data files.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200211094900.17315-4-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit a0cf8daf77548786ced84d773f06fc70571c5d38)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/244     | 14 ++++++++++++++
 tests/qemu-iotests/244.out |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 13978f93d2..2f5dfb9edd 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -194,6 +194,20 @@ $QEMU_IO -c 'read -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=human "$TEST_IMG" | _filter_testdir
 $QEMU_IMG map --output=json "$TEST_IMG"
 
+echo
+echo "=== Copy offloading ==="
+echo
+
+# Make use of copy offloading if the test host can provide it
+_make_test_img -o "data_file=$TEST_IMG.data" 64M
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
+$QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
+
+# blkdebug doesn't support copy offloading, so this tests the error path
+$QEMU_IMG amend -f $IMGFMT -o "data_file=blkdebug::$TEST_IMG.data" "$TEST_IMG"
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
+$QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 6a3d0067cc..e6f4dc7993 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -122,4 +122,10 @@ Offset          Length          Mapped to       File
 0               0x100000        0               TEST_DIR/t.qcow2.data
 [{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true, "offset": 0},
 { "start": 1048576, "length": 66060288, "depth": 0, "zero": true, "data": false}]
+
+=== Copy offloading ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
+Images are identical.
+Images are identical.
 *** done
-- 
2.17.1


