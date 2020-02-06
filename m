Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A178AC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DC321775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X03e9Yrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DC321775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl3q-0003zy-I6
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzN-00066M-En
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzM-00042x-Dz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:53 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzM-0003zG-6x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id u6so8237862wrt.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E1tpXHsNOMFCBxdlvbzgg+MYBNzwjBDboyeQBHHvZGM=;
 b=X03e9YrqTAPYxUiKW42wPsUzBqsGmw3nZnKORBmgEzr/aY6kNuxIb5KNdx81teMjvf
 BPfUbK07JtvPbqwJgM9J/k1DSu4/o7LhZYVIRmNYechWV/o46CqqtxwcrR+t6YBBqfv1
 NYILT2TPjDTg0xGToL1mpnuuomQoIHqHXTDSy9en35iLRgEDaLwj2TcDJ/95JrhZjEwQ
 EnGYcebb4DwF6HzVJ0SupnjUcd0ItNub7pzRJlKEI2ONv8yVADlpjw0wyUuwz36RBS0K
 cTXo7ajIUHXxmMd5+Bx7qV2AJtfp8y/zdedfQOAiFjUcovrW1uMi6iuwlJLf6q2+FcWr
 Kq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E1tpXHsNOMFCBxdlvbzgg+MYBNzwjBDboyeQBHHvZGM=;
 b=XNEz2TxAYMXlPZ5jHi/hqJ8zM5IuDU0G8SAXfzZJBLKKyM471caXvhK7yF5JKbi+Pj
 6aww5yDF/ugPIZLxDFRczvw9FZV7R6ZCPWLJUBnTPis6tLlB8nVb42NpTwzLHDQbU70W
 dIhuYEZWQnJZtbAzbryeE1T0Zx4ByAIBt6WINoJN4lEMmf8DoxUj6cwimbjtKWGgd3X4
 ebI91IIWrBffWniKxBZj66pNHmNbY0xASWh4vK7Vj8Hg/50YYDXoAk9R0WW3pP5M7WHC
 gmkC/wKi0XkJ4CZ2aIpTNSSCsl5i1aOvpqaj5s6FdZJIjpzc0rGxJweWbswOe77JDl6h
 v2ww==
X-Gm-Message-State: APjAAAUFnCpI0ZxNa1OqyuKS2ivrFy4qTBWmhkp9uSpIPWqjrxiZdUBC
 3i6O5sxxLmjS/BUtdmxPw1HYKhCB8Y0=
X-Google-Smtp-Source: APXvYqzG7nVuwzy1hpVPdEECk5+wQ6ZZ0wMa6QCswQQIDuuFeqxD+2g0wc7UMarnyBberhuG/lX3GQ==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr4731013wrw.373.1581010250763; 
 Thu, 06 Feb 2020 09:30:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:30:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/29] Makefile: Fix typo in dependency list for interop
 manpages
Date: Thu,  6 Feb 2020 17:30:14 +0000
Message-Id: <20200206173040.17337-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a typo in the dependency list for the manpages built from the
'interop' manual, which meant we were accidentally not including
the .hx file in the dependency list.

Fixes: e13c59fa4414215500e6
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 20bf0cc771a..274a24f7aa4 100644
--- a/Makefile
+++ b/Makefile
@@ -1052,7 +1052,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1 virtfs-proxy-helper.1,\
-       $(SRC_PATH/qemu-img-cmds.hx))
+       $(SRC_PATH)/qemu-img-cmds.hx)
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
-- 
2.20.1


