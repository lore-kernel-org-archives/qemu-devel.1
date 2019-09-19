Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3F9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690FE217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8Ezy9WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690FE217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0AE-0002re-Hy
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB06m-0008Ns-NX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwk-0004Mo-BZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwk-0004MI-5X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id y19so3938263wrd.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tblJT4RtEixMQfFRyBeEWlegYmtqzQLK4AhwWipF6ds=;
 b=z8Ezy9WSh8HJaGUWe64aWKbGuLS8CCtrtrg+ZH9LZaPg86K2Pye/CIBYeQ27EaqUoE
 zFB6VyEIWSNK4dEtqOhrKGl5X01eDKpI0VMAYZ4E4cFQPxWoFbEjlbEEYcnXSNsT62aL
 rXGZHt5ZmxmwXo6CYKT588jBk8wfNOapWtOjVLHvB9eGNHwH2FPN6m2a56XstJWA2C5b
 8PNigtXV6qz/ALYS+shvxFdHP82P7zsEhAM7VGBjHLJNQYQNNpqigL0pFyVGXdXSzjqY
 UoZTgh7rvZOg56wnO0kSSLAEF+ebWTlj2iKm6oOgIEJqOE2Lsx3W6F5br78Nm4GSZqev
 rPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tblJT4RtEixMQfFRyBeEWlegYmtqzQLK4AhwWipF6ds=;
 b=Qafy7A1vDwjhd+aRAR9QHHYdefno64fcYp7VZb3dLPhtOqQ7gnk6cHPJ4S7uPpvlV+
 qCuHgYo5o7XZWUG4iiF7EKeKDhB9+RoLApuI8L26P40Xw9zK78a06c30TAo8Nw5VeC9M
 08hb4iGxVZAZg9yS3m9Dt8OvOZbfoO7LnLl902neXzFw4t3kLUzBm/SPQvIuJdWw4iGJ
 oZeC4t9zto+84oeBzlVYgyj5/WvxkSVngK0KqYLu89n3y99Eco9H000r8t6DnR2tUY51
 VCpDz2H+97NfCyMBY8NQuB4ZtMMBSqadckJvxqlWnARP4EwKrnh2YUlOk3s20ILiYfTk
 Ey4g==
X-Gm-Message-State: APjAAAVw6dA5I7l2fTjopkMEEUjnWHIw3fhTtu1cYBQT+10PWGEau7n6
 DIi0sGgUWWsUR47FbUeu/6jMCg==
X-Google-Smtp-Source: APXvYqwh0++D3UTChkg8Agrlg60ftFKvp9PFNyOlnzkSIkF1zMW3gHSx5PTZ2a6yykL2udny0SM7KA==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr8269280wrs.24.1568913021040;
 Thu, 19 Sep 2019 10:10:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b184sm10000262wmg.47.2019.09.19.10.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F88B1FF92;
 Thu, 19 Sep 2019 18:10:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 05/16] podman: fix command invocation
Date: Thu, 19 Sep 2019 18:10:04 +0100
Message-Id: <20190919171015.12681-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Oops; there's no argv here.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190913193821.17756-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 4dca6006d2f..890e874ba93 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -338,7 +338,7 @@ class Docker(object):
             cmd = [ "-u", str(uid) ] + cmd
             # podman requires a bit more fiddling
             if self._command[0] == "podman":
-                argv.insert(0, '--userns=keep-id')
+                cmd.insert(0, '--userns=keep-id')
 
         ret = self._do_check(["run", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
-- 
2.20.1


