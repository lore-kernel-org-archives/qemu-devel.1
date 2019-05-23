Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F10C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A5A21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwkjGBT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A5A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl3D-0004OL-Uo
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:34:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvA-0005gI-Ko
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkv4-0001Br-8d
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv0-0000wY-JH
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so1126305wma.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VHL/eH+WA1PJ4T5TasKMlaKBAQV31B2TXqjsSLGyJaY=;
	b=NwkjGBT8bp+Ve9YOqOitp3MeeUi5QKJyXvejYpvbioHd7YwusaILrEorFCVAPRLQ6M
	pnxohw4Wtzi1I85XTA06jBOnKs2x67sPBsO0N/3EX6N1t2Iosl4ZkJxPU1axJOQpaZs4
	2zrHD9QRDuOBY7Z8U1Cfs+rkEDPECPi7tWTkS3lnqls6cPK2EAzrOJXwjWeoEEtjldC6
	sjew6Ces2RNkpAl60UZz/JjrIpDLiSq6qGNf5quTHiTNj2p6SgyLf9/NaB0zZeZmVyC2
	rn3qP7rmzIA4EVCTYOkw63dAht4S5ATADAtxry5QuO0hPIgvKdG7Kct20x/xw5YtGe53
	kyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VHL/eH+WA1PJ4T5TasKMlaKBAQV31B2TXqjsSLGyJaY=;
	b=Fd2aLpGnwq3g0lmj9hR3Zxma61t/rzw7eZYTNZw0fkmhO78mcMvJaugdkQGcomO84b
	RImfqDaXGBFJwVMQamCygpYdSyFJBgc/52xbllr+jDDaVTcmpE7JV7ZMdNZtX/FqJbk1
	61sRY1KhbmIwF8jRUrM+/0l7ShLLEPcvOmuD7KsU1V9aJZVyb+BOMRnwVgGWgU3T0iIq
	g3tR1sFSBbcYubx5+2OE5G4y8tIqI/EJa/2idHODr19ZuWVjDRomkdZwgeD3bsZJn/5h
	5GL27boF2p3eLN701qBC9csu1D4w6i9KG5zIVrPvGcntTGm2EBG1scOYU9txH+N/59vB
	ZShQ==
X-Gm-Message-State: APjAAAUyTUT2PUUnlzk4lzPTJo6CVveyv4Pc/QYNgXLNAHus6tLKiKzz
	0jiBXfi2rLLRsR8I82+ALTt11Q==
X-Google-Smtp-Source: APXvYqz7QpLbMCbSXDl5hrbY0Yej61fFhCVC7W3FescAIaLrOywmyDU6lG7aVwdXk2cm0C8+Y5C09A==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr11837752wmh.132.1558607140227;
	Thu, 23 May 2019 03:25:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z13sm23588885wrw.42.2019.05.23.03.25.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 71A1A1FF9A;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:15 +0100
Message-Id: <20190523102532.10486-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 11/28] MAINTAINERS: update for semihostings
 new home
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
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seeing as I touched it I should at least keep an eye on it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6948ebc63b..c4f209898a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2560,6 +2560,13 @@ F: docs/pvrdma.txt
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


