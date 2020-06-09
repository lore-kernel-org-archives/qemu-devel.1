Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67306C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34990207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HO7zG6cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34990207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibhB-0003yO-FE
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeC-0007fp-5T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe7-0004Nm-SG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id l17so2340115wmj.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FCvzuxz79RDdPY0dCs+Wo9qWjxWoXIJFo/KmJobCbzg=;
 b=HO7zG6cv9qA9bgWA3Mx0IJvsWOK0Ljjjp2Zgg1J/SrNN/PTWimuPAkpUy159LZut81
 5jFI+X1ZK2BgpiZgqHvGfdbgtcDp5NflTrm3FGn1tsciZREEsmiswq6IGR/gmHELJOq5
 ZTwAYaO1izBzzgvV+Nt0I5sEbwsRdDxzwUwI3yY/SCnCTIu99td1nCElMLgAsvm7V9op
 bmJ5qFQH+NIAFBn/BStaEgeRH8kkNsbIuPumzow6t0YivqLARmf0Lb4zkdkqnmqG2gdH
 ypWkUTkXyui2yBe6HSf9trDP7/u3Lk8okdq0iiPJXmKguORgPlqwI/FpkKu5UkYa1Cv7
 1KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FCvzuxz79RDdPY0dCs+Wo9qWjxWoXIJFo/KmJobCbzg=;
 b=bl45xla9tRKyXqT4sN7lYKeKvb10yr1k0AKRbqZ5WKoGNubHY8/AUeEYbs1ihDChLN
 X1rbZtxpV9KG8bYazkm4sZyUDomNtb7AKbXEPNQ9ojIZRM3PX9sRvZAWY60IXsCnfCZ6
 nS0QnSfKjlXJVGUejH+3N6Un02Oo2h7ZWlanpCGumvppxG8b6VQHcVKVSQ4Xrwhyrkwl
 nkCWmB1WxgImAp4YMh+Fe9KDp3NBKTIFjIFrvBsX24NHnHcbXKRGyBscixwOYPUD2FGy
 /5cDmJx2ks3rrb5hJPhYYIEU88ouZaWXYI3JZ2MTH7iXw2dlvt1SF+k4hILBLoJ2zm5k
 Cj6w==
X-Gm-Message-State: AOAM532DLBMf7uVCA9UGqnOJ37CviMKxqURzfeDS9bCOj5whHhO7nd98
 zyw0hCWOF5NrbOkICs/lXwgZGw==
X-Google-Smtp-Source: ABdhPJw0NzNHM2r60rDbPs5B3OZNaq3Vc1EYuk6cxZ+uSwXktCV0ydi0U37E99aI3yAcIPu0q5hpzg==
X-Received: by 2002:a1c:4954:: with SMTP id w81mr3421321wma.86.1591699097710; 
 Tue, 09 Jun 2020 03:38:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t189sm2507096wma.4.2020.06.09.03.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E1D631FF92;
 Tue,  9 Jun 2020 11:38:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/17] .shippable: temporaily disable some cross builds
Date: Tue,  9 Jun 2020 11:37:58 +0100
Message-Id: <20200609103809.23443-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These currently fail due to Debian bug #960271 as the
linux-libc-library has a user-space build breaking symbol in it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200605154929.26910-7-alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 2cce7b56890..10cf219bff4 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -5,8 +5,8 @@ env:
   global:
     - LC_ALL=C
   matrix:
-    - IMAGE=debian-amd64
-      TARGET_LIST=x86_64-softmmu,x86_64-linux-user
+    # - IMAGE=debian-amd64
+    #   TARGET_LIST=x86_64-softmmu,x86_64-linux-user
     - IMAGE=debian-win32-cross
       TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
     - IMAGE=debian-win64-cross
@@ -19,10 +19,10 @@ env:
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
     - IMAGE=debian-s390x-cross
       TARGET_LIST=s390x-softmmu,s390x-linux-user
-    - IMAGE=debian-mips-cross
-      TARGET_LIST=mips-softmmu,mipsel-linux-user
-    - IMAGE=debian-mips64el-cross
-      TARGET_LIST=mips64el-softmmu,mips64el-linux-user
+    # - IMAGE=debian-mips-cross
+    #   TARGET_LIST=mips-softmmu,mipsel-linux-user
+    # - IMAGE=debian-mips64el-cross
+    #   TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
-- 
2.20.1


