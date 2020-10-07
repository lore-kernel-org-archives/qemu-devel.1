Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFBBC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C002087D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5OMXGIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C002087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCCB-0001M5-9x
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBs1-0005DG-7y
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBrv-0000sp-0j
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id h7so2827314wre.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g9M+cLZqzZD6qLL9uvEMm0RktbZNa4FzWnuD4/zjCec=;
 b=J5OMXGIaTUhNwynMTd/Mn8H+wMlFaq7tTkOOe4tchT0uu+RUHVr86onCqFbB7+bTvR
 r7A7VaEJA3ndyhFr5frW4pGkDV953fQ0hCUpVW7u+3zWDqGc+Gl3cQML82xRYLdccwx7
 ogXyKhaCx8DO/DMBC8brbOLM47XZSJhQzAjHUesRmNxoQSopOlzPhav05NIfdLK7IIcQ
 T1S1UQyWNYgq/Cbk8y0nIiU4ANpTXTj1W6jsItFreYUbRFuxGEknfYqkiNynpA8/VLEL
 ZVq4EIq6kyYsdp23mUPAQHrbLjQd85h2trAncrPqGCTcwe3X5v+PVQizFekE4eNpz7XX
 KLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g9M+cLZqzZD6qLL9uvEMm0RktbZNa4FzWnuD4/zjCec=;
 b=KhJ9wKmXqQxF1AY7yIC7teWkFSHYIypjXR4sliHUutADg6TeFVCm/e8/wv2pK0hDIQ
 YcsVVgDJWYh6OJXu7Cmcjfn/kPLrwZy7a5mrFpjPboIgV5hLpfnx4+teXRZllORHeVt9
 UvDILFlu8Y0TS35drnHs23tpydBZZmotuH29yODYCXJQoHfTHnzVEJkuIT0XpwDr6h+Q
 ZVR6H2OuaWZKJoRHy8jlMTszFRmkZ748/Xe09oPpZPbLN3X0ulNKSMj1/ZmPMMF+cB8x
 H5SoyYbWp707BGAHGY1FODM0hbNptqvcsPX+Jxmo0drtsolJPtujbmF7zykWs5prF5Sn
 xNtw==
X-Gm-Message-State: AOAM532RxQLGUAdUepYNG0RcUhPhk8Df1fPjs+lPif72r41cNzAp+dg7
 CoVXknHgaVUj2IzkPPyfzj7o+g==
X-Google-Smtp-Source: ABdhPJzAEuvYTBMVzsTK8m7+pQ4qb70LUWVM2kyi/uLuyZjVdau0DqlyqmdGBlCBHadtc8m/FQoVGQ==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr4538305wro.326.1602086441007; 
 Wed, 07 Oct 2020 09:00:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c14sm3254936wrm.64.2020.10.07.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 373AD1FF87;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/22] configure: fix performance regression due to PIC
 objects
Date: Wed,  7 Oct 2020 17:00:17 +0100
Message-Id: <20201007160038.26953-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ahmed Karaman <ahmedkrmn@outlook.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Because most files in QEMU are grouped into static libraries, Meson conservatively
compiles them with -fPIC.  This is overkill and produces slowdowns up to 20% on
some TCG tests.

As a stopgap measure, use the b_staticpic option to limit the slowdown to
--enable-pie.  https://github.com/mesonbuild/meson/pull/7760 will allow
us to use b_staticpic=false and let Meson do the right thing.

Reported-by: Ahmed Karaman <ahmedkrmn@outlook.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200919155639.1045857-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200924092314.1722645-57-pbonzini@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 28df227db5..b553288c5e 100755
--- a/configure
+++ b/configure
@@ -7209,6 +7209,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
+        -Db_staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
 	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
-- 
2.20.1


