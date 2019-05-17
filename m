Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17951C46460
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62CB2173C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFWTOmBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62CB2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgsr-0000oS-41
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:43:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqq-0007tL-Qw
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqo-00038l-CV
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRgqm-00030u-N7
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:40:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id x64so7685513wmb.5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=K1PYSu9pA1oky++yuIlXAuhJhMUCXE5jcIih2/bVKYA=;
	b=UFWTOmBijaNUh7m6PjBYAFkE6uvTOMBUJoUJXqPtQAsh8TiBQAYe1r+YOSqtM7YRu0
	RfEfVh2gnfa7vF3Xc9sq+AqVci7jkeTeZ3GFLqIrn9syFpaG3Ug7d8TPxvZWz4lhA9k8
	YgdGaW/7BWK0THVAqneWXtGATuiLY5JhKSb1E/Ty3qxhsXpWimI5jyxxUJxa00Nq2+9d
	6cTEjoZTfl7kAOahNt35HWDmlkg3QQLN49MmiLj2bU+3gvUoqM0ZKiNveybanWsnRM8y
	L1AsU8C+gj77EwRME7rDty/G3QG5MSpRFQ0UxNqWQ9EvNRp5oU66jemXazAUEgKB7Cel
	BHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=K1PYSu9pA1oky++yuIlXAuhJhMUCXE5jcIih2/bVKYA=;
	b=l3U1YOcZOv8WTjO+Yn/pPNeSbzIae76HbueEf8+R/1YD23UHHr3KK8BO7bodgaUdIs
	T7uHFXRYiNQT/b9s7i9vY4rcKf75iWgOW7MrV1J35VobgcQ7T+C1LDSYuHmt+SwZOilK
	1U/riWI+sJ4boB7vrNNdRne8FbK3HxF5QYA0rYGHJnW9HrSdcqtIIec47fjKcBG6JA09
	lBojQ5WNHpS7v6AOIljiGecXQ2Q4aLKuAiJ7xtX5TWCtgApvURDH09KL2LfyLrS7xm4D
	5wlRsQMVcI7kHWqvFJD3Em+0Wamt85wTeSrNRaYdoL72kRDdQAGf9q9oxz7W+B2vZ5tr
	nw6A==
X-Gm-Message-State: APjAAAVAOR6YZBit17RYNrMMohMtHNKJOJq3E8qoCBcRWqs8YmuSlwt6
	ECqNhyrzKan9kN+FsTUBbg0dfg==
X-Google-Smtp-Source: APXvYqxVKXd51QsCvxC+E9BQmldaJ0s4F7uY6mdywl4ns1VbOvm7LqbpDpGsUM623TjY/liEC9bGbw==
X-Received: by 2002:a05:600c:2116:: with SMTP id
	u22mr3033642wml.58.1558114852224; 
	Fri, 17 May 2019 10:40:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y18sm5418641wmd.29.2019.05.17.10.40.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 10:40:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:40:45 +0100
Message-Id: <20190517174046.11146-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517174046.11146-1-peter.maydell@linaro.org>
References: <20190517174046.11146-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 3/4] hw/arm/armv7m: Forward "vfp" and "dsp"
 properties to CPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create "vfp" and "dsp" properties on the armv7m container object
which will be forwarded to its CPU object, so that SoCs can
configure whether the CPU has these features.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armv7m.h |  4 ++++
 hw/arm/armv7m.c         | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index e96a98f8093..d2c74d3872a 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -43,6 +43,8 @@ typedef struct {
  *   devices will be automatically layered on top of this view.)
  * + Property "idau": IDAU interface (forwarded to CPU object)
  * + Property "init-svtor": secure VTOR reset value (forwarded to CPU object)
+ * + Property "vfp": enable VFP (forwarded to CPU object)
+ * + Property "dsp": enable DSP (forwarded to CPU object)
  * + Property "enable-bitband": expose bitbanded IO
  */
 typedef struct ARMv7MState {
@@ -66,6 +68,8 @@ typedef struct ARMv7MState {
     uint32_t init_svtor;
     bool enable_bitband;
     bool start_powered_off;
+    bool vfp;
+    bool dsp;
 } ARMv7MState;
 
 #endif
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c4b2a9a1f5c..7caf9bd3364 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -190,6 +190,22 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {
+        object_property_set_bool(OBJECT(s->cpu), s->vfp,
+                                 "vfp", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+    if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
+        object_property_set_bool(OBJECT(s->cpu), s->dsp,
+                                 "dsp", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
 
     /*
      * Tell the CPU where the NVIC is; it will fail realize if it doesn't
@@ -260,6 +276,8 @@ static Property armv7m_properties[] = {
     DEFINE_PROP_BOOL("enable-bitband", ARMv7MState, enable_bitband, false),
     DEFINE_PROP_BOOL("start-powered-off", ARMv7MState, start_powered_off,
                      false),
+    DEFINE_PROP_BOOL("vfp", ARMv7MState, vfp, true),
+    DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


