Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA2FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED672206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ashEI3xb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED672206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5d8R-0007Wk-PR
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDZ-0001zM-IG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDY-0002Te-Bw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5cDY-0002Ss-5u
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id q19so242207wmc.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IMcXjKEwyw5C8Npir5bad9GD9TTDcpBdgpA+xbrkFvs=;
 b=ashEI3xbDEuVDTdbUssnl8Kp6Ym2gIzoexmNLh940pCW3oqTK3EH7NhBBzlhkTZ/Jd
 m9cLdsXpuPNSNMgWmVoXcJYbT5n1HHPWUwu2R2nuLUVWBdGk52RVZKPJvUWSXB+GNvVU
 XycKdh2in7GeGRB7J7lUqYLiZHIdGGwHpRCnc1oiqA6Uyx/JdktyWSRb/tTV6x+NdWHD
 tcUJxXUmB0meEDVf9SsOESp+9Vl5rKluEjpr19G5Lo3/39x5/THVotgXU2i5twrhs+ac
 ZM7QjEZEQDEB259IN5HGaEq4dP7JGIGYC7i/VW6iDD7P3wsb9JksBJacsQL4sR8rqKQo
 LP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IMcXjKEwyw5C8Npir5bad9GD9TTDcpBdgpA+xbrkFvs=;
 b=W8ZmGhLNBDmM0kdpRVReNwbjWCIouELxlnRWsvJDo/6B1tRJUgioWWEAeoAD3rGjnZ
 VMnvGE1w6Uv1d5d2RzhqcabFic5J42nfOgbp/Z3MMI+xkjngDpEGQHd1fCHjLMXAj4v/
 S0udiJb5Hoe6h8rkSvI9J+eTXK+Uqej3OnuSvGBpDU85LxpsLUcqdE7nEQB7P5LD51Su
 Qm98EQYwzQJUBTZLAv+q29EefN3cP33e7QrjYnrQnaOUXSaw/LOhME3pk/juZqEvHS1Z
 lbo56ydufs4Gh8sQo/hJENhdBlQE2VbtlOeKVufwxJFtAYr6wOtHfRb4hFmP0STfPL5E
 opzA==
X-Gm-Message-State: APjAAAWL3wTRuI24eRnRiG+NUkJEXLZyZHe8MQH1Pse7lVcXnrcUS+er
 j7wkuy4bqW1IeB7f2YBNmEaJ6A==
X-Google-Smtp-Source: APXvYqwubXV4X0rQ8f0pwest8nMQubPD1SrQ5/lhRjPoSykpUBZCgdAOTnU4acsRNTXnGcd1wZupIA==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr130088wmi.91.1567630167108;
 Wed, 04 Sep 2019 13:49:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u68sm350497wmu.12.2019.09.04.13.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:49:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 201941FFC1;
 Wed,  4 Sep 2019 21:30:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:12 +0100
Message-Id: <20190904203013.9028-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v1 41/42] tests/docker: --disable-libssh on
 ubuntu1804 builds
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently this stops the mega:

  make docker-test-build

from working. Once the source is patched to deal with the case this
workaround can be removed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/ubuntu1804.docker | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 44bbf0f77ae..883f9bcf31c 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -56,3 +56,6 @@ RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml sdl2
+
+# https://bugs.launchpad.net/qemu/+bug/1838763
+ENV QEMU_CONFIGURE_OPTS --disable-libssh
-- 
2.20.1


