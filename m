Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC294C28CC3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E21421911
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGjwsyhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E21421911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIHL-000301-Py
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:27:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6c-0002f6-EX
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6b-0006aX-Ju
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6b-0006Zh-Al
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so3823154wrt.6
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xFNo43YFBlGXQTu9u+IzwiFY7MRIcliAhPyrexXbSw4=;
	b=aGjwsyhpJaISYkAKaegqef18bmnET9MGNJhLPvwin5OYecXdS5j8OilhPw2iOzIN5Z
	l6z3sNIxNC4428P1VhbmVEnBu70f5bB/ciSX8L4Y6wz+ICKS0L7wlKJfc5OrQJQteQ2R
	pezeixNxxn4Ddorw2qlh/wm5Ua+MWZeb56xtNq4Omj+7PQC7NDzPuUpQjRxRfGLOKYPH
	qoV4JeKcqok3eQp6JUbOMGVJdvlkW3RzUPF6IUS3CBReFtstDKmbTHYN8d6DCVutoV4e
	FriSvQmJFWux1UiDDtBjrM3ZMB4r+Zw32f8cHmruK2UT53LhMnZIiBMZ1q21N6bYbzhm
	I2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xFNo43YFBlGXQTu9u+IzwiFY7MRIcliAhPyrexXbSw4=;
	b=h7u91pY74T8omO6V4HSt7ZPr+dIPlxJqZ3qffRA3ew61FvlEnSGBur/mk2earbyDzM
	QawGoqwZX57MAvAa8spmvADzCyQb51kSrP58ZA4hYyPMT495GIgmw7+SUCVCPCH3QBSj
	KM5bbQ4g5TrFqcaGQBfb56E1qpVpuyHoayHiWCOKfA6IbOHE3xuw25dZD7j4JSsu4McX
	/WIVEcJyd6CiZMQskN4ffO9Lm+XkQpMRVBwHJtjuoYzTmJ+PAIdPaiquq1BqXTbiVuNQ
	rQfKp63H/rt/P6y6qbTuQPK55+4mJn+YQcAdr0ctB5Mh+XxQRU8jhNQl77WmH2KmBNO7
	2UJw==
X-Gm-Message-State: APjAAAUlhq9QBW7d4cHRVqfsU6sxNhhAheDQ+aCiZ4/w7brKYDjRYf5p
	1hGiV1EGStaD9eEJ2gkx9ZhMD/eDK/U=
X-Google-Smtp-Source: APXvYqxWfR5ka4YxVTg7uJO60eRpfrpaBivarGhzWUZ0TJGb5+N4KuC+QC3y+EXmq3pTqSIFAltonQ==
X-Received: by 2002:a5d:504f:: with SMTP id h15mr2043355wrt.208.1559211376335; 
	Thu, 30 May 2019 03:16:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id j2sm2338652wrx.65.2019.05.30.03.16.07
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:09 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C32581FF99;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:46 +0100
Message-Id: <20190530101603.22254-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 09/26] tests/vm: Use python configured on
 build
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
---
 tests/vm/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 992d823f6bd..6f82676306d 100644
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


