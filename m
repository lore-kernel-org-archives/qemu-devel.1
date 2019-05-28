Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91384C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DF020989
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPALOcul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DF020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60099 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYun-00072i-Oz
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:01:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkC-0006Jo-4v
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkB-0000Cm-8R
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYkB-00008t-1X
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h1so5331536wro.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=eOLgzCPVuK47NB48nwRoyyPbsLoU9UamcYj7EK9p+AQ=;
	b=gPALOculpv/YntpRqxs1XNvaDIpXen91zkXrRGNOvtdRe2TKkPY6QN0wv1AGB9nSNl
	1ZfZf6fLkrIiTOuDYRWYV6+ARAIeqM7JmDjbsJKf3k0ua9srVcdpzuHg8HBa/sJz35Rm
	DWic4T5mETU4NmB3JhAeFEpZddLakWqIZLHjb/7+VdtJhJNipNv0emTrBroCh5xG0Zgl
	m9+2RErRl56BOsCOrERgb/5jJm1p2luNepJp49wl0iFhOe4RQWC+fpccQ7yV+tBThqpz
	xfzeFowOgz9u5rfWn1/peftot5IjeS8JGlU6NDDeIyIK6iw7yfaEQYIyE95GuJMUVBPZ
	hgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eOLgzCPVuK47NB48nwRoyyPbsLoU9UamcYj7EK9p+AQ=;
	b=A2obSDZN3L8HYII+jgzRdKh0UJiGlQ3t+zJwxBUriVFLhEJG8TyuPy/oogwppby4ct
	bHYjK2VPgR9en81+igxem3pJlaBFUvuTOirGZfXZSGD9h4Vd8jEtR2OI62BNBVxpaorn
	QaUW5fOMHMyethM5lq18smRXjpTetRl5emFGliDGpFRpLyHhZ0Qmm7pQtky0SQ5GkPD5
	MAuyWo9UYNcwm/g4llgnh2EZrNB7B0/TwE3oPaYlFWW+BaAyb3hljQpQcKWkeec4s4FR
	zINv3QgoqqO07a1pcR9ax/CtfkShZwKFlu5WM+1yU7wWFExo8HTkROUc6N87TxnsTf8M
	BJ0w==
X-Gm-Message-State: APjAAAULlL7AKvtAWrDiNyFHRnuaGTNpfbXo0fl74mh6UEjrCMLblUxC
	bRaWg7vFL4Qko28oeOTnTUlGQA==
X-Google-Smtp-Source: APXvYqzve/FOgudhC9XModt6CnmvAFwb3L5Ub/00IKwAEDR7r5L8CtZT/KCZawZFP0temRa+vMQYQA==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr7658418wrn.165.1559037002960; 
	Tue, 28 May 2019 02:50:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d11sm12704447wrv.72.2019.05.28.02.49.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:57 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6D5611FF9A;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:36 +0100
Message-Id: <20190528094953.14898-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 11/28] MAINTAINERS: update for semihostings new
 home
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seeing as I touched it I should at least keep an eye on it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cacd751bf3..cc1178fe692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2562,6 +2562,13 @@ F: docs/pvrdma.txt
 F: contrib/rdmacm-mux/*
 F: qapi/rdma.json
 
+Semihosting
+M: Alex Bennée <alex.bennee@linaro.org>
+L: qemu-devel@nongnu.org
+S: Maintained
+F: hw/semihosting/
+F: include/hw/semihosting/
+
 Build and test automation
 -------------------------
 Build and test automation
-- 
2.20.1


