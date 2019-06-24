Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B9C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7E5208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrcGtnpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7E5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPLq-0000Vm-1I
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41477)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0006fj-Cf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGE-0007dJ-Gx
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGD-0007Lj-5s
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id n4so12787225wrs.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g1Gikb/q4aJ790nsrLBBZxeFgZO8Vqq/Oo0RByk4pDk=;
 b=DrcGtnpFi3Ydl8TJ6ET8W4Atli+YgU6sjopl3d7io59NTYvCQ7Zp8EhjwkN5qRrmtJ
 C7s350UC4Fd/X5DzncZ+fg9ox45RyUQLr3VTc6JAFKZepSKFaqfDXO3iJk6Sv+ktSP9A
 JsaEwsu3f5lWmnkkHOhtxoYyC77lVlgfUOwSmI8VbGOJrKnEwZNY/7QvO8o0HBvUkWHK
 gbwm8xzv1W7rmNJEBE4guiDGEeC9aqt3rQ/dnG7yvfQOJs32RlgnuEFEfCQZ+eLcLKcM
 OvnZtI3z2zsl7fbp72jwEihnQTwjfw7XsNANB7NuUL15h/2fsgrt8aawdsU+aKWgJ5rP
 IAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g1Gikb/q4aJ790nsrLBBZxeFgZO8Vqq/Oo0RByk4pDk=;
 b=gC65MsQ9Ow1ctoFhqciViW04dvFu4YkM9BAEk4qcuZsm/QEHh//FN+IdSsaVk3/4Xh
 /OqWEdzQ4zFksHR4rqlggVrKDgRn00KTJyLknw0XyPBE6PwsaK4luZ8a7SGRlk8tXc3y
 WxknLiCdMM6u54VWWjFxQS37AeNsbRNcYYiX957jb3RoUNSROX8xQeZcoFPiW9uT+Ywf
 uFk68ozy0MGBMO+J5X+FpPGNn88jvd5vEucRDk4h9RreXa1f98ldR7mmuA5xVfs5ewro
 48tHwHGLrSHiECnGXzDakvti5hko9x7HXBKsDqofB8/GTtCbRl5vEZk6WOwAhOU91rZw
 pJ7g==
X-Gm-Message-State: APjAAAWgNy7zhWhlM9tkYsO7hT+vYCSvU/vyBOVgzL2xhL/nyMBxEtPL
 G7uEQ+GYYH47Wqf7XW8J4oImlw==
X-Google-Smtp-Source: APXvYqwcwsFNu5Nf5LHFzO5QTBW31YpnNRNSUnN+crPgC/6y760jgaykRecTvjIvPghb7KY+W9dXQg==
X-Received: by 2002:a5d:4fc1:: with SMTP id h1mr24334734wrw.83.1561383820838; 
 Mon, 24 Jun 2019 06:43:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t6sm11005487wmb.29.2019.06.24.06.43.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D53BC1FF91;
 Mon, 24 Jun 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:22 +0100
Message-Id: <20190624134337.10532-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 04/19] tests/vm: add source repos on ubuntu.i386
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

Possibly because of different behavior on the newly update
cloud-image, trying to run 'apt-get build-dep' results in:

   E: You must put some 'source' URIs in your sources.list

This enables all source repos (even though some are not
needed) for simplicity sake.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190613130718.3763-5-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 7017e6d388..3ea459ee20 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -77,6 +77,7 @@ class UbuntuX86VM(basevm.BaseVM):
         time.sleep(5)
         self.wait_ssh()
         # The previous update sometimes doesn't survive a reboot, so do it again
+        self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get build-dep -y qemu")
         self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
-- 
2.20.1


