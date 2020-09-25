Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9601BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1886D206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zfnm6T2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1886D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnGv-0004ka-1G
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCj-0007Z1-H0
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCe-0001Nq-IR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id e2so3182990wme.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=87z//cD5ketSzCXz9JVIdviJkCIdGgLMY4qP1K0Kw40=;
 b=Zfnm6T2pDEvo/aiIj0k4PRMgOcmLUaD57bfdPABvJlchpHAWFm8Sxky8kEMM0W354v
 hjKwaXMxltd3o/PS7J7d79CPlCSTbl/FN+0y5i08Md4ooRI98Le4U5BYg2iCMibq8ko0
 fifFGDyfGiLs0ffg6xAjUF2dygYiU9qKK7Xq3Hp/zCNy3VSg9FpT6XGJ2v36T86xs56G
 rVJ0S3MjCun1FIO9ClkhyZfapnHi3fNqtE0dqLSoX362Bshjs+nodsNjT7tIHehOhNIj
 vLlkbarQtbtUs+ZiYrg6yXtPJ73FDiqRAtgYtqgZSMs5rGTAR4pdSu9oDcRoXY9/YwDm
 cCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=87z//cD5ketSzCXz9JVIdviJkCIdGgLMY4qP1K0Kw40=;
 b=sFvvr8SaSGqvaYkk9VXiG4w7/jyNIdUX3W49EELRJ0o/8hUHcZ6271m/noiJJAGyxL
 DtbBsaQRkUtyptoZYYJo9z6qJeZ35xjx+a7Uxz7+ldOYhSm6agryTfJ/0G/Pw7n8NWoa
 pBG/iFZAqvCFQ5Iiz+T7C48eqezRPwpfbcc18icc8mJOjLGEINNqEOQQcRNtEnYdDkT8
 Yy4XDtGGbw34sOdbIN3sBwLjgHIMkwlIpvpcX2KSFeQEV6NpICrIzR07bZgjpnwUlsua
 G0JtseGskOsBvPm7rwX5sZzzlHMIlj5j3teBOguGGT+IMzbbyNixaG/DTBzfvkVByUUw
 ZbRQ==
X-Gm-Message-State: AOAM531i/do/9tjY7NrrnW5sDYZM5+0/IN3vaEajViO81ckm6W6SFOy6
 n0zbGuxof+Y/gqbsRv7dbL/D2A==
X-Google-Smtp-Source: ABdhPJwKP0PaoMjwzBkKR4DsYdC/a+SHjJ54z0qEhlhD4wxQ/i2xT2ySLHPvdDCL+xLk2E+vOzWalQ==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr3139106wmj.163.1601038315224; 
 Fri, 25 Sep 2020 05:51:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h3sm3094150wrq.0.2020.09.25.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73B101FF8F;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 03/19] hw/virtio: move virtio-pci.h into shared include
 space
Date: Fri, 25 Sep 2020 13:51:31 +0100
Message-Id: <20200925125147.26943-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: jean-philippe@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, takahiro.akashi@linaro.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows other device classes that will be exposed via PCI to be
able to do so in the appropriate hw/ directory. I resisted the
temptation to re-order headers to be more aesthetically pleasing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 {hw => include/hw}/virtio/virtio-pci.h | 0
 hw/virtio/vhost-scsi-pci.c             | 2 +-
 hw/virtio/vhost-user-blk-pci.c         | 2 +-
 hw/virtio/vhost-user-fs-pci.c          | 2 +-
 hw/virtio/vhost-user-input-pci.c       | 2 +-
 hw/virtio/vhost-user-scsi-pci.c        | 2 +-
 hw/virtio/vhost-user-vsock-pci.c       | 2 +-
 hw/virtio/vhost-vsock-pci.c            | 2 +-
 hw/virtio/virtio-9p-pci.c              | 2 +-
 hw/virtio/virtio-balloon-pci.c         | 2 +-
 hw/virtio/virtio-blk-pci.c             | 2 +-
 hw/virtio/virtio-input-host-pci.c      | 2 +-
 hw/virtio/virtio-input-pci.c           | 2 +-
 hw/virtio/virtio-iommu-pci.c           | 2 +-
 hw/virtio/virtio-net-pci.c             | 2 +-
 hw/virtio/virtio-pci.c                 | 2 +-
 hw/virtio/virtio-rng-pci.c             | 2 +-
 hw/virtio/virtio-scsi-pci.c            | 2 +-
 hw/virtio/virtio-serial-pci.c          | 2 +-
 19 files changed, 18 insertions(+), 18 deletions(-)
 rename {hw => include/hw}/virtio/virtio-pci.h (100%)

diff --git a/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
similarity index 100%
rename from hw/virtio/virtio-pci.h
rename to include/hw/virtio/virtio-pci.h
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index cb71a294faaf..08980bc23bdb 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -21,7 +21,7 @@
 #include "hw/virtio/vhost-scsi.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 typedef struct VHostSCSIPCI VHostSCSIPCI;
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 33b404d8a225..eef8641a9891 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index 8bb389bd282a..777249e8bc4d 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-user-fs.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 struct VHostUserFSPCI {
diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-input-pci.c
index c9d3e9113a5e..b858898a3630 100644
--- a/hw/virtio/vhost-user-input-pci.c
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -9,7 +9,7 @@
 #include "hw/virtio/virtio-input.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 typedef struct VHostUserInputPCI VHostUserInputPCI;
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index d5343412a11c..75882e3cf943 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -30,7 +30,7 @@
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
 #include "sysemu/kvm.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index 763f89984e91..a50845ea87a3 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-user-vsock.h"
 #include "qom/object.h"
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index e56067b42781..35773fbcb3b0 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index e07adcd9ea78..94c14f0b98c9 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/9pfs/virtio-9p.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index a2c5cc7207a9..8d5a212b94cd 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 9d5795810c36..9743bee965af 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -19,7 +19,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-blk.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-input-host-pci.c b/hw/virtio/virtio-input-host-pci.c
index 0ac360de4f34..cf8a9cf9e8db 100644
--- a/hw/virtio/virtio-input-host-pci.c
+++ b/hw/virtio/virtio-input-host-pci.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-input.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 85acd3d2ebb4..d208df68af5f 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 76540e57b104..022447b5a469 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index 292d13d27815..954b6fbf2d58 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -19,7 +19,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-net.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5bc769f685ce..507cb57c410f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -32,7 +32,7 @@
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
 #include "sysemu/kvm.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qemu/range.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/visitor.h"
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index c1f916268be7..151ece6f946a 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-rng.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 97fab742368a..e8e3442f3828 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -18,7 +18,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/module.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
index 35bcd961c988..cea31adcc4c6 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -20,7 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qemu/module.h"
-#include "virtio-pci.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
-- 
2.20.1


