Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70509CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3053320640
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brddRrEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3053320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzsF-0001uY-Kb
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzeh-0002Rn-Hw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005LD-8o
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzee-0005IF-1M
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id q13so14346668wrs.12
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+VD/m4Cu25zUbCunHR/eAJrfDLHr+QomcQ2i0WEOmJw=;
 b=brddRrEK/jdp6QmFZym0ziDgj65h2hVge/R16d0Utn7KA06D3nJVehf14ZZyHOfYS4
 8taWqyAyfH9+b+YR5ZJSVPE9VN079+zHpKnkOVhoLGq+CWT5rHUsmvuXeBn0SjAF2YEH
 uDh+SCxpx/FhlVMqrRq935lKsUGO10JW7uW9BLLCAdAHz9MxZrqj+dW6Nq3/gca6esFL
 hnmAa4A/KCcjqRyuGE/oafiayKt4iHf0+jg1RvbLlp8zKfbE7hrpXBorIgNBu56Dhixi
 B16Rt8CNU9VxLLDQrcOGslDFimDLGiWR8ZqJM5QUn6nojpJTz8CfiXdP4yinFiJYz1Dv
 zLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+VD/m4Cu25zUbCunHR/eAJrfDLHr+QomcQ2i0WEOmJw=;
 b=YXoB1kr6axiG5kiatAsNi/uVjrjapKyfPSKyMZ3dEfWHF9Xz7oqt0mrg+G10Hp5wOy
 nQD6kF4wJ9MrdT9qkCXl1t/cWNDWRG6aqD+w6Mi/ix3CB1Jcyg16xkhq+zdGo9KhOFya
 TyY/OZawMN7khsW3WKMiraIRqPAFfXO2ole3eCwsyjh+6zrIxr8HsO3CbfQaHqQFGNOE
 G21zZSGaZ4wksS8kqnGgy/JERhxDqSyrGyncnK8r0fMkNdxN2hRVeaMcSHRcYjiTZjo1
 Rx7hzs8Cy55o4ModdwJXUzUfKOpG2VjCemDkmxiZJgnPnk9GsW4Y1eD9aZVIis6E8cLH
 K0Hg==
X-Gm-Message-State: APjAAAVXlkFuj+jApHrJmB4Lr5+4Ra39ZubQRmZZ/fjFYNvwSrEK4h/Q
 WVJb/qa8wcI/FIBVVpWC8Zwzog==
X-Google-Smtp-Source: APXvYqx0zGa2vws3JlLAwLTkQQ0Y/LbfMCbVriuIO3uY/9HByjbJ7tXdJfAunzlcscrS4mCNXR905Q==
X-Received: by 2002:adf:db81:: with SMTP id u1mr4783094wri.347.1571771833191; 
 Tue, 22 Oct 2019 12:17:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x21sm7054233wmj.42.2019.10.22.12.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA3E61FF98;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 08/19] travis.yml: bump Xcode 10 to latest dot release
Date: Tue, 22 Oct 2019 20:16:53 +0100
Message-Id: <20191022191704.6134-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
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
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As 10.3 is available lets use it. I don't know what Apple's
deprecation policy is for Xcode because it requires an AppleID to find
out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


