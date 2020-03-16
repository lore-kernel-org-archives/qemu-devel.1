Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F0C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1366A20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZ63sTDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1366A20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu6O-00005P-5i
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRM-0000eI-JJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRI-0008GJ-RP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRI-00082C-Fs
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id a132so18580312wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZZCLDV01NVJMn0TsI5hdBQQvWUb6UiKnEo9bNWpw6gs=;
 b=rZ63sTDlVfAcYzRWg00N/5cdhSxvYq8tQ7rIJdD2Hjwlh5YZsaGi/lTL6eKel5Zxco
 LVVY1UfozQXF7JgHynTJQyzibiqzpIU+DHAmoiUQU9x62S7gCKSAjYBG4VIh4qaNRdyl
 7s1XkCMLw7O91Y507W2qtcAbZ0oSX1bxmcw/EqCR8MGvIByh7Fzfk4tbbYFFcQKCBu6g
 +EUjYCmmNaTXB62y47o6Pc0RCS5/LSfWNqENnfUPuaSu1+WnAK12fYEkfWUCdVyR9H+l
 fZclHfZvnuQKyHW8QXtebbjk95yQXqgnXdNgAqG5XuhKRKUrW/2Uer+oTWO4uifwGMqu
 l3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZZCLDV01NVJMn0TsI5hdBQQvWUb6UiKnEo9bNWpw6gs=;
 b=dAIF/2WTdzuMetgooInDmq2072IZtv7WekzK6rgP10g3yW39k/2YdV37hrOydO0r0s
 d9FpKRp7+LqCOhKCeu9z8UuWi2i73v5bCLX63EOLwGKJQmTUOIFw+STe38VwZFhJaOTB
 +ZvkVB7bJUosz1ht1sLc5KXRFm4St/yn5j01w2rhV+uBTPN1UjliiUpFGWdv/U3U5aNt
 4MSdy1iYLPMuEZqFFzT3K25ha3GVzYoxrxjelx15OU9T+lCZmjE3jJh8dX2WAsFmSl/2
 CeiOiSVw57c8/31DuMzvP3hQk2r1qEzHR59pZfwHvRvlRq+4PBRhxEF3lMP9ZFbsPZnn
 eFlg==
X-Gm-Message-State: ANhLgQ1ZEvGr75oFNZtd72J+wWyX10FStxnBSKp8/OA3HVbaMpqJqbf7
 NUDrVeARfYDrHh9MCQfmReb5qA==
X-Google-Smtp-Source: ADFU+vvyAHLXN1VLmBH1AYEhQ7T8o/iXogIIBJfEd8MeQ9as9PXJ2jSPURLbW17Fd+D3G3zW3+7WJA==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr177487wmg.52.1584379326311; 
 Mon, 16 Mar 2020 10:22:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f187sm457188wme.31.2020.03.16.10.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5295E1FF8C;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/28] tests/docker: Update VirGL git repository URL
Date: Mon, 16 Mar 2020 17:21:29 +0000
Message-Id: <20200316172155.971-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

freedesktop.org is moving to a GitLab instance,
use the new url.

- https://www.fooishbar.org/blog/gitlab-fdo-introduction/
- https://gitlab.freedesktop.org/freedesktop/freedesktop/-/wikis/home

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-2-philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 3b860af1068..b67fad54cb7 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -27,7 +27,7 @@ RUN apt update && \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer && \
+RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
 
-- 
2.20.1


