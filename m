Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E842C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A46206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFxo3CNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A46206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i20fU-0001sG-B2
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 18:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i20br-000722-Ff
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i20bq-0003u4-Fd
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:03:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i20bq-0003tb-A5; Sun, 25 Aug 2019 18:03:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id c3so13436755wrd.7;
 Sun, 25 Aug 2019 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GCTJEvAcTs97QcMqmmV3RVLZe4+hEjGIEVsWARwdvjo=;
 b=TFxo3CNv+GaDrjjYbPEa6y0HqS21PvOQh4NshegA9coF6sxxrctWZJX880GBm1uO1V
 Q0GNojZ4d5LkJn4iObqhPJSlQ2EihbdZOCY8q/M2P6tdYiohoK9dEZlTn8XUXOO6qnJB
 TJQmcsT3TO51c+lHU9OaM7vfLlihGcGwO8QZZNZZv1+SDZ1HVyMdw7nMem41Uqt9GQta
 Y7sx8W/hPz1P3pdjoNc8RpI/9cOuU8TFbrt5yZPJdL+vU9bBlUuFtOyosMqS6X/oJX0l
 PEyXHYfiY/VHxaXlAIPuPNBYTTSIPu06ASlIIY657MZtJGUaXAcpRuhFjF+0w3o2ua/J
 G60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GCTJEvAcTs97QcMqmmV3RVLZe4+hEjGIEVsWARwdvjo=;
 b=Q1diSicXm/SlbxGLoX4vSbIfb0alhhtro/hO12tqHKyB/KXXzA/H4ZL4RGF8dDpaUC
 SpnhdWCNIvPJGrBpoJWXIq5KDay8z+bO7UqZALYPxiatYXZ7tl05IIqK3fp9Mw3kuWGe
 TJXGwqbLSkLyviJQHzW9jBOPgpIsroLNDkExNYOtoAZeHSOLwr0lVKXQf/oV8UjakTnB
 2DsgX+WDWcTQiAv8AHskRaFeFdbMIqASy20HAxOaerEf4oUSBIMZlFJaANlI3pAy2hP/
 pnam7i7P/Fq52o+hPZ5GhWL8txXix/KtXKO5sD7XeACaBv/6+Btu0Sh0TuwQ9RKQs0dQ
 hRPQ==
X-Gm-Message-State: APjAAAUm0D75QCw+l10leguvhbbEWgoO5cZfn21HBdh4rsbTNgfP3Qp+
 nhxFtQys5jO4oRaZNuPt5OzBfhl+MqM=
X-Google-Smtp-Source: APXvYqzTt/LmZ4UFudmBg0nx+z5gn62EHGdOwGaewuez6CPcUqPmg8ZFD/71SxnVTk+gef4wbSh5tw==
X-Received: by 2002:a5d:568e:: with SMTP id f14mr17913867wrv.167.1566770616356; 
 Sun, 25 Aug 2019 15:03:36 -0700 (PDT)
Received: from localhost.localdomain (93-173-200-237.bb.netvision.net.il.
 [93.173.200.237])
 by smtp.gmail.com with ESMTPSA id f134sm17578257wmg.20.2019.08.25.15.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2019 15:03:35 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 01:03:29 +0300
Message-Id: <20190825220329.7942-3-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825220329.7942-1-nsoffer@redhat.com>
References: <20190825220329.7942-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 2/2] iotests: Test allocate_first_block()
 with O_DIRECT
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using block_resize we can test allocate_first_block() with file
descriptor opened with O_DIRECT, ensuring that it works for any size
larger than 4096 bytes.

Testing smaller sizes is tricky as the result depends on the filesystem
used for testing. For example on NFS any size will work since O_DIRECT
does not require any alignment.
---
 tests/qemu-iotests/175     | 25 +++++++++++++++++++++++++
 tests/qemu-iotests/175.out |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index d54cb43c39..60cc251eb2 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -49,6 +49,23 @@ _filter_blocks()
         -e "s/blocks=$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\\)/max allocation/"
 }
 
+# Resize image using block_resize.
+# Parameter 1: image path
+# Parameter 2: new size
+_block_resize()
+{
+    local path=$1
+    local size=$2
+
+    $QEMU -qmp stdio -nographic -nodefaults \
+        -blockdev file,node-name=file,filename=$path,cache.direct=on \
+        <<EOF
+{'execute': 'qmp_capabilities'}
+{'execute': 'block_resize', 'arguments': {'node-name': 'file', 'size': $size}}
+{'execute': 'quit'}
+EOF
+}
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -79,6 +96,14 @@ for mode in off full falloc; do
     stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
 done
 
+for new_size in 4096 1048576; do
+    echo
+    echo "== resize empty image with block_resize =="
+    _make_test_img 0 | _filter_imgfmt
+    _block_resize $TEST_IMG $new_size >/dev/null
+    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $new_size
+done
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 263e521262..39c2ee0f62 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -15,4 +15,12 @@ size=1048576, max allocation
 == creating image with preallocation falloc ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=falloc
 size=1048576, max allocation
+
+== resize empty image with block_resize ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
+size=4096, min allocation
+
+== resize empty image with block_resize ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
+size=1048576, min allocation
  *** done
-- 
2.20.1


