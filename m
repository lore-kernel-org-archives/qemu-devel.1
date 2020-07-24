Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3BDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD01520714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4Jz8v2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD01520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrZ3-0006lB-QZ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSS-0004I0-Gw
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSO-0000LG-LC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id r2so2165304wrs.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bBHLOf2caPKPYUmFKO5eX0gKvXVT+aR9KRaX+uIZvh0=;
 b=m4Jz8v2lJggWycIJbEITQmGAIvP6WoXc1zQwbGFwbp/PrTW8Xt87tPWRczqgEhVPOq
 X57w9FsDEOkxtfjgAZ/Kh3q7QAvccqA9CKmwY6mweKO2Qjradqcu4Xbp89yDLfd5Fala
 m9oUprl1MBGXppzURqtoBdHGXHfp/0bppQtLNZsjbESmW2umhd8RVqvqp+yifoih2sXw
 kfqZtejQvDFajwVAE/8b2DIpjKANOrAX+UKXS2ssJL2+/PtBFAEdUtYC721EhtHRNZM6
 rDZ1rP+ObKeAm05mLXZ1FiemvzqWpoeo1pVYCmzwsNJManTzKksbVbKBX9/eQti9/hV0
 tMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bBHLOf2caPKPYUmFKO5eX0gKvXVT+aR9KRaX+uIZvh0=;
 b=NOpQDekBS/kuI4qhAoS6iaGx8kIJ5hO9iILYGiunffKYTXpMqtyi9FnVJGkwSV1Xi8
 n00zlkIo66kE5TT28SpqfTZiduRQ5GpdxgJotjnb2u6UfsHcVN8Fk42awKdApeRe0rVf
 tY+rcaJwWiT3lar96Eso0+DzORxPJuLXdrCvK5+tivOPa2biOFOYkG1nyvhGLd5hMRdO
 5fz90W/7Hp0+r0QM3izOYUNkYfSionwwR+zSpL5m5xkGQ64wip/cPO1MZQXeUp10oIPt
 wdMqmw7vrYBnt05P1LuaHi1e9U6s3mx4q/Ye5qBXKW1CQbd/l7iHceI3O4x2UfzgNL89
 cA9A==
X-Gm-Message-State: AOAM533MkYUHutHfPRzKW1U+jpgMkt1NogQOklOCnJmuAsWpFm/xMf/k
 wwqZYSbIQPdUhcs/FqXtYvc4UA==
X-Google-Smtp-Source: ABdhPJxXhMqP+60l3cLc/LicFnJYFFvz80yFXh9WwBpQhfMLp61DfGQlln8bavC48Pv73fQHbVAo3A==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr7036489wre.321.1595573123304; 
 Thu, 23 Jul 2020 23:45:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v1sm126517wro.83.2020.07.23.23.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C3151FF98;
 Fri, 24 Jul 2020 07:45:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/16] tests/docker: fix update command due to python3
 str/bytes distinction
Date: Fri, 24 Jul 2020 07:45:02 +0100
Message-Id: <20200724064509.331-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Does this seem convoluted to you? It feels a little complicated to me.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200722062902.24509-10-alex.bennee@linaro.org>
---
 tests/docker/docker.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index c9f20d8d093..356d7618f1a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -24,7 +24,7 @@ import tempfile
 import re
 import signal
 from tarfile import TarFile, TarInfo
-from io import StringIO
+from io import StringIO, BytesIO
 from shutil import copy, rmtree
 from pwd import getpwuid
 from datetime import datetime, timedelta
@@ -541,13 +541,14 @@ class UpdateCommand(SubCommand):
 
         # Create a Docker buildfile
         df = StringIO()
-        df.write("FROM %s\n" % args.tag)
-        df.write("ADD . /\n")
-        df.seek(0)
+        df.write(u"FROM %s\n" % args.tag)
+        df.write(u"ADD . /\n")
+
+        df_bytes = BytesIO(bytes(df.getvalue(), "UTF-8"))
 
         df_tar = TarInfo(name="Dockerfile")
-        df_tar.size = len(df.buf)
-        tmp_tar.addfile(df_tar, fileobj=df)
+        df_tar.size = df_bytes.getbuffer().nbytes
+        tmp_tar.addfile(df_tar, fileobj=df_bytes)
 
         tmp_tar.close()
 
-- 
2.20.1


