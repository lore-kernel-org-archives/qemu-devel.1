Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA895C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D903206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeOl9TTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D903206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwmh-00081A-OM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLB-0003ry-Dg; Thu, 03 Sep 2020 17:00:17 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL9-0007Ui-KI; Thu, 03 Sep 2020 17:00:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id a2so3980736otr.11;
 Thu, 03 Sep 2020 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RtiowuAQkv312A5ys7+EMqL5vJk41pvA+ri5Ve8MLsg=;
 b=CeOl9TTuwTND8XKf4EXTnn841voh1MBgCRSGyn0h4uom/ihjf+XoLYcAyE3kV8uejO
 swgrw8Y7eJyHc+3+hh8N5AVWI7DXvPYApjSYrmHMiJRuFqyoxzj8IUMl8xKx8fGDMCBi
 sg7UvA11lE9hh+W2jiiWSYgF7scl0cbaDrpNeKqThOnap4knvhqF/Q5gpIyzxfrkAPxt
 BiizcxGi9UBmdqN02jWW67MLjhZdYY/nsAcrL4aGyBRtmjJosHwM2Oriz9on0eM8XtSu
 xRzzXKnr/EOHaOGEItgT2dF15QPnZyEmdopI7DYu+lfmNc0jKQDRPALkcdX4tFPZ2jnT
 E0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RtiowuAQkv312A5ys7+EMqL5vJk41pvA+ri5Ve8MLsg=;
 b=SoedIv8Nx5bQ6bh5n1Hsf1n9hEo9DUQjVFCrszG1vKcm0YsM+tZp54J8Vp1xaOE6+v
 0mHEBRX+1OJGOGPJNka9kwZHMs841JLcoR5gt+VkKs1hep1PXtPPz7U8FixRG6VqJxpy
 GpTUYCjuaAnG6v/bLo/kXJWBh1cTud+nC2Xv3a8qLrMXHiMdPxT8heb+3MsiuFvp/U+L
 Fqn1oJxDTbwwsbsQxLaVYSe0mTi759dEIeZ0mwnC+tu49sC+OI31XUo7UAFG/ezFZEqU
 wFLuz2Uckse7ehrRQR2DibFZA6COdDvGm+Hb2lUZBMPE+qgOorPc1lmmfv18eVv+d1mS
 1SXA==
X-Gm-Message-State: AOAM533tXXisIv/NTBXZp13ztf3bsGOqWPQk7z9zzI6b/6WfQax//i+C
 Qt5+zo8CeCybQM+z06DM+6WocN33hME=
X-Google-Smtp-Source: ABdhPJwzgt4QElx5SjNbrbNMMksX+d1txIE1M3j60cpnbNpIrvEOjs/sRCUGVM5LwAYhfw+oQU/lyg==
X-Received: by 2002:a9d:6d95:: with SMTP id x21mr3138157otp.339.1599166813759; 
 Thu, 03 Sep 2020 14:00:13 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id e7sm205748otk.59.2020.09.03.14.00.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:13 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/77] linux-user/strace.list: fix epoll_create{,
 1} -strace output
Date: Thu,  3 Sep 2020 15:58:44 -0500
Message-Id: <20200903205935.27832-27-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org,
 Sergei Trofimovich <slyfox@gentoo.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergei Trofimovich <slyfox@gentoo.org>

Fix syscall name and parameters priinter.

Before the change:

```
$ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
...
1274697 %s(%d)(2097152,274903156744,274903156760,274905840712,274877908880,274903235616) = 3
1274697 exit_group(0)
```

After the change:

```
$ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
...
1273719 epoll_create1(2097152) = 3
1273719 exit_group(0)
```

Fixes: 9cbc0578cb6 ("Improve output of various syscalls")
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200416175957.1274882-1-slyfox@gentoo.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit fd568660b7ae9b9e45cbb616acc91ae4c065c32d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/strace.list | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e92a8..9281c0a758 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -125,10 +125,10 @@
 { TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create
-{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
+{ TARGET_NR_epoll_create, "epoll_create", "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create1
-{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
+{ TARGET_NR_epoll_create1, "epoll_create1", "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_ctl
 { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
-- 
2.17.1


