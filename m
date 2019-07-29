Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB26C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED92216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1G6OjQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED92216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7au-0005VE-6C
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Qf-0000Sd-BK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Qe-000298-2C
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:13 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7Qd-00026N-RX; Mon, 29 Jul 2019 11:19:11 -0400
Received: by mail-pg1-x541.google.com with SMTP id f5so19605898pgu.5;
 Mon, 29 Jul 2019 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gOorbCfkOfD5hZ9Ne/IGI2m869VvMpyg8Fi+6sPnwi8=;
 b=F1G6OjQEueVHGDuOxyiPHc/6rCXIpTHvBUxDKg/GCcSs7LIom8AHRKoVzpeGTt0kl1
 AHwgGNguLmZQbE/2H+3CvRrKuWgippajWFoUFLlIKFstyGEp649gMHswlVcEvyglMk0Y
 /+Bf3gd2t4SI8uNc/bxPrP/E9c3UOX3u5PklkDRcPsm24HnJzVsXqblo4OJmLKI2hnuq
 RudvuXeFWtylYu4MuACDcIlSO0g/Nn5Ez9tAPT/Bo2pOcTE7gZfKNzr83sWXAtPhfc28
 drWwByGMWHse3DXertNDAmDXXdco0VKkqgXSvTABuResxGzV9mot+7fXOkWdly4PVpYS
 vKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gOorbCfkOfD5hZ9Ne/IGI2m869VvMpyg8Fi+6sPnwi8=;
 b=Angjjw8uxKZb3t6E1n1WZuL4uWU8X6EEXkki+kHcxX8+kDBMkxrIthAW6J/uzmSZOL
 /M+bcwxmL+gfNqqppcwOnzNQ1tknMMA1LyQAV3sP1zRwDT1GFvBxY5eirNTPbQY5g1FA
 XY1bRXU1AImfj7chtfKmVTHZhdps1hDgByf3VHdn7F3m5LoftGUs9YF6U4bL8R565rNK
 jfY+WOLFMnCi4u3KOSzcgIn2vgEV69dPVaC7dd4qZvEwLFjZ7wMbIYD9PDhzYvr6ScpU
 GrFwo/G+RqP05xf7lKteXCOKufShSiMy4upiTBlO/uJVHKutUrxvnHunHC0BxNnimrpc
 ZLbQ==
X-Gm-Message-State: APjAAAUEmk6s5lusdlJvRm/NcQTAjU01b7v9y1MW81B+qbrgV3iVsq6a
 iwdhzCGmooC+BUy1I5ehcI8Dtz5rlo4iGQ==
X-Google-Smtp-Source: APXvYqx7ATTByWezOb6rtvkEfSN65BlA2JSe7DJoZbU+CNhr2MziYjNcj2wbP/ZRlbiUTdg1kapMYw==
X-Received: by 2002:a63:c50f:: with SMTP id f15mr5133443pgd.372.1564413550517; 
 Mon, 29 Jul 2019 08:19:10 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.19.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:19:09 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:50 +0530
Message-Id: <20190729151651.21306-15-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 14/15] tests/qemu-iotests: enable testing
 with aio options
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
 tests/qemu-iotests/check      | 15 ++++++++++++++-
 tests/qemu-iotests/common.rc  | 14 ++++++++++++++
 tests/qemu-iotests/iotests.py |  9 ++++++++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index c24874ff4a..1e398923fd 100755
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
@@ -225,6 +227,11 @@ s/ .*//p
         CACHEMODE_IS_DEFAULT=false
         cachemode=false
         continue
+    elif $aiomode
+    then
+        AIOMODE="$r"
+        aiomode=false
+        continue
     fi
 
     xpand=true
@@ -269,6 +276,7 @@ other options
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
     -c mode             cache mode
+    -i mode             AIO mode
     -makecheck          pretty print output for make check
 
 testlist options
@@ -433,10 +441,13 @@ testlist options
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
@@ -515,6 +526,8 @@ done
 
 # Set qemu-io cache mode with $CACHEMODE we have
 QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --cache $CACHEMODE"
+# Set qemu-io aio mode with $AIOMODE we have
+QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --aio $AIOMODE"
 
 QEMU_IO_OPTIONS_NO_FMT="$QEMU_IO_OPTIONS"
 if [ "$IMGOPTSSYNTAX" != "true" ]; then
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 5502c3da2f..03f4a1cd7f 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -490,6 +490,20 @@ _default_cache_mode()
         return
     fi
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
+_default_aio_mode()
+{
+    AIOMODE="$1"
+    QEMU_IO="$QEMU_IO --aio $1"
+}
 
 _unsupported_imgopts()
 {
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ce74177ab1..76f1ab0945 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -58,6 +58,7 @@ imgproto = os.environ.get('IMGPROTO', 'file')
 test_dir = os.environ.get('TEST_DIR')
 output_dir = os.environ.get('OUTPUT_DIR', '.')
 cachemode = os.environ.get('CACHEMODE')
+aiomode = os.environ.get('AIOMODE')
 qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
 
 socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
@@ -457,6 +458,7 @@ class VM(qtest.QEMUQtestMachine):
             options.append('file=%s' % path)
             options.append('format=%s' % format)
             options.append('cache=%s' % cachemode)
+            options.append('aio=%s' % aiomode)
 
         if opts:
             options.append(opts)
@@ -799,6 +801,10 @@ def verify_cache_mode(supported_cache_modes=[]):
     if supported_cache_modes and (cachemode not in supported_cache_modes):
         notrun('not suitable for this cache mode: %s' % cachemode)
 
+def verify_aio_mode(supported_aio_modes=[]):
+    if supported_aio_modes and (aiomode not in supported_aio_modes):
+        notrun('not suitable for this aio mode: %s' % aiomode)
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
 
@@ -843,7 +849,7 @@ def skip_if_unsupported(required_formats=[], read_only=False):
     return skip_test_decorator
 
 def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
-         unsupported_fmts=[]):
+        supported_aio_modes=[], unsupported_fmts=[]):
     '''Run tests'''
 
     global debug
@@ -861,6 +867,7 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
+    verify_aio_mode(supported_aio_modes)
 
     if debug:
         output = sys.stdout
-- 
2.21.0


