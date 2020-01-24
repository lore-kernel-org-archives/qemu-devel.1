Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88815C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4705B2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POpqCcLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4705B2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5pH-00081s-GM
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ks-0007xq-3f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kq-0005rs-6w
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5kp-0005pg-Vl
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so3562209wro.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SneCzotSwHMcNyP5CETRFEt/c6BUYP4c0Zs/+5k3iGo=;
 b=POpqCcLGj0c65hgCMDRshA5ffsfS58Cjo2XwXUn92OzqOWOmTTwS8etcues6aedkXl
 L0D2oKb7i9iMPV/3PSQgvs6IcZeGhkjTUrJoX2Vb/aRQCI+Xpq/iygGkP5WzPcKHQsyy
 W0G+pySulP1merIZcOsy6aIOnyZSMw683inZIZFd92KU8zZTV7jVtR917GoOFaUWWsoO
 RYCihqIN4HQPezGC0271VS+jFaQsd/CxIAl7siiwkg3A6mgP0PZpRpxXYFTud9pTAZD/
 P11F8PGK/TVScCulAkWrziX09tDhaNb09n+V0ZutY/Th8c/t6NRsB/YgZyIn9EyYIQy7
 ZvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SneCzotSwHMcNyP5CETRFEt/c6BUYP4c0Zs/+5k3iGo=;
 b=eXLPnzEN/xzsUqqYUt0gBRLwU5EbQDhh6JI6VbIuFgLr7PT47s5P+x8FcgphTQVJ0f
 S9Qwny8LNDja1J+P1ljIRYUL6RWMzN5TRS5h3KVpb9BBqji7JjzVHRE6b2S+17B/26Sx
 8TnD+ruJbEiwU9gJ2FNqNx66Q1X4TFgx1Bl9jp4HsbxDgkRunr8N/uSH+VUssxwK/jkz
 iXnglsjwamhdQMyiFuMIjBRVacRxXIE49tz1G5ZXRVnV3kVnkqifNdysw4uz4xUzjtpC
 PICTJgjVcLEy1/8k6elwD9jAgnxyXI3tWDTvyb6P45MAVdO6MNF0Y48W5sQ55N7p5qnj
 2WwQ==
X-Gm-Message-State: APjAAAUf+ZAu1dNSJs4ejaLuGyDs824u/egZmJAs4iAbSwx9+uo27N3/
 r7+QwNoxxg4CEVtmzjA2bDVIEQ==
X-Google-Smtp-Source: APXvYqyTDrPr4aOXw4jkiAhiO8kSt3bMiJvrtNtgU0nmJ8LvpNAvbl3U5/GjTgp4pzPfqooY/FFhhA==
X-Received: by 2002:adf:f581:: with SMTP id f1mr6314692wro.264.1579898434833; 
 Fri, 24 Jan 2020 12:40:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o1sm8822069wrn.84.2020.01.24.12.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6EFA1FF93;
 Fri, 24 Jan 2020 20:40:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/13] tests/docker: move all cross-compilers images into
 dockerfiles.cross
Date: Fri, 24 Jan 2020 20:40:19 +0000
Message-Id: <20200124204026.2107-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These images will no longer be visible to the main container build
process. This is because we will want to selectively include them for
each supported architecture later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../{dockerfiles => dockerfiles.cross}/debian-alpha-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-amd64-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-arm64-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-armel-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-armhf-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-hppa-cross.docker   | 0
 .../{dockerfiles => dockerfiles.cross}/debian-m68k-cross.docker   | 0
 .../{dockerfiles => dockerfiles.cross}/debian-mips-cross.docker   | 0
 .../{dockerfiles => dockerfiles.cross}/debian-mips64-cross.docker | 0
 .../debian-mips64el-cross.docker                                  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-mipsel-cross.docker | 0
 .../debian-powerpc-cross.docker                                   | 0
 .../{dockerfiles => dockerfiles.cross}/debian-ppc64-cross.docker  | 0
 .../debian-ppc64el-cross.docker                                   | 0
 .../debian-riscv64-cross.docker                                   | 0
 .../{dockerfiles => dockerfiles.cross}/debian-s390x-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-sh4-cross.docker    | 0
 .../debian-sparc64-cross.docker                                   | 0
 .../debian-tricore-cross.docker                                   | 0
 .../{dockerfiles => dockerfiles.cross}/debian-win32-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-win64-cross.docker  | 0
 .../{dockerfiles => dockerfiles.cross}/debian-xtensa-cross.docker | 0
 .../{dockerfiles => dockerfiles.cross}/fedora-cris-cross.docker   | 0
 .../{dockerfiles => dockerfiles.cross}/fedora-i386-cross.docker   | 0
 24 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-alpha-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-amd64-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-arm64-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-armel-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-armhf-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-hppa-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-m68k-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-mips-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-mips64-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-mips64el-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-mipsel-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-powerpc-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-ppc64-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-ppc64el-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-riscv64-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-s390x-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-sh4-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-sparc64-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-tricore-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-win32-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-win64-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/debian-xtensa-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/fedora-cris-cross.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.cross}/fedora-i386-cross.docker (100%)

diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles.cross/debian-alpha-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-alpha-cross.docker
rename to tests/docker/dockerfiles.cross/debian-alpha-cross.docker
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles.cross/debian-amd64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-amd64-cross.docker
rename to tests/docker/dockerfiles.cross/debian-amd64-cross.docker
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles.cross/debian-arm64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-arm64-cross.docker
rename to tests/docker/dockerfiles.cross/debian-arm64-cross.docker
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles.cross/debian-armel-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-armel-cross.docker
rename to tests/docker/dockerfiles.cross/debian-armel-cross.docker
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles.cross/debian-armhf-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-armhf-cross.docker
rename to tests/docker/dockerfiles.cross/debian-armhf-cross.docker
diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/docker/dockerfiles.cross/debian-hppa-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-hppa-cross.docker
rename to tests/docker/dockerfiles.cross/debian-hppa-cross.docker
diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/docker/dockerfiles.cross/debian-m68k-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-m68k-cross.docker
rename to tests/docker/dockerfiles.cross/debian-m68k-cross.docker
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles.cross/debian-mips-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-mips-cross.docker
rename to tests/docker/dockerfiles.cross/debian-mips-cross.docker
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles.cross/debian-mips64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-mips64-cross.docker
rename to tests/docker/dockerfiles.cross/debian-mips64-cross.docker
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles.cross/debian-mips64el-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-mips64el-cross.docker
rename to tests/docker/dockerfiles.cross/debian-mips64el-cross.docker
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles.cross/debian-mipsel-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-mipsel-cross.docker
rename to tests/docker/dockerfiles.cross/debian-mipsel-cross.docker
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles.cross/debian-powerpc-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-powerpc-cross.docker
rename to tests/docker/dockerfiles.cross/debian-powerpc-cross.docker
diff --git a/tests/docker/dockerfiles/debian-ppc64-cross.docker b/tests/docker/dockerfiles.cross/debian-ppc64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-ppc64-cross.docker
rename to tests/docker/dockerfiles.cross/debian-ppc64-cross.docker
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles.cross/debian-ppc64el-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-ppc64el-cross.docker
rename to tests/docker/dockerfiles.cross/debian-ppc64el-cross.docker
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles.cross/debian-riscv64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-riscv64-cross.docker
rename to tests/docker/dockerfiles.cross/debian-riscv64-cross.docker
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles.cross/debian-s390x-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-s390x-cross.docker
rename to tests/docker/dockerfiles.cross/debian-s390x-cross.docker
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles.cross/debian-sh4-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-sh4-cross.docker
rename to tests/docker/dockerfiles.cross/debian-sh4-cross.docker
diff --git a/tests/docker/dockerfiles/debian-sparc64-cross.docker b/tests/docker/dockerfiles.cross/debian-sparc64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-sparc64-cross.docker
rename to tests/docker/dockerfiles.cross/debian-sparc64-cross.docker
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles.cross/debian-tricore-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-tricore-cross.docker
rename to tests/docker/dockerfiles.cross/debian-tricore-cross.docker
diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles.cross/debian-win32-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-win32-cross.docker
rename to tests/docker/dockerfiles.cross/debian-win32-cross.docker
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles.cross/debian-win64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-win64-cross.docker
rename to tests/docker/dockerfiles.cross/debian-win64-cross.docker
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles.cross/debian-xtensa-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-xtensa-cross.docker
rename to tests/docker/dockerfiles.cross/debian-xtensa-cross.docker
diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles.cross/fedora-cris-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/fedora-cris-cross.docker
rename to tests/docker/dockerfiles.cross/fedora-cris-cross.docker
diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles.cross/fedora-i386-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/fedora-i386-cross.docker
rename to tests/docker/dockerfiles.cross/fedora-i386-cross.docker
-- 
2.20.1


