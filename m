Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EFC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27B92173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXYaB+vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27B92173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmXU-0006tJ-0p
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:09:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmOE-00075n-2z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmOD-0004xl-0C
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmOC-0004xD-Nn
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id s15so4009522wra.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BruQFJSmyR8ZsEhlY42Yrz/6o7DH3AvksulnhVRaQWU=;
	b=aXYaB+vktXvYqhzIAlcqMSfT3UIKylD4W5gN16cnli8OURj0OJJyRmSor8Sj9emZX5
	bClYOyiRXpv4dUFnGmrIroJuV4hRkk5tJN3OY3NxYdQyoT7l76jgjZl4apJ2uF2Zbmp8
	/xB6CXqlYcNb3EUo4VeTMoPeckhJzCRIGRpgO1wE+6ThS4KCjMZ2jBfPxY/wXtE8YNjJ
	vRvUhtXq01KtB7VsiKqaUW+g4ihnuxNfFMMlzOAwfYCuojcYQxBO8NFmDvwa+OJhzNoE
	b0iI1eUb9iiuW3C1iOzSKgGwl/KtVItZgoOeXLQHOG8idI6gmw51qmiCyzrdnGYTnHoC
	0uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BruQFJSmyR8ZsEhlY42Yrz/6o7DH3AvksulnhVRaQWU=;
	b=KbR7CRBELovGbD7mEn8H89pBBFquURuMJIywabjj4s6d20/hhEfIVJmDNHF2HnuG7e
	6Lgk9zIaoDgj+6g48Ml95HF9WA95odMQ5tOhkSfVr1wVOiJgKZj36CYhzrTgh3hQkApG
	Wv+bzrOeh5KTZnNHsZ57vU4LlJnPJEcV/cEcXN/WAbo3v83ilxXiWon5ZqlwjsTytWr7
	V0zJJg8W/xHCkpcA5l6jeQBU4xHQQlvcMCUmmAfetvVo+z1RUguGirsiqKkCvJIjKF1K
	C0i2XxqkSwc+kxxkU7E08drgdVRu9++5/mWjrQJp8ZPQDOrhxLfoVGkKGw/aPLtNr1Sl
	hX7g==
X-Gm-Message-State: APjAAAWzIpTXxinAq89+T3ApsVYM/GDDZRyzPga24ijV1UrgNahIjqB7
	MkVBCtoi5ArAYy0XNgQTaVcERQ==
X-Google-Smtp-Source: APXvYqxjt6iEJwNN/6oioj+FX0PZ2hz4SHpbbhqg/LcfylBgi+rJh32qmec+qRuChMRL2rvl32Ke7g==
X-Received: by 2002:a5d:458e:: with SMTP id p14mr4043359wrq.318.1557421163682; 
	Thu, 09 May 2019 09:59:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z17sm3625846wrm.33.2019.05.09.09.59.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7423D1FF87;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:05 +0100
Message-Id: <20190509165912.10512-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PATCH v1 17/23] tests/qemu-iotests/check: Pick a
 default machine if necessary
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Max Reitz <mreitz@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

qemu-system-arm, qemu-system-aarch64 and qemu-system-tricore do not have
a default machine, so when running the qemu-iotests with such a binary,
lots of tests are failing. Fix it by picking a default machine in the
"check" script instead.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190502084506.8009-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/check | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f9c24b6753c..922c5d1d3d3 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -130,7 +130,6 @@ export CACHEMODE="writeback"
 export QEMU_IO_OPTIONS=""
 export QEMU_IO_OPTIONS_NO_FMT=""
 export CACHEMODE_IS_DEFAULT=true
-export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
 export VALGRIND_QEMU=
 export IMGKEYSECRET=
 export IMGOPTSSYNTAX=false
@@ -564,6 +563,18 @@ then
 fi
 export QEMU_PROG="$(type -p "$QEMU_PROG")"
 
+case "$QEMU_PROG" in
+    *qemu-system-arm|*qemu-system-aarch64)
+        export QEMU_OPTIONS="-nodefaults -machine virt,accel=qtest"
+        ;;
+    *qemu-system-tricore)
+        export QEMU_OPTIONS="-nodefaults -machine tricore_testboard,accel=qtest"
+        ;;
+    *)
+        export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
+        ;;
+esac
+
 if [ -z "$QEMU_IMG_PROG" ]; then
     if [ -x "$build_iotests/qemu-img" ]; then
         export QEMU_IMG_PROG="$build_iotests/qemu-img"
-- 
2.20.1


