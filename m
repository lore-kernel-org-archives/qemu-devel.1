Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F3ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4B621D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKX7/qq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4B621D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5b1-0006bS-NR
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Of-00089B-RR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oe-00036w-Ko
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oe-00036I-Et
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id c22so3170736wmd.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TdZ5GZorCml1FjL+yJ8DutcSWJmng0qMadQB/3SWejo=;
 b=rKX7/qq5q8Xr6mfvAYsAfe/ti11dKijn1Yr3doRslwZFb3xZlKJyJ51OlbYr3tcb7I
 L44F44uLB/vfISvpaBJMK2PmkShclVGuOmMOY8Dl4ucZlPMaySdcjA7/DXOUqk9V58Jr
 h4RuXzcaoB5no9htopatPHyeDoMYQwKpwEPHJh6P3k0n6cPPjYiZUv1wd4Dhv+EixMtR
 8fqTC7lLETHxJBPqHNwsijeStCPqiCs2Rl8lY/1N7ylFQ4tCrsUcXvk3BZTIeG0BAkCH
 ZWvKk9mU9BV3e+jIMijvaIvCvkRZABGPS/6VI1hr35wbe/3ePfk9Fj67bvPBUZFqnGRy
 1Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TdZ5GZorCml1FjL+yJ8DutcSWJmng0qMadQB/3SWejo=;
 b=QOWL8bY4vigVNv8POi16+X9YHw3QEozVh8qm66FqMi4T8BSTx55FzYPWNl0vTl1tWh
 oieAWeSQ65MAsE3uK6gpBcngmcYfUxWN5AsSkieUXU8+ZPVPt/SJFhJyjoCckDL0yrAC
 lmetb51fbqzP1XNQO0RHMVGWpsh6a7z3Hece9B4qeNW/4jjBXIOkG+JHhOMiA0RIJznn
 Jbqk9nfn41jNyyyy2hGfaOYWRAkXe9DoXqetsneqsWzRNxEhD53HFdHV15RXDkTYNXcF
 yO0nRzM/vNicOYVYeXwQHLhoi19lN7NToEu749Ewg/pHMo+zzUaNEk3zOTDkKsRs90Ce
 kw9w==
X-Gm-Message-State: APjAAAXt11jqPzQ27NEoDKztLS6j+HsvTzhO7GxUllOpfV2pZ+ZhQBgo
 0KhViYSz3YxjbxhaJj/YrPE8Mg==
X-Google-Smtp-Source: APXvYqxZ//7PJKVtHnxF4GltkoNVhf51+loeGcRau3Yqmka2drQScs+FLkDWp6ohoQESe5E6Wo4g4Q==
X-Received: by 2002:a05:600c:2487:: with SMTP id
 7mr4998009wms.164.1572032235260; 
 Fri, 25 Oct 2019 12:37:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l8sm3222959wru.22.2019.10.25.12.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 164991FF96;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 07/15] travis.yml: bump Xcode 10 to latest dot release
Date: Fri, 25 Oct 2019 20:37:01 +0100
Message-Id: <20191025193709.28783-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

According to:

  https://docs.travis-ci.com/user/reference/osx/#macos-version

we have 10.3 available so lets use it. I don't know what Apple's
deprecation policy is for Xcode because it requires an AppleID to find
out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index f2b679fe701..da6a2063fca 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -247,7 +247,7 @@ matrix:
     - env:
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
-      osx_image: xcode10.2
+      osx_image: xcode10.3
       compiler: clang
 
 
-- 
2.20.1


