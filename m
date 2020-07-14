Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95E3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 21:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25DA20658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga3/8b9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25DA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvSSp-0003wy-VK
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 17:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jvSSB-0003PP-Gj; Tue, 14 Jul 2020 17:27:07 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jvSSA-0000Un-16; Tue, 14 Jul 2020 17:27:07 -0400
Received: by mail-ej1-x641.google.com with SMTP id dr13so39105ejc.3;
 Tue, 14 Jul 2020 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=nfbgl3ybXzgF5TE75BwsG3yyqCmTUfySLxIqtRQ4guY=;
 b=ga3/8b9xvbSJz1IJNGHKkGZ0LHfBK0nrzGB1xIoOh08rrm2s8s2LVS15vl9buzX61f
 +gh+pshsvWc9029AJY3Bvk7kkWNcPtASfQvDJ+CUsE8NfqKMI7CHhPus1UOr1IFurU9k
 y/t8+yi83ZAR7HxEs8kvvn+AyOjlXF4b6gEz5qGZlaMkGUNPvSI1YkPxHz9UvfdutsmM
 iLZlhXH0/BBaxZWwoj+Q9ycJJu14BUo8Bigt3RdOR3CBvTnwft74iCn5PK72VlyvBVuM
 yFb1bkwgbesDhpu/AiYnyLPTXJv4mnRBtJyAy0ll9uf82Rw5sxrTSQE6RAmqt/W3URss
 nNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=nfbgl3ybXzgF5TE75BwsG3yyqCmTUfySLxIqtRQ4guY=;
 b=QPjh4uBvg/pDhVs/rFyuklNXB0Ksjl2vogf3SnGbbIuv6FGW6+X5ABR9iQKRyFIx8C
 e5xjfLkLs9R+Pnc9+ZDEqeSlj0Dm8tSozPxrYFLcj0GVSFvhkkf7WDdmuIK8xLZqOG8R
 g9zfwzKgIzvR8EAaELbgNjjgVOkfHpoK23mQG589PQ8dZTvh0zLoBdihPqVfwS+namYq
 RP8DpVlTnJ43fPex8EKpnoVyG9yE18UUSMLTFJnFMhXiPJARYBjjWhZ9+BPZLIioB2by
 /Qf0oFT5q08jXKJscOyZPQo3sbFWxk0A16+a2CTc/X4bD/unhVQ10uBEigxiWU/H3Bqj
 1bxA==
X-Gm-Message-State: AOAM5320x02WtMhb4IX33U5ZAlnumBZ11Zs8jDfk7L2300br7rJGlVO/
 4XNTKCApvSNhJE7Ky5wyybkTmPfLZ9gAPG/xEm5km0Mfzx4=
X-Google-Smtp-Source: ABdhPJxvOcM3aXH7YPwXZ+UirgRnl3/Vx3h9h5u1/EGAv4YuHFDR2LBG9J7dg+QwhW2K1VoZ7nH50w0Dh58NFcwAE0M=
X-Received: by 2002:a17:906:c78f:: with SMTP id
 cw15mr6228036ejb.58.1594762023662; 
 Tue, 14 Jul 2020 14:27:03 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 14 Jul 2020 22:26:52 +0100
Message-ID: <CA+XhMqxD6gQDBaj8tX0CMEj3si7qYKsM8u1km47e_-U7MC37Pg@mail.gmail.com>
Subject: [PATCH] util: qemu_get_thread_id for OpenBSD
To: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x641.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 9c7f54c67d40fae0174ba795fbaad829cd59c264 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 14 Jul 2020 23:23:55 +0100
Subject: [PATCH] util: qemu_get_thread_id implementation for OpenBSD.

ussage of getthrid syscall.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 72907d4d7f..b4f7de83c8 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -100,6 +100,8 @@ int qemu_get_thread_id(void)
     return (int)tid;
 #elif defined(__NetBSD__)
     return _lwp_self();
+#elif defined(__OpenBSD__)
+    return getthrid();
 #else
     return getpid();
 #endif
-- 
2.27.0

