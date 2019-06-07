Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D50C46476
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3873212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMYxmG3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3873212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZB8Z-0003Md-VO
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp1-00048R-TL
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp0-0004R1-7Y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAoz-0004ML-W8
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id p11so1344871wre.7
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+SKipxqDiHRib8HzDeti6YzGOBFsaSaAYfMEIKsinVY=;
 b=lMYxmG3RToTynruFovsfKYuH3FC/2j3/M00lxPrleLwTPEf/zix0ZGiEQEEUQugjFR
 DCZWpIF0t4z75WrONvGED/EgGZaaR8+E+ASD19Fkoz1JmB25YLCgA/iCXmA9SKLaCHqH
 nlo2L8D7Vr2Otp/b7rj0xaXRvcx5fLCig4/gNBqiQhhM5kSrJwxQi0xxRjvlwEwMTlZk
 7doSWfbu8RoZvY66xMbWqIuHP4AkHQKO7APVIUfiIISDWuTiExGJdR5ubdBLK+y0RagA
 duMkWQ0OXY4+SAJSN0eRQsUnVzJUqhteWh8/k8WKGOfpIRSQ97biCNPO0c84vXXcdrAQ
 q+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+SKipxqDiHRib8HzDeti6YzGOBFsaSaAYfMEIKsinVY=;
 b=PweT0xPopbUG1ZnyPVUaW/5Ip2dHiGScki1lTCTlMDnuaOIQ3E9LOMiIZEKPlsTNyT
 nokwe1Jja29Cj1yR2El/myjXXjQlAbSBqovJKv7lisZ9L4+FNdT4XoxcIfvTUG0W5S7a
 5efPRYhZjXe+YdmQi7I7cXWYmIxq742vm75A9C5+smd4StT82Um6lo/Y3HhxUtuM+bTu
 CnmYeszV65Szo/gzxfoeqQ7Xwe6EKtgxE7AodV13CZd8wgSwrMddMmvxET48tfrdmY+n
 3rSh+1+VKYKS6KsQ43rdceSaw+xl8ADAiH4a7NCmE7EdW8agrWjdVAAUVR9vZXDryIg/
 16YQ==
X-Gm-Message-State: APjAAAVYhGd7qQnDUqi4Nuoj+Krd1TTkGEIkR3spDTGX9WPQl6O80hwa
 cwki1ZKPlmFWjc4cHAkEINh7yw==
X-Google-Smtp-Source: APXvYqxVwgYs0TG1qlX0mu+HwFknbgr2QWIbk+URE6/vBegD7WbJGmES+6sEBGhc1or12d/Fhzj/Tw==
X-Received: by 2002:adf:8183:: with SMTP id 3mr19050280wra.181.1559898360433; 
 Fri, 07 Jun 2019 02:06:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z12sm1046080wrl.37.2019.06.07.02.05.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:57 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2D501FF98;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:07 +0100
Message-Id: <20190607090552.12434-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 08/52] tests/vm: Use python configured on build
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

Changed the vm-test makefile to execute python scripts
with the interpreter configured on build. This allows to
run vm-test targets properly in Linux distros with Python 3
only support.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190329210804.22121-2-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 992d823f6b..6f82676306 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -35,7 +35,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 			$(SRC_PATH)/tests/vm/Makefile.include
 	@mkdir -p $(IMAGES_DIR)
 	$(call quiet-command, \
-		$< \
+		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		--image "$@" \
 		--force \
@@ -46,7 +46,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 # Build in VM $(IMAGE)
 vm-build-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
-- 
2.20.1


