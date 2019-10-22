Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30DECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2BF2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ucj53R0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2BF2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzh5-0004fc-Bb
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzef-0002QR-Cb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005Kz-7R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzed-0005Bs-Vv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id o28so19317122wro.7
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TnPzYaJ5mZGC1gX/sWa80nvOZ3fKPxbclnFkNmnhS90=;
 b=Ucj53R0jBURBr9BLTb2pC47IxubLSj4qQnxUD4Uo7xfUHLPqA6gNVsYpfjxMKZc0y0
 icmxOaThm64wodFgZ02WmU2jkhzZHZKO1Ud/v/jxb5vF4ENZTuv520tldekpWHTQrJdT
 HCsPCftMGXkbqx7frd/UClqFQqZF9ZYxECCoHPbZ8ftlJ5A/ebUtij9xLgfzw/kUAJVY
 m1TPZBARstgZ5W3XtygJkepeednPFF7heahl0+JCXhU1MCUz6Z7nZKCQ+ccshtevEDkb
 MqoP65z2z1VAjPeUL0ezJjqBB+im98cetA4T8ZF9eJscUdqx+rEShlMDToVJHq+VjnSZ
 yVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TnPzYaJ5mZGC1gX/sWa80nvOZ3fKPxbclnFkNmnhS90=;
 b=npRKZTv2DyX/Y7LdyWV6KPq64CPYZHy238X8kBoWy0hQcd0Kj9cMb0EPoqX2JRxv3x
 YfTVVaScpaWmXSJXv2PUMMG7BfodA6b1SNGbaUmgJBmVWlgp7odI6BhMJbQ6/g7bl8aJ
 F3canhPXLMvr9LkV9QqRxiRChjavvyvvpyotmAud47p1OkZX3oBMxgjNxX7PRUNbSk7w
 jG8IG+QDUJ/c5FTK2R/YgdAs3aNAFXkpNZ44bJ3GeDxgr3L3ry1PDFfeibTL5Rs6oTL1
 HESXumLY40LOIii/a6XVtsPHDSs1Py8U0n5YQqMEM6tDZpxCqyH72Ape3Jur2767FvYy
 v0jw==
X-Gm-Message-State: APjAAAUmT6/zbmmVWNxHRjZlMN231DSYuFkpZKBmfRMRgMmORrlRPdZD
 phkBzg7F+ZShz0HDDLyjAOzx2g==
X-Google-Smtp-Source: APXvYqygaO3Jo/cjhfZGuzbP2G30pC/RCTQbV7whYacRTlcUSD4SEJCW7BR/0khAcfNVtZZUvhu57Q==
X-Received: by 2002:adf:f447:: with SMTP id f7mr4716331wrp.210.1571771827248; 
 Tue, 22 Oct 2019 12:17:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o70sm26017848wme.29.2019.10.22.12.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6640E1FF8F;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/19] travis.yml: Add libvdeplug-dev to compile-test
 net/vde.c
Date: Tue, 22 Oct 2019 20:16:47 +0100
Message-Id: <20191022191704.6134-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

This library is needed to compile the VDE network backend.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-2-thuth@redhat.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 7d90b87540f..7be2a9949f5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,7 @@ addons:
       - libssh-dev
       - liburcu-dev
       - libusb-1.0-0-dev
+      - libvdeplug-dev
       - libvte-2.91-dev
       - sparse
       - uuid-dev
-- 
2.20.1


