Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87446C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492E72085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7EqRFqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492E72085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZxE-0007wb-ID
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:07:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZqE-0002gB-E6
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZqD-00065u-Gp
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:59:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZqD-00065P-AT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:59:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id e15so7433132wrs.4
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Sllw1VUnenUpn8foyb+omUx4/xqmAm1WWWMjnAQGm+o=;
	b=j7EqRFqDBdumU8BKx8cZiiwsoTgIF+oRxgknzCAYsWJfPB+vg35Bh5P9i9EDWAq1RV
	nzVphwC2rj63evzqjGC0DvVlgtCe+EOyorFJ1ZehoebCuKFm33P3aXWG4/TJeNpD0Y+1
	Q2dCw3T0Z+Lace/M577r3XVs+2iK8sH+SUd9HIc5MMe06Bbg4M6c2jlQh3YUa3kRbIZd
	danVeJuhWKGAixcEuzjkk0FjXtye9DUz8EO2DXh3sCyjJFKfpPJXTUhmBclw0XqnWARc
	Vx/z5Qzyr4HymY5SJqZNb8x0KSGwBG7DbIe0g7jTZ87JyPjKyeY5XTxV4WW3/SoKZEOX
	ehbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Sllw1VUnenUpn8foyb+omUx4/xqmAm1WWWMjnAQGm+o=;
	b=W+gSHxa8H18WwyM/BjRSDmNxptlYlX/U+LmstW1w7/gJamWp5xUK2BIMm3NsObuQ9t
	BS8GSHePhYsfHJaP1IPy8Z0SR46GqKcBs/xRb1tHTobOzMFmgSl2Vuuh+yIbxZC3WNRd
	Y8d/F2KMFYR4m32dtKya2flNxV5h7XotlKoD9xdnpkjMIonS0/AxMkqMJe3o2fPGPeRS
	bh9S/Y+Gb6qJmbxCGRsqPJcgucK9f2jH4Jq04h+LQ0D6UsDDRu16KERTQO48fFJUJLIq
	yCu+OTU2zrNCIWvZwKrZ9dJ3ozDups9cMEHxoc1Sios4Tk+awGSPB9nWX2oDzjtT4/Hj
	M8aw==
X-Gm-Message-State: APjAAAW/NDtzPbSekAy5SDaAw7Q+dCqWnJumNIJS5w9bEMVWXJQyDDtd
	tCP6DaWOu5CX9WtBOePdkf7c4w==
X-Google-Smtp-Source: APXvYqzmpX5EAEjWdjH5CWwXqYDm8LjKdXjQ6WA8cCWQcizF6oQQINtrI8lI2sb818pzEmRQHOGeTA==
X-Received: by 2002:adf:afcd:: with SMTP id y13mr21262936wrd.270.1557849584105;
	Tue, 14 May 2019 08:59:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 6sm18365980wrd.51.2019.05.14.08.59.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 14 May 2019 08:59:43 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 029091FF9A;
	Tue, 14 May 2019 16:53:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:53:01 +0100
Message-Id: <20190514155301.16123-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [RFC PATCH 11/11] MAINTAINERS: update for semihostings
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
Cc: qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seeing as I touched it I should at least keep an eye on it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a73a61a5465..e9050beb222 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2559,6 +2559,13 @@ F: docs/pvrdma.txt
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


