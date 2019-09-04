Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFEF208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raR5C9aI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFEF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5d5M-0004I3-9w
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDY-0001xc-Ah
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDX-0002Se-56
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5cDW-0002S7-VI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id c10so258786wmc.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ct8GRVkho5bZaPQ+r0/dd0wEzdlz65fQJcg/sMTvk3E=;
 b=raR5C9aIXdekox5/6ORleuMBMP/O4fIzdlei2ifybFuJggDG/v5VmIjYHHyrdTfPdE
 SvDqEU/bjQpjCAtPzO8o1eb/98uhJUfz7aU6ZAn5+3ISG/cfr9eeI7NRrq/5AsgIlax/
 NUrAbwN7i/V5TrjhOfl+kYWQa5ZDNu/q4k9yPZWuYwKpIgXasq+degGhnKjUdNfLnuu1
 PBN4xV/2Rm7wBRbkEyZVa44jz6cTjbxPLvqseDIpJ+K5X/QgmcpCvL5jKbKiR6M6ZrDx
 4JtDnR018fQRqmsa2iyuTxNyOXnT6EIDCr/7Jj2+yz0mZQM7jnjE1pdOXSwDwUOI5U9G
 2f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ct8GRVkho5bZaPQ+r0/dd0wEzdlz65fQJcg/sMTvk3E=;
 b=qKEf9Id/oqQKz4ATQYumoa62EruTMAWCnxtCINgKy3Th+wUUQyDYiGSCWsd0657qKS
 EqE2p211ypSEU7IJBHFfz57IRngXPe5VNVeo6M63hJemOacckkHcQIYmJG7ug1J/JuYO
 dzbzwkbR+EBFMlft8z3sC/vnLAATnFrhV1pnOwEz9TmTnTONmH3fKcCVXvgWRCMbBVx5
 OjoYubNek8CqZ7pDu9n1DFtVwSLxNlHbEuYaxdKig6UbiXjltgF8bzJGr+HXf3RTdBQy
 KvCGUU5eyjwzZqZayqddKK1JnZfBNRsoOESlZ3Ewhzss1Gth9SXFpUfYvmrjKvj4Tw5Y
 idUA==
X-Gm-Message-State: APjAAAWOdoKuyyJobMnZu92Aa7ySwr5nkSD02SzscSftBlOj99b4jZyB
 WWRkG9RoOX/hePEd2Be29sBNQw==
X-Google-Smtp-Source: APXvYqyJWS0GcjQa64yh1HXIAnDwZsWTMu4fnQfbr5hoiHvZrjW7gf9ve3I/k1wE8BDSmwBZVsIYqg==
X-Received: by 2002:a05:600c:2111:: with SMTP id
 u17mr177161wml.64.1567630165938; 
 Wed, 04 Sep 2019 13:49:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g15sm212099wmk.17.2019.09.04.13.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:49:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B3261FFAC;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:54 +0100
Message-Id: <20190904203013.9028-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 23/42] tests/docker: add debian-xtensa-cross
 to DEBIAN_PARTIAL_IMAGES
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

This should have been marked when the docker recipe was added to
prevent it being used for cross compiling QEMU. Sort the
DEBIAN_PARTIAL_IMAGE list while we are at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index f4e9dfc0120..8d7f9376578 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -115,10 +115,15 @@ docker-image-travis: NOUSER=1
 docker-image-tricore-cross: docker-image-debian9
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-alpha-cross debian-hppa-cross debian-m68k-cross debian-sh4-cross
-DOCKER_PARTIAL_IMAGES += debian-sparc64-cross debian-mips64-cross debian-riscv64-cross
-DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross debian-ppc64-cross fedora-i386-cross
-DOCKER_PARTIAL_IMAGES += fedora-cris-cross
+DOCKER_PARTIAL_IMAGES += debian-alpha-cross
+DOCKER_PARTIAL_IMAGES += debian-hppa-cross
+DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
+DOCKER_PARTIAL_IMAGES += debian-powerpc-cross debian-ppc64-cross
+DOCKER_PARTIAL_IMAGES += debian-riscv64-cross
+DOCKER_PARTIAL_IMAGES += debian-sh4-cross debian-sparc64-cross
+DOCKER_PARTIAL_IMAGES += debian-tricore-cross
+DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
+DOCKER_PARTIAL_IMAGES += fedora-i386-cross fedora-cris-cross
 
 # Rules for building linux-user powered images
 #
-- 
2.20.1


