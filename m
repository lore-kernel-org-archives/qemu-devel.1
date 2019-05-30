Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D1C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1043F25715
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0zDxZwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1043F25715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIC1-0006Qr-8t
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:21:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6V-0002ZM-Lz
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6U-0006Th-IP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6U-0006T3-CA
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so3788701wrr.13
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=yQmtSC53V1a0JKg4AWzdnb+vwP+cvIVWjcrHwPCZ1/w=;
	b=b0zDxZwI8DCcavqQEsrfZ42GgsfYbuubHXpdanDl8UCYoA+7sIUhLeDQilG0bearmk
	PNxHJDFlY/O+fcH0t0C0J0j7C2+c7PTgGE4Q1tOYT+bS5lZeyeaEEuBOzKj6e47Xfbmk
	Qod2uN30J/GQW3oui14+m+9LFLNZQdfcbyjU58yrg83bjeOYj95CFGh3UxG3epDBUNDx
	j0MMH0tlWL8RNIb+ksbZsdzPOQ+fL+yGsuT+O5XVK0YB82zzTGBKJx8GAb2RvAVtgnd5
	HnqOj8hjR+ptYul3NbeptQYDR+IZuKOj1lfuqk5GHg48fTS06ah15LH0+tEpg5eq8zsE
	ZNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=yQmtSC53V1a0JKg4AWzdnb+vwP+cvIVWjcrHwPCZ1/w=;
	b=Q+AcSyxQOSSloAKMAmeyF7Tf2nmjbJbWloeiKlJIBf2xRBEWr/7Jkc7bcWTIn9d3Cr
	qBeBtpTqe4ZLvMZ0sTw6NjbxFDBZQdNn5gn/9fB1Ey45MLw7IzrSrbFBZ2I4m15VkA5x
	2D7i0exzLk+unW7Gam0IV5QNNm//xDTCLgipJtGg4so3liUu/9KqNMljvv/1KR3FyiZE
	4ClwOJQUApyQb0t3sD/5qKwKnhAKVmfMjfJj7Cr5gdlSr9iqSWaYq7nhlFOmzsIPw1F7
	sSaLsvLOfEEND3BlZLELrN83AkpFaVCsrCoHjtvLrZsJ6QD9sxV34EzA40SRUdTH4U6J
	7qIA==
X-Gm-Message-State: APjAAAWZUGW6/ElALClPow/tTFrnb0ybYl4MXyzzVtpSkse5KyiKPe6r
	yXyWAM7N4KBpmrem6f6hznHafg==
X-Google-Smtp-Source: APXvYqwmFHRoNHh7v6ItWKRgKwUuYTrm4LFft7EcwdlAa9JZuTprh3t/0wMkCrKRVZXpV4XExmXCoQ==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr1864752wrv.61.1559211369320; 
	Thu, 30 May 2019 03:16:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	u14sm2690100wrt.75.2019.05.30.03.16.04
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:06 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5E5A31FF91;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:41 +0100
Message-Id: <20190530101603.22254-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 04/26] tests/docker: Update the Fedora image
 to Fedora 30
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fedora 30 got released:

  https://fedoramagazine.org/announcing-fedora-30/

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190528153304.27157-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index afbba29adaa..12c460597ed 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:29
+FROM fedora:30
 ENV PACKAGES \
     bc \
     bison \
-- 
2.20.1


