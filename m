Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4AECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BCA20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yDqArvks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BCA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtVh-0007TC-Al
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDx-0003B0-J3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDw-0008PN-Kh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDw-0008Ou-Ea
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id n7so761757wmc.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0daDUPmy7VqJtOPnYQKTH35LlZ0A9ZxcamAsZRQwgj4=;
 b=yDqArvksbhSUaibIWxhFzsUnuES/S1gxKsRTrslnosnHokbP/UCnUbfJOD3r/d4jum
 ItHMwqAf0Ml8dMm9mbN5VkOXjljJjhc5npwxL42HdP8lM+cOGSQGkPtcLHA7T//z0WIA
 G7yjJb4hySRKfurFwur0T5gJS1ni59iLXUjdvtb2MtTRYMciqobQPnRov30+XjUuCmZB
 pS+EZFrnH2dNXZCV5XI++K8e39Q0pZPG3p8PUxLNU04Bw6kHwkN8s/XIgUuUIwJmBJ01
 eZUmYg3nrjPu/8g0KO2Pb/NdWiGD+09NsqcJbZdeBK5KjO4BDAIVvR/kVSGRityhQzY9
 9juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0daDUPmy7VqJtOPnYQKTH35LlZ0A9ZxcamAsZRQwgj4=;
 b=DQYOun2IzLhceGf5xEU+JRuhQCT8phgY2ssQNLaeWgu4YneuKSn80ioMx9rkBV4LG0
 LBd9Z7exJzTEBm2Bc59YklGwe9xHWWTW4uPIR7YbuUw1slv9oUCnyC9ppSW5hYz1wL26
 Kj5zzXkgUD4C4FP2GEyVGrQt/+02ycusC4442HH51+zRcqMdGWCuNUwh3u72JwLoXcya
 DYgfTqvnlGG4IocmrSlrudBm1xjDRX8GTHoTWa9z/eJGpgbgVQR1LadqxxZ9dRyXw/8s
 ehKSQUxfIh8HeJtXxk7o5TWbrpCLEmHBC9lKPPZRrdD5mOdwV7OQCwa4+UQBqw7SrPCr
 VPmQ==
X-Gm-Message-State: APjAAAVLcpqSQmyE7Q+E5NVZjN0AMWmHRTB96IaPzY1gyfe/0XPlp5ao
 TRAjUhgqXh4Va9uOZLZmd3MbVQ==
X-Google-Smtp-Source: APXvYqy5WxoUtCWCTY66BOxGp1A65MLdQWEHFHnZfVeU8hdLcTiNa8dIXszk0OW4KeNH68uq6BikBA==
X-Received: by 2002:a1c:f602:: with SMTP id w2mr1776340wmc.83.1571985443116;
 Thu, 24 Oct 2019 23:37:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r1sm1033311wmh.37.2019.10.24.23.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B19081FF9B;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 11/73] tests/vm/netbsd: Disable IPv6
Date: Fri, 25 Oct 2019 07:36:11 +0100
Message-Id: <20191025063713.23374-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Workaround for issues when the host has no IPv6 connectivity.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191018181705.17957-4-ehabkost@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


