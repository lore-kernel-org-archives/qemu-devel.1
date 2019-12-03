Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587EC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC9E20656
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgMgDH2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHwT-0000QP-BV
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icHok-00048e-Gz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icHoh-0006U7-Kk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:53 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icHof-0006RV-Rc
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:50 -0500
Received: by mail-pg1-x541.google.com with SMTP id z124so2358780pgb.13
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 15:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=F49PxON0VnAE/h3y78/zUg66WDa1bFGtWTeeXtFn+7E=;
 b=CgMgDH2pdHI0TDuIi4wo5pvawhBy50zsghJb0MfKJWO0eLH6vGPqMWHpkuXYnSGm4U
 IMuAin9BSG5V9tvYcGfZk3wXm6cr3JDiie5vf6TB/UNl3LT+8peEZdtStc4qVrlWC1pd
 XKBCI/JiCuwEfV7A3kOXxhXuCevul1+HpLoFgu50PODHjkJUHZncvOSb++PDN2z7Yif0
 jABZk3+XN1VMXtEt24yWWaPy4zVvsm0FsZtXw8MyWkpduhEEPNsO6ieOiRiDsJn62vY3
 vneh4K2sincYHh2Fv1HRgELlqEw4gyTqWN3L4GYpXJjI3u0cnucGbOPllZ/3qL9ERLdY
 am5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=F49PxON0VnAE/h3y78/zUg66WDa1bFGtWTeeXtFn+7E=;
 b=HXisjfoG7/RdANJAobAXinuv29MLCntlU1BBhPHAF+XdYMk7Ejcnycsnhsb2y7FE+m
 yysIIyly8WgpfmV8zHZug9GH+yOk3h2aL5YHxi2o039nWkgtGu6lYUD4S+LxLxbbVmOg
 93/StAnqrVuztntXtOTwop/RvvJeTxRgOUCz6+Usmyu4N7o6uvQ6cnx+hzAyddh5ipB0
 vk1DaO/spGuExxsav6o1fKuIEXHUufuqdvOXCOkMR5OTlE0nVXgObyrmE6EV11ngPwvs
 Wj4mMz/zoJtEUMWS0GOMgXqmz5ue/Kidsaww5aFUQ4nUUDNsFq1lGOj20XOCR2ErZrIk
 je2Q==
X-Gm-Message-State: APjAAAU+MYh/qHJreA/FblxO0UlQ6I9RQBb5FrnUzvHY9SkEfzy0JpDQ
 jHQ7rhKnzULfn18ltGB3++XZbpK7xW0=
X-Google-Smtp-Source: APXvYqzvQvpbnydmAePOAw8VXvqEniExeLlAxUsyJR5uMm5CZzgijEIMJ0R0HnXnQu3NZOCU2rv10A==
X-Received: by 2002:a63:d958:: with SMTP id e24mr284065pgj.31.1575416566589;
 Tue, 03 Dec 2019 15:42:46 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k5sm4128256pju.14.2019.12.03.15.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 15:42:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/arm: Implement ARMv8.2-UAO
Date: Tue,  3 Dec 2019 15:42:40 -0800
Message-Id: <20191203234244.9124-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

Based-on: <20191203225333.17055-1-richard.henderson@linaro.org>
("target/arm: Implement ARMv8.1-PAN + ARMv8.2-ATS1E1")

This was relatively easy to do, and related to the VHE
and PAN patch sets.  It's also already supported by the
Linux kernel and thus easily tested.


r~


Richard Henderson (4):
  target/arm: Add ID_AA64MMFR2_EL1
  target/arm: Update MSR access to UAO
  target/arm: Implement UAO semantics
  target/arm: Enable ARMv8.2-UAO in -cpu max

 target/arm/cpu.h           | 23 +++++++++++++
 target/arm/cpu64.c         |  4 +++
 target/arm/helper.c        | 66 +++++++++++++++++++++++++-------------
 target/arm/kvm64.c         |  2 ++
 target/arm/translate-a64.c | 14 ++++++++
 5 files changed, 87 insertions(+), 22 deletions(-)

-- 
2.17.1


