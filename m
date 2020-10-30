Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491C8C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A347B20756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/fKT/cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A347B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKAa-0000Z1-JQ
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7V-0004yi-Db
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:32797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7T-0005u0-Fj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id b19so2256318pld.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 19:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hWFPHSjsVgdkpwaXmpPyiEJodAdz7dCX6Ri0ZTK6cK8=;
 b=x/fKT/cmwIXnwSo8MCGaRpIhmifd5D5s2ER+1atRem6b/a1+2k+DJ7YJlJoBJ4xbnw
 SyxB4dpI5tb3fueW7KxzKxenIgZpnn/w5xhyQjzXtUSE8cmBqj3ZjibxMX7M41savdLZ
 6koDiw4yrfVZaR8KT9+k3mSlbMfXGfZMkeJm5JeUFikJ/wvRO5IZO4bqGBYt5AWT4bnq
 Q5fEhs61Y8RdwuFAZeY5fhYEQZ0JCcb4gESIoUsnCvYEAE/Ic9XZoy9S6ms4LgDOjsbw
 gjkmnCIax64SIeUraUW9BBWEoh+cncvurj5PqsYfDlwEToadi1Y97eZK/pG1ItgljlSq
 SyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hWFPHSjsVgdkpwaXmpPyiEJodAdz7dCX6Ri0ZTK6cK8=;
 b=emTHkoPe1l5u+NZON7Wh/llDHMXi2IAceqAQGU6XWHCz+RotJ8tifu1nr7qUWt6Xrn
 8FMUBZLUOZMkAXVjS6lJxiN8/kTk2fjkNjGy6pfI5Qxl/0/qSoSujDSJ1rXOIzqYide2
 mEp29bTh43tAYe6OXPgi9Pguc8meUQnVoCoxEYM892b0Aus1czpQRrf9c+fStZCNkugm
 iiaUUi4h9qMpfJlrULH6xtnz//q7NRVRYgWsJi87zBc68aHXyBZoxqrEFpvtlzWkhRgF
 TTVhAXvey2JX7XHy6qURqv1wd8nhe9eJjf6plXiekCfdF99qpz76UBeHg8pliojmOZHg
 shcg==
X-Gm-Message-State: AOAM533Pb6wVNyMlUE/4VbD6DglXKJvyUFKXQEZhh55csMlcVKAUV+xq
 INKC9/uSyn5f1RBbZ3d8zfRFu7jVBHpp2w==
X-Google-Smtp-Source: ABdhPJzIW+9bcyeOfVQLFqF5v079gynX5ykPUiuAHPh0nfDEKH8pIkzHG+Y/TazUfIzHD7M5PLMxjw==
X-Received: by 2002:a17:902:9a4c:b029:d6:1f21:8021 with SMTP id
 x12-20020a1709029a4cb02900d61f218021mr6704567plv.58.1604024780264; 
 Thu, 29 Oct 2020 19:26:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b7sm4446517pfr.171.2020.10.29.19.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 19:26:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/11] target/arm: Fix neon reg offsets
Date: Thu, 29 Oct 2020 19:26:07 -0700
Message-Id: <20201030022618.785675-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Much of the existing usage of neon_reg_offset is broken for
big-endian hosts, as it computes the offset of the first
32-bit unit, not the offset of the entire vector register.

Fix this by separating out the different usages.  Make the
whole thing look a bit more like the aarch64 code.

Changes for v2:
  * Fix two tcg temp leaks.

r~

Richard Henderson (11):
  target/arm: Introduce neon_full_reg_offset
  target/arm: Move neon_element_offset to translate.c
  target/arm: Use neon_element_offset in neon_load/store_reg
  target/arm: Use neon_element_offset in vfp_reg_offset
  target/arm: Add read/write_neon_element32
  target/arm: Expand read/write_neon_element32 to all MemOp
  target/arm: Rename neon_load_reg32 to vfp_load_reg32
  target/arm: Add read/write_neon_element64
  target/arm: Rename neon_load_reg64 to vfp_load_reg64
  target/arm: Simplify do_long_3d and do_2scalar_long
  target/arm: Improve do_prewiden_3d

 target/arm/translate.c          | 153 ++++++++---
 target/arm/translate-neon.c.inc | 472 +++++++++++++++++---------------
 target/arm/translate-vfp.c.inc  | 341 ++++++++++-------------
 3 files changed, 516 insertions(+), 450 deletions(-)

-- 
2.25.1


