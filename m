Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB6CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768E5207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtibFGV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768E5207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibfS-0000l8-HX
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe9-0007cz-3Q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe3-0004NF-GH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:20 -0400
Received: by mail-wr1-x430.google.com with SMTP id r7so20744394wro.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9pkl6iqDPM5DBUIjjPAZ8d3gYA1coOAv0ui3m8FG6bQ=;
 b=AtibFGV/7JcGtqyPrCAVXwAoAb92UuyOmVBooJYi94/d15ascHEhCG/1qLHEhWlA76
 Gha7WGOd/L89d/2gLppwH0qx1YouOjtT2fBoZPAMkhA0e/ERxHMOSpe0Op++R+27Mcv/
 7WsRfsfncAWwh7nV/ieoEAVznNVECfN+hFuk0v6tP5M4n4eHVT2ulk3EZEitJTBg83qA
 19WzmlYi1R9TOMoeM1MMLyROeJjj3XidCW5nrMESaIYnnKLCL2S+cwSNpqQ3Nm6YTjtg
 AaSYA+b+5dMnNkodD1g2DbF9YBnZMIiEUm8WjXGvjwhqzk1qRKK8Pf/LVWK+bXQmxuN0
 9BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9pkl6iqDPM5DBUIjjPAZ8d3gYA1coOAv0ui3m8FG6bQ=;
 b=U5/YP2gruIfx63jmtCRQwAh8hY5AJZeFsaA3wixZdCiJwwnCDkWKPbB4pacBwETW9i
 n7f0j1O/OgG52XSDRv8Ug/vwE0a22iTNxFXJygcwHWcwtswK7mGqGI2xLHQ9UmqY46jt
 X1BvfajcEZi7VQ0qRr56ScPa2jd64fTZKM+nzy8fLOPdFNvDzgTvm1hqJMaQljnaMK3R
 MuoqfuVRtsy89Epywt9ms5BPprRLxdx6Y/QlLCyFWr9t6MNTA+KpEJiKmZMizQxIST9Q
 WEy/+5Rcu/nb4lraxgUdPGyBpmGxT6hdh1Z6cZHsrpC0hjzibJBg37r5hnrrgLrMlgQV
 F/nQ==
X-Gm-Message-State: AOAM5333eSl3sA6Lu1DmBrFVc8pb8GIdhFmKUD27ULJwXis03fYFNSQ2
 9dl2LNUpJCIbq3jkz96vI7gzfA==
X-Google-Smtp-Source: ABdhPJzUnHFBB+/VKzbUS+4pZp/H41e2/i1dkT+8we6JzPdtBMNH/Wwai23AFrtuRrzbXZ6FW1Pw8g==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr3601739wrv.51.1591699094101;
 Tue, 09 Jun 2020 03:38:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d24sm2370416wmb.45.2020.06.09.03.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 418681FF8C;
 Tue,  9 Jun 2020 11:38:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/17] scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as
 special header
Date: Tue,  9 Jun 2020 11:37:54 +0100
Message-Id: <20200609103809.23443-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

"qemu/qemu-plugin.h" isn't meant to be include by QEMU codebase,
but by 3rd party plugins that QEMU can use. These plugins can be
built out of QEMU and don't include "qemu/osdep.h".
Mark "qemu/qemu-plugin.h" as a special header that doesn't need
to be cleaned for "qemu/osdep.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200524215654.13256-1-f4bug@amsat.org>
Message-Id: <20200605154929.26910-3-alex.bennee@linaro.org>

diff --git a/scripts/clean-includes b/scripts/clean-includes
index dd938daa3ec..795b3bea318 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -123,6 +123,7 @@ for f in "$@"; do
       ;;
     *include/qemu/osdep.h | \
     *include/qemu/compiler.h | \
+    *include/qemu/qemu-plugin.h | \
     *include/glib-compat.h | \
     *include/sysemu/os-posix.h | \
     *include/sysemu/os-win32.h | \
-- 
2.20.1


