Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4287AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D175D2076C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMfpbcpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D175D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFa9q-0005jL-OE
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFa9G-0005DV-W9; Tue, 08 Sep 2020 05:42:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFa9F-00039t-Dh; Tue, 08 Sep 2020 05:42:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so18335801wrn.10;
 Tue, 08 Sep 2020 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vRvvNFuPLMOty9OGBT9DAPAEn8hxMWpojKikY7Rxziw=;
 b=MMfpbcpyiOfkU4eIuwXfw7wvXmeU0CYXQfAWAqsZAqZvjv/TUGGUt2Jar7j2pNvg3h
 apfqGTGcT5CiW7eWS25ypgkpp0EbulMD+Ys/wvSevXamEw/f3Ux6NnxCpUy0JNBhw3Rx
 Q3Kx0oTDsZjs/rfVobr1c4TKxcnuYaLS63vagaR3BQCCXGjYQzKcMcfKd4vx0E3P6AzL
 /hKwJ8iPi5pii7X1mrOSq/x/Gu+rb7mMSmk3rGOAeQJEuroe16j4FGHA4YOflxR5GCfY
 AgzC+d2q/7RlwOJCh+gGxqp+shRZewpjIX5sefoWSheFzZ6SWIOW/ZGrdL2jWiy8t135
 Or2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=vRvvNFuPLMOty9OGBT9DAPAEn8hxMWpojKikY7Rxziw=;
 b=mVchIA2Kcvj9AUeN7wsIxbOn1zRklfIbjqhHH9belPezRmHBGrHG7KbGX55DbHdf14
 Ex6NK9wDuLTauv0YQylC4WrGaBGY4/XeBJpVa1+YACf0IxjZCmhVtojIhLxJO5sNfuNa
 K3t9/B7GAO+EBYwTLPcUAFTuwC8fUZ7KGCjQsE2s3Kxyq1M9tk3eoGJtAaHSxHP44LrN
 n2DsnFOjNJ7a3ClzqDRZP5ieOuYTVBOUMoHJl8mCWvAW6DJzUMiwWWk+pkua7W5EmF8C
 YwGWdfc1IsyUkczaZMU0eDyWPxYYk5TMTUCwtXyyfRAkgfeLjgp+rFIXJyAHXoEWxHqB
 HeOA==
X-Gm-Message-State: AOAM533m4UHpPbQ+JgPfwd4OmzvaCNcBKz8xSsSGk3mApsOf4x4YYt+M
 mrEXNC5Xx43FhpDfIi/dyoV8fFpsro4=
X-Google-Smtp-Source: ABdhPJwVepSNOhJcP26FPT9432P6d2cuVNednWxiCYln1Tke++MB80BmQeSzVO5ipowK+YiWYyShbw==
X-Received: by 2002:a5d:574e:: with SMTP id q14mr24730857wrw.281.1599558162380; 
 Tue, 08 Sep 2020 02:42:42 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:6c4a:4cae:bef0:843f])
 by smtp.gmail.com with ESMTPSA id o4sm29701827wru.55.2020.09.08.02.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 02:42:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] kconfig: fix comment referring to old Makefiles
Date: Tue,  8 Sep 2020 11:42:44 +0200
Message-Id: <20200908094244.26327-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Kconfig.host | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig.host b/Kconfig.host
index a6d871c399..4af19bf70e 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -1,6 +1,6 @@
 # These are "proxy" symbols used to pass config-host.mak values
-# down to Kconfig.  See also MINIKCONF_ARGS in the Makefile:
-# these two need to be kept in sync.
+# down to Kconfig.  See also kconfig_external_symbols in
+# meson.build: these two need to be kept in sync.
 
 config LINUX
     bool
-- 
2.26.2


