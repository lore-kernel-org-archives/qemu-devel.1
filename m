Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1691C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E31920731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nglpp7Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E31920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIACS-0003Ta-Q7
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qq-0000xI-NK; Tue, 15 Sep 2020 08:14:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qn-0008Ce-3W; Tue, 15 Sep 2020 08:14:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id u9so1237967plk.4;
 Tue, 15 Sep 2020 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=08QvrHPKEN4GbCfMFC4QXPv5o40Q0NOGDJhtin5ahIA=;
 b=nglpp7Vbz1cImKfKJYdVyhKLTHX7VsUhuaJ2L1iNOr2eM6wwcUffLpLeYvSTeE1qa4
 m/bgsnCYj2c6ccaPnBiq6eZ2S1CrapAoGLuDz3q9Q1negU/X76+i1ZSqAWtbj9nN1tOk
 FkLE+ok8hErOm+8RFmMwNJga2I19+CRUakj6jlOzDircx9r8K/WBQ5Ikc8K35U9YcS+h
 HP7SnSczdtp5Lt9vahuNXGF9hvuNLHRd4RWzUO5PKoxdzGw96pGR1k9kam4mmsOhs15P
 gNeCBJteFSQj7EI8ZS/NtCDWItbRACx5lBsRzoekdnlmdHBKdjsf0erJzCUOj/04/CM8
 MKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=08QvrHPKEN4GbCfMFC4QXPv5o40Q0NOGDJhtin5ahIA=;
 b=r1zluS8qOCyaJ/bxkc3ZcKDVG3yxFetQBluXJgOvu8c+5JGI+y0UySbPootkT8oIZP
 JRZSoPKwJy7wxNYDcS5A/G5H8zqNcIj66PNcEu3NU6b8uV6LQaTAcU6t9CeFL6EkIlEe
 sz8C7hj4GYiMcMsquyTI8UVCrcHv4V86wF71VebmoGSIJThOa3XtnjZkdis9shJxs6KK
 p2mUPVvxdebp2QeY8gaL/GL7TY8/q6nw2VvRm10XrdZhLuibaP9C8uyau/oRv+RIh0No
 r0+xPqywH2B14oBMi14UdGvVJdedBudr5NT8Rv+X0Ur6sn9OojCuPyCvkiwvk+H4ZPEW
 oafQ==
X-Gm-Message-State: AOAM532HuP8Fs8FwMlhSJN5YMczU9Zu7u+DDF8iFhtDhoDQFtC9iyhzp
 rxEsaUK9ijU9uGSHfVbMQ47Xrw3mzlzaecvIl4I=
X-Google-Smtp-Source: ABdhPJyWbrNn7g0s7T6NMINRHiBCQttHFQUCu5CFhAusmZBgyRdfLE6SZ5O9IOBpLbUGuQKHuTdK7g==
X-Received: by 2002:a17:902:522:b029:d1:9bc8:15df with SMTP id
 31-20020a1709020522b02900d19bc815dfmr19540125plf.25.1600172057481; 
 Tue, 15 Sep 2020 05:14:17 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:16 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 09/26] osdep: file locking functions are not available on
 Win32
Date: Tue, 15 Sep 2020 20:13:01 +0800
Message-Id: <20200915121318.247-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x644.google.com
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

Do not declare the following locking functions on Win32:
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


