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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E240C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBBA21D79
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGl4qqkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBBA21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwmq-0007cp-NU
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhD-00079H-L5; Wed, 09 Sep 2020 05:47:19 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:52301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwh7-0007j3-VN; Wed, 09 Sep 2020 05:47:15 -0400
Received: by mail-pj1-x102a.google.com with SMTP id o16so1069104pjr.2;
 Wed, 09 Sep 2020 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFEZh3+xvAfqz2f0h/nVnmxCipA8eA9k8U4UHOk894U=;
 b=ZGl4qqkWxPcp+1u/vu95J1yjmFXXI1yW5UsDfNWfoCYEXfyqzcD/kl9ZdgDwWgdMZI
 aIDiuZwfYRXCWPRVox0Ud6FFq5H70wMvTtS3wI0ktXmGhG4qffVWv11cr79Cyv2fp57F
 t/gIBzaIU6IJtpazBQ0pzGtPC9JOI4BL1um70ffpeD32/5gwQxXty+cdO4yPxvMBEq+r
 NL3wDicrUI/PsTB11SHnvC52mL13mtIxTDk/5lt3xbI2xg1M1Qnix3Ikx+7+D4oN3pUZ
 pF4voyKiHppQBKf5mFM+UvtwK56ln10z2OeGf4ii6OSIo6fmTtmQhnXbGsatvJMEMeiC
 q3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFEZh3+xvAfqz2f0h/nVnmxCipA8eA9k8U4UHOk894U=;
 b=tgfAbDMKuXjpkNVyz1OVXaMhD46iOso+wTbYFW7d9MCRRpWzDWX+rDoYrv1stfsPu3
 RukKs6IMwq0p5EBQuJ5sFYkNh66k1c9thep5XMFVNkcGFrP+aQXvgvLXDs6zvAXnBNTB
 aoJYGu4w8CYoV6q9a1Pnz7L7SED+sneOMooA4ZNOPqACcl41Fo0yksy3Eeld6/oxZ2WB
 lX2+hWHpr4CLa2TVfKf+6gkR9Ewh3VD/QkEAx+ImdgpvVPcKtsG0CvR4mkQupUEizM6K
 0KoIWdsA2abDL5O7wQzmu1hvmBqdFpgCt+/9vElMZcnDk1WJ2JYZLpmpP2SbNhqorI2X
 V+pg==
X-Gm-Message-State: AOAM530R0bnehL2yvC9/nRHEWJDZfJ8Ccu17gutne3VnAvgSu6B+h8YB
 ypxIclf9GXxCPlix88YapDgPfx6IU4PvAR6t
X-Google-Smtp-Source: ABdhPJyakJW9crd8/X+I9GJ0HWKM33BoAwk3yZODcTam17ktjdZ0gsDCdMmU9JAteQleOxQpCCRh+g==
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr96111pjb.101.1599644831957; 
 Wed, 09 Sep 2020 02:47:11 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/21] osdep: These function are only available on
 Non-Win32 system.
Date: Wed,  9 Sep 2020 17:46:05 +0800
Message-Id: <20200909094617.1582-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102a.google.com
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

int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
int qemu_unlock_fd(int fd, int64_t start, int64_t len);
int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
bool qemu_has_ofd_lock(void);

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 412962d91a..e80fddd1e8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -502,11 +502,11 @@ int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup(int fd);
-#endif
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+#endif
 
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
-- 
2.28.0.windows.1


