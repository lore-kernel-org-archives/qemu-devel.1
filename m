Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5437C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863F1206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppZPh3k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863F1206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjoyp-0002p2-RD
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjox5-0000oV-UQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:02:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37918)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjox3-0006sk-Vd
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:02:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id e1so10830680wrt.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OWM6z37V43sNWJfaIriZyMnMn9bapISVtQNxM8oRL7o=;
 b=ppZPh3k3Qp8LHCkmeJxvF1AnZPH2I1BJz2okR/I2Q8Cczc7h1zXZrA81syI+BTkjXz
 2fDIa70+FGYn8lPnzwVlITnRt1EcdCkeARM1SZknSWU0WQE9pQkwGe9NVyXKQ8wDanyN
 MJkdI8hgFJZTh1EquNtx6ngW27YDw7AFM5iuwYpTg18CTHVPTmWa05Ja4LDy7L+v6SbL
 E34RpKWYRxusrwvG7HyuDIQkQveJSDciWF2MrAEoDIfq4SObs80Ipnk0cE7TrvnqGNXh
 zPu8DAZuojEF9ZbnZyDQyAAQz3Bsv4PWGh3GVAP5CbpUQrBM2Q4mZj7Bdeuz0Swo+1gL
 yFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OWM6z37V43sNWJfaIriZyMnMn9bapISVtQNxM8oRL7o=;
 b=CyNDy6tI/xvXJfTR3mcI8lUTee3pBWDz1ucNCRxEguWAgZxGq/KheFbQC/A1uFlW8l
 Z+q6E8bf2yFJmY6OvO10FSS65tl44Zw+60Djm3vA6eWYZjcQsxhfK2rFSMPI8QvgHPrM
 V1S4N/PnTr/7M6S3XBhOdNP3wvE/pWh/rN5K4gwa/ZWPEmqQ28cyibwLMR14xFCuTIIQ
 1wpzmNewseGnDMjyqPuI37x/n+fKJ1BA/i+D2licPFIoI2WFWvgv70GKrgXI0KRR9I12
 YoKytb3aiX1reQYa1xRkfQ3SSBmmW22sXTMzj3sh1e7XG/aBF27SqNVBTbFo8fnnAkeU
 oFMQ==
X-Gm-Message-State: AOAM531XIf8pTkEOdgX43Flrjw6Xq2kvjPdh/Y/EjppYDQR0hIjyBgQm
 GWD3AhHonAy4PDjb/YjoQMkRdQ==
X-Google-Smtp-Source: ABdhPJysIpBUY5h3O60gPGuj1iQ1YKVz4fNeyuD85SbAvvHHHidIyKKBP/95BmU1gqNfZcrXpVSFlw==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr16303446wru.211.1591988565304; 
 Fri, 12 Jun 2020 12:02:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f71sm9278533wmf.22.2020.06.12.12.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 55C321FF8F;
 Fri, 12 Jun 2020 20:02:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/18] Makefile: remove old compatibility gunks
Date: Fri, 12 Jun 2020 20:02:22 +0100
Message-Id: <20200612190237.30436-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 Claudio Fontana <cfontana@suse.de>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200518160319.18861-3-cfontana@suse.de>
---
 Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index 9385c2e653b..57b83521b18 100644
--- a/Makefile
+++ b/Makefile
@@ -562,12 +562,6 @@ slirp/all: .git-submodule-status
 		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
 		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
 
-# Compatibility gunk to keep make working across the rename of targets
-# for recursion, to be removed some time after 4.1.
-subdir-dtc: dtc/all
-subdir-capstone: capstone/all
-subdir-slirp: slirp/all
-
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y)
 
-- 
2.20.1


