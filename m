Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EDC5ACD7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD84020735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUEM3lOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD84020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGO7-0002G5-Us
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMu-0000Ke-Fy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMt-0002Ou-Ip
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:08 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMs-0002Bt-AB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id 6so26871668wre.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IMRyldADtWFAPXkEQJ3RH0vIzu/xA/WRDnShCl/zgaI=;
 b=GUEM3lOu7uriy+U23tyWVTMCaZCMs3e0wSz/pfjCY30Df3cb96nxMKTlYw2WXSS25d
 zlm3ELwIzxlTs9pbAi/B9YQa/SeqzSUL0TTM37phHYXRBeYXs7dY2d3BGqz6eEGk6stY
 7wf++SH8AvNBhVznbjid3s+xCD2/hV1PyQJuPfdRoVYONApdVMA9NhgtRIp1zeWyj48G
 yLImwpBAVfQY4q8wlci1rEmC0bEXS6AOEcixaRK3SZjmjcfyWHkmoizEnfnlNmw6yBSa
 kyqJw2sXQbZsbDTeJE+4AZtyhd7bHoM/ydESoJc2Ew0upEDUpNZzrOCGiDVnu7URfKoT
 CP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IMRyldADtWFAPXkEQJ3RH0vIzu/xA/WRDnShCl/zgaI=;
 b=OcMhTfodlMo6acramiaVHoY1LUqz7XU+LDwlhl/OzGHmOrrTPlXJ5b42HZnSeFO6yX
 JY+aQDyGl/f/nw4L6IKqgTL/Fasu4m6zxp2Mw4KguT/9KoWTmvWYuMhAE15wkCuMUyT/
 gRxFyynwutkaQC2DMaK83dSLAojh+TS5jjvQ4kK9Dqjej6bl+IeJZx870ytUIPpmzKjk
 +4tbul4RBXJ0Y31O6XKvgW0ihvMD1jfXio86+KLGPeehbKMilieqngR30CvV/r6LRN6n
 P4cmEtWwQQDw26Nc1W58JkjReZ6wGgVbJaAjA/LcFQMonLwRoiRS9qEYvRCG/J+q2kab
 p4SQ==
X-Gm-Message-State: ANhLgQ35lq3Dhta6aJ/5dubOSyWc7EtC0JlkYv/K1GbJ7ZstQCoIjnTk
 mkyhtP4YWFtu0WAnpppvEyxKDA==
X-Google-Smtp-Source: ADFU+vvvY3qBmzLGOXX6e0nZTBryQXfFpdoTAbhTA6tvkAlh5Ah702g3nQqGkUDT+rqrDzohqcYIog==
X-Received: by 2002:a5d:68c1:: with SMTP id p1mr197570wrw.198.1584467462480;
 Tue, 17 Mar 2020 10:51:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c5sm654524wma.3.2020.03.17.10.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:51:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE8401FF91;
 Tue, 17 Mar 2020 17:50:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/28] travis.yml: Set G_MESSAGES_DEBUG do report GLib errors
Date: Tue, 17 Mar 2020 17:50:30 +0000
Message-Id: <20200317175053.5278-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit f5852efa293 we can display GLib errors with the QEMU
error reporting API. Set it to the 'error' level, as this helps
understanding failures from QEMU calls to GLib on Travis-CI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200316101544.22361-1-philmd@redhat.com>
Message-Id: <20200316172155.971-6-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index b92798ac3b9..ccf68aa9abc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,6 +79,7 @@ env:
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=1G
+    - G_MESSAGES_DEBUG=error
 
 
 git:
-- 
2.20.1


