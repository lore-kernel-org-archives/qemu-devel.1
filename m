Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6500C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EF320872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NibXJ9ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EF320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs2t-0000OC-QZ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002Zi-C5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw1-0004VV-4f
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw0-0004UI-P0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 3so1722295wmi.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FDw1x34VjZz6x324dEY/m3Hhnbg5UxW8YU5wYZvVAME=;
 b=NibXJ9uiByjgH+pIty3xgWpgz0W4gW4Ppj4z3PVezNDbIeItGuvyuUzf4/hASepZkR
 XXoxO5KswvCPtxvBTMze/dG9GmptwiOzJGlLFv9npWQUTY1Mo//rpxAASt4zTIwPUM8k
 J92e+DvTTYMiigQCO4Q/b0RXiqp7X1BqPftThsiXynZqOttW0Ass+jl6JwHEEe8of5iV
 aMsw37B918CN9j39vDv3KYGvAfNcsznf+7wXeU2piizjaMs5rRaxBFlX+Iqsbs1eZZn9
 efk6tIIWewVKAvNmJ/7ZThIyMtig7/m4P0LBtiAANRjh/zMEytehjYZ9Gax0iDbcgHUN
 MjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FDw1x34VjZz6x324dEY/m3Hhnbg5UxW8YU5wYZvVAME=;
 b=ul/2VLP1JFjqjIwmLslZOJujqmxVMIQygtk0MXm5Ot2ee4TzxVnFsbww5cUlq/q7Vh
 HVtfbB7WlrQuSJn0rk5rQwVRjSOJZPNYBpX4Tz+GPp4wHRAqyPUB0Vkf6RnXipJNWcNU
 uDFW0+JCV2a1fYPyEhwmo8rhGn08tsOFPAXcpAtHPKGe+MedevRvlib/YjKutfwVXgGA
 Jhdw7xDnGw5pQwOuF/0zZNKm4hhuCejMBiWexZVNapmC1A8FNkAgisWuLcGEBdi08Hgw
 rza0RAq4jE3uqdzkp9ECeCXktOOAU7pAEovB/Og/kX0bZudozXx2DAT6+3XkRPaqrtii
 ksJw==
X-Gm-Message-State: APjAAAWAQm4udWG3U1VOWHjEHddItddKmCzA+psvsrbbOEXe5WmDGyfq
 a5hO/MJbgp94la1b4PAlrFJ9n2MQcUm5Aw==
X-Google-Smtp-Source: APXvYqwjMFzX1mkLyBY4ZuVpgJJYPWiTa6QABqISWRdHLaAvPvayzMHoznus9T3SxvBwi/nLnZN54g==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr2620553wmo.114.1569358879357; 
 Tue, 24 Sep 2019 14:01:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w4sm3908478wrv.66.2019.09.24.14.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DEEED1FF9C;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 12/33] tests/docker: add sanitizers back to clang build
Date: Tue, 24 Sep 2019 22:00:45 +0100
Message-Id: <20190924210106.27117-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Fedora23 is but a distant twinkle. The sanitizer works again, and even
if not, we have --enable-sanitizers now.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190912014442.5757-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/test-clang | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 324e341cea9..db9e6970b78 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -17,11 +17,7 @@ requires clang
 
 cd "$BUILD_DIR"
 
-OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
-# -fsanitize=undefined is broken on Fedora 23, skip it for now
-# See also: https://bugzilla.redhat.com/show_bug.cgi?id=1263834
-#OPTS="$OPTS --extra-cflags=-fsanitize=undefined \
-    #--extra-cflags=-fno-sanitize=float-divide-by-zero"
+OPTS="--cxx=clang++ --cc=clang --host-cc=clang --enable-sanitizers"
 build_qemu $OPTS
 check_qemu
 install_qemu
-- 
2.20.1


