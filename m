Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0457C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6AB227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yk3jf9+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6AB227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtR0-00040O-8W
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNJ-0006dR-PH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNI-0008S8-Mo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNI-0008NM-E3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:44 -0500
Received: by mail-wr1-x42d.google.com with SMTP id b6so5516305wrq.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=903ieA21LmcrJVAsLL1LFphWZ9y7liPxJNyTsqIDuUs=;
 b=yk3jf9+4el4JsIh3kBJo7wFoxtSkjc9VVNRqehA+FL/FAsNad/qRHPe4W8n6R6IYDt
 utdt2eFfNnpEPBSI7lY5MBRS8osAnlNZ+XsYMMRes6SYP0qEhtN2FHXZZMzqRlQCYX5P
 bJU8oyvHz33djfkHE/UoYwRVumaDE3L3+brcCyG7GOpeFRWoF4apCEVuJsm3C4omRtdz
 m/rxoWcqwT6sGYOeCYT+RBeqifKJ7deaAGDbiuY0Ak9X0dFDzCT2xGYq/UvNbKPvmvYj
 9BfBDZyk57KUQz41W0HBqqPRBhHLicna4ZINLcDq3sbT3CuIAA6x+c0P7jg/mvns2Y41
 49EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=903ieA21LmcrJVAsLL1LFphWZ9y7liPxJNyTsqIDuUs=;
 b=M64Xl3DAP92T8yOqtNxItvELdlKVylCo7iy/j5LSKdpUSv/ubA/odCuxDtJda+3DGo
 8eezm9UFskxLSpcioGsUYB3FNikWBxeuOEr3L20LNK7MC6aKJwlR5m0xoSmc4AiPdk8f
 d7qYQgw3po4aj92HogYO48bzCR1V0LZ73qOfaaKGXfzl0Tn/VB6qnRvSNPKCn4ajH19K
 cqaYjDor7iukj6vwQz6AcPOfvNo2vp49FOvQVjQk/pCW8UjNLUhadwqq3WZ3dv5W6Ock
 sc4ju3dAvXFczeUoxxqKpsQ/d/9jE9pN0utW13brJlTGiehKK0HXvuuij1MK4kSEZlWy
 NFcQ==
X-Gm-Message-State: APjAAAW2YInTPD3nMtCZsLsra/aN8XyxEQ0E2gEKoth6zR2QU5x5yLmT
 +BEdkMNTf8gtdwSTd276P8K+OA==
X-Google-Smtp-Source: APXvYqxa7tX+9dLTADX/pQ7y7+uIbvwQf0YU0+Y4cygV0ErGGDPovQT0xiyZx/4SKxMWV0Kx78wzgg==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr9043454wrp.2.1576752583259;
 Thu, 19 Dec 2019 02:49:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x14sm5620446wmj.42.2019.12.19.02.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3F251FF92;
 Thu, 19 Dec 2019 10:49:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/25] iotests: Skip test 060 if it is not possible to create
 large files
Date: Thu, 19 Dec 2019 10:49:14 +0000
Message-Id: <20191219104934.866-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Test 060 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. The repair process
in test 060 creates a file of 64 GiB, so test first whether such large
files are possible and skip the test if that's not the case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191204154618.23560-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index b91d8321bb8..d96f17a4846 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -49,6 +49,9 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
 
+# The repair process will create a large file - so check for availability first
+_require_large_file 64G
+
 rt_offset=65536  # 0x10000 (XXX: just an assumption)
 rb_offset=131072 # 0x20000 (XXX: just an assumption)
 l1_offset=196608 # 0x30000 (XXX: just an assumption)
-- 
2.20.1


