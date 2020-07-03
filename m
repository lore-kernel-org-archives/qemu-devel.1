Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6F320782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjyJRfP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6F320782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSHY-0007s8-OD
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9u-0000JS-KI; Fri, 03 Jul 2020 16:19:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9t-0001Ys-5D; Fri, 03 Jul 2020 16:19:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so33931185wrs.11;
 Fri, 03 Jul 2020 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kJoG6XnRiQVGgmRb/J8imecGQI2+tmstpB8uqDWyxdQ=;
 b=jjyJRfP100XodI7htnK3FQVzapwwPo39D5cQ/hYYosaqtKyRU7MxSxvJpZhTvdCldc
 lqlFhOUEpScfxNRs1CteN0vgeah8ciRNWTi1L3Rb6bFaGImQAa2J9yBiZJSr+lCtqJn2
 DKAzSBm+5B/hscTuUs+wc070Qdw5kdNokHU5A+oMslXfG6PhKc5YZPFxSJ0vQ+QiiMVq
 xrWSD6T1wZQXFFgHAyKkEoBUpJDnf0iaSCsAS1an3Dw2dPMobEKLHd4PNjpLml9WayKF
 b3Z9YTRXlUXp3m8BbT4eZuIE5klIl480oRfgfGhbWi5NVHhf0ZPdl57uopmWzvof5ZKl
 YvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kJoG6XnRiQVGgmRb/J8imecGQI2+tmstpB8uqDWyxdQ=;
 b=XxQ8s+ELNMcwJ2ajxZYbfKnkzwX/zrQ78thAvOnc1DGLStV1EEVaPYNcGJT1eDGnN2
 W2FAg3X084+EJn+rK+nwIE9m8vuUm8A4Etx5r8KeNRRJiG3A03cAZFk556xDmbigu2CU
 4wxFNdFQ6Tb5afVzpf3cvydifraHB94m88mIYzTDYHX9N6W4tEA3l+EXcIhZLGS7QSbx
 v0f6id4LMgkJuHhkMy7p614gkOfHj4+9rk7ASkxni6whj8sOUpgKtqN1V8SAdHsVai5h
 RqxYX987Khwf/Xs359Ybznn+3GYp0itR7nCRAjPw0ollYY4OMeRZ8j6X/6wZ+0nhigXK
 NSUw==
X-Gm-Message-State: AOAM531+OTFE0rqMwoFviw8HBq16ZLcC2xB1MI5M/7a06CfsWVp5c+2e
 eOmK25KKvrImJRZcCzm/keadTfQATL4=
X-Google-Smtp-Source: ABdhPJyCsHQRT9wCCwCxlbKLDPFfGCE5+cSZXe8CUShtKb1OmFki4GBXQKBVew7K2hQugaR3Upb36A==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr38884277wro.317.1593807579413; 
 Fri, 03 Jul 2020 13:19:39 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 18/18] hw/core/qdev: Display warning for devices missing
 migration state
Date: Fri,  3 Jul 2020 22:19:11 +0200
Message-Id: <20200703201911.26573-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When built with --enable-qdev-debug, QEMU displays warnings
listing devices missing migration state:

  $ qemu-system-arm -S -M spitz
  qemu-system-arm: warning: missing migration state for type: 'pxa270-c0-arm-cpu'
  qemu-system-arm: warning: missing migration state for type: 'serial'
  qemu-system-arm: warning: missing migration state for type: 'pxa2xx-pcmcia'
  qemu-system-arm: warning: missing migration state for type: 'pxa2xx-pcmcia'
  qemu-system-arm: warning: missing migration state for type: 'pxa2xx-i2c-slave'
  qemu-system-arm: warning: missing migration state for type: 'pxa2xx-i2c-slave'
  qemu-system-arm: warning: missing migration state for type: 'ads7846'
  qemu-system-arm: warning: missing migration state for type: 'max1111'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because there might be something simpler than --enable-qdev-debug.

 configure      | 9 +++++++++
 hw/core/qdev.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/configure b/configure
index 8a65240d4a..d38efd5605 100755
--- a/configure
+++ b/configure
@@ -441,6 +441,7 @@ edk2_blobs="no"
 pkgversion=""
 pie=""
 qom_cast_debug="yes"
+qdev_debug="no"
 trace_backends="log"
 trace_file="trace"
 spice=""
@@ -1124,6 +1125,10 @@ for opt do
   ;;
   --enable-qom-cast-debug) qom_cast_debug="yes"
   ;;
+  --disable-qdev-debug) qdev_debug="no"
+  ;;
+  --enable-qdev-debug) qdev_debug="yes"
+  ;;
   --disable-virtfs) virtfs="no"
   ;;
   --enable-virtfs) virtfs="yes"
@@ -6966,6 +6971,7 @@ echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
 echo "libssh support    $libssh"
 echo "QOM debugging     $qom_cast_debug"
+echo "QDEV debugging    $qdev_debug"
 echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
@@ -7594,6 +7600,9 @@ fi
 if test "$qom_cast_debug" = "yes" ; then
   echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
 fi
+if test "$qdev_debug" = "yes" ; then
+  echo "CONFIG_QDEV_DEBUG=y" >> $config_host_mak
+fi
 if test "$rbd" = "yes" ; then
   echo "CONFIG_RBD=m" >> $config_host_mak
   echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0d18bc6d93..c2da1e0509 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -932,6 +932,11 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
                                                &local_err) < 0) {
                 goto post_realize_fail;
             }
+        } else {
+#ifdef CONFIG_QDEV_DEBUG
+            warn_report("missing migration state for type: '%s'",
+                        object_get_typename(OBJECT(dev)));
+#endif
         }
 
         /*
-- 
2.21.3


