Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4C5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75889208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elfPb4nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75889208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8Kk-0006yj-KZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fl-0007Nh-5P
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fj-0006vn-0Z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so676969wrj.13
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8L2vbKsuiM4fLbSGCq4fCZieZ/wNbRKZPh+JXVwckiw=;
 b=elfPb4nnrSUwiW/bV0pZBaHIpKnqzEM61rBwtZcLcn5JFU9z+74X8DiuvkjtrNxRz8
 TJAJZcA7VH+B6ctLfzXk3LjR7ns8yNGlX7ly5hfRwJtVlccrm+ewd5p00GGSje5wZTq0
 Zxd5mm6GwffgX7dTXJ42+NA8PVeL2cZLu8bXEaoq4AVwOkTdw8+TPmyAlc3TW4adO1q1
 SyaloCWXZZ53SKMjWSZg8KlrIbdzvyS1CTuSSevg7/CmlBvudQIUq9eOZtLj2DQ6arKJ
 1VRdL9VeodH5TG84ci7+dBbBLdnjyv0smj8m91mElhqQLw3PhVYREY6BpdsBR1/yFfGe
 twWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8L2vbKsuiM4fLbSGCq4fCZieZ/wNbRKZPh+JXVwckiw=;
 b=XuIOgIg+iRyan2QdMUWXgW9qYm5w1pCQi8nZWooFZdnn3BiRwTwUcbT10S3Ybo93hd
 lUixo5ik6Wi3g5dQxlVRHk6dSeHLh5mYiabrgwscYYNBw1VRfcRTwkepVRt9od20gfrx
 H76g1h/CB/t4P12SrM6Q1SXdJRU5I/fQDZS0FgScL1IAsh14kOqykrYZUEU7Xr8lHtX8
 IXkpd0hMf+w9/mkb37FRerJbtCPQLQ4VhT+SIYSvSZipeEH1T0WaOl1SRPekxJgPgbi4
 LhQ0IyN6aqrE+1Ehsr/N776wJAW513R3kyJRiB+HY9NtcqvHsDWEq4tRQbQjcIgZOotW
 gTgg==
X-Gm-Message-State: AOAM531cpuDtJ2B/0FJgU/czX/XjoLaqOTm/fpdo8UAVrYIh/XXQAErj
 g5I7WSgDVIK2HDA29IF+EdNK8lHf3Hw=
X-Google-Smtp-Source: ABdhPJxFhcMAgJr5CRZ3Emw8aCypboNv9TMcjVGrFJi+ZoZ+6a3wFO6wT/+JBg6Iio1K1kXylSeOKg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr31382443wrq.357.1595399357669; 
 Tue, 21 Jul 2020 23:29:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r11sm5854388wmh.1.2020.07.21.23.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D04591FF98;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] tests/docker: fix update command due to python3
 str/bytes distinction
Date: Wed, 22 Jul 2020 07:28:59 +0100
Message-Id: <20200722062902.24509-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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


