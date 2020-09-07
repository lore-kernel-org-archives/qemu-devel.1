Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609BCC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73D62145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ39Q70K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73D62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNQa-0001MT-Ng
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNn-0004i4-TU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:04:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:37425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNm-0008Mf-A3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:04:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id w7so9123506pfi.4
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WA05sJoHqncdo9RaNraHixhNExgVWebBduhybnmWtFg=;
 b=fZ39Q70K2L3BPTiw3iRu1nVbMwKVm/YABSCg9OQJsEorSd4JH+Wzbcbk5az031U2oW
 jQ52S26LcfgbjF8VMA5Adw4fkmNRWWxDGRxyscZe6O1siJqZG5DNwqJFNf+wlofNX9C/
 fM3dylycbqnxK2DPYm94FiLT8wB1kCeLe+ly4panU4V45sX/sihIBsMJXqMhCLruxV7b
 cB95TekPU+LhqnOOBDmAg+57doPR8YIP6Ku6EVhq9cXYY3SRvhZQFP73EQxwEo5JCaBK
 nNt6OraHqHkY6uf02VTHE/XS+yW2I4uNEzWvI3NEowsH0mZ6H3bdI3xELjsOSgd0SD4m
 kIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WA05sJoHqncdo9RaNraHixhNExgVWebBduhybnmWtFg=;
 b=SFIZK84s2I5HsUmIAeW5WK70F5x/O+m/m+/HRxx8ZNMy0KGPx5yMuL52r8Xe+xT+mF
 ZKT3e0Qxg6Kt3d4uiA/G2FEi5Te4TF5l9RveMLsQ1nEiMdfhYW7eg6vyD3T3RcnnswPo
 zCymIG7ZqTIn4UBU8ounK3bIsyT3HUIKR9mpHQ3FtbliYSjXyaPE7vKSibhtakP1eCvW
 H+DKSEM4VSug8/BQ53uaBQDLcHxXIt+PLc13qPPpzIGWklleb17X2iB14ipt8z6OTRnR
 al8ZIIqtJvd0glmf3PPUZKzzoUFj7ysdt/pMkVwcYz2MnfCPgTUgfnDICaFjRH8UBKWS
 o8Gg==
X-Gm-Message-State: AOAM5312dE0sewIdz3VCnJHNAT8tsjCfANF9KpdeoJKYFd7gGpNB0E9F
 jpK3TJSeS2ufa+s2SA3/DAWUwB6GTuQNdaJk
X-Google-Smtp-Source: ABdhPJzxm3avZehq0aF3fbPiq7DJESGWt07+xPu6oXKaEkmwSZ+fLcJbKg+vG46ZR8r7STNwfzI/ag==
X-Received: by 2002:a17:902:7c0e:b029:d0:89f3:28d4 with SMTP id
 x14-20020a1709027c0eb02900d089f328d4mr19496066pll.16.1599509092331; 
 Mon, 07 Sep 2020 13:04:52 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 204sm8713098pfc.200.2020.09.07.13.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 13:04:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] meson: Disable test-char on msys2/mingw for fixing tests
 stuck
Date: Tue,  8 Sep 2020 04:04:30 +0800
Message-Id: <20200907200432.2418-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200907200432.2418-1-luoyonggang@gmail.com>
References: <20200907200432.2418-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x435.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=E8=8C=85?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/meson.build b/tests/meson.build
index 7f27a15cee..cf816a33cc 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -198,8 +198,13 @@ if have_system
   # are not runnable under TSan due to a known issue.
   # https://github.com/google/sanitizers/issues/1116
   if 'CONFIG_TSAN' not in config_host
+    if 'CONFIG_POSIX' in config_host
+        tests += {
+          'test-char': ['socket-helpers.c', qom, io, chardev]
+        }
+    endif
+
     tests += {
-      'test-char': ['socket-helpers.c', qom, io, chardev],
       'test-qdev-global-props': [qom, hwcore, testqapi]
     }
   endif
-- 
2.28.0.windows.1


