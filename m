Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F271C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D932465D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncgrbPZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D932465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05L4-00078E-3T
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j058L-0000zO-VN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j058H-0003yA-0P
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j058G-0003tK-Pp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id t3so3050146wru.7
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/ZswA9Otu9vtfPLtWP689YkHSf+JvE188+hies8lU5M=;
 b=ncgrbPZhSiBQ/R5Vkz0ucSHt+Y6ZL1DKItYxxKSCAY1OrG7J9mSyFjzO6CLX/7hagI
 f+9tyPzRLU0pHlBuFLMlRa0E7/tD9RyRQZ8WK2+EZiU/GPJ70jbBJSJz3ZD79TcwvVgI
 I5LNMRXIOi9C44YyNDnZhrxo7ZaBDZtKR47dXRBJzNVDQcY7u5aCWiD1ft5maLVRwL/3
 dI8UHnl7YimIhYMjvrEi7Foeli7NCsdjRAclY+UlKzlAMYStTwFbz5dwCm2RIuEx3/h6
 NnHXifni6JuBfLhb/is3SBSc54N7R1Ib1tEx4R+9PluCt8Zp2NHXf6NzORnz35UlsO/U
 A7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/ZswA9Otu9vtfPLtWP689YkHSf+JvE188+hies8lU5M=;
 b=DHYSXQVZ/mHzrhTza4LHhQN55fS5CDGwUhhYDAokBwMHx62pi5Uou9tOvkM2SYcrBi
 2nx2hY4YazGdSe5PlGD2MJEPbZgf5eFwP7/M0YDy9CYaKUSJmchukrhb1AJW0CkgQN49
 yzVdPpgIeAV9eKh7+4xlOVjIHUSW6rJt+iBJtFO9xcMWzpFa7NAMih0tXu7iTuoYHc6D
 JG75EvtjqRCSaA+5gkB/0AGTfkgWhM8JHKcQEsP7mnrSn4A2JK9zCD2fCOnHq0EwKrhW
 0h982SwgeCHwFIn8eX/cbC1EL1DTAbJYP0h1Lqo4hXas81Iqa8z3j+CROEnIKWO/4vJH
 EepQ==
X-Gm-Message-State: APjAAAUebOudGfMLhBKVJUJskuT7CJaultjAW/mjHP36V9lEKWbUEi77
 Ru2Al020KkwU3h4L7Oy6zl3dTQ==
X-Google-Smtp-Source: APXvYqylIFZGgwj+7zbjjqupasm0ZNmyYEAz1rz1jBFm7MYoxN9PeEmV2jGByB76xkBD5zh0K8ji0Q==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr4958979wrq.93.1581087682781; 
 Fri, 07 Feb 2020 07:01:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r14sm3595073wrj.26.2020.02.07.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:01:19 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 033271FF8C;
 Fri,  7 Feb 2020 15:01:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/5] docs/devel: document query handle lifetimes
Date: Fri,  7 Feb 2020 15:01:14 +0000
Message-Id: <20200207150118.23007-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207150118.23007-1-alex.bennee@linaro.org>
References: <20200207150118.23007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I forgot to document the lifetime of handles in the developer
documentation. Do so now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/tcg-plugins.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 718eef00f22..a05990906cc 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -51,8 +51,17 @@ about how QEMU's translation works to the plugins. While there are
 conceptions such as translation time and translation blocks the
 details are opaque to plugins. The plugin is able to query select
 details of instructions and system configuration only through the
-exported *qemu_plugin* functions. The types used to describe
-instructions and events are opaque to the plugins themselves.
+exported *qemu_plugin* functions.
+
+Query Handle Lifetime
+---------------------
+
+Each callback provides an opaque anonymous information handle which
+can usually be further queried to find out information about a
+translation, instruction or operation. The handles themselves are only
+valid during the lifetime of the callback so it is important that any
+information that is needed is extracted during the callback and saved
+by the plugin.
 
 Usage
 =====
-- 
2.20.1


