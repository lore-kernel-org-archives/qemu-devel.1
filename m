Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D15C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865C5206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyuhMEx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865C5206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKqG-0004bi-TU
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiY-0007d2-0X
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiW-0003gm-I0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:34160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKiW-0003fp-B5; Thu, 01 Aug 2019 19:42:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id b13so34953780pfo.1;
 Thu, 01 Aug 2019 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IkdMZ1ySU5K9IoJU/TAak65ZSyC3YEsojkXSiNxLvTQ=;
 b=DyuhMEx8ZfB0/vNvAgyRo5rficWwNFxCStGOnRbdr7MPD228ZwQfaaFGp+f7p7UPjG
 D5uCqg8+ZflqQkBTSQU3ZnG+0e2DXJOsZKSSLsyVLPGTXh7JhFrrLe8NETjDil9aJE8m
 S2fdYouXgZ8wXKxPOQsTOPRZnX0VYeppz7dvITKbMAFNtjbDh9apZqe0uqDkDpDl917M
 /wm9pLX4QipU+uHf87ybiNy3eMJZo3DC2Qoxr5F7aq3Xu4CQ0Aqf0Gcgm8z7XJlLCOW+
 3xeXneQZSLgI8J15vIln/CPwXYR4DchNB6Xrtz8d0d8NyuSxAYvRGXfufdO23EJxtXaV
 p4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkdMZ1ySU5K9IoJU/TAak65ZSyC3YEsojkXSiNxLvTQ=;
 b=dhRmC7Fi1oczKajn5XdcbEnLZsLIdgVztD0oUwLVRc7fWA4hZvDfUabwYMLZ6jVqoY
 kgCPAl99GfROMdW3xSEs32BjQmNWaNU0p38gNBo3OJdz3g3TGS9J4nboWgh8AdgAEJ5m
 o5IPp5ho1Q84fBz5k876Fwt1jLeWflpIEfXbs47nuIMnYpoM5ksROGdj309i1KJBhv/r
 dKbIr2P6XIJZqCX/RnAR90d2tEoj2ZzAmyPm4100lTb3q640/E4l0kgPIUU6+Jrv+gDr
 paosndXgTv1qnUrGysNn/aLid/MkSpDHYQewH+9DGyd3RFhr0zsWZB2+IzvIFw+O2wpE
 oyVw==
X-Gm-Message-State: APjAAAV29Kd1Mz93GfXCslwN4no65ioDOs+wn+bP3dx/xmF1V3N4yjgU
 wc9hqm2M5hB7F+eyn+uzpM/pdfCrPPWwgw==
X-Google-Smtp-Source: APXvYqzrxcJkyrEvAGW2yBmB4YhwQz5hroDzHegvdTpB5nGuklYb1OETgUY8KUqQV4jxw5UUksrgQw==
X-Received: by 2002:a17:90a:f488:: with SMTP id
 bx8mr1293794pjb.91.1564702958794; 
 Thu, 01 Aug 2019 16:42:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.42.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:42:38 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:28 +0530
Message-Id: <20190801234031.29561-15-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PATCH v9 14/17] tests/qemu-iotests: enable testing
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


