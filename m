Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A70C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0285723102
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Um8s5pfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0285723102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zDi-0003yQ-9f
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zCx-00036w-0k
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:39:03 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:36647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zCt-0006O7-Le
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:39:02 -0400
Received: by mail-pg1-x533.google.com with SMTP id p37so5979119pgl.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6ylxTGSowvqS4Sh1nFgWGtctWNG02JS9Mw6SmxLJsAo=;
 b=Um8s5pfhmy2Si6VqG67ZNrDCMnUQgwt2dA1lBHVzX5nmT6wVCJFQtyhaRo0ikfXU2b
 xGBoC6slDc17ehVG7Degk/TJMRrhhZcP3vTkx7p6YDEQOGCnv1qYqaOHARKvmQlX+Rsv
 UNLBjOxJ8IgrfcI1BH3Jx3ZpsUIhYEyT/e+EFZjkM0Box2qIJOEIKCZKe5pLObJknxOQ
 IKJ6ERIe1xmRA7ifDRlKT++5LJzwaUea8iM8X41ingucjgclu3Avi1KU9irGq+fuwh7H
 OdxwX5QD+dCIJEpUhYkIoK0e5FNB1WG47OW+pEZDnDgj4ONSSH/aIySDLOXYDpYH8gY6
 GTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6ylxTGSowvqS4Sh1nFgWGtctWNG02JS9Mw6SmxLJsAo=;
 b=s4kBQKBwU0SkK0UVGTEYOak3vDbfEJdWWV/7Z6bkAq63IybcZGAaCtmmyImxOs10fu
 xv6D5YH3DF94xAskVnx/eFX9NyQ/jnbdLBIBt0hZJKcuUMv5BtjuqP0/e1Aw5MObGBMt
 HXysfpkK+YsHFop+QoQTzUrCI998gLnrNVPgIyzt5498B6+eNlfWjNqGGsj4ljo++fBw
 p1AHKo7M69LL/fe5QjxHWvnCz0OnwDOTKCwt0wsYdVfsvR5sINfrrIzW9Hpw5iOZm+N7
 dJE8Nxh8nAXCLt/qhJ4pLEdKUTvF/r8uXipcU+Qr3VNhrTGaRwbqJlQ1MGXYdDtNPNE0
 VV9g==
X-Gm-Message-State: AOAM5301njE31Bcd38UCoKfNPGK5JYTNfyQUC4KQ+tePn2pwRZALP+mQ
 bwIF0JzZvsmU0LzFQjlRW+tymd7R5+R8Ug==
X-Google-Smtp-Source: ABdhPJzooIQPqUp4BAMWMSJrlSyEDXoHoqf7zkYUy1ztrkOXxne62hcZz4uUU1WlEbzv6gHTuRdCgw==
X-Received: by 2002:aa7:8a4d:: with SMTP id n13mr3342048pfa.143.1597441181486; 
 Fri, 14 Aug 2020 14:39:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q83sm10417249pfc.31.2020.08.14.14.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 14:39:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] target/arm: Implement an IMPDEF pauth algorithm
Date: Fri, 14 Aug 2020 14:39:35 -0700
Message-Id: <20200814213938.369628-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, drjones@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The architected pauth algorithm is quite slow without
hardware support, and boot times for kernels that enable
use of the feature have been significantly impacted.

Version 1 blurb at
  https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg02172.html
which contains larger study of the tradeoffs.

Version 2 changes:
  * Use boolean properties, for qmp_query_cpu_model_expansion (drjones).
  * Move XXH64 implementation to xxhash.h (ajb).
  * Include a small cleanup to parsing the "sve" property
    that I noticed along the way.

Version 3 changes:
  * Swap order of patches (drjones).
  * Add properties test case (drjones).


r~

Richard Henderson (3):
  target/arm: Implement an IMPDEF pauth algorithm
  target/arm: Add cpu properties to control pauth
  target/arm: Use object_property_add_bool for "sve" property

 include/qemu/xxhash.h          | 82 ++++++++++++++++++++++++++++++++++
 target/arm/cpu.h               | 25 +++++++++--
 target/arm/cpu.c               | 13 ++++++
 target/arm/cpu64.c             | 64 ++++++++++++++++++--------
 target/arm/monitor.c           |  1 +
 target/arm/pauth_helper.c      | 41 ++++++++++++++---
 tests/qtest/arm-cpu-features.c | 13 ++++++
 7 files changed, 212 insertions(+), 27 deletions(-)

-- 
2.25.1


