Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED57C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8072204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgnH157G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8072204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7an-0000Zx-Tc
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vv-0003Xs-EG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:59 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55985)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vu-0007hU-F0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:59 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ne5so1307023pjb.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rdRr8k9RoF6oI62onYFF+ei/xJnpiy+5iLWvNRMEmaI=;
 b=fgnH157GNy39piUiVuhYZ2EEHd1hvDpNYFV/mbXwRNtKmrcv2hSqSDrQYzKBW9A1R9
 499h0INvusZIAru0wkFi4TjeEwUyLcHR+cOqcyiBkuFj0ozkiWy2WFxxtVyokChpE2Oc
 hGJoM54QfqExU3KUaz3f/7RzimtVHXnPtvwnMSRtD+SmfldV9aHXkCHSX3zyHeBjJbUw
 iiZ61LPBdOM18NgRY8SEH9fdEcpx7tjMvBVeAbBu5VJRKoooGrNF14/Qxd6KV+608hOf
 uGQ/sU1K0DIP/vrMaJuQC6rM3xsVBQEDk6kSQLGJVhnscziGPGPh+M1qfVBk534rMkAY
 KWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rdRr8k9RoF6oI62onYFF+ei/xJnpiy+5iLWvNRMEmaI=;
 b=aRQhhbkWCTpmmEVOWFCMdWfnzxYPAGG6pWCD8Lf1NkBFjQw7+bvY1hrPhLNC5lYXRK
 0g83zusKDZrhVNbAlYNNXfea26KFW7jlkqNOpkGKQyotM2PTP5i8zZ5tY5e2Vk9659Ko
 sjDrdndEFliMKYQ8MNb6i2OZnTz+oCwC3jDknl6Vh+1dsxorrAyKJoP3c4wwKbLmZmSF
 6Lu63jqtAuMZItO2aKEj9ACVOPzG19AyZAzFUAvtQpr9rdOyKkPuyc9GW17StWti4WuP
 Xgei6JnaJxJBNO0nx86YJtPzweEmVRk94Qvbl3V3JKt/PCfqCJHZJjftuR+VxVD8rLpJ
 I5rA==
X-Gm-Message-State: AOAM530yg/q+k1mwbpTa0pGyNVHQ2EB6bg728ZpKt+s4JOVSA54lR70z
 CaxwgXO3ZFuw82zKSK4XlppydIGfYpY=
X-Google-Smtp-Source: ABdhPJz5xCUkpqpwqfVXH/zCWYrb4fDtkz4uUzyTrdP6aJgHn6XL6iNhaFe2TR2a313ShHfYGXz0LQ==
X-Received: by 2002:a17:902:bd09:: with SMTP id
 p9mr4586962pls.214.1591821590479; 
 Wed, 10 Jun 2020 13:39:50 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g6sm740648pfb.164.2020.06.10.13.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:39:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] configure: Add -Wno-psabi
Date: Wed, 10 Jun 2020 13:39:42 -0700
Message-Id: <20200610203942.887374-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610203942.887374-1-richard.henderson@linaro.org>
References: <20200610203942.887374-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On aarch64, gcc 9.3 is generating

qemu/exec.c: In function ‘address_space_translate_iommu’:
qemu/exec.c:431:28: note: parameter passing for argument of type \
  ‘MemTxAttrs’ {aka ‘struct MemTxAttrs’} changed in GCC 9.1

and many other reptitions.  This structure, and the functions
amongst which it is passed, are not part of a QEMU public API.
Therefore we do not care how the compiler passes the argument,
so long as the compiler is self-consistent.

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
TODO: The only portion of QEMU which does have a public api,
and so must have a stable abi, is "qemu/plugin.h".  We could
test this by forcing -Wpsabi or -Werror=psabi in tests/plugin.
I can't seem to make that work -- Alex?
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 8b33447048..76d32e0f7b 100755
--- a/configure
+++ b/configure
@@ -2036,6 +2036,7 @@ add_to nowarn_flags -Wno-shift-negative-value
 add_to nowarn_flags -Wno-string-plus-int
 add_to nowarn_flags -Wno-typedef-redefinition
 add_to nowarn_flags -Wno-tautological-type-limit-compare
+add_to nowarn_flags -Wno-psabi
 
 gcc_flags="$warn_flags $nowarn_flags"
 
-- 
2.25.1


