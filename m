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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D939C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A319521D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjmMiQQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A319521D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwoY-0002Iv-KL
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwh2-0006sD-1G; Wed, 09 Sep 2020 05:47:08 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwh0-0007iF-Da; Wed, 09 Sep 2020 05:47:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id v196so1811280pfc.1;
 Wed, 09 Sep 2020 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=476E7aHWp8h1cxEJLePHYcg3LlpMgvhjzr9aOxTQys8=;
 b=jjmMiQQ7W/4RWaYy1KkssJhtbXe15QiGy+7y102kLhzCuvViBIgEubZ60ipPk0yjCo
 x80sX+rrlUeSw3CK22ZGGBKxPs33HbTpfcozJJnpnt+/zMy+aV7+foPWmf4ekONpMb8d
 Z/bYbVc0LRoB6TwdJlMwtwpreRSnmM5L3Kf07IZy899XCVBD9oEN5b21hvYcrYplkBhQ
 UuIZ0hf6tzT5X6pzU8IiR4hC84whwRC0tJTQYyPHC21F9aT5ncJXRX3KFAxjE/QJzwlh
 Aj4EUS36elfCTrjI/csCR1FGKl8pV3sWYmW65cjWaic+OeEAySAaZdjSXP29CsTj/x1G
 wTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=476E7aHWp8h1cxEJLePHYcg3LlpMgvhjzr9aOxTQys8=;
 b=BS4Kue7seI+ja9HLR/i64WjPRp3gba6gSvG4+SFqAhaX+b0QQGkQcBKcqGreDyfUDG
 LVc0/lq7eiQpfyIBiAGmCgiFXkEk5AhfJSwV6mSgen5F70tp+Bo5kXSqUFXSzBTKwiyn
 DfEcXw69Ht7iy0AZo0cGI17x7VrHofTqn0z0xrQyUo6KpNxgiq5wcKR63NaMRXLiufgZ
 J/oWGURcpuken/elhoX7iUjdABeyEASc4hr6wzqiPvXF4ihPm4SXZ+eGnPdKjJg1fViO
 ePpr7/GO72iXZ3RO1NaYskzytBm1TtnB0RGFPi48bhNAEt/rYvsc25lFmqhONm+n6aYe
 chAw==
X-Gm-Message-State: AOAM533+mabF4w89HyhbCU+MZzPAzC2I5a1YFadAIIFJnMAUHRD1a4b3
 vzpL/k+5weMUX7+6zlAEL2O47lmOvrsP4G8W
X-Google-Smtp-Source: ABdhPJxgIU/Udq43HufOMq8LZMsm5nt4aKP/degqjunGtfDAngD6mMRWOcyjFrEDc6YjdWWAUYzyqg==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr43006plr.50.1599644823417; 
 Wed, 09 Sep 2020 02:47:03 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/21] tests: Trying fixes test-replication.c on
 msys2/mingw.
Date: Wed,  9 Sep 2020 17:46:03 +0800
Message-Id: <20200909094617.1582-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Windows there is no path like /tmp/s_local_disk.XXXXXX
Use g_get_tmp_dir instead of /tmp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-replication.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index 9ab3666a90..e7cbd6b144 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -23,14 +23,14 @@
 
 /* primary */
 #define P_ID "primary-id"
-static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
+static char *p_local_disk;
 
 /* secondary */
 #define S_ID "secondary-id"
 #define S_LOCAL_DISK_ID "secondary-local-disk-id"
-static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
-static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
-static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
+static char *s_local_disk;
+static char *s_active_disk;
+static char *s_hidden_disk;
 
 /* FIXME: steal from blockdev.c */
 QemuOptsList qemu_drive_opts = {
@@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
 int main(int argc, char **argv)
 {
     int ret;
+    const char *tmpdir = g_get_tmp_dir();
+    p_local_disk = g_strdup_printf("%s/p_local_disk.XXXXXX", tmpdir);
+    s_local_disk = g_strdup_printf("%s/s_local_disk.XXXXXX", tmpdir);
+    s_active_disk = g_strdup_printf("%s/s_active_disk.XXXXXX", tmpdir);
+    s_hidden_disk = g_strdup_printf("%s/s_hidden_disk.XXXXXX", tmpdir);
     qemu_init_main_loop(&error_fatal);
     bdrv_init();
 
@@ -605,5 +610,10 @@ int main(int argc, char **argv)
 
     cleanup_imgs();
 
+    g_free(p_local_disk);
+    g_free(s_local_disk);
+    g_free(s_active_disk);
+    g_free(s_hidden_disk);
+
     return ret;
 }
-- 
2.28.0.windows.1


