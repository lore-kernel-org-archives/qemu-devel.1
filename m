Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3C1C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACB6206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkoRA9MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACB6206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWoJ-0000Rp-31
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWk2-0003tG-Q1; Mon, 04 May 2020 04:46:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWk1-00059V-NI; Mon, 04 May 2020 04:46:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id k1so1027359wro.12;
 Mon, 04 May 2020 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yQVaxRYvRYKfoRoJCtXozicb6p4ygnojFcpJd6zilzU=;
 b=AkoRA9MJn/AfYwzLdmr06wHLXPz9SpdPPdOdLYAgnb5WI2mX/+HOAt1HAnrGOMCtDM
 Wf0lSoj4SEYzYHW1/kgfqF2gG/9ULSELuQQXY4flsQhGgiHXTiwtjIwDE1pAVvYXO6jD
 SpwlMp9uohSj6gkizRKHCgZDi9HaV8eXQaLeNJsnrnVeF44o1p75KJbUozGNBJKF55xa
 OfYA5mxdV/qEczgVN32vD4xjtrX+wHDHSroum/L7RCyT6VksPHCFrgtVCyzayE0VQXYq
 Q/sUaPa//S0Mky/IlyLLGuekc5hUgn+y1LzMRR9XjOVAfU5bGGZcqhptwLvjxAC8ezZq
 WHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yQVaxRYvRYKfoRoJCtXozicb6p4ygnojFcpJd6zilzU=;
 b=Qr7OZk0xLT4YWYMgFpc1fzObYAUQo8us3LZP6hkQftNWq5IM2vxAEFHIrBsmGM2KK4
 haEEogd1EstycB9EqY258Z2+aKzYHu7Ul9/OXmPlPk0pmNE+XbPJdvvNFqGxuK+hQurw
 vQXn0GXHjyd6hnvPRFFHVlbQn3c17vFkX2y/oQMRfbfQwoavWzrQlrXl63w/lCCixIdV
 A94Zj11220ecGFkYGxy2CktxnO7/xDnnbzH+Feg0PatESd8ejO7KyXOEgkuJBGWzwx1Y
 fyiWqgxiG7cHt3yeiVilXpZN99k4myTQztvxH9JPXMNVzNpanfzNRaUe18mHwkCpKAlF
 sfsw==
X-Gm-Message-State: AGi0PuaSJjTm1zhK/gip04V0D3746p3JogJS1VcqWBrzkpEuSiP4+jbw
 BM9x/ieOc3NZCzJCbh43kJZFX+17
X-Google-Smtp-Source: APiQypIx+HTNBLgl2366kAbs8WSlR1dLjbD4LY/EUpg6Ur8BoQGOpKpVkIHh8YXHVezYy0h1Wi+VmQ==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr813952wrn.325.1588581979953;
 Mon, 04 May 2020 01:46:19 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w6sm10740621wrt.39.2020.05.04.01.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:46:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] io/task: Move 'qom/object.h' header to source
Date: Mon,  4 May 2020 10:46:14 +0200
Message-Id: <20200504084615.27642-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504084615.27642-1-f4bug@amsat.org>
References: <20200504084615.27642-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need "qom/object.h" to call object_ref()/object_unref().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/io/task.h | 2 --
 io/task.c         | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 1abbfb8b65..6818dfedd0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -21,8 +21,6 @@
 #ifndef QIO_TASK_H
 #define QIO_TASK_H
 
-#include "qom/object.h"
-
 typedef struct QIOTask QIOTask;
 
 typedef void (*QIOTaskFunc)(QIOTask *task,
diff --git a/io/task.c b/io/task.c
index 1ae7b86488..53c0bed686 100644
--- a/io/task.c
+++ b/io/task.c
@@ -22,6 +22,7 @@
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
+#include "qom/object.h"
 #include "trace.h"
 
 struct QIOTaskThreadData {
-- 
2.21.3


