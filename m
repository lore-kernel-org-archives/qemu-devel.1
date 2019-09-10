Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FBDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCBE206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcR+lngg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCBE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cBD-00089K-F0
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqz-0000sk-Kw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqy-0000ff-LC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqy-0000fF-Es
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l16so18350541wrv.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SR2u2Njn4Tu4kLUbOMpSvZxbFz5v5AyikcOmiSFMewo=;
 b=OcR+lngg+nBYtk0Cexz9HssB64Nm7X4M5TOSGYSqfFfT/IRiCn668EnmUsKqaOic1R
 Av0qcdhL3CWw/fgAjOustWmnGem9BiTst9vzdv2dQ3QxpdxHtCdd3wkZ9NkfIa4A3sQa
 UPcsK+2jBak6B8S9ECkTtFiSnZmzXm+cRPSguLEFdlQ3KvjpPs67PgSNu35/558HbVkR
 luhVgpsfotOEvo/oYFfn+q1dqrhTgBXhLb9mA0VCazlRY8tYD3oxoTG6aS6JZCvasfGA
 iYKNKHGtU6qmJ+OiJVPZRQUKGpT8Hy+OcENdcRQculGIEdR3wcO3E02iMK2oLI5m/5vG
 sydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SR2u2Njn4Tu4kLUbOMpSvZxbFz5v5AyikcOmiSFMewo=;
 b=OaHL6zhJ+DovKy6tnsMXOe33hpe5ZLeZdw3ysRz7EKbD/EqOGVGuCmDW3Osfd2e2T0
 hg0zuTxZT5eaXm0sOv96pUQ8PO5ApJW4AgBJsL6CrlyVxkc1Ciwn8VteO9e6l4VX0J6K
 QIJmzvIzc6L3D/HQ0v957N4bWQXaloSkguxbBEtlqTZSNVOAezsE3a6gsifVaLnZ2hUF
 88VAePiEmdcY6IPLLBImnCJoc5u1BSVV2AocI/sGVeFzKtYPWTK8xCWfM4jWpsbCa2jP
 5gN6FF/iXNu/3RY/YV2XksJDAgPEMH4rts23lG0hmQ5vfChqESp9ysDhu5qzXDEdpmwS
 JCBA==
X-Gm-Message-State: APjAAAVZ2MxlQYbQ78k9+ki8eZQ2qINdKm9hCb/ICY4nEUYj3vPw86AD
 1fdpOufZf+Q1r7nzqp+5hpO7OA==
X-Google-Smtp-Source: APXvYqxCt4MAWdruIC8J9letz1xCf7QztqXiOxokYxcIlQkzwqNsg1RxyOz9Qbu+eAIVr0EANv1nsA==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr25287666wro.288.1568105423473; 
 Tue, 10 Sep 2019 01:50:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y12sm9499221wrn.74.2019.09.10.01.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B06A41FFC5;
 Tue, 10 Sep 2019 09:43:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:49 +0100
Message-Id: <20190910084349.28817-46-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 45/45] travis.yml: Install libcap-dev for
 testing virito-9p
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

So far we were not testing virtio-9p in Travis yet, since we forgot to
install libcap-devel. Do it now to get some more test coverage.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190905113346.2473-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 1ff26205795..d0b9e099b9c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -26,6 +26,7 @@ addons:
       - libaio-dev
       - libattr1-dev
       - libbrlapi-dev
+      - libcap-dev
       - libcap-ng-dev
       - libgcc-4.8-dev
       - libgnutls-dev
-- 
2.20.1


