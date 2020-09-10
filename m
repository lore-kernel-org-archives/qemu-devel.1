Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC439C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E00220BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQbT9PDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E00220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJzG-0004k6-9p
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsR-000839-7W; Thu, 10 Sep 2020 06:32:27 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:34887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsP-0003Am-IP; Thu, 10 Sep 2020 06:32:26 -0400
Received: by mail-pj1-x1035.google.com with SMTP id jw11so2836287pjb.0;
 Thu, 10 Sep 2020 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C/1izafIbfTFDVThqlQpYnHLHf4305LjfMqLD1ztqLA=;
 b=XQbT9PDIsZdXCIjn4VwNBJDp3sdWWcSOe4Qu41+t+QDQ2AWITGCifdsNqeWyYNgFpg
 LYXzZci8L8He4GksN4rl6+kmaQ+8rvdSb8UgbyEzHsNHcNUMVuRw1bBYN8KGO/CDW9IY
 xii39YcfNrO9yxWk13z8e1v9ynYqENf6iKPili0QcY2Y8S7PCzRlPTVC+bMn2tLDZu2W
 0CGQt+CqAgtRGPEN03jNpZrb6fq2FrUOMI0HZVzezRiQXXCL1/9r7KjW5dMQnB5PXEcr
 0dkbhs57GRyBi1u8ZJI1/Qai3j0OpSSO38L+Q5GxtfdnEK5O9LsMsUN9B5IYyet0YqnO
 5yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C/1izafIbfTFDVThqlQpYnHLHf4305LjfMqLD1ztqLA=;
 b=ckoqirfe5t+wIFPcgdJd0ptSUWTfTIP0pvBdNQZOqMZ34UnGgPGpPwbdBT+8hTz23q
 rU/e8OIfa9CBvXwjFb0sktLrqstE6Df8syi6eAZj1wloYWSdXt51JkGspk1nbMpUAlp1
 3AJTQ+5cKpEK2eJroCceyI4odc90Im35I7ABfiLeN2v144QJSdJCSjBfKZ6FeCatwnxr
 6Wh5XKnXqyii14DaCBhaXQOuayogNGN7YyLrBSz91P4eHFZEUM8EEkmk/8PZVvOG63P1
 4nH76iE0mmXbHpvlawZNNL5gYfwMH5Alwvfk+bjB5+ZaZUGzXgmDKrAEHPNxPCJc2kfn
 kKpg==
X-Gm-Message-State: AOAM530d4TEf5ySP3mB47WJuUsreXNhBczjHGYOQbak0pnVqIKT3B3K7
 m9k4ysbr7JNqeMrxRRcborRFbwOn9e5kNs3xHRM=
X-Google-Smtp-Source: ABdhPJwqhV5GAqm6azQvdPIn0eqaWVI8wB2UmyhgdtpsXrYLcxIL/KHf6fGLPRykmJIIScr2qKYODQ==
X-Received: by 2002:a17:90b:b8f:: with SMTP id
 bd15mr4839342pjb.65.1599733943308; 
 Thu, 10 Sep 2020 03:32:23 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:32:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/25] osdep: file locking functions are not available on
 Win32
Date: Thu, 10 Sep 2020 18:30:45 +0800
Message-Id: <20200910103059.987-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1035.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


