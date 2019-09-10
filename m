Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F0C4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E1020872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugs4fYGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E1020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cKJ-0003cD-0O
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0V-0004VU-0d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0T-0004kV-IX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0T-0004jq-Bk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id q14so18455864wrm.9
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2geBL/UXKOMwRi8vueKTObH+zcw3y51W+as/Irfueho=;
 b=ugs4fYGn1Xv16wxc8e40D6D++lgn+xk3+r/yCMP1Rh1s/VcMWViVsV4gtPMrKVDwy5
 8o/V7tvzIopc6FMLJRJZIhcXGKu0XXngZJ3Mv6hfQvzOOADF0O0wZikQekOM+vPlDVJn
 6zYxyZkuiC7gOQuyGd7iixJMOguYvM93ln9yi2irPoe7cTYhY1Fmbae/wEFVxufD6HVk
 5zVLXznPZJukA42i44rQ40B8rkWS3g2sqcUc0udcUKVODLk5231oO0VYoALFfWj+SJlI
 LzvBNG/Mpz1JMpmHY4kXBgC/f4RuH6UZTz5kVs4v35X9kPdE4z871PpN/Cbw7coLobVQ
 vxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2geBL/UXKOMwRi8vueKTObH+zcw3y51W+as/Irfueho=;
 b=t7uw3uSTEUMX815rQ+mzZ38DfdYeSUJBP5gBEC/3AlGMK7yt3ER0B1BNdmcukqTc2Z
 JwsJp99W9KfGCH8WKiANu8nUmy4LuZ9I/LhFMrSNJKNCVzhZ1+1+YnCP98a0e579fgPu
 fVQDvG1Gc4aISxqlxtzWSQH5gDcgStsAajodE3QIariN62h0yZ49VusiwP6GOpmjz+CQ
 qQltniSrv5ShB09PLIDGFuf44o3uqmEmcTIho1UkUpNXu7AfqtuRfEDoOJ04xSfbWx/i
 eWB2JWmOD1yrisV/QE9giv5ntjp5nFPwOT9sH2mZkx+JyRRqTT4FILYsUu5guaoZR4z4
 phpQ==
X-Gm-Message-State: APjAAAUmZKfcpZ783YNAIBQKiV/W2q3eKXX3rHXEPqFoh0L4kDpgAcDq
 18kPLQzDFD0H8gzgqlkH5Nz+3g==
X-Google-Smtp-Source: APXvYqzPhZCdCjxVpDYJ/7bQco0LLAwhRLyeI3d/WS74LkvhFeqqmECmi3lWd2Cxxxivzd+wATAGLg==
X-Received: by 2002:adf:f846:: with SMTP id d6mr25207441wrq.67.1568106012313; 
 Tue, 10 Sep 2019 02:00:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 7sm1757710wmo.29.2019.09.10.02.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAB391FFAC;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:28 +0100
Message-Id: <20190910084349.28817-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 24/45] tests/docker: update Debian Sid image
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we are not currently using it we might as well keep the image
for later usage. So:

  - update to a more recent snapshot
  - clean up verbiage in commentary
  - remove duplicate shell from a merge failure

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
index 513459ca7f8..2a1bcc33b24 100644
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -1,25 +1,19 @@
 #
 # Debian Sid Base
 #
-# A number of our guests exist as ports only. We can either use the
-# ports repo or get everything from Sid. However Sid is a rolling
-# distro which may be broken at any particular time. If you are
-# unlucky and try and build your images while gcc is in the process of
-# being uploaded this can fail. Your only recourse is to try again in
-# a few hours when the repos have re-synced. Once built however you
-# won't be affected by repo changes unless the docker recipies are
-# updated and trigger a re-build.
+# Currently we can build all our guests with cross-compilers in the
+# latest Debian release (Buster). However new compilers will first
+# arrive in Sid. However Sid is a rolling distro which may be broken
+# at any particular time. To try and mitigate this we use Debian's
+# snapshot archive which provides a "stable" view of what state Sid
+# was in.
 #
 
 # This must be earlier than the snapshot date we are aiming for
-FROM debian:sid-20181011-slim
+FROM debian:sid-20190812-slim
 
-# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20181030"
-RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
-
-# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20181030"
+ # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
+ENV DEBIAN_SNAPSHOT_DATE "20190820"
 RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
 
 # Duplicate deb line as deb-src
-- 
2.20.1


