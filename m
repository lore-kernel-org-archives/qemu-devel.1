Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7848CC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065572068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ61gXHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065572068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiq1-0003ij-5p
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihV-0003al-7D; Tue, 08 Sep 2020 14:50:41 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:53408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihT-0002on-DY; Tue, 08 Sep 2020 14:50:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id t7so62701pjd.3;
 Tue, 08 Sep 2020 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NnBwIumxkiQ9pXVAp8TmFXF/H8dsT5OnHNvh40zg8GM=;
 b=dZ61gXHrueNmi8e4+i/f5VjPIc3SbBIj26rqqDK8YpFPdoVNxHukAD/T967bpZlWNo
 2kSafz843mWWsSGaY0VSc3D/lV0aA5k364u9eA5v1JFfdAlfisGTA/rDfRVm1rez7FaD
 hCrZTtjXhq0tfIqrz6kpuXIrf+dU+nNhXhmbCzDg3YkDlyITZifS6rWkKvHpuEhDrPAf
 UWc2cORqtnXurqGXU799QdXDb29nS9DLDR+LWSPNaYGpSq/7X7/wfWiO/4MXknAUpi8Z
 dwPlpPYkvCwc0GNteYXZVLUF2TC+vvm5Z0DLJa4ckwnezwosXy3QHHSvZtwnpjgKPu9S
 wpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NnBwIumxkiQ9pXVAp8TmFXF/H8dsT5OnHNvh40zg8GM=;
 b=Ei8/hboDXIkSRPlzDY74gLvT2OvNZzkv6UqOtdzazTk17/N7/48tik15hkygYHhVXl
 uwor2ZzPS2gN5ECznEK3BIiyJqKOeL3gmaTQ2fpa8Di5oLUGY7abTw2iVFhtCw1W0pzp
 acwT5pZhUV/3muZtcQD6yKfGfch0rjIsbS6qV2xEkSLVyRIIaoCUuZ0DWY0eRsC5/2IY
 tnctxIw2PkUVLHo22LT0Ubqc8mpGpCz2hlwHv4m/fvZ42FlsSv4SAR0GGK5TEQVHfxrj
 yOgTgZD1YAarpY1DSnJjbc6htmSf6cIRZLO9pYALU/v6RBo3Khao52uoH0vgx2hTwfC/
 cTnQ==
X-Gm-Message-State: AOAM532/JSdHsDZvenkpik7Y77Df7L2ltS4LRMgMxofgjtxnOzCExEO7
 pyYJ6boYYV+rkt+ZzckoTGy5DH3y8bx4X0U3
X-Google-Smtp-Source: ABdhPJw7QsEuGqVB+fe4fIKSLWPRF/h3iM9/7Dslogjs3svpC/7HSG+UhzlGqie0zhflEaNfUxo3Yw==
X-Received: by 2002:a17:90a:6848:: with SMTP id
 e8mr173323pjm.221.1599591037058; 
 Tue, 08 Sep 2020 11:50:37 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:36 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] logging: Fixes memory leak in test-logging.c
Date: Wed,  9 Sep 2020 02:49:17 +0800
Message-Id: <20200908184918.1085-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102f.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_dir_make_tmp Returns the actual name used. This string should be
freed with g_free() when not needed any longer and is is in the GLib
file name encoding. In case of errors, NULL is returned and error will
be set. Use g_autofree to free it properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/test-logging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 8a1161de1d..957f6c08cd 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)
 
 int main(int argc, char **argv)
 {
-    gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
+    g_autofree gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
     int rc;
 
     g_test_init(&argc, &argv, NULL);
-- 
2.28.0.windows.1


