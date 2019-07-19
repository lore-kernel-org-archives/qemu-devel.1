Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E219FC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EEE2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tS4v0DwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EEE2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT5k-0004uP-NJ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4u-00017u-Al
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4t-0008SS-7D
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:40 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:40282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT4t-0008SC-1c; Fri, 19 Jul 2019 09:37:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id p184so14199538pfp.7;
 Fri, 19 Jul 2019 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KoETR8gbApZFB6Kf1iN1u5XLfMfWWkdp70lAnElXhFE=;
 b=tS4v0DwIrfckzCnKQhKODmlgbm9yI+OnX4k0xAkb9F37S1WciI8RjE54iLsFanH9yz
 v1aeGP8ND5yZ6G52EEEEmiVbyLNlaXfqEJmcyGJQmxoMyBKIGxd6FX1hqk4rjKeGz7WM
 RJx2bgYZs2WV0GbExGJXSj0TEw5A9sr9C8yIrUbeIYKxz8DUvSbVigRX8Mm9DIN9G6ie
 +W78S0wAYZxOmGDYXZSVoJhVMG/YrZwOFaZQh6dWBOMiMRu7VWvT6FZcWDbW+CIsxkH8
 7mHehJZxosiQtvkDvhT1Zfn4lPItX4ic0cHaK/wy2j4owi1A+3IuYs3Ud1RfNtj6WR99
 CLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KoETR8gbApZFB6Kf1iN1u5XLfMfWWkdp70lAnElXhFE=;
 b=uAg6lKPYiEwAAxL2OKuZE4YJ/BdLgyT+qWdB3V6eUBRXUlwzJA4DRylNMW4R8s8G3C
 4hm6+Ic166LKcfq7l7+3h89oe4Uw25egleYHxyN0inA/QHk4NF7s0rALQKBvJOiR+UoB
 L2KmOZUByqaDyxslP6O/7NeJDuwdYCY8qGrYsSMX42Iy3gaLsBUcgvhhcpE7kpUyc2wm
 nEslIzKgU6rt3EGrwKd0D0Lo8u03FoQiwpvqERhjl/k2cUsuivKAJ3tZhS/Ssks0D79w
 KF9V0FyE4bpFJ9zQ2WuYzZ1mL+AJT3nY7lGFgLkj1WE2l9t2oTnSuZtqwLHziMIFcIn6
 q79g==
X-Gm-Message-State: APjAAAXT245hkMg/RFO4KpEJ6NNLnxBIIG+MxeIgnDRSGbo6NsSSnMl+
 zCobag5sW5AFrROoEw/7zbjeesWYioA=
X-Google-Smtp-Source: APXvYqw5yPGWPRUDnVgNShffPjJypAR5ePskvPixEBVLEKOW8OWXZUwj1glJPxqHYLaaAGgKvXPddw==
X-Received: by 2002:a17:90b:28f:: with SMTP id
 az15mr57151975pjb.18.1563543457774; 
 Fri, 19 Jul 2019 06:37:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.37.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:37:37 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:30 +0530
Message-Id: <20190719133530.28688-15-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: [Qemu-devel] [PATCH v6 14/14] qemu-iotest: enable testing with
 qemu-io aio options
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 tests/qemu-iotests/check     | 14 +++++++++++++-
 tests/qemu-iotests/common.rc | 10 ++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f925606cc5..2bc5bc62e2 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -132,6 +132,7 @@ sortme=false
 expunge=true
 have_test_arg=false
 cachemode=false
+aiomode=false
 
 tmp="${TEST_DIR}"/$$
 rm -f $tmp.list $tmp.tmp $tmp.sed
@@ -141,6 +142,7 @@ export IMGFMT_GENERIC=true
 export IMGPROTO=file
 export IMGOPTS=""
 export CACHEMODE="writeback"
+export AIOMODE="threads"
 export QEMU_IO_OPTIONS=""
 export QEMU_IO_OPTIONS_NO_FMT=""
 export CACHEMODE_IS_DEFAULT=true
@@ -225,6 +227,10 @@ s/ .*//p
         CACHEMODE_IS_DEFAULT=false
         cachemode=false
         continue
+    elif $aiomode
+    then
+        AIOMODE="$r"
+        aiomode=false
     fi
 
     xpand=true
@@ -269,6 +275,7 @@ other options
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
     -c mode             cache mode
+    -i mode             AIO mode
     -makecheck          pretty print output for make check
 
 testlist options
@@ -433,10 +440,13 @@ testlist options
             cachemode=true
             xpand=false
             ;;
+        -i)
+            aiomode=true
+            xpand=false
+            ;;
         -T)        # deprecated timestamp option
             xpand=false
             ;;
-
         -v)
             verbose=true
             xpand=false
@@ -515,6 +525,8 @@ done
 
 # Set qemu-io cache mode with $CACHEMODE we have
 QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --cache $CACHEMODE"
+# Set qemu-io aio mode with $AIOMODE we have
+QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --aio $AIOMODE"
 
 QEMU_IO_OPTIONS_NO_FMT="$QEMU_IO_OPTIONS"
 if [ "$IMGOPTSSYNTAX" != "true" ]; then
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 5502c3da2f..39c04cc169 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -482,6 +482,16 @@ _supported_cache_modes()
     _notrun "not suitable for cache mode: $CACHEMODE"
 }
 
+_supported_aio_modes()
+{
+    for mode; do
+        if [ "$mode" = "$AIOMODE" ]; then
+            return
+        fi
+    done
+    _notrun "not suitable for aio mode: $AIOMODE"
+}
+
 _default_cache_mode()
 {
     if $CACHEMODE_IS_DEFAULT; then
-- 
2.21.0


