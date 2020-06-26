Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB5620775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ/gXbFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB5620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonzn-00008r-FD
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jonyM-0006x8-4Q; Fri, 26 Jun 2020 09:00:53 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jonyK-0002zW-1F; Fri, 26 Jun 2020 09:00:49 -0400
Received: by mail-ed1-x543.google.com with SMTP id cy7so6846207edb.5;
 Fri, 26 Jun 2020 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=RuzXvA/aTpuOPYIFxer48+fv+OoNhJtBmY1ds60T/Kg=;
 b=PQ/gXbFPCOvm2cQi1ZP2scGUreT66L11xkr54x0/yZ/VgwO8KcNkRTon+Vx6O6sDKM
 8BuxTpbhdqlUmGbOU/Ez1kh1i8xAF8k54u7U24z1A1QRFjfCZqug1DfcoOLftt5sslQg
 olMXVw2hZU10CcLDPoIU81qLvx0ZyigDz3BAHT+MHozWMbtjFJFsQ0tBdFnLeRgH5kXR
 otHOQY5xBi0B7Il/Lpt4hjY02R3xMnNnLyFUbShAFXg8GvPj4wX9BX3ZVTrKSzZ6/DI8
 GGUOIsUd8cm5t2IUbAtknumvivKQp2M7esnPtwm89whqcSVNZk+aI4khePqEBnkoj85b
 iHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RuzXvA/aTpuOPYIFxer48+fv+OoNhJtBmY1ds60T/Kg=;
 b=DRf4Ab66MCikxZh9oYiULFL4Y6wgybkkeYJNSZ+H7uAU2c8D6c349O/3OXUwglTbyK
 BD7UqYYRPWmo9TRd0iLGk0XAwxkh61niySg/3xtTnHF5rpwnBeuDLPluqsj1dDJ7/4yo
 LAp5EfLZFAycodegl4aOcmapil2GfN61PJbUFbnetaBiLy90GJqDQny+TfNi3INlU4qB
 Rveh4caW89wbJrYXdNjlFS6GyKRx3R8CzVJHK9D8/CLxCfq7qB48zfeijKMRKTxTID4g
 1KfI8ZoB8inXgJAwU+2HV3mRttFEnLYiBlYuPNYcf1fBja9cKHhWHX69BrRi5z5mlGKQ
 fjvw==
X-Gm-Message-State: AOAM532mQDYVhj7hG0fzC1rKeKN12erE7AqMAGQD0JZ171Y8+AUdhd26
 MO+25ReRMgqcEijVFZdCxa502ChRqay+6ZTpHS4qSVPeRsg=
X-Google-Smtp-Source: ABdhPJwYljeaXbFNmnPmEvBjSV5o8KokL2U6ZIar6QgvszEVsN2ag93tuE9Ch9u9ASOSpbdXrBS1i+QCpjh1zTBsVt8=
X-Received: by 2002:aa7:d297:: with SMTP id w23mr3077415edq.49.1593176445455; 
 Fri, 26 Jun 2020 06:00:45 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 14:00:34 +0100
Message-ID: <CA+XhMqwDLw2BJ9Cf0kEyUW+J+rTPOOvebRPPkBSiWdD50wct5Q@mail.gmail.com>
Subject: [PATCH 1/3] haiku build fix second batch
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 95ef79ddff73eebd1f1bec6673c2c68209fab107 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:56:14 +0000
Subject: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros build
 failure.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/qemu/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783..1d3e4c24e4 100644
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
2.26.0

