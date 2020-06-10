Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DBFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D242072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCOrSdqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D242072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8vx-0007kM-TX
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uI-0005a0-Su; Wed, 10 Jun 2020 18:09:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33564)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uI-0008HL-5b; Wed, 10 Jun 2020 18:09:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so4068677wru.0;
 Wed, 10 Jun 2020 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kApVhTiRZdHYmfzkme5PHn6iCnC1la+mtVXPuU6Ar5Q=;
 b=kCOrSdqzoMcu/2hY7LCM55PK7Ewp5PkRGJY6HM/q80XFoQag7JalYIQnXD5k0O2j0v
 1RD8ispK1FkyG5y7w6whsI5uT1gJLZnQcmHg+aFVKQO/99B8kYOAbib1yObnjz6bnOh9
 LHOtA/PWWtVMSoAWQmYPma1le6oScZliGJXe0stWJ9gCDlBEL3Z4aJKZ1yviazo52xsQ
 B3GAwIwHai0te/zF4+r/mHX1YF8+tlNzXpbyNgPtwUfT1ZsVhw9OpjsXPNStqaAeGK29
 +A+Im8mrM0ueanANfkgbZPl0A2Z+CFh76kyqeQnjm5S9mXhkknshyAaqjreuiVld7RA/
 u2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kApVhTiRZdHYmfzkme5PHn6iCnC1la+mtVXPuU6Ar5Q=;
 b=AD5eiag6fCBxxbbfgdpkd6+Wj1/xnu1xqBA9T3AA1+hLte7eqfeoOG2oX9pZC+qX3D
 cQtzRlrzQR145Jxxk4Z8k+aukmUEwLUiLu4pa1zg226s/2kwp5K87sR6Qu74uRmr7JXS
 Iexx/atuUhMaY/VXdswJuGcZm+K3Ky7+XX0s7gQJNN0a8IHCpb4lujPvemEl9qTHasQ+
 BIJaXpLngsx5Qut2rlhEjgafcsmJd3M5sSIAB2P3Z4hO7qA7I6otXmWDbAVYSYrMQIT5
 U40r197Cj2W7ms7mOXeURd9hICgU8Gfa07OqBdRdtByZK+HQo/fyRXX2IItFheZR6Z47
 +prQ==
X-Gm-Message-State: AOAM530Nc6EWS/8HH1+RL/FU+6lfq4SQCNrt0tLbvNyQJPTdRzp0euKh
 EGFYD9Hh7w50leqyqofLtxCQ65Xn
X-Google-Smtp-Source: ABdhPJzsXpvIvqxx3TPvVyYlatPJ+W8FfkLAuXc1R2YLH9KOrm9Woj3AvOSwOdy2HRwRM1FmccD/Ag==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr6071554wrq.189.1591826940379; 
 Wed, 10 Jun 2020 15:09:00 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:08:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/11] MAINTAINERS: Demote SH4 based R2D machine to 'Odd
 Fixes'
Date: Thu, 11 Jun 2020 00:08:45 +0200
Message-Id: <20200610220853.8558-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Magnus Damm doesn't have much time to maintain the R2D machine,
but want to keep it [*]. Demote its status to 'Odd Fixes' so
contributors won't expect Magnus to take the patches:

    Odd Fixes:   It has a maintainer but they don't have time to do
                 much other than throw the odd patch in. See below.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg710319.html

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1d1b0f62d..e4e27acd26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1251,7 +1251,7 @@ SH4 Machines
 ------------
 R2D
 M: Magnus Damm <magnus.damm@gmail.com>
-S: Maintained
+S: Odd Fixes
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
-- 
2.21.3


