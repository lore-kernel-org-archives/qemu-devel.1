Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263DDC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E307D205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c95YFYMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E307D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44697 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtm2-0005A2-28
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsGT-00045J-CD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsGS-000791-2u
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsGR-00074p-Tj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecct8qM9CQq9wafb4H/DdqFCaIbWp3zdOza4EOqH9I4=;
 b=c95YFYMkfCRaVN+sBlJNYP59oneTP5J978NZXe6kzWU3HRPrA/P3U4zustSTbGdWNutv5b
 sgYuvGmUSLdYOiFirMRDqrhWZXDMwMco8kL9PNTjZRJHwhgf/nKflkvQUDySM3o0D3C9Qi
 tfIVR2tThEqfzXrE/P9RffEtaOvRnqc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-rzMu8fKaP4yUuOEYnCjtqg-1; Mon, 16 Mar 2020 12:06:50 -0400
X-MC-Unique: rzMu8fKaP4yUuOEYnCjtqg-1
Received: by mail-wm1-f70.google.com with SMTP id f185so1010320wmf.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZypQ8Ym2m02m1znfiemKRznaDVP8zp+ewV5H3Kv12cs=;
 b=Pu+1WT24zTyLapclgmNBderSbNeukXFqL28mgw5s0v+joY3cHZ3DI02FtZSX4kJzvq
 26efF8EOjXuBb06OTgyr2mlOhQSe6xb1Qw+ge1Q1ytmHsGQ06aZJHIDi96gt6DHTIcVg
 VEdFqZqeimvwAKn63OmA9ypfH6bkQpDhPVTaPftc5WOA48qa/Rf5lNP0iUd8WiFvlWdd
 gKRws6nIstMIWJQ4dMTs7/ZwcYOqOx3LUrwIl7kAIIvmDQ5j2blvOoRvc0xwSBSsfK8/
 w1NFgX75cNGe0Asv/xktsHpv+dl4lHEqjNi42caS+BxpXX8KOLJk1cg+SWrauLjPdqSx
 477Q==
X-Gm-Message-State: ANhLgQ1jTHCD/haRe/vahwrjubZXt3RbwdTtFV16NbK1A4KTBdWzR5AP
 d/fzICShVXPJLVG6V8qPMKOuChEB1/n1bo4flf1Jq2qNaDu69EDnocaof1ELgsO4ukV7mIHw+Qg
 cmxoXpKX0OwpaJ9Y=
X-Received: by 2002:a5d:6287:: with SMTP id k7mr52980wru.195.1584374808596;
 Mon, 16 Mar 2020 09:06:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvIxEdXRN1Eb4UdNMtDRQaogZc63ozPayx+X/+0N08mn+FZQszGY+8INmM9VEIFVn95PP+ZPA==
X-Received: by 2002:a5d:6287:: with SMTP id k7mr52955wru.195.1584374808384;
 Mon, 16 Mar 2020 09:06:48 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b15sm498970wru.70.2020.03.16.09.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:06:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/19] target/arm: Make set_feature() available for other
 files
Date: Mon, 16 Mar 2020 17:06:17 +0100
Message-Id: <20200316160634.3386-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Move the common set_feature() and unset_feature() functions
from cpu.c and cpu64.c to internals.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190921150420.30743-2-thuth@redhat.com>
[PMD: Split Thomas's patch in two: set_feature, cpu_register (later)]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/internals.h | 10 ++++++++++
 target/arm/cpu.c       | 10 ----------
 target/arm/cpu64.c     | 11 +----------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index e633aff36e..7341848e1d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -27,6 +27,16 @@
=20
 #include "hw/registerfields.h"
=20
+static inline void set_feature(CPUARMState *env, int feature)
+{
+    env->features |=3D 1ULL << feature;
+}
+
+static inline void unset_feature(CPUARMState *env, int feature)
+{
+    env->features &=3D ~(1ULL << feature);
+}
+
 /* register banks for CPU modes */
 #define BANK_USRSYS 0
 #define BANK_SVC    1
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3623ecefbd..c074364542 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -723,16 +723,6 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
=20
 #endif
=20
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |=3D 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &=3D ~(1ULL << feature);
-}
-
 static int
 print_insn_thumb1(bfd_vma pc, disassemble_info *info)
 {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 62d36f9e8d..622082eae2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internals.h"
 #include "qemu/module.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
@@ -29,16 +30,6 @@
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
=20
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |=3D 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &=3D ~(1ULL << feature);
-}
-
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *=
ri)
 {
--=20
2.21.1


