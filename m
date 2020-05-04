Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B26C47258
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84AF206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdjlNowg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84AF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWYt-00053u-P4
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXs-0003LP-GA
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:48 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXr-0007Rz-RU
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so7449722wmc.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xU5I2xlUHbp9bQFHtUli8mHPbgdjvZx4MCau2zAPM7A=;
 b=UdjlNowgafeJMhYBAaIFhSl36blvfWpB3C4x7GKqbkOFTY5gmLDaYDnSjIrXm7Wr57
 nipMyVGQHFh53aQNq9N4ptiMxynUzryx2QDwYT3jcVIjc5bQ6GILwbhV0eR3Di0wc09a
 uWTmZVD+0VtD4toqeUVf6TnyhekXwOsZb64KLjDp9zZ6MPxf0d095mZdT/tXFJ9C1FXx
 fMIwIxQ6FoQihbEN1lYU4G0CbBJ/J25KcvLtOe2pcEifr8O4qUUZfDHm4fEzrGVdwSkb
 hlM/5uRpPJJUzucLXccpPCXUje0ix51NRjPujj50JJQBO384YoJJ3jaj2xJp6lmm51jN
 fF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xU5I2xlUHbp9bQFHtUli8mHPbgdjvZx4MCau2zAPM7A=;
 b=KrOuuHhuCwh3jZGR7bN6yuWam1ryFCZk7ld20h5LzslwmrI5lJebisXYYjTUjoIQ0e
 1jRQmOZ1xWzu0lFhpfgp1pPOo1Akvv2yYrptvv8a0te80JBVi8Z0MRKcG96V17v7RJ4O
 MkD5N1a7nImoxRPqnTsTjFQxuC/cQLkUSDVGuLlBUXOqDYsl4uplo5DTwRFr7HbHMVR7
 Ak1c57G5wK+vAkcmG5fX5tULRGwoavMOk7dMuPGG9E4KsbxaFJLsXQMqQ0otFQZbcUGF
 JYviQqZZfywP5kgfTMTqaYMJpxYWrG0mFuEN7E9LA7QDZmBLBPnHO/8HEIge4nuG0Tl6
 AddQ==
X-Gm-Message-State: AGi0PuaIW+xbnrE5w77DcQkyZ2w1FYE3m+WpliajYn8apwfOI3fGIP4w
 VwOIcdNT/9vyN9S5WLz8HkgfQLyw
X-Google-Smtp-Source: APiQypKw/oyntCrnijtY+ib4tyKRqtvjtgC/AK1uXkueovrrsp7Af+0gnbNaa/Ejev5yPMYZr6AH0g==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr12978382wmi.53.1588581226141; 
 Mon, 04 May 2020 01:33:46 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 2sm13048053wre.25.2020.05.04.01.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:33:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/i386/vmport: Remove unused 'hw/input/i8042.h' include
Date: Mon,  4 May 2020 10:33:40 +0200
Message-Id: <20200504083342.24273-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504083342.24273-1-f4bug@amsat.org>
References: <20200504083342.24273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unused "hw/input/i8042.h" include.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/vmport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 1f31e27c8a..114141c6f3 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
-#include "hw/input/i8042.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "trace.h"
-- 
2.21.3


