Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA4EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670F520684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXDD8Ml1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670F520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYo7a-0002UZ-MC
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 04:51:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYnyl-0003Zd-RG
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYnlq-0000lE-68
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:29:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYnln-0000Y7-39
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:29:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so1415398wrm.8
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=MVxKLXvv3XKjmXllNopXwy6owIzV+D4TJIoeCStLTxM=;
	b=tXDD8Ml1nxNYVKfT3y2XyClwlG3zQNwov/UUmmuKB58WtNGRPHI0hVI7tyi1/8urU5
	vtU2VVKuuEzhSzMrqda1ij9g6BUoQDav1TUOD66cojHW4CiJ4xjAW5pnjI4dl5FyBOBx
	BEocfEXpOxziK3NCVL9RLCI1MCrFDgkJlVr3EwQ8fevTylpc3JphKhRLxOmKawWMgqFh
	zv7egdGBFbDJA04c5oVeMkOAB+lyLD4byqJt3xIj05WFd/GRU4jeDbA6dGbi2KBFoPwU
	pt53y9CVrrJ6q1Fvc83K6APLNN9CbR8yc7dPKdEUaoasNPeUtiZ1BrqbYkO5Fae6jFmm
	ZFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=MVxKLXvv3XKjmXllNopXwy6owIzV+D4TJIoeCStLTxM=;
	b=aFh3SP9rL8yFn98ysP4NlbUtsVvP7vQ8egEZlhgC/eAmS1C2bDQfavQ94pmgGwto88
	je5Z472gHOOVRdfxEuwIu0NXH9sYBm+jget0oc6obv1TMd+5WM2eJXu0NE8f7KYBwItr
	AD8caGkStDD3JtkTJP5/l2EVsWuNNmuSPTVilYkvGfWQwFIHmwaF912UnDplEdQU4PzU
	vNixrwDP3GO7f8Z+GVdI9edkJtf8nQC2/fzyjxAvkSy5S9OLbbYWQMHI+dNvkQy/LJP4
	PMk7OUgd7AdaNjieknz8OtttvhRcHo2ca8+egmFrWOoP+SU1BZ+0OfxAg7NGMm5YdB69
	UgSg==
X-Gm-Message-State: APjAAAWGsQXIXpTLbjjn3qtnoACQtLqbnLSRQvgvn8Fw6ngBvlW0VgjN
	2TAiQWpdxQeowZYP3epm+syN7g==
X-Google-Smtp-Source: APXvYqz+pwNszU9GWPToNpu4l8IXf5+Afw/LaospTeJa8aGxP1r4xOpgL3n00Z0lbVuhvz7yfQqg4Q==
X-Received: by 2002:a05:6000:148:: with SMTP id
	r8mr14988744wrx.210.1559809746485; 
	Thu, 06 Jun 2019 01:29:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f3sm1065155wre.93.2019.06.06.01.29.05
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 06 Jun 2019 01:29:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 20E721FF87;
	Thu,  6 Jun 2019 09:29:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 09:29:00 +0100
Message-Id: <20190606082900.6330-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH] MAINTAINERS: put myself forward for gdbstub
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As I've been reviewing a lot of this recently and I'm going to put
together a pull request I'd better keep an eye on it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a96829ea83..8ef34cf1ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,7 +1872,8 @@ F: util/error.c
 F: util/qemu-error.c
 
 GDB stub
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
 F: gdbstub*
 F: gdb-xml/
 
-- 
2.20.1


