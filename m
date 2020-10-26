Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50688C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74F8207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCXmF8Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74F8207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXC27-0002xP-Sg
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwa-0003Jd-RV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:39284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwV-0000M4-L5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:26 -0400
Received: by mail-ej1-x631.google.com with SMTP id bn26so199882ejb.6
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W3Vv/QCWXUFg/foUe4To3UqDPWKAHvwPLF8rKVguBJk=;
 b=fCXmF8FbDBx/SIXLzr9WdkSYJwYMIY27zgNwbRw76qP71b6mwta7DeMxs1l1QjgtWi
 kSqYM2FCYTySMzjjU/gDQPafT5NySt+MnXK9OfQWhOpqdAmGaGkqrkSwjtmPlywIDCJd
 7bDXDW3XNEsf4KgqbvKMT2eBsROMVze9fqnw1M4U4d3PBSvzRViVrtniRwBbtSh6MdoG
 vMpDGvneGZt2LioQEGXlPCGhjThYKGhLI5ORB/zgXISx6tsAhAKxY5GHOjaHDl7T9LtG
 68zf+vSvi8H09IzkZe9QXoLuvjm2cpxSOG6iSssQS+FZfWamdwGO0iTZ4qTu3I/9EzkL
 SP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W3Vv/QCWXUFg/foUe4To3UqDPWKAHvwPLF8rKVguBJk=;
 b=g9m7+S96Y3kVo7VVy4YAJ1ZHISRErRO4bZw7JjNrQ3bg7XHELEYVljG5xBYxN7G74U
 nDbnFLrHDK1aXpOQIijTvwj7lgz/RmIZK/e6BoC3BudL+/fdRMD/heL6rUfdKxt7pZzL
 d6v7ptGuBrUTRlurYqm5T8kqmadcrFJ2zuCf1b//PDp6CIRBIQRVsIN6PjzF3B47khP1
 0V/CKD5p1Y8fnFSOqu6mHXsK0FcSob2VABhF83LXQQbNI0sZU2oBRxYff+0kUhQVRPAL
 S2IZMyv7q0lSM4sSzkyFESGK+QIJRD7uDUgHm1ee87qK840XFAybhYpVutUe4nINWbbu
 N7EA==
X-Gm-Message-State: AOAM531cf//dLtxQLpH9l2BIC9rMCRt5a3KCnPrum5DXzP3GVRjv5iSa
 cXCkqHSGndeCobg/H7v00pHg2No0MNE=
X-Google-Smtp-Source: ABdhPJzAvg8E4+MptrAi3QV3nzihfSdPJcEzv7+ee50wxEtscV190cgXAxvcNu8UjBkmvpHhuMtpjQ==
X-Received: by 2002:a17:906:3406:: with SMTP id
 c6mr17140314ejb.65.1603755021949; 
 Mon, 26 Oct 2020 16:30:21 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t15sm5948010edr.27.2020.10.26.16.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:30:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] target/rx: Fix Lesser GPL version number
Date: Tue, 27 Oct 2020 00:29:35 +0100
Message-Id: <20201026232935.92777-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chetan Pant <chetan4windows@gmail.com>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201023123840.19988-1-chetan4windows@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/insns.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 232a61fc8ed..ca9334b37af 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.26.2


