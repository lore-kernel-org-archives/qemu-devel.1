Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5E0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EBB2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StXec8e7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EBB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOPn-0007pn-UP
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOF-000559-Tb
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOA-00079A-CM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOA-00078h-6X
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so14710326wma.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OKC9Pxddfkn7fXnu8/AzAFxKBTosF8UUw8eP0Jg/zfU=;
 b=StXec8e7eWk3jn6nerfcl8zvAfN5inSEjyMBFxd9eK1lH9JiMepbUIIs/vRnbnhGTN
 lFxVrAnpmCwWZTQme5A4n7wLLA6yWt/f6OAdOCeKVczg4dGBmonlvIbGOup3DVqDv15V
 bUmWRdhjspeV/NGz5V68A25JvnHWIpRzKxKYQXT9/Kwn1yHFgttV47BE6giysXNqyfzJ
 YjcI1plO4ERLAoSkSfmvmyks3bmkDOSYrmQLXPw+vPau1EXRZibDy0MT14BK4VvxZvk/
 SYVtAnc+khAMPdD6wlPW5QKScl65vWGdU6V5DQqHArs1Y/yD6YGD86esw2cN7X86hpqR
 gXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OKC9Pxddfkn7fXnu8/AzAFxKBTosF8UUw8eP0Jg/zfU=;
 b=epRj/ZJCzuin5gMYJNSF4p4qtCpqielAdDel6gQiyeiozZO7146wugzsDAYX0JBlse
 z1qHV6liQOWNhiOU/bffVjBTkww3rIQsbrOhCOYVWh0tM39enLo7kHiP2y2jdxGm3bDn
 5ldlStFGLp2U0+RcFxdBqFwTZ+HgqH13G9YWhLde2rwF6uvspdkYDQ/ZuQGXcz0fZ1PA
 zpCC9qdGa023RCL1pb63enxUgn35/HsPIZ0vX/fME2VJtzxSrGOYrGbNTEjMcyEKZnt4
 HMwwFiuXyJvQXEY3i1ogat/BSm2es8VfjG4lazGm5bHOAeJXVgorTmnNz9ecezVDo5MM
 FeWQ==
X-Gm-Message-State: AGi0PuaKXgQ4FgiOZK5FGPpC+PfDSZV2kCVm6/oh9ULlW/H/IwUIM1Ei
 G0tNS4DBsfusCVP8HrvDpJR5GXeT/LYMUg==
X-Google-Smtp-Source: APiQypIU25nGuJdNiVzftlTuuxmbCrZZjEnYGsTebqRSPAUZKBj5NojVWsJkVBSU/Qc78DS3ZqvRxQ==
X-Received: by 2002:a05:600c:2046:: with SMTP id
 p6mr615121wmg.177.1586881576889; 
 Tue, 14 Apr 2020 09:26:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] osdep.h: Drop no-longer-needed Coverity workarounds
Date: Tue, 14 Apr 2020 17:26:02 +0100
Message-Id: <20200414162613.4479-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit a1a98357e3fd in 2018 we added some workarounds for Coverity
not being able to handle the _Float* types introduced by recent
glibc.  Newer versions of the Coverity scan tools have support for
these types, and will fail with errors about duplicate typedefs if we
have our workaround.  Remove our copy of the typedefs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200319193323.2038-2-peter.maydell@linaro.org
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


