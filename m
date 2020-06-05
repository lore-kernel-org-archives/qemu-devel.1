Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F5FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C76206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVmbaf93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C76206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGK0-0000ZZ-8Y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHk-0003PX-0i
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHj-0003q9-5m
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:39 -0400
Received: by mail-pg1-x541.google.com with SMTP id e9so5493054pgo.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hi7LUnC/2Vxc6CG4AyW71h/9KhgELUl20yMZDhooBMo=;
 b=OVmbaf933xh3+YjoGnMzeKhaIMEES9/YNzfNkwU4WoU4wV4VsD72CXkV5csQ8rH96p
 SGNxx/1QpdRtfP/na6jfrSOPETR6s177Pkw0UB4llk/Tps/G1R/L8c/i8zvVNy8d1poT
 tuonWtc7WTRAqnf4JXd/6DGK989PV/wzRqN32OIJ5Sze5eE58MXE6nvxBQ00FtSC9gIv
 4rMSDCIkQ3j13V7fkocxbt5BObP5bz1G44RJIerfaEjbfDD1GTSEfHAlGMlsXm12vD1o
 mEmx49o84FE5doG3phUctcF0FnNWq12omdU6IK4vcaS90OVik1nAzJvqhA9VHsODQJe9
 771w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hi7LUnC/2Vxc6CG4AyW71h/9KhgELUl20yMZDhooBMo=;
 b=DfZ7TeFVfNqy6bCvsILBS9RDdqU4hm5iopQr8L1SLxwIQNg6JBdMNV6YqaIiNiNYIk
 mUVacYHx5SMig6kD9c8WwQetlVs4x7Eo76quld0+kDg4r1ZQhovYIwGGY+n0F49OTyNA
 vQp56J4/0bhr1YP5AU6dIRZkerb5VevZJyp7DkSkWlw85I0vdXX5dFeqvEnEEqnDO1Gw
 Fl8Xmd3li5u1PngCFRC/58smGz+OIbab6lQ8Pj8wsT//nKOWsU2jffUV+8A4ynJWXxdT
 nF4uZsGreYeV5ay/LCaUzVFQiUw+zaocdjuDPZnTfbM5qFK/X41ECqmuS0+Bj3NAsKpZ
 mybQ==
X-Gm-Message-State: AOAM530oO5RcoJXCeIxUyiQvVffE4slqlfG6Qwl3x+zTTku/lmiu+z6x
 A7iV6aB3U/N/UZqM8EkI34E286CZSh8HOw==
X-Google-Smtp-Source: ABdhPJy7FYzw8hFdsg5vb8oQ23ByADcRJvmYYPWoQ6JjCeTdFWmdyoxSvQBO9775/oGkiNO5JmcNhg==
X-Received: by 2002:a65:568d:: with SMTP id v13mr10411043pgs.436.1591378657135; 
 Fri, 05 Jun 2020 10:37:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:36 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/13] thread: add qemu_spin_destroy
Date: Fri,  5 Jun 2020 13:34:12 -0400
Message-Id: <20200605173422.1490-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

It will be used for TSAN annotations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/thread.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index d22848138e..e50a073889 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -215,6 +215,9 @@ static inline void qemu_spin_init(QemuSpin *spin)
     __sync_lock_release(&spin->value);
 }
 
+static inline void qemu_spin_destroy(QemuSpin *spin)
+{ }
+
 static inline void qemu_spin_lock(QemuSpin *spin)
 {
     while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
-- 
2.17.1


