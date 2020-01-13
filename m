Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22DC33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225DE2081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXw94Lp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225DE2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqx5P-0000Rs-8A
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 05:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iqx4l-00080T-69
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iqx4j-00008V-Iv
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:36:02 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iqx4j-00006q-Av
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:36:01 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so9015779wmf.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 02:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KvwlEriwCS4WKo1aBJVweTtOEMd67yx3axHOa2dEAWg=;
 b=tXw94Lp0smHY/YMRA5gZlobVVDpXosuPHn0qzjqbUNqbSoDZQk19GGpxdtRbdudQXy
 MM52WCsYeskR5VxkJ34prDM+NMsgnQUC6c5f///pG7NWrMipK+3PdV8R8e6B7LZpAzx6
 oGxEp8pzhlYP3WtTvhdh8wEZcaXJAI9H75AaNMFMaSFe+PoHW1mz8LPZjrEDY02KHySN
 yLoT9r2v9DZoDane2ocEs4UM65FHeuXQGHrBfWy7w7y4ByNWRzXcy/7FuVu/LmJId5ED
 FdIozh5XCFCq93ND2TadpQyAv6+DpAXu0LZZ108NBWp/+KupXH4SEENbNB7lHrzTwQyO
 FgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KvwlEriwCS4WKo1aBJVweTtOEMd67yx3axHOa2dEAWg=;
 b=k9IAgMk3nkYaQSW4Js/6kBjOUxH+gRNaij62ooC5PR/SXiGQgyjCv4xtyqpNAsrYf4
 28v97bVz/EnOYWtxZ/6MovMuXDMBzMDDeWhQb5hB2MlP9k6pFlNPm6PHFddyLSD/bL4/
 0KyqEjqI6bHfJYk1CAIXMCzALynKyjQddl8Wzbmu3xzzKKygNVCHX1e3htdTlXdQz5HU
 M+Wp9EJxIyYm5UonUMwLRJnS3hscetSpDiM7A80kMgDO9uPThIhC0qVVLv9/gjVznF4i
 wI0Fkyrx9h6QJSJ94IwMiDmA+iuDiv0eAO5Y4bRpI+Wn+xwIMc+rBuZvZAJ3gIS+a0iI
 ud1Q==
X-Gm-Message-State: APjAAAUxK/U3AXcaUdCWUnj4VfXSR4/+RGwk6lybHc2KZ/dwxdkGRDJL
 OIjhJxp1yiB/bR3yPHuUGxExbA==
X-Google-Smtp-Source: APXvYqyLeU6VPFLN65qMVYaXmIqDRVZ4Sp1+71v4TLxxGxD/6bHZyieMp4A3F6iB4JTluEswBuKo/g==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr18807239wml.173.1578911759563; 
 Mon, 13 Jan 2020 02:35:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm15054788wrn.33.2020.01.13.02.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 02:35:58 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF95D1FF87;
 Mon, 13 Jan 2020 10:35:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] documentation: update links to readthedocs
Date: Mon, 13 Jan 2020 10:35:50 +0000
Message-Id: <20200113103550.1133-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: pbonzini@redhat.com, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

..and extemporise a little about their state.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 documentation.md | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/documentation.md b/documentation.md
index f4ef9f4..55d5db6 100644
--- a/documentation.md
+++ b/documentation.md
@@ -3,9 +3,12 @@ title: QEMU documentation
 permalink: /documentation/
 ---
 
-The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be read online, courtesy of Stefan Weil.
-More documentation is found in the <a href="https://git.qemu.org/?p=qemu.git;a=tree;f=docs;hb=master">`docs`</a>
-directory of the QEMU git tree.
+The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be
+read online, courtesy of Stefan Weil. There is a partial set of
+[developer documentation](https://qemu.readthedocs.io/en/latest/)
+which is generated from the QEMU git tree. The process of converting
+the rest of the [`docs`](https://git.qemu.org/?p=qemu.git;a=tree;f=docs;hb=master)
+directory is ongoing.
 
 The [QEMU wiki](https://wiki.qemu.org) contains more
 [user documentation](https://wiki.qemu.org/Category:User_documentation) and
-- 
2.20.1


