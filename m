Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97190C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CFC20848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6Y0QJQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CFC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Qrf-0007np-H1
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqm-0006zX-Lq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqk-0000HV-Hw
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:33528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqk-0000Cs-9F
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:01:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id a25so4353997wmm.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BGRHjAUypumnFL1eJKQfDSrUM7lP7pKJ1hNyJQydohM=;
 b=O6Y0QJQ/prGVd3+be7zWcaFVJGx0oaozYmOYx/gIPsFvMTGhHHa5gg3QQyLFEDoX4w
 DqfnfzhZ0dJaXDHVxtXDwwEAG/0Ee+LWYczV24aUk4lxi3FYUKeVtxE2qA66+zC3nUNr
 pl7gCYsho7iTc3cP2kJxOhzgNr+4oP7yt69CWzaY0PKJK5zJHMyzSC/qmgE40Py5Z6ul
 auVEq9fj8KWTrDw93BX23s8+Wwe3H/Ntf9CJdc6qWD9zeMsCzJPkzMX5v3+K6whAgWZu
 5YG1rYReuirTYZwFahVka5GfXh8cs5z9oTxe6OLcoX0m3XeLTPYQK1PylEZ8GixAWf8a
 s5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BGRHjAUypumnFL1eJKQfDSrUM7lP7pKJ1hNyJQydohM=;
 b=pLfLkyu2b+aBWW1JRhhQdOw4Sl4Z/jwzUSXJ0SU/NL2+FE2/hM80BxQP21PShjH3nb
 Ay0jxkuDpN7aHhGnKvL9/BbP6I22CJygpUDUjLJLmlh7GsbgRXCdqmT8eZmKead/N0vX
 f533GgzyHp6uM4RcOVWd7S1vrd+3TOFiECS0wHnyLAhssAJ3UspNoMvU5E5znqEwcrXa
 k7sxjdkuwr9/4bLvKIM8ATuD9+Jdbo+JZTcJfEJE0o8lM138LNKsYjRtKc77DZbdvZyC
 +Xep9NcbnLwsp3/taDBKUjwWvJrJKLt6vmh09+/4OZ2h5dTiGcPXa3rYL/TTQpT9b2kO
 IwZg==
X-Gm-Message-State: ANhLgQ0EC71PQPZxq6lzeLnRyrbdeuEUITVUMxNP941O/K93Cddx470g
 F8pY5yasQtv1rvzZC3w2LbwNGQ==
X-Google-Smtp-Source: ADFU+vvdE+o6GuyZah5BbifV5KRm8pmEpFgMGVwjS9f/ZKAvu6cR8ZzJO3BD5hZukL9oql66PF7bmQ==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr2861694wmg.146.1583316116987; 
 Wed, 04 Mar 2020 02:01:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p15sm3233657wma.40.2020.03.04.02.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:01:55 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 034CE1FF8C;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/9] tests/vm: use $(PYTHON) consistently
Date: Wed,  4 Mar 2020 10:01:46 +0000
Message-Id: <20200304100154.14822-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
consistent with other cases like vm-build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219163537.22098-2-robert.foley@linaro.org>
Message-Id: <20200303150622.20133-2-alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 9e7c46a4735..778e5067554 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 
 vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		--image "$<" \
 		--interactive \
-- 
2.20.1


