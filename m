Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEBC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D48A21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDlR7Yvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D48A21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rMr-0000Z8-9J
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIH-0000iD-80
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIG-0002ih-5e
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rIF-0002gr-V8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id z12so1786401wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I5SVyZLmK4mKEgyCR0TafKDKBPyJxm72cVAZ/22L6J0=;
 b=bDlR7YvxGsvJMSf7oTX1D7QQi0TIF2iihLHiST4iwwdE+qjWop88yJRgCt1IQaPuvI
 JW62Q4nNdu6Y4G1RWFXySlk8MX+Cbdv3WR0iTeWuiJkewo5owHCbwwuQkZCkJMAWTYjl
 y6glFdroYmGsqNo28XgDo1z87OrHdO4g0L2tMoOXXTpLVVTAXqtWDFKgW1mocbHecf7q
 xos89dsCnwlZ3QCu+9M0GG/1qrtc184JtCEdhWOqhsK+ia39VDoV8wwBxbmUaFlzYw0E
 gW1KrKNJ59Kh6oWcbQ+vqJi7PISUWCrSctVg4SbkfBg83xTcm8KSw/4Mbp51HcaFl/37
 XjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I5SVyZLmK4mKEgyCR0TafKDKBPyJxm72cVAZ/22L6J0=;
 b=jKCQvZe0BDGmSdSh0rYe6AvC/JWrT1uCax8IXTiElmPQ/F4R0BRmARqoj4fbkYEOyX
 V+QP/pnoAfkF+6ABuC6l73zY4xPAkcLPlbhEqpXuvFqTELJO7M5rNuHZz+/9bToNwQ+O
 ABka7bRbfjmQbYlZ6OIsKdqQs9Pmm+iAniLHBNTFJzlkGfVmJgfne8aZIwVzr3K6zct/
 Sx14fjDOSQ4NvHZS7SLZx5n+AMCkWD3PkbckcPcf1kzk6++LxGW+OiJSGG8tLvTXnMie
 VAHIqT4PhuJeR8WL0hGlBQ7cqtaQtWbd0I3lRhGDB8M0vzTA2ROeFGOMImMnae3dxfN6
 3OzQ==
X-Gm-Message-State: APjAAAXaf7fP3CXG4F4aI9SGJ46oaCM1/gCzjR1MRaCJebk5cDrmOz5B
 NIrX/DaVlKHpb7Glh3AfIOLTRA==
X-Google-Smtp-Source: APXvYqx2yrKnsPwfAzZwZcgX8elDvmw3d+1UURZ7gk26dYeaJxU5dTFoAmIqTSJB/w5f9HeRBAycBg==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr3776989wma.87.1582702782893; 
 Tue, 25 Feb 2020 23:39:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p12sm2092249wrx.10.2020.02.25.23.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:36 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EF6321FF98;
 Wed, 26 Feb 2020 07:39:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/19] tests/iotests: be a little more forgiving on the size
 test
Date: Wed, 26 Feb 2020 07:39:18 +0000
Message-Id: <20200226073929.28237-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Kevin Wolf <kwolf@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least on ZFS this was failing as 512 was less than or equal to 512.
I suspect the reason is additional compression done by ZFS and however
qemu-img gets the actual size.

Loosen the criteria to make sure after is not bigger than before and
also dump the values in the report.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200225124710.14152-9-alex.bennee@linaro.org>

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 3500e0c47a2..af677d90b86 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -125,9 +125,9 @@ $QEMU_IO -c "write -P 0xcc $offset $data_size" "json:{\
 sizeB=$($QEMU_IMG info --output=json "$TEST_IMG" |
         sed -n '/"actual-size":/ s/[^0-9]//gp')
 
-if [ $sizeA -le $sizeB ]
+if [ $sizeA -lt $sizeB ]
 then
-    echo "Compression ERROR"
+    echo "Compression ERROR ($sizeA < $sizeB)"
 fi
 
 $QEMU_IMG check --output=json "$TEST_IMG" |
-- 
2.20.1


