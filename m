Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC3EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDB5206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rm9avP8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDB5206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqbA-0003ta-El
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8K-0002Zu-EB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8I-0007aH-FE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so18878551wrp.8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qUjmc9Cv5nZ2tZDUd3kTmt0wAg+RDP5BIX08BU1qjCE=;
 b=Rm9avP8yHqPg05x9/ubTReVk5gvlofqHg5XimdKrOF+jCUvuUHk/zUsvH2m2RrACje
 0n5f/FbLggrCgbX8H1Ib9yhGuLihmAmwFojgNJytQFOeCrbqWnBl3Iso0nKtmOGY3Cj0
 WjYxly4Ko1rdMPZXZacqjJpL5VamvivB5vRRcAVLBPqiBc2BbRIplaUPgGe5IXJVnO+i
 RbW+x1T3ba/1vmdX0sNS5v5pAAwbleeDkTYHw62BNPN2dLjO4qFyNp/8/93tzB6NbQ/J
 t0gR9GnLRXVvPGPGwVdhE9xd94UQbPKep0Y1lS5aDE+opWhxpa3FVc1r98rxlZLDbpJT
 oW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qUjmc9Cv5nZ2tZDUd3kTmt0wAg+RDP5BIX08BU1qjCE=;
 b=d1vq5ZY6UqTTFhuZe/azRKLTNYc22LcMN6xlqrclV/2WrvJbNao7phDxAFIyJR5+65
 EPUO4KRcZBRrFQbsCXqxFUn6frBkGZ+tchC8LYNzxACI6mCEyoZfK/PzHRp9rQWwDe/E
 NKSjrWL+r9naw41x14Hc5f3rNdn04hLoK11xCJHxxQ4kh4kcMjOJPdu2j7IqJ3pK4HWF
 OfQXht3H3OXXZfRBfVNYargAFj7eHGRD8zbd/Z2rtZGI43vgftzk23YH/MXj4ixBbSTh
 1Yc8cT1wsk+wXXkcscOKk+ClufYpubCa0TtOhEjf/o5qEkGYDt782tn+hqJ9lq3SRhGm
 gfDA==
X-Gm-Message-State: AOAM532IvHqIUv0qve5igFFz1gTisYvjREXqdgdPJANqFST1113V5Zh0
 TXfNR9EMv1OURQOUNOzkdZRDPU4g0PEwHUvS
X-Google-Smtp-Source: ABdhPJxm+IgxDm9ahSxkdnYtNcOhWU733UnfT/1EeJwkMh8k5zsFkUQ+xp2jvhXqOz8nSxO+yesxhA==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr17340082wrm.0.1600092420568; 
 Mon, 14 Sep 2020 07:07:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/36] Deprecate Unicore32 port
Date: Mon, 14 Sep 2020 15:06:20 +0100
Message-Id: <20200914140641.21369-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate our Unicore32 target support:
 * the Linux kernel dropped support for unicore32 in commit
   05119217a9bd199c for its 5.9 release (with rationale in the
   cover letter: https://lkml.org/lkml/2020/8/3/232 )
 * there is apparently no upstream toolchain that can create unicore32
   binaries
 * the maintainer doesn't seem to have made any contributions to
   QEMU since the port first landed in 2012
 * nobody else seems to have made changes to the unicore code except
   for generic cleanups either

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20200825172719.19422-1-peter.maydell@linaro.org
---
 docs/system/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index b633fb3ef05..3f8a00e9095 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -408,6 +408,14 @@ The above, converted to the current supported format::
 linux-user mode CPUs
 --------------------
 
+``unicore32`` CPUs (since 5.2.0)
+''''''''''''''''''''''''''''''''
+
+The ``unicore32`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. Support for this CPU was removed from the
+upstream Linux kernel, and there is no available upstream toolchain
+to build binaries for it.
+
 ``tilegx`` CPUs (since 5.1.0)
 '''''''''''''''''''''''''''''
 
-- 
2.20.1


