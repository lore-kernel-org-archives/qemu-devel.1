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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C033CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EE42067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al+bwAPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EE42067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFijD-0006dK-EJ
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigw-0002Uq-FI; Tue, 08 Sep 2020 14:50:06 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigu-0002fl-My; Tue, 08 Sep 2020 14:50:06 -0400
Received: by mail-pg1-x544.google.com with SMTP id 67so169937pgd.12;
 Tue, 08 Sep 2020 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J6p0/9F4oWoBiAN/SDJT/VDhYaeCOAUy66N0oF2OF+w=;
 b=al+bwAPmK2vB3f/cr4VR6nO6eS9nwdtcdJOqwOoxYQs6nIEgqbS88wmFsXPnft+XER
 4WPUVIrgqYWclDMWDkiX9BlpGxtH/Z0IFdn6ZrsPDif/XP/zporgjnfdXRCfKgprSrJb
 S4/+jTjrrKSOSYjeqNYPu3CUy3W+PMrBvWEYJGTfxFhOK1MPvxSkJWH3NmamrMyQaKV6
 P+kKV86q2GwibwWuTNyf3ThBKTKSshkbAJ7I0pvn9YCmK51e30R7LW6rN2z+VhEPBeG3
 /lDSFyTF8k3fOQOWsmbQB1x9CypWpaatFytB2tW51fxwHNl6PC5eN3UchWaIUnHpHi4e
 12sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J6p0/9F4oWoBiAN/SDJT/VDhYaeCOAUy66N0oF2OF+w=;
 b=CPeSWhm6WRLG7KtDQeQIjvDF9+rvDM4X9oDUQpmghQRur85bO6EAsns5DZmWe/xL60
 0/NOC53jrCEw1NWPwxf0xEX/MOxhy0itoqxbUzlWFuVT6b4zn/BaE1K5zfmidHMeQ/8I
 TOw8tUgcats5NNPtbIlMxN4WMrRti7J7Mw3yBXAI1VCsOFxl3KJrmeib9T0BcbSOUihr
 oME86a1+Fr2QaBsFfPESjCfHioZtLDJXLocFN23NyAPd8dFl5R0gmgPAyTlKsvsfcuCE
 wx0ozSoUdsglQyGucPs//ys9owfAV7nrkpGT04Cd7IA9nn3XNS7FUmS+Auv1ij7EaJp1
 g4NQ==
X-Gm-Message-State: AOAM5324RH+4ic/gIM4CnymdqvRcksHKO4QMjK7JDQOFubjhNKc3gTPh
 X8bhWMxRwFTQr5WZ/mwjTrooAzOpvXrjyqM2
X-Google-Smtp-Source: ABdhPJx7mnH+FGzeHgy/LoeKu+HiG8406aBUpCxpVftxYBszTAvVDnejbcRBkCyS9XYbQ6Tlor06Tg==
X-Received: by 2002:a62:7ec2:0:b029:138:8cbc:ebd4 with SMTP id
 z185-20020a627ec20000b02901388cbcebd4mr484358pfc.2.1599591002614; 
 Tue, 08 Sep 2020 11:50:02 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] tests: Trying fixes test-replication.c on msys2/mingw.
Date: Wed,  9 Sep 2020 02:49:09 +0800
Message-Id: <20200908184918.1085-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Windows there is no path like /tmp/s_local_disk.XXXXXX

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-replication.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index 9ab3666a90..cfc1ae6feb 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -23,14 +23,14 @@
 
 /* primary */
 #define P_ID "primary-id"
-static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
+static char p_local_disk[PATH_MAX];
 
 /* secondary */
 #define S_ID "secondary-id"
 #define S_LOCAL_DISK_ID "secondary-local-disk-id"
-static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
-static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
-static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
+static char s_local_disk[PATH_MAX];
+static char s_active_disk[PATH_MAX];
+static char s_hidden_disk[PATH_MAX];
 
 /* FIXME: steal from blockdev.c */
 QemuOptsList qemu_drive_opts = {
@@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
 int main(int argc, char **argv)
 {
     int ret;
+    const char *tmpdir = g_get_tmp_dir();
+    snprintf(p_local_disk, sizeof(p_local_disk), "%s/p_local_disk.XXXXXX", tmpdir);
+    snprintf(s_local_disk, sizeof(s_local_disk), "%s/s_local_disk.XXXXXX", tmpdir);
+    snprintf(s_active_disk, sizeof(s_active_disk), "%s/s_active_disk.XXXXXX", tmpdir);
+    snprintf(s_hidden_disk, sizeof(s_hidden_disk), "%s/s_hidden_disk.XXXXXX", tmpdir);
     qemu_init_main_loop(&error_fatal);
     bdrv_init();
 
-- 
2.28.0.windows.1


