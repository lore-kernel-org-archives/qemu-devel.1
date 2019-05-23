Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB353C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AE320851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLgUC8sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AE320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlDN-00050G-Nc
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:44:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2i-0004LT-Rs
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2g-0006Zj-Vn
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:48 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTl2g-0006Y2-OJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id j187so5221950wmj.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Cq0hWZXgOdvqzfyTAW4dZk0efyH3GC8saHgcK0H4+rE=;
	b=bLgUC8svY8IwS/zqbOPvYZDuiE/6OwIvaoMD/hI9dV/k6Tp4oZNNd7HebstmTT/Qt1
	dHIMH5wKVkHZXy7CYvJbBsrVeHLykfoPGwasCl6vfe8qnp/+yx16q3yptdmrSJE+ADDd
	6uvfLwwXD6Ubfqb6MWa62/Sv0hnuyc2inPGfYy7Xnp2IGVfY8cvP6kKAHL1aznUc8/Ci
	XchtDej7u3yq/sqJiFg6+TrGej1jbLBQzXO6ssg4EjLwHMgN+edT2No9W7jIyDQuzCkg
	yqeQMWKIM5m/DsMyDRgIRAUm4DW7uGPPiVu6f9TDyVoOIDAHiNxS15o3+m1oaoWc9RYc
	Tc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Cq0hWZXgOdvqzfyTAW4dZk0efyH3GC8saHgcK0H4+rE=;
	b=kFLRuAm7tVHOXSVG2nhM9Tr65ALeTk3IQjQ8nUf+xc5lPS6LsL14nXhGs3Pa+fItJ7
	J4pjxtkue7BpTVFI0IGAgG+PLseNlHVlHNEEtaUzFW8P8y3cG4ZhnP2mWw9nG44y146o
	QXG+bfXrQXn/VTWCAEdbQdsSY2XG7P3eD2QLCzWiSecht4CLqzjr8PO9giZKwNoSXtWD
	PzfUArbDDqWZack/iLNjPA3xXKsLrRj9/e5ZCH4FF5htZlSIYOPb3lZLwZ23v0YQDmrO
	v21b3SEsI0L6LguLn2hE8fNGZI8rIcDqMzBZjgrJnyzGm8aCathOLxy8ojLZEG2biiY4
	G4ng==
X-Gm-Message-State: APjAAAU2fjvuwO4IU7gmFMh3lpPXifBk4ZSHwvbq0TqJk8qctdX3hbjU
	PsbCTEPt4WcpbByJu02Nmrv4gQ==
X-Google-Smtp-Source: APXvYqwRlYGdVVeSdJ/AOsa6IqhSoaIIq1NE5Y2b+R40z5lrIzTMzaPlNMTOJdM4lwWQq1rAlKcIzQ==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr10591112wmg.30.1558607623046; 
	Thu, 23 May 2019 03:33:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	f11sm25065583wrv.93.2019.05.23.03.33.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:33:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0AEDE1FFA3;
	Thu, 23 May 2019 11:25:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:22 +0100
Message-Id: <20190523102532.10486-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 18/28] tests/tcg/multiarch: move the system
 memory test
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing inherently architecture specific about the memory
test although we may have to manage different restrictions of
unaligned access across architectures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/{i386 => multiarch}/system/memory.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/{i386 => multiarch}/system/memory.c (100%)

diff --git a/tests/tcg/i386/system/memory.c b/tests/tcg/multiarch/system/memory.c
similarity index 100%
rename from tests/tcg/i386/system/memory.c
rename to tests/tcg/multiarch/system/memory.c
-- 
2.20.1


