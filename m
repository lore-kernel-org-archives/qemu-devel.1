Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC74C2D0E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118072083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jg3uVjPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118072083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtXX-0007B3-43
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtUB-00021B-B3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU8-0000w3-W9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:38 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtU8-0000uK-QE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id u10so12542776wro.7
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fDYf/1zmgKNKjKhgfcohx9pQW+K3uRqOoa+dvB2+KwU=;
 b=Jg3uVjPQioMHN9QODuTGcSLff1gZdlGv2bXwosnMObIDMnE2K6TvKV0ndwYd9eXA+2
 iyySRgoxIeeRxuOFCRQSjZ4uouCyp/5gKF2KN3obQjj+99xT3wBUvbvxxTvQGQxHkZfs
 gzPkSTyfCMkpTbsOZqGMft+9ZaLlPJJg135gUusAzzVHPN9Drqw1IVg73stmG3ETrWiK
 fZtkAh78fPbnjWujptvLe1wlR+qNCfyH9a058edHDnkhnKdaLj6JCUdEvtdmXMmLZE1e
 OPwyMuSwQZHpvZBm+3mtSgs1OYPojyZudFelpk1vT7Jx9gayUZQwh0XM78gdi0dAJlIm
 JeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fDYf/1zmgKNKjKhgfcohx9pQW+K3uRqOoa+dvB2+KwU=;
 b=YdQFO7mIa8KxSc/KX/GPesr2Z3zvt47d303Bbak19r0HLaZITbnsxuSPUDuwhUQ9Nd
 smBssxfxGy4cw8fN8E12WFkRqmmpNTSlNKoMXfCA04AedXoBQ5a++9Temew/z3RYmIbN
 mfK+FM7CTLJP+WpxSRjhSux49GxOC73F874bqxIyh7oeRrwoTmF7o3PfsKMCdBQHvBYI
 paDY43d6nivkB99D7H3J7WISUTQQnjx9QfYaJss1NdOwUo9DNMbqZ1xk5h1x0IDKuYIm
 tUToXrrW7ZS2SSrl8hELiN/KcIFP5M6VcqbwF5VmMYdz29LXXT2Yl4WzMAt7c3TbqcRi
 /ggg==
X-Gm-Message-State: ANhLgQ3bsaAmKj385hG7xAXsl0VUQcpoHTZFi2xgl3slq/LyRaA9HDsc
 k3YeUxKJBCOoF5Q4KJS7VnvfeA==
X-Google-Smtp-Source: ADFU+vu9aNwfkwElnX0SVkN98i52JZvAeToS2wjWjo1/J5l6XflOryH0uTPx44VvQT+htebKETigYA==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr677442wrq.121.1585332815028;
 Fri, 27 Mar 2020 11:13:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm9257528wrr.60.2020.03.27.11.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 061041FF96;
 Fri, 27 Mar 2020 18:13:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 08/12] tests/docker: Keep package list sorted
Date: Fri, 27 Mar 2020 18:13:16 +0000
Message-Id: <20200327181320.23329-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Keep package list sorted, this eases rebase/cherry-pick.

Fixes: 3a6784813
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322120104.21267-2-philmd@redhat.com>
Message-Id: <20200323161514.23952-8-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index cdd72de7ebf..9a2a2e515d7 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -2,6 +2,8 @@ FROM centos:7
 RUN yum install -y epel-release centos-release-xen-48
 
 RUN yum -y update
+
+# Please keep this list sorted alphabetically
 ENV PACKAGES \
     bison \
     bzip2 \
@@ -19,6 +21,7 @@ ENV PACKAGES \
     libepoxy-devel \
     libfdt-devel \
     librdmacm-devel \
+    libzstd-devel \
     lzo-devel \
     make \
     mesa-libEGL-devel \
@@ -33,7 +36,6 @@ ENV PACKAGES \
     tar \
     vte-devel \
     xen-devel \
-    zlib-devel \
-    libzstd-devel
+    zlib-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a6522228c02..019eb12dcb1 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,6 @@
 FROM fedora:30
+
+# Please keep this list sorted alphabetically
 ENV PACKAGES \
     bc \
     bison \
@@ -38,6 +40,7 @@ ENV PACKAGES \
     libubsan \
     libusbx-devel \
     libxml2-devel \
+    libzstd-devel \
     llvm \
     lzo-devel \
     make \
@@ -92,8 +95,7 @@ ENV PACKAGES \
     vte291-devel \
     which \
     xen-devel \
-    zlib-devel \
-    libzstd-devel
+    zlib-devel
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
 RUN dnf install -y $PACKAGES
-- 
2.20.1


