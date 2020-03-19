Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5373C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB0B2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qK2Y/gWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB0B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0w8-0005SC-Jp
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v3-0004GC-G3
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v2-0005o0-Cu
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF0v2-0005mv-6p
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so4675452wru.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jh3gZFW8hITPJm52vDp0+U3ojSlhwuXHPcuBu7ELJi8=;
 b=qK2Y/gWMId7ULf7kwlPCJlHcu4zU71MQ4LYOH9JpSjK2zll5B3udpVWapKbFgKNuUh
 DMcAZG6VExueagn3XquNaX/7hRpzX01tTno0TaqvLTRcy+V4K84uWXuQDvMQHihljf0D
 lMr+Mo0xUX4gsucio9/9oUDOPGOisCAtSeHLbjtRkehMSTzQwGw3KTMPwY9n9dV+0dYW
 igzGDxfbwpwASRbZGSQj9kaCAdtBS3z/FFSR4mtEkxPIIC6tSLWNiADvFk5Q1IEKd4l5
 +uI3EiaNvbzo/1sTCmOVLp+EfK8DksCaPKbz16WvRYjA04nsGQGoPJqr3DmEgLKz3BJ3
 FWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jh3gZFW8hITPJm52vDp0+U3ojSlhwuXHPcuBu7ELJi8=;
 b=q0Oe3ujHgvYRCLvRImfX9V+Gv+Znj+ylwZ0GDXs0V9y5wjDS4VCukg7RTU4hFFSSSd
 zPKbgN5pQe85PayBOowQmEMT00DMDBxVwolQVKakyS3JtcUVLRUjefUQY2aMkrQTWOHc
 52MdEwMvMOKav9uoaqLzd/y96PXa9MC9KJp7qfWg+9J1u9yaFKptaMoX2kb/OhUIfZVd
 AUiPXlxelH7pi8APcbuz5sYydeR6t3t4slK7HA46t/PabUl9eSN1D3DddDgL5R1Gugia
 96YQqT2YTThM4caKIKx3nD6qglY6vBOY13V97Xpa6JVImIB3l0hsSg15dVm2mh3VB9e2
 mT6Q==
X-Gm-Message-State: ANhLgQ3Jy6Elwszb60zaP+aV4d3ApVVj3ZL5guuZYhAxIiHnMAeQepcO
 St5y0CyRIdL8qTAvCyDLWUomHl6zi7C/yA==
X-Google-Smtp-Source: ADFU+vui+kepmADB7WGcV2qwsDnMj3fOe8bU4jBFgC1eSaVZM8OG4NMqvQADedT25eARS6wkOZB0tQ==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr6396061wro.386.1584646406640; 
 Thu, 19 Mar 2020 12:33:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm4984794wrw.20.2020.03.19.12.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 12:33:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] osdep.h: Drop no-longer-needed Coverity workarounds
Date: Thu, 19 Mar 2020 19:33:18 +0000
Message-Id: <20200319193323.2038-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319193323.2038-1-peter.maydell@linaro.org>
References: <20200319193323.2038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit a1a98357e3fd in 2018 we added some workarounds for Coverity
not being able to handle the _Float* types introduced by recent
glibc.  Newer versions of the Coverity scan tools have support for
these types, and will fail with errors about duplicate typedefs if we
have our workaround.  Remove our copy of the typedefs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Sadly I don't think there's any way to tell whether we should
or should not provide the typedefs, so anybody with an older
Coverity will presumably find this breaks them.
---
 include/qemu/osdep.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9bd3dcfd136..20f5c5f197d 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -33,20 +33,6 @@
 #else
 #include "exec/poison.h"
 #endif
-#ifdef __COVERITY__
-/* Coverity does not like the new _Float* types that are used by
- * recent glibc, and croaks on every single file that includes
- * stdlib.h.  These typedefs are enough to please it.
- *
- * Note that these fix parse errors so they cannot be placed in
- * scripts/coverity-model.c.
- */
-typedef float _Float32;
-typedef double _Float32x;
-typedef double _Float64;
-typedef __float80 _Float64x;
-typedef __float128 _Float128;
-#endif
 
 #include "qemu/compiler.h"
 
-- 
2.20.1


