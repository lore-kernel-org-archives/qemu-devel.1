Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D575FC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A019420726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPGpctce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A019420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aZd-00076s-SO
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZkU-0003ko-Gu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZkT-00044m-AP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:42 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZkT-00043g-3X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:41 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so3042062wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=33Beb3UWNrnG47QEWUCuKu06Yy/rgf1M+3g9PXxe6cI=;
 b=hPGpctcecNWVS6r7SWnEe9n3xT4/g2BzygzWIxO5t+WNO5n/oeOd7O8hzgU/NeL8un
 Za5ZkmKPSppXWi4Kjt1kcmuYRDVBPLqI7WPfYfv/B1yOLPgtVRcAPpkNcQpIdsM4pfCD
 d9aYY9WaOsqpVp11WQr5klYvdov9FLJl/zdjCy3kuEdS1Fg6SbBP8O60WPkyANYqsf5s
 0oP49k3VNi0aeoD0N5OtbOUW07BEQcqjDnnynK0FAMw1mWJ5nmOJeY6hWo00mkltXY2c
 nm0dxzu0KkpJWVv/xEjD8vPJNL5fn5nZ6XGogz68p0gDWv7szw/s5RW9eWFnH0krgtY9
 VGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=33Beb3UWNrnG47QEWUCuKu06Yy/rgf1M+3g9PXxe6cI=;
 b=a8IEvy96L49+gID+law8rB8qlw16I6wfUfcvBBB0cR54FRiUM9UFjY4aYzIr3GJTQW
 sBWSCU/KWGuV8l9oZw6RDDQ7DcYy2FOg6NUWxL4HEANe9QqfpbmpPUWzWe5ucOVih94t
 OgUH1twuaWea7uro6yzvMTGFh95uokPdnKhsj3agTwUzYe3MIBCbSVcm5UyrHarjOXEn
 54+SB9YMHhALrJII0mMObCJG1ctf0eSNfyZpiJ0yZr0Yv+q9kJVX/+yDz//zY+51YKm+
 f5rbUZ5Thho2vhgwCYJjrq5GdSDYWuJHaroqwjl8G+FIq1nxAVe+LG0wGM5fcqRiFxr2
 YbDg==
X-Gm-Message-State: APjAAAUNmI22Q7T1FsB6xA1ijpkUlAJqaP4aL4RCETjoXnT5u7Fidmbi
 aV4IZIRZ70eyWPjuTO79n/bBXA==
X-Google-Smtp-Source: APXvYqwgCsuveY3EsQFWO6ZotEa+054ejPSyDchPKiCf/uXDm+0elXO3x67zTqF5cpRUqSDmER6GPg==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr5244353wmf.100.1582635339975; 
 Tue, 25 Feb 2020 04:55:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm22856681wrx.25.2020.02.25.04.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:55:37 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5F4E1FFA5;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 16/19] tests/tcg: give debug builds a little bit longer
Date: Tue, 25 Feb 2020 12:47:07 +0000
Message-Id: <20200225124710.14152-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When combined with heavy plugins we occasionally hit the timeouts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/tcg/Makefile.target | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 3c7421a356e..b3cff3cad1a 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -79,7 +79,7 @@ QEMU_OPTS=
 
 # If TCG debugging is enabled things are a lot slower
 ifeq ($(CONFIG_DEBUG_TCG),y)
-TIMEOUT=45
+TIMEOUT=60
 else
 TIMEOUT=15
 endif
@@ -137,7 +137,7 @@ PLUGINS=$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
 $(foreach p,$(PLUGINS), \
 	$(foreach t,$(TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
-		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=30) \
+		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=60) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif
 
-- 
2.20.1


