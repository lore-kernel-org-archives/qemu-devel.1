Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD5DC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BD020757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8z4gUCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BD020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU39e-0005N7-Mk
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38h-0004Cx-0I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38R-0001jS-CI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:57:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38Q-0001ig-Vy; Thu, 30 Apr 2020 02:57:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id x17so5435103wrt.5;
 Wed, 29 Apr 2020 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nqIDLimm6YCRzjrPX1mBGe1chKWTd08ik4rVUOYbyhE=;
 b=G8z4gUCWoJHPrTl6VQSzaOllVAZVJknm+KBddI2IuxrlnGb6bCk7Ced6cTvFXBLFLX
 oZpAIcxSbb2Qnzjuj1pvdFJvmlp9IL7YgtTdVlvzZf/a+G27abKLzT7GK68VK7n70V28
 MmNC9ts4LqK9/Npzf3HYM+vxlasDLr9xZYmeT/+h99eugDH20CxnfijQ4sQeyu4WugHq
 j/fDVpAmVJ8bR+wBEQai+561kcBQ0Yb/ckp4CTW7nc/PJJR0bOXpweCpCsQDGHyySMec
 vC0CITORShKujr+MfTLUePyh7UAm9OrfrhYHAoSSrOLybi6abgYDy+W1jyb6KD25Y0Ww
 3a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nqIDLimm6YCRzjrPX1mBGe1chKWTd08ik4rVUOYbyhE=;
 b=cCJ5JLKZ01QeI24XVwgE862mslLh1GboL3Q1bvgNr6ROAehSojorg/xmkyeme16zRq
 FN02+O7TSRnu536dyXh83GtKWXkVcgUM3ejsIxJikQ3hxH4D+j+rm9W3nq/uycHIRSCe
 fJG/zGUZUfA3jGllHTGfV3jz/LFwUufqkTLyUeJGrDmhmP6YQiYixcssHNJN5QcSkLsc
 V0M/NrJe/HUmC/h6Vcovntyijewu4iKMRGGNc8ZqwXSK7DCgcHY6nVVUTOy6PXZs8TTz
 tuokLT/Rf6bfnusQMW4HaxwZehVNTa4zZ/Zq46KI6QIZsgyh1aQAPL2EE6hDe4lGaXHW
 7APw==
X-Gm-Message-State: AGi0PubCYqn+4o5U3sPGuqoV6ptsSJjR8lq7GTj4D9BxwJQqvPuSp1v+
 KHtfJ95E9H4KIyfUV+O1LkdkIKRFSFg=
X-Google-Smtp-Source: APiQypIFlKlYH544t4C5FDo1lPq6dTgliJEpOU2bxg+RPb5UKrUkUKPK1L32tKtLnm/2Q9hptg9ydQ==
X-Received: by 2002:adf:f748:: with SMTP id z8mr2010110wrp.45.1588229845066;
 Wed, 29 Apr 2020 23:57:25 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id k184sm11139730wmf.9.2020.04.29.23.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 23:57:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] MAINTAINERS: Cover the GDB Python scripts in the
 gdbstub section
Date: Thu, 30 Apr 2020 08:57:18 +0200
Message-Id: <20200430065720.10763-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200430065720.10763-1-f4bug@amsat.org>
References: <20200430065720.10763-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep an eye on these "same same, but different" files.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..7a7f2b9c31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2083,6 +2083,7 @@ R: Philippe Mathieu-Daudé <philmd@redhat.com>
 S: Maintained
 F: gdbstub*
 F: gdb-xml/
+F: scripts/qemugdb/
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.21.1


