Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDE921928
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+oneVqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDE921928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0CW-0005Gt-Ls
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07P-0008UJ-7k
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwi-0004La-FZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwi-0004Kv-8A
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id x2so5535941wmj.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ROcEXk4VlPnAKdNfwfPvcGYJ80CFnYnY+S2Rny52Nig=;
 b=K+oneVqMntgvacF/QwvgdIWnZ+iqP61QhjnSWz3HUiIMnTVPQW8+k4Y1URy08n7YfR
 k/kivN3Cl4xh/gxb3T+YEXdxkxx+aIarEG5U/JqLNYIBQwxR7rF+Jag4fYyf3I2tPMpD
 I7gXfXP1UBNIoFIMYtVwzNzvtKFzG9HnOMxTCOQFyj4+lzWKr3lbAyT42FIbYePC8Hlv
 XQMAjMsdauN8We8+3v1UfmpjQpXxX8bmqnoGgd085W2CYYyqsBG/H/2L4AbCEmHs/k3w
 V1b+IrQj/cxJvaDwidc+xvLDFmHAVUcxajEzLxmeHUnDb5Xg5Kh1R5J8D+ECZS0JlLGs
 YruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ROcEXk4VlPnAKdNfwfPvcGYJ80CFnYnY+S2Rny52Nig=;
 b=udQ2hunpK1zR0tC5uraPchW0ACSq0INN9os3RWMxDCg/+lW4uY5I5/cquIgzP4585T
 b2fHdSSdnu9kpoTORuCTCo9cDolwCbz21pwzDNsnWRKkRqb3wq+UQ4iIn6UP/iIt/yY0
 A9UuscAKxNh4/aitUinlFQ+1UZ6C92sEfx2j7+OhaF8jWTl79my9GW51I3DFrYM6pKVv
 zQPVJum8Nkk3v65UXHcrCjTz5LAhAafUcvKbOEAE5nf5kiSudisyrAnNa2C0x6d3BWQ0
 CVymPMzaQCfh4DooyKvKVNMvy4ocYR/ZPqiEckeOIeX0d861rgQRHC2nKZYnPDQjpTWJ
 Nvog==
X-Gm-Message-State: APjAAAUREnMGFFLlRsLySzOkRSSYC+O0il4iQy+cpwmXnDHtTKiMWQt5
 lIeGuLEy7LzpyU2tQK5hZH3crA==
X-Google-Smtp-Source: APXvYqzK7PmrHbs3U0flW+np4Ek+hyDa6VpRfJ3lQPBOL8IKz0xeyQ3q0rMfh4z4T+Lerql5q6qijA==
X-Received: by 2002:a05:600c:2059:: with SMTP id
 p25mr3974611wmg.50.1568913019152; 
 Thu, 19 Sep 2019 10:10:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f143sm11670669wme.40.2019.09.19.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9B641FF90;
 Thu, 19 Sep 2019 18:10:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/16] tests/docker: remove python2.7 from docker9-mxe
Date: Thu, 19 Sep 2019 18:10:02 +0100
Message-Id: <20190919171015.12681-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

When it was based on docker8 which uses python-minimal, it needed this.
It no longer does.

Goodbye, python2.7.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190918222546.11696-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian9-mxe.docker | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
index 7431168dad9..62ff1cecf2d 100644
--- a/tests/docker/dockerfiles/debian9-mxe.docker
+++ b/tests/docker/dockerfiles/debian9-mxe.docker
@@ -16,7 +16,6 @@ RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276 &&
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        libpython2.7-stdlib \
         $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
 
-ENV PATH $PATH:/usr/lib/mxe/usr/bin/ 
+ENV PATH $PATH:/usr/lib/mxe/usr/bin/
-- 
2.20.1


