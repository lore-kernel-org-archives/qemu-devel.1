Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B05C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC572072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8Pjl3ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC572072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXeo-0008V1-RX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5E-0003vm-2s
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5D-0005He-0u
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:31 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:33225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX5C-0005HQ-Th; Mon, 06 Jan 2020 13:26:30 -0500
Received: by mail-qv1-xf41.google.com with SMTP id z3so19447673qvn.0;
 Mon, 06 Jan 2020 10:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EhZ2N0Be93JJ38Lc58rqaW3YyswF78lbGstMwnrxgGM=;
 b=C8Pjl3ZAR7uxcNb2WC2cD7a0IyfpVUGS7udsCxa1RgktzSShtaiYwsCBaTnalFM3p4
 pXFWMXSmRtC1pANYIMNlxv4/a+iPhvKTDKB/IanhJc6mCR9BOzXYYjrNX1gUCmvOow3j
 aZ1QK0805WfMtxzDZw642f8eE+f1XkvmJTIz57zAGBrCPoazVugJEjWek8sB2glAaAtK
 cAPiBbQO+pkAkgJ0rHSKk/bXWPFVbeVWKCXwBShCx41fKR2HripZ2t4g2VkKp0YBLMWd
 SiIsHCO1rjBcrLEtAgfPq9sNYOlldhnH0ed5jL1mP2Oerp9ZiLUAk4FK81IdbuWU1kQe
 TeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EhZ2N0Be93JJ38Lc58rqaW3YyswF78lbGstMwnrxgGM=;
 b=mkrTA2wHd3NOO8zgCvQYESPl1qhemdMWudt/TJ0OCXf5wGcZ+3Uck5XjNI31p/DpIy
 VpAdUwODLl1rLkEgVwuAl7b/VG0EaYIJ3iHqqWTWrvm2d9TSfw1JLJCk4+NklGJt30z7
 B5DHiu/xY0k/7O42KZYex3KiP5PC2hRO+o6z7BQOGVOdiX9QqTYOD4fDJWMYkK9qur5R
 RxS1YRqHjDdI5gShH2rWBfoDSAptM4igzZXbsiysopxV6f+swezCHXq3v4Bcyk03QJf6
 RQyR2aXQw9PO36/ydBHwmhQHJTsPsybi/U+oPiGbMdXIhut1vkJu2JVgnZAST6Hjnqs7
 rpsA==
X-Gm-Message-State: APjAAAXqovCsO2YjOF2mX2RqLlH6qwQ2FSyptvE+gkUxmr2FMx3c7FR9
 BZ7YM/E1VxD+e2DwcceOA9ZRybpf
X-Google-Smtp-Source: APXvYqw7lVxB1o+8CAoAA6lKB+gAA0an9W9BtgAWkHWtYxNXwFKkIXd3FIPrxT20ebCZz5Xn0KuW4Q==
X-Received: by 2002:ad4:58e1:: with SMTP id di1mr65553062qvb.201.1578335190371; 
 Mon, 06 Jan 2020 10:26:30 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:30 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 55/59] linux-user/flatload.c: remove unused 'out' label
Date: Mon,  6 Jan 2020 15:24:21 -0300
Message-Id: <20200106182425.20312-56-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label in out_free_buf() is not used at all.

CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 linux-user/flatload.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 0122ab3afe..3945c40ee1 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -247,7 +247,6 @@ out_free_buf:
 	kfree(buf);
 out_free:
 	kfree(strm.workspace);
-out:
 	return retval;
 }
 
-- 
2.24.1


