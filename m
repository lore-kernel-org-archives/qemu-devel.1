Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60EC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C764A2072E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaI0poiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C764A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isEGW-0003Vz-RD
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 18:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFV-0002fe-JE
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFU-00083L-Eh
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:25 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:55957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isEFU-00080i-8k
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:24 -0500
Received: by mail-pj1-x1034.google.com with SMTP id d5so2271329pjz.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 15:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DmQHc5bzsOAilfmxs+IZ22O3FD0s0+ykfMYFN/uiYsw=;
 b=BaI0poiGZgengjeVxzaev1PnThL39vYvHzNhJuD14eE9eCt99SBC/fsrIKyL5dzk0x
 PniSeCnbu3kGY0Fd3Y4eU7s2T2xLqebf2L2nF47k8h0h6rVLqn/H6Ur1ah7RWDKJng+f
 ZvWHfG16aSjygfDGtTfJl6+ltXLt2hOMEn0qjr4tulnyFnX7+SE7ylv+ylE4PAykGQ4j
 rEbRJiQDtPHBylD1KaZyLotegWE3p0Luohlvq6c3di8+d1VNZ/3MFZ4GqCKt5RNV6L77
 yD0Lk4nhhXF0Cpbxk+f7b/IfS+bAJsBCfk0kx8TV799ZfLHso7/bdmVEEGfNJP+bpOOo
 8dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DmQHc5bzsOAilfmxs+IZ22O3FD0s0+ykfMYFN/uiYsw=;
 b=WUIrtfY47pTGlrfMz0F+0nQaYbWFWPw/neqx4+RMob7u7O81OHZFUbzxS7IKfhHKlB
 Vk7rBifNxx7N/xBxOp8zWmcsepTuJhdkbiDt8PEw51DywWz0copD0uVUQxEKIVzO1Ksa
 CaEAaz1CYdF0SF7TR+xbD6NuHqVW88Abq5NX4V80F01PwF1Nb4oGhbBHSe8tA7HuqlP7
 773z0Y8PWdzjwJPE5JuHRYgSiYp7piG0xUtXMkyhcJQui82T/HfHO9YCLzOEc5twk2ll
 C7BAQx/ypwxkd7Llz5uJHpu9DI1zgCwgu+/XZ4ExHSCXeHuebsYT2h4k/CFo763cU3UH
 iPZg==
X-Gm-Message-State: APjAAAVKyQl9wYx2AL46LDz7BqWlhbHgPYBdT/poC3woAvgpyyXNlj/Q
 NN/4rWq1JU9KIIeVeecX+j0/PJHJqaI=
X-Google-Smtp-Source: APXvYqwEh43rwF4ZTIVbhkmaMcgfLNEB3xJX8bjoCz1ksUd89R4l01iuMUF+VTqsl/DDUOpmdWmktQ==
X-Received: by 2002:a17:90b:30c8:: with SMTP id
 hi8mr2021393pjb.73.1579216097714; 
 Thu, 16 Jan 2020 15:08:17 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s7sm5111578pjk.22.2020.01.16.15.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 15:08:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/arm: Fix ComputePAC (LP 1859713)
Date: Thu, 16 Jan 2020 13:08:05 -1000
Message-Id: <20200116230809.19078-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1034
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
Cc: peter.maydell@linaro.org, vincent.dehors@smile.fr, alex.bennee@linaro.org,
 adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks to Vincent and Adrien for both reporting the bug and
providing the solution.  I've converted their manual testing
into executable tests.


r~


Richard Henderson (3):
  tests/tcg/aarch64: Fix compilation parameters for pauth-%
  tests/tcg/aarch64: Add pauth-3
  tests/tcg/aarch64: Add pauth-4

Vincent Dehors (1):
  target/arm: Fix PAuth sbox functions

 target/arm/pauth_helper.c                 |  4 +--
 tests/tcg/aarch64/pauth-1.c               |  2 --
 tests/tcg/aarch64/pauth-2.c               |  2 --
 tests/tcg/aarch64/pauth-4.c               | 25 ++++++++++++++
 tests/tcg/aarch64/system/pauth-3.c        | 40 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  5 ++-
 tests/tcg/aarch64/Makefile.target         |  3 +-
 7 files changed, 73 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-4.c
 create mode 100644 tests/tcg/aarch64/system/pauth-3.c

-- 
2.20.1


