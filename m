Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967CAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BB9207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOQfpnUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BB9207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2xN-0003lQ-0y
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2ku-00014h-A7; Wed, 09 Sep 2020 12:15:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2ks-0006b7-Eh; Wed, 09 Sep 2020 12:15:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id w186so2409562pgb.8;
 Wed, 09 Sep 2020 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K7y5ZJD/cG5cMFm0+/8rHEDw15+8VS3xMSK8qF/3N8U=;
 b=pOQfpnUaT0JUADrVOuZkK6LqiZKxqNLzQuRPrGVIbXB+q4V0VBnC22pQKUqmEqO5vC
 l5EqhDYvCdh1irGlC6l+kpm94Ap104vt0/ZNDnJXdMLQbKuEh5lRhfCer0avfWF871Qb
 l6bgbDzLPVSy7NgLyYA9qfLFzB0j8YILGvRmEKpy2T+6NZ8j4wr4JtJdc3tMtqQElWGk
 DjdTUPMI44WK0AwJ+7I8zj0UcsiRN/fM04rRBjy9Xs6a4isDIh4ra2CDNGjuXh0tjAIu
 mDwxMwZpgyLyMIBtiTP9qfksGdhH9jOmnaox/vyB5+Fj21xaBtrUxMs71lil1UORlLZU
 6PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K7y5ZJD/cG5cMFm0+/8rHEDw15+8VS3xMSK8qF/3N8U=;
 b=bDHwBDi/gr4qDDqgb+F5Io9d8E5TbVmfkdP5dwnBB6X54hXB1FVi2XZcjEqaJqEnga
 wJT/sNetaiSGWNEA68LvFb7Cu5lBTQNsTJmhKDvorGLG1Uq2yui4wF25LOAovhalW1aO
 bnW5rEm7mE2XjIT2M9CXyy0zcj/kPGwzkf8QO6/Wq5tX45MjygA6PLQUPexPC3Tqh395
 QZqbUT/J3jOPJ5NMAwQ1RZfLNv5vlgSJQLFkZ4g0Snq/piWT3AHnMwyUg1447D9Ad+Pr
 VyB88bHH9aKO+FXAB26PCPeOyL4m+rzqaGpFqz015iSbJjZlNgaWvP0AtGNA3pUdR2NO
 ERrQ==
X-Gm-Message-State: AOAM5327dcWX16o8SGR4LcchhAR1vFajW8OxNFMYxmKFa8UKaShpmmkX
 loDs5RXzwL8kzApzoeb/gytrRIh+xf/zEHb1
X-Google-Smtp-Source: ABdhPJyqNUf+PAfP+iMfYK413WTlPUign2NjCC1ICIn39tCtnhWsztOFn8EqohwhsgSIGiZEMFBqwg==
X-Received: by 2002:aa7:9115:: with SMTP id 21mr1443026pfh.158.1599668127025; 
 Wed, 09 Sep 2020 09:15:27 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l123sm2506987pgl.24.2020.09.09.09.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:15:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/24] rcu: fixes test-logging.c by call drain_call_rcu
 before rmdir_full
Date: Thu, 10 Sep 2020 00:14:29 +0800
Message-Id: <20200909161430.1789-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909161430.1789-1-luoyonggang@gmail.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

drain_call_rcu is necessary on win32, because under win32, if you
don't close the file before remove it, the remove would be fail.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-logging.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 783fe09a27..8b1522cfed 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -210,6 +210,8 @@ int main(int argc, char **argv)
                          tmp_path, test_logfile_lock);
 
     rc = g_test_run();
+    qemu_log_close();
+    drain_call_rcu();
 
     rmdir_full(tmp_path);
     return rc;
-- 
2.28.0.windows.1


