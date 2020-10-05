Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B3F2085B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2W/Sm1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B3F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTqO-0002gT-ES
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPTpC-0001SI-Df
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:59:00 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPTp9-0002RK-5h
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:58:58 -0400
Received: by mail-oi1-x243.google.com with SMTP id x62so4930403oix.11
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S3+TYbT1fFZy18sR1x/5WNfjMK8/14PhYYhpiP2tuHw=;
 b=u2W/Sm1eG9I3f+1zgd6QaHWFLAlNLrUGO5KUzce06hqN2jMdknEErncGi0Falxg6UD
 A0rFZMkWR2qsdYdqGm0iZAsaT15vHI/U1UAaN8rJa98qseesDy1jqYA5x3BALG66Asmz
 rZbkgwlNpw9l6z4BoucSAeSlP4ysz36tK34vocRN3HVOoGj2kAEhSZmYgon46eXLnvpX
 lj20WU9rdCpXXohw4mnUcGxAqO0q2Hmxiqfu7kCM1XIxIxNn2ZDGw/p4epY4rohhn1uh
 TBM/dr79u1/b+jDVew9OpatYno9sTe3IiQiAKhYw/dTFCd4b34F7GN2O/vMXdC1k/Gpj
 lDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S3+TYbT1fFZy18sR1x/5WNfjMK8/14PhYYhpiP2tuHw=;
 b=L0nU1U9tyLUN1htdSxMLcXg1jLRUegOgsuHsel1eMQorYcDnefZxde+iUNhhxi3QWm
 o2WUqupSUh6RWpBQkfB0YHkFj6pq/Y4lxwpC8aWrRWN+zPCLAsyr7FdWSTgxXns/9Se1
 iaTt4fSY8O9TTSAZq9eQ8uiawaAyahotL2PmqL2vtq7BUy/UV4/owDAr1utFrw+u3HlJ
 2E2S7xnL9xo7k8bshqSgx6SFJgEqQXqzoKrYayxvxghIds7gbP6ueC+nBMAKks4suY5b
 P1Po9TwzxdP7u73P7XeI5/QygQWH2xsEU5Me6KoAeEoR62AF4g0YL+AAXxGIXzSO5aOq
 eJuQ==
X-Gm-Message-State: AOAM530dUj3t8lNYhqe94ltHaXOBVWI1+VRD2iqQpvYcX1b1x07RskFA
 UAncM+MaF3Q7QkJJnysmWKOCOnSbCppifwYY
X-Google-Smtp-Source: ABdhPJy5aA9uyVhNNox+RuZjpnWyIJMH6RM8zYp4Ck4jWL2ZLk4Hcr7DYb7s7f600dRy4cZPsR2lQQ==
X-Received: by 2002:aca:ea44:: with SMTP id i65mr159445oih.117.1601917133481; 
 Mon, 05 Oct 2020 09:58:53 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id r21sm69162otd.47.2020.10.05.09.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:58:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/tcg/linux-test: Adjust getsockname for musl
Date: Mon,  5 Oct 2020 11:58:50 -0500
Message-Id: <20201005165850.88425-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unlike glibc, musl does not use transparent unions to hide
the different structures that overlap struct sockaddr.

Add an explicit cast to work around this.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 8a7c15cd31..96bbad5823 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -296,7 +296,7 @@ static void test_socket(void)
     server_fd = server_socket();
     /* find out what port we got */
     socklen = sizeof(server_addr);
-    ret = getsockname(server_fd, &server_addr, &socklen);
+    ret = getsockname(server_fd, (struct sockaddr *)&server_addr, &socklen);
     chk_error(ret);
     server_port = ntohs(server_addr.sin_port);
 
-- 
2.25.1


