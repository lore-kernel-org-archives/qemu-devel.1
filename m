Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEACC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412CC205CB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajidGXnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412CC205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxDn-00084L-En
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMG-0005Fl-QS; Thu, 03 Sep 2020 17:01:25 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:39224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMF-0007vC-4a; Thu, 03 Sep 2020 17:01:24 -0400
Received: by mail-ot1-x332.google.com with SMTP id u25so4011941otq.6;
 Thu, 03 Sep 2020 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E70J8HSNM80vAgu3Ao3Q8OgYv6xE4YCHtBCrJzU2WUA=;
 b=ajidGXnSWBaH/GwIEMI1Hm9V2A2yedWl6ac4SRt4Lp3/DDRy3or7BijxgKTel4Qz8m
 F8LYry1WtlSkgOBbzXbc+pV/2iUa3Zgra6xbAEWbdNz2O71IPC1VqZrahbjdnPKtzgzQ
 u7l8D5mmjWRTdWtv6AvXZHDE5EruJJ04JFWypV8Hle5HaKtevvQG+y3ElJBwKTTBz2CF
 d6BCrzQRDQIEyMtqGcvfFMmf0K8lKTLMi6/70XEMYyQ0BpS5GeLPsnjSlwJ69PBM8a+G
 JqWaMLjF8CzwWOCQN/JMWzvGEw+BgE4rtBrAU7RWUwEYfmhaDFOsHRgVDAJedVXrWZiQ
 RkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=E70J8HSNM80vAgu3Ao3Q8OgYv6xE4YCHtBCrJzU2WUA=;
 b=fEAe0V0jbrFR/KL8ogcV3CWdjnomSzmRBYJ7f4Bnrc6rSMq2TD+NWY9Y/Ex7/v98ZK
 I7uLB6WrZVXkVSGf2rA+bZVDuOwEtGJv+KALU/Vjxi0TLPhdQyRa4igCd3oIXtZVh263
 DYxswEKLbaigZK5o+X0hE8ZlHmmMX1MeObMDdqrnEoAPTKyKBYZui2UzuTSlw4kBO6Mu
 ftJVCAgDCMA9bE00b1xNXzHMybypvQFhoAnmzrERg/KOw3iqzWsgMa+CYdtMG7INGta7
 LYRiuOWaZjBmg+A8E9GTRUka0QKPBR72KJbBcYB0U4yKTGrFdvTqqf7MCLWyiT/cWnfe
 Cdew==
X-Gm-Message-State: AOAM532cb0DcJF5HBF6nE2OlfYHGAn7qME8Wk/ZGpWKhjxVaN/RuIVz+
 akWBPe/pC1xZKbh+drynvwd7WbeeVUArVA==
X-Google-Smtp-Source: ABdhPJzXySGpZPVLjP7vOorjlMkpNhGQPAJfx5GEt8rwqFzqZ+hUAwqIIr2Oe8jg0FFtKSqjOzjtLw==
X-Received: by 2002:a9d:7618:: with SMTP id k24mr3225209otl.34.1599166881283; 
 Thu, 03 Sep 2020 14:01:21 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 68sm771492otw.3.2020.09.03.14.01.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:20 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 73/77] iotests/028: Add test for cross-base-EOF reads
Date: Thu,  3 Sep 2020 15:59:31 -0500
Message-Id: <20200903205935.27832-74-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200728120806.265916-3-mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Claudio Fontana <cfontana@suse.de>
(cherry picked from commit ae159450e161b3e1e2c5b815d19632abbbbcd1a1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/028     | 19 +++++++++++++++++++
 tests/qemu-iotests/028.out | 11 +++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 797dae5350..1e52986b74 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -142,6 +142,25 @@ TEST_IMG="${TEST_IMG}.copy" io_zero readv $(( offset + 32 * 1024 )) 512 1024 32
 
 _check_test_img
 
+echo
+echo '=== Reading across backing EOF in one operation ==='
+echo
+
+# Use a cluster boundary as the base end here
+base_size=$((3 * 1024 * 1024 * 1024))
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $base_size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $image_size
+
+# Write 16 times 42 at the end of the base image
+$QEMU_IO -c "write -P 42 $((base_size - 16)) 16" "$TEST_IMG.base" \
+    | _filter_qemu_io
+
+# Read 32 bytes across the base EOF from the top;
+# should be 16 times 0x2a, then 16 times 0x00
+$QEMU_IO -c "read -v $((base_size - 16)) 32" "$TEST_IMG" \
+    | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index 37aed84436..51ae06d38f 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -730,4 +730,15 @@ read 512/512 bytes at offset 3221257728
 read 512/512 bytes at offset 3221258752
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+
+=== Reading across backing EOF in one operation ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=3221225472
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294968832 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 16/16 bytes at offset 3221225456
+16 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+bffffff0:  2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a  ................
+c0000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+read 32/32 bytes at offset 3221225456
+32 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.17.1


