Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F103C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5997B20899
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKbhtJdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5997B20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrND0-0002nC-JU
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN75-0003ro-Dk
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN73-0006kK-FP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so32299172wmj.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oblRNa3Qf/H2qkj0LJ6Mp9Oq0mTcNDfKBA/ktyk5uVY=;
 b=SKbhtJdmnqWawTJe5v7ju0w2hlz1gsuo2eAu9Xy+LKN+r1JFtMs+PtwC9GEMFsStyG
 cMLLJsrllmhEVBtFtkOAaYX2Xl4tGrgVEBC3p0m+PB2KOj7fDr6rA4tB618EpVmcmslS
 /f8IpfiEq0xS4fePTgo+TlUlv+jUVIURUxuT7Qikp+gluWtZKF/aLxwLqbxJ1g+0ZdqO
 yQ4l2ekv/WOze12wo0SyZ2fCWKA7bpV9rvrbttqh/qYxw4UYpBOinGPnvcv+BcYV3dLV
 zwxx06N2iXBp8IUMFH2J7ynoHQwyVg6t1LBd6K95qUp0GV/1fk9JoeLjz/F70Uj8rWHX
 yMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oblRNa3Qf/H2qkj0LJ6Mp9Oq0mTcNDfKBA/ktyk5uVY=;
 b=ExB9/KJxVfoJCWKQUN0mYFDw4WWNVjzaB89flKqoq0v9pzqKlV4ew6xTn0wCm2/w9C
 0eRRJXMIXjcdsCsoGqxoPDBTEZBdB0tV/WbUomVBsbPFpEYg1ciOhbKNjhHDdbj/MTR6
 Z9bX0L19J7QHpf4i4TyMM0AEgdWtnXVnrPFIeTDKOqK82+gp0FrOBC4rdGIt5dw+lYPA
 j/Derw5Q9id9Jz0J95PXtkaVh+JjAgNgrt/tJD/FYq0xgWAXWvTLLJomaGDDT9DpAGat
 rR97QwUrB7muNDpizLLRTp5LiXbLtQdp3aclYjtyWVnEGlWGzUpjsUBX7q+xNO3EC6Xs
 47YQ==
X-Gm-Message-State: AOAM533CiEMrKfM/BMHevC4C1sQU5e3S+2pUyKu/wi7D2pRM4xdcnL6u
 C3a7eOZlNwCA9psWqFKXAyeIq4147rXqLQ==
X-Google-Smtp-Source: ABdhPJxREzIlQ8NydptpPuKNWRXYsyMAFj4a2nRTTyYNAYlD8Wf6NfjY6tHrsw7V+jKNsBEMRpORFg==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr34964783wmh.143.1593788183915; 
 Fri, 03 Jul 2020 07:56:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14078347wme.31.2020.07.03.07.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 07:56:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] bswap.h: Include <endian.h> on Haiku for bswap
 operations
Date: Fri,  3 Jul 2020 15:56:11 +0100
Message-Id: <20200703145614.16684-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703145614.16684-1-peter.maydell@linaro.org>
References: <20200703145614.16684-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Haiku puts the bswap* functions in <endian.h>; pull in that
include file on that platform.

Signed-off-by: David Carlier <devnexen@gmail.com>
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783e..1d3e4c24e41 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,6 +8,8 @@
 # include <machine/bswap.h>
 #elif defined(__FreeBSD__)
 # include <sys/endian.h>
+#elif defined(__HAIKU__)
+# include <endian.h>
 #elif defined(CONFIG_BYTESWAP_H)
 # include <byteswap.h>
 
-- 
2.20.1


