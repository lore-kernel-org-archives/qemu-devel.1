Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D62CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE19620B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QP6x4850"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE19620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzuq-0004VJ-RP
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznU-0004wu-R0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznT-00026i-Mt
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMznT-00025p-Ci
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id v9so8087385wrq.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FAqFQJqp9wB9CdQPIdWZc2GaC2MYvXPxclSsx2WiX5w=;
 b=QP6x4850OFgTIOy7Fxl414ti+BsoxT3yD3P+RDuaAWsoIAAmC9urz5YJq7m1I3irTo
 bb7NQeb4+9pNS6uUSiGMdZtomQ6r4bFO2SapJrvAoXX9gY7+susFDjwEQJCAYO0sgRWr
 aXBihF84rl9aVjlKVHmjf+ZVw6NdmIn41X3ygRYq//x2HPGLYlKHnl7FSSyHw03m6JQc
 dgyeqPi/Bida5zs3x0ldhYv1mFTxhQc0k8C87Qga4jTvWVH+0dglCqhn1dLhwNuReavf
 HgqDgnzv536VDKB7eJWk63/4oLAeHPyuoE3QbRFeOYU2myx5dqM/EOqktptgr8o8rkGG
 xQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FAqFQJqp9wB9CdQPIdWZc2GaC2MYvXPxclSsx2WiX5w=;
 b=ipuq0D7DgVwx5U+ulT6+RhyTn43Kcqk9TSc84TNIz7dHTD+zo2QXzDDsZ6TqSsNAJ6
 s/4+CTA1mhmCMPBNP8p19rtvuqpO0b7Z5EidV1eJck6rUZR0L0cRr3R3Lpj6cq3WkqSF
 4t7m59ymD7JifiGhfiS2pMMsH+Iu1PjCHe4/FoV3AH4L1pP0Ogpn07w4g7pl3VSQ7buQ
 HX2E9c+0//OhtO5BG+PxRWZ1Rp4NCoUTdm1nPktvYotZjQHKq76cACVqAt/DQwFIuCDy
 KrSIBCXQY0BlINxxGC8k+qMatV8nqBjfhta/kZ4E/xmz10kRgr+5qN7S1ORYq0FXJHQr
 H/qw==
X-Gm-Message-State: APjAAAVIzyaOpK078TUdyqYJcjwpSxXxQmrOyPc/lgs+eTehuZyrkmLf
 zMQsBiRYB2tZIU3MjGZuaV04yA==
X-Google-Smtp-Source: APXvYqwB3kPAvgN9apQXs3bY0grYqLcRaTmppWfewT8VyHWtoxXd8L9v+5OGsVrU/3Gy2EfnUA7qWw==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr4943460wrc.293.1571772382229; 
 Tue, 22 Oct 2019 12:26:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z142sm19702344wmc.24.2019.10.22.12.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:26:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5570A1FF9C;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 12/19] tests/vm/netbsd: Disable IPv6
Date: Tue, 22 Oct 2019 20:16:57 +0100
Message-Id: <20191022191704.6134-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Workaround for issues when the host has no IPv6 connectivity.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191018181705.17957-4-ehabkost@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/netbsd | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 9558a672efa..d4dd1929f2d 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -63,6 +63,13 @@ class NetBSDVM(basevm.BaseVM):
     """
     poweroff = "/sbin/poweroff"
 
+    # Workaround for NetBSD + IPv6 + slirp issues.
+    # NetBSD seems to ignore the ICMPv6 Destination Unreachable
+    # messages generated by slirp.  When the host has no IPv6
+    # connectivity, this causes every connection to ftp.NetBSD.org
+    # take more than a minute to be established.
+    ipv6 = False
+
     def build_image(self, img):
         cimg = self._download_with_cache(self.link, sha512sum=self.csum)
         img_tmp = img + ".tmp"
-- 
2.20.1


