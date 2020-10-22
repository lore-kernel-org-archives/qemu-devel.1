Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E3C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B857221FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbNEXuCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B857221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZfN-0001ay-Rz
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVZOh-00026a-Ok
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:08:48 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVZOV-0000Zm-Co
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:08:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so1887105wma.4
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qLPB1dB+Oklmp5dhgjQooB7fphLzdqsSaIVwxQvRp+M=;
 b=KbNEXuCOgFL3tTz71uZbBvC1OR2lqbN0QcpMKadeHeRWZIWq/JTCwpuOA9I5m1IwSS
 mblPC6h1rGx/DJBqcK/ZW0FWa5mqdVF1+jRJoQxPyZWvBW04supVKea5SI40qBFbUMgv
 urdd7dfr0cU/ertF2YEhbVRj4aMqBVJnDZKMvNHoNDmmK1aQeD2sFMbSYyg65c6t/1P0
 gN7HFtWWRD6ITmO4MdiOdVAfYUkmALCBu1aR5LkEaPZk9oWzb8r0ZkLXT06RAPILEqm3
 rSp43X7yO7Sj0SxTY1iKfG4PddIB1NscMAzkRsnSUWmkjCcq/VOsx/lrP5j0yk9ZE/Sd
 T8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qLPB1dB+Oklmp5dhgjQooB7fphLzdqsSaIVwxQvRp+M=;
 b=qzuUTPFvjgGrn70EZvcOQNCUsV/YYIGcCfQbe/6qwcXsSS7r4iJzWi/jRZhZXi/krj
 AV1Xy7swISpAHpBvdLxfmuysxeuOceLzHpAAL5HSngY6G3SE00f1c4eoTnh80+ayEx9H
 xaX3+BQrHGjmrwqLli/+ZsNsYIw9p1MCNt4Y+bnE1nOROT/jZtMFaEy9J0G0kwNnKDEl
 /c2n+eEpHhxRTrYR7XZZl01xMltBFUTAmEsV+rwxlmB26lPCVsfYS3z8KjD5zmuKcUHq
 pJRn9eglbEkJnoZYa4KAWjZdk7kT4QfvSI4pRxPYGpMBKQnbvnFLt8DKvfIWAcjKaYI2
 fdxg==
X-Gm-Message-State: AOAM531Hp0/BeKPVK+SL5xLM7gtz2NZ4DED50iM70Ta7n1VhlICklxN/
 HkJoPenYzeb1+xHFl4D1q1PuVbv2/GXlYA==
X-Google-Smtp-Source: ABdhPJyWAOBkCwluaG2Ot0edeqAf0H0GjO3K8ziM7CC4S2epV3Yd692Ehtl6jl1SMHFevFoKVHWyWw==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr2215910wmz.15.1603368513039;
 Thu, 22 Oct 2020 05:08:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x81sm3406210wmb.11.2020.10.22.05.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 05:08:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration: Drop unused VMSTATE_FLOAT64 support
Date: Thu, 22 Oct 2020 13:08:30 +0100
Message-Id: <20201022120830.5938-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ef96e3ae9698d6 in January 2019 removed the last user of the
VMSTATE_FLOAT64* macros. These were used by targets which defined
their floating point register file as an array of 'float64'.

We used to try to maintain a stricter distinction between
'float64' (a type for holding an integer representing an IEEE float)
and 'uint64_t', including having a debug option for 'float64' being
a struct and supposedly mandatory macros for converting between
float64 and uint64_t. We no longer think that's a usefully
strong distinction to draw and we allow ourselves to freely
assume that float64 really is just a 64-bit integer type, so
for new targets we would simply recommend use of the uint64_t type
for a floating point register file. The float64 type remains
as a useful way of documenting in the type signature of helper
functions and the like that they expect to receive an IEEE float
from the TCG generated code rather than an arbitrary integer.

Since the VMSTATE_FLOAT64* macros have no remaining users and
we don't recommend new code uses them, delete them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h | 13 -------------
 migration/vmstate-types.c   | 26 --------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f68ed7db13c..4d71dc8fbaa 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -219,7 +219,6 @@ extern const VMStateInfo vmstate_info_uint64;
 #define VMS_NULLPTR_MARKER (0x30U) /* '0' */
 extern const VMStateInfo vmstate_info_nullptr;
 
-extern const VMStateInfo vmstate_info_float64;
 extern const VMStateInfo vmstate_info_cpudouble;
 
 extern const VMStateInfo vmstate_info_timer;
@@ -997,12 +996,6 @@ extern const VMStateInfo vmstate_info_qlist;
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_uint64, uint64_t)
 
 
-#define VMSTATE_FLOAT64_V(_f, _s, _v)                                 \
-    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_float64, float64)
-
-#define VMSTATE_FLOAT64(_f, _s)                                       \
-    VMSTATE_FLOAT64_V(_f, _s, 0)
-
 #define VMSTATE_TIMER_PTR_TEST(_f, _s, _test)                             \
     VMSTATE_POINTER_TEST(_f, _s, _test, vmstate_info_timer, QEMUTimer *)
 
@@ -1114,12 +1107,6 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_INT64_ARRAY(_f, _s, _n)                               \
     VMSTATE_INT64_ARRAY_V(_f, _s, _n, 0)
 
-#define VMSTATE_FLOAT64_ARRAY_V(_f, _s, _n, _v)                       \
-    VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_float64, float64)
-
-#define VMSTATE_FLOAT64_ARRAY(_f, _s, _n)                             \
-    VMSTATE_FLOAT64_ARRAY_V(_f, _s, _n, 0)
-
 #define VMSTATE_CPUDOUBLE_ARRAY_V(_f, _s, _n, _v)                     \
     VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_cpudouble, CPU_DoubleU)
 
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 35e784c9d93..e22d41d73d6 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -420,32 +420,6 @@ const VMStateInfo vmstate_info_uint16_equal = {
     .put  = put_uint16,
 };
 
-/* floating point */
-
-static int get_float64(QEMUFile *f, void *pv, size_t size,
-                       const VMStateField *field)
-{
-    float64 *v = pv;
-
-    *v = make_float64(qemu_get_be64(f));
-    return 0;
-}
-
-static int put_float64(QEMUFile *f, void *pv, size_t size,
-                       const VMStateField *field, QJSON *vmdesc)
-{
-    uint64_t *v = pv;
-
-    qemu_put_be64(f, float64_val(*v));
-    return 0;
-}
-
-const VMStateInfo vmstate_info_float64 = {
-    .name = "float64",
-    .get  = get_float64,
-    .put  = put_float64,
-};
-
 /* CPU_DoubleU type */
 
 static int get_cpudouble(QEMUFile *f, void *pv, size_t size,
-- 
2.20.1


