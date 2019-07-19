Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74943C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F5F21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJYjnLyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F5F21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT3y-0004dM-87
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT3X-0003Ap-Tm
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT3W-0007hN-UG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT3W-0007hD-PC; Fri, 19 Jul 2019 09:36:14 -0400
Received: by mail-pg1-x542.google.com with SMTP id i18so14488222pgl.11;
 Fri, 19 Jul 2019 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H6PLhtfnLnyVKqBOLq7108F9Sn3pPpFYHAfoVuQwmXo=;
 b=MJYjnLyYcxJsKZev50XCw6P4KeZaDbsLqCpdJzf2cpl/KRR8ugEbtvdCnk7FNhgszE
 TiyerQOmq09qQ/GYEs7F+u7Ph3HK1Tacux8IJ+M0cKQ5pt1zgead3eP4TkIOSTihU2xU
 jwKFYkJE8PMheE8Lx7brQFcuqdvAJNy1WTYmGD1Zdtui56yx38GVocLLZkQXJ5R8bZ3V
 lU4xg0CvpbKkzR4mGV4t/RJbut1WzkG/eQEpDAt0bbbxicA9HH7Du+lcHjuAAy1GOipn
 n8ZSey7++rOjgYR3T+1JXIs7sPKJrIWhm11AK5nGuZ8qojhg8sdu0s2vjP5R+4s3PqhK
 kguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H6PLhtfnLnyVKqBOLq7108F9Sn3pPpFYHAfoVuQwmXo=;
 b=YpAYqtAGk3PHMM5FpO7DQrMfZzOmf8+Rg0rvxFR7Uhl8QlxZIMPGUN9RBWNTGH12DY
 PYonzUUrrvwwprGgDrH/LHgkqjVBpJ2rRxvPfmCiw66NyyR+6SAUVLX/paOW13T6aAJm
 VeBicNhr8rK3xy1zaaGXnWFL6zM54ZPl3qFMj7QnsFrNMxkyhHiQq4TiG+tmSNLrJ1yP
 J8yhsD115q12RG5qbCoj2pD4qkAaC1FE+pxcJEceVm/pgKhW6IjDS+IC6Zt4i4t/Ya9X
 p5cRJEdspd3PDoXqlNf+5yt+7V5jFylO6JNh7xo4kOQYFcng9OvI09iK3HxIfMT+zUOo
 MzOw==
X-Gm-Message-State: APjAAAW4Ng6U4KB2Da2j6HZQHqpF3fvQNNlfgBjGoV52yS/HrcpeFZ6D
 cHJITOtsjDDyCWOsKqYGjLr9z0VkPNA=
X-Google-Smtp-Source: APXvYqzTy97aRE1j2BnGXD1k88zOe+thca17sk9LARCXp8cenAU+3hKUVE9f4BeYU8DHPmEBVHP0CA==
X-Received: by 2002:a63:204b:: with SMTP id r11mr14386295pgm.121.1563543373498; 
 Fri, 19 Jul 2019 06:36:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.36.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:36:12 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:19 +0530
Message-Id: <20190719133530.28688-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v6 03/14] block/block: add BDRV flag for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index 734c9d2f76..40bd93cd0f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,6 +121,7 @@ typedef struct HDGeometry {
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
 #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read-write fails */
+#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread pool */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.21.0


