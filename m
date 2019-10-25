Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1AF2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smYSJqcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1AF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtKN-0000u4-VV
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDw-00036P-3Z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDu-0008OG-RF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDu-0008Np-LD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id o28so910579wro.7
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TdZ5GZorCml1FjL+yJ8DutcSWJmng0qMadQB/3SWejo=;
 b=smYSJqcHCcYvobR7/VDxV3lMDqhuscsa2UqavQnx/Hsf/n+vM9Jfjos+eJCmLo10iS
 l9AD86wO5weQ8gTB+ROzfUd7q729LksArF2SGsL9vZ432037qpvgLVdw/siw71Stnp6T
 3cs5D8kVVOxS2rIrsgH220Mgck4SpageQqmZ7JhbARUVEoUl0tN6QerHfU8zP81uHs0/
 IdVntJXGT6W3WqPqJtznfbqzfKqr2tmcIqaFxWzxNHYDD5/RAZVeUDY86eXoGYzGVPm4
 oEDPDQyxnA2fWw0vOyYj0FvvdAH9R/PL/hbxkAQdTblphZ5CYJFZ1J01pghiwk70BTEJ
 dB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TdZ5GZorCml1FjL+yJ8DutcSWJmng0qMadQB/3SWejo=;
 b=XMf/nPtt0Qt615gVAeezH/+DGvmW1uNYRGDYi1evjSngydTgDCUTGI5KgFAd7aPkvV
 KI1N33YMza3vNirMCUj7YXnlFkE0H93HVo+Mziu4nzt5NKpsPL/DIoyVzAcp1B7jnZbc
 lunG8Jqbq5VJEMtZjBuqVzDAuG1Cg6bGbKvF0i4qewBZKYPKtfpJIz7+RMabHThHMMn4
 DCpf7q+zNj/aZ3Y97Oc3X0jHr6B/0O+tqMeXmJkWwsqnw+uARd2M2N9ExUXHX5evitln
 MWaAkARupzBcPsJZlyor+fT1nlG0TKTKleL1fkutqYWGCpxja51Csnw74a6afX2U+Ecc
 Fj+w==
X-Gm-Message-State: APjAAAVcjfAD204zM0j3/o8yPHSpYRWEeLSQOMtigKjcaG8igr1NyqJX
 Rvmr1NJJVcswzg7GjfdDaQ/2qYl/gNA=
X-Google-Smtp-Source: APXvYqwr6cETFaexJukUH7hOCUx/9WDAf3Pt34MyqT1Q0oYM4z8U7fSueY/SCgRKsXxkwdoCxXtSYw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr448426wrl.322.1571985441631; 
 Thu, 24 Oct 2019 23:37:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm1278343wrq.52.2019.10.24.23.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 591F41FF96;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 07/73] travis.yml: bump Xcode 10 to latest dot release
Date: Fri, 25 Oct 2019 07:36:07 +0100
Message-Id: <20191025063713.23374-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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


