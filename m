Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F5C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EF922272
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzkjSXfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EF922272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjL3-0000k9-BQ
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGjJs-0007iM-7A
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:28 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGjJp-0002n3-Ku
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:27 -0400
Received: by mail-ed1-x543.google.com with SMTP id l17so9952221edq.12
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6coWo/KghQRTwcuSxIRXRuWtsjyX27yVGXHfqUPxFoU=;
 b=qzkjSXfQCQ1JO1lbV+Gg6EcY7hX4/maPaU5slaTaM5Dau5gEIBB20xZiBDvaNF1TjB
 2xgP41/r/ysdVrJhNte7dFpvb60gPx2CD3/fjKk+VIhfAir9kfUNNAwkkDGHtv5XJmAj
 8lTNpofHsgcHG8ZjmQjzyNQCmY2T7Sc5+STWEcA6BBDzJkRKnR/ivk3d2ePBrT+SBkGj
 v1OVFbkto/gilE+8Lby2pLtwaC74OLSROQ6Z3rSXTlvshpKEY/gHsbN2cv4rZnANYlcz
 2Fk9ScJwo5zyWfzLwH9YGEQvA41j2J9Xb90+WClA+Scw//ecwp1YS9cxqyrfU50RZJjg
 BcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=6coWo/KghQRTwcuSxIRXRuWtsjyX27yVGXHfqUPxFoU=;
 b=as3PuCMGhtrZlO+EsdXqrNCNk9DFjros/Ln2kqWem11jizWlCbQ+Ty2P70hOoSKYpn
 C+1XYXEG8vtu40cFfeTf3IXqR2MNNIJcwar0mVLpfsa/b1zQqRnFE2XbIi6TgC4bTzhc
 P7ghsZ2qx99ZKXsrHHa/jhN+Kq8gUyhtWexl9yxF93GUXOzAeJg3pwWs9vP875LDGQM4
 pO69AxRGjV15w0VuzdjY43IC5dcL4xDiT9A41WmigH3aSTaW8iXno3rHYNDSbRWVLhgw
 YGOaicHgxLnE1mE4X659uE074bAFzC1lqO0JfLzcSeW8Sn6bYs2FyglgJS6B4usiwovR
 1E5g==
X-Gm-Message-State: AOAM5306icYnH7VmHTolHKIGEewA5abZyXlCi8rB/wSlT4jh1Cozv0Uo
 eaMarQxmQl3JM/VuGi1FSVonhXwzpz4=
X-Google-Smtp-Source: ABdhPJzS1UaJDv5dtmtkKiYwEAnkjNamihrdN38yMAIXG4PxckTz93BSvMu3qVbh5K3g/HdNk4e9pQ==
X-Received: by 2002:a05:6402:3050:: with SMTP id
 bu16mr2097511edb.343.1599831743402; 
 Fri, 11 Sep 2020 06:42:23 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id i35sm1757165edi.41.2020.09.11.06.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 06:42:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: add missing genh dependency
Date: Fri, 11 Sep 2020 15:42:21 +0200
Message-Id: <20200911134221.46636-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix high-parallelism builds by forcing all generated headers
to be created before tests are compiled.

Reported-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/meson.build b/tests/meson.build
index 3683512dca..e2b915ea8f 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -56,7 +56,7 @@ test_qapi_files = custom_target('Test QAPI files',
 # perhaps change qapi_gen to replace / with _, like Meson itself does?
 subdir('include')
 
-libtestqapi = static_library('testqapi', sources: [test_qapi_files, test_qapi_outputs_extra])
+libtestqapi = static_library('testqapi', sources: [test_qapi_files, genh, test_qapi_outputs_extra])
 testqapi = declare_dependency(link_with: libtestqapi)
 
 testblock = declare_dependency(dependencies: [block], sources: 'iothread.c')
@@ -223,7 +223,7 @@ foreach test_name, extra: tests
     src += test_ss.all_sources()
     deps += test_ss.all_dependencies()
   endif
-  exe = executable(test_name, src, dependencies: deps)
+  exe = executable(test_name, src, genh, dependencies: deps)
 
   test(test_name, exe,
        depends: test_deps.get(test_name, []),
-- 
2.26.2


