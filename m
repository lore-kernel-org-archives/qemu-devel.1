Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A23C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACD52146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxH0D6iV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACD52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pWb-0004N7-3O
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pVo-0003E4-B6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pVm-0002nf-6j
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:09:52 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8pVl-0002mx-W4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:09:50 -0500
Received: by mail-wr1-x441.google.com with SMTP id t11so940724wrw.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tYnjdVHVbzSLgWR2JAiiP7YknzWJrfOPrv/6EnTLir4=;
 b=cxH0D6iV5py5Vnh+f2GBZ/kk0wPd5wyxJMcfJjIQiZzkiOCufFx/pbLuEV0ccd2LRP
 j6s84Lqp/JSJk9Qt09jjZacCSAlgJ5zNgUIuspON4ogGVbMPQUpf+ww1G3XFBarUqHPN
 ez36HTvgeyWtdPfjmLb+kUIO4WUcY/Hx0oNNRE6A/OlGRv27csP2KvIbCt7jLiuqowCa
 8Z1BcEtdhyb9EiQgCqTzwrxcyrNKY40z7UBaV5ehWxkgo5XOJvcAoFJZ04PEwrlSXN8P
 K0lnFKEaxMlx0Pu668QXjwgUe8xNl2zHnOkFbf8t/lyM4R77Y/7c3ON/DeRjJMTNEL6v
 KtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tYnjdVHVbzSLgWR2JAiiP7YknzWJrfOPrv/6EnTLir4=;
 b=s5j23CPlfiIPjg04yhAN0B5sS9JX70YdNWFhhbsuaimy9zbCfMYTibcjFNiU3292Jg
 Lz9+1JuTF1gAhqNOdrZ92H7Kd497xmhy+ymB4q16mgVjlm/EQhjna4esSgTFF14yMCtO
 IkphtA+84bv6VnLg82JPNmzhu+s+ZVUgazQyyx6q8VzosoOFTbr2Et7mlrAEuwT0rAp2
 FkP7PIdOYBPB+p3YQjflprSjFwSbmJ7L9GlVvfQwGFSr+r1tizIN21zP5IbebC7u45Vo
 N6QSRVo9IqNKZdnj2hWnV2YJbaSCtJyxMQumd8lS3VWg6V4t9wCkN/GCFlQR3o3dFbIu
 pAnQ==
X-Gm-Message-State: ANhLgQ3AXSgpCKtsg1Npb0jO06ekrFEdslZ5byk81+5VEP78TfKDffZ5
 Jml0/tND6cFqh+dv4lUPg4xn/g==
X-Google-Smtp-Source: ADFU+vsC+fdW+lAIgYkDFy6ZO1XfRGjXh2K/CiRdk11tQiGjidOm9G6O2cG9EXKNKMTkYpXeOH2gxA==
X-Received: by 2002:adf:eec3:: with SMTP id a3mr865019wrp.170.1583172588553;
 Mon, 02 Mar 2020 10:09:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v16sm11472800wrp.84.2020.03.02.10.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:09:47 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DAD6D1FF87;
 Mon,  2 Mar 2020 18:09:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: move @skipUnless decoration to test itself
Date: Mon,  2 Mar 2020 18:09:37 +0000
Message-Id: <20200302180937.24148-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, f4bug@amsat.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It appears ignore the decoration if just applied to the class.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/machine_mips_malta.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
index 92b4f28a112..b8fac2a44d5 100644
--- a/tests/acceptance/machine_mips_malta.py
+++ b/tests/acceptance/machine_mips_malta.py
@@ -30,14 +30,14 @@ except ImportError:
     CV2_AVAILABLE = False
 
 
-@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
 class MaltaMachineFramebuffer(Test):
 
     timeout = 30
 
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         """
         Boot Linux kernel and check Tux logo is displayed on the framebuffer.
-- 
2.20.1


