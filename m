Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC5BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D86720678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpIVGniE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D86720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxOJ-0007F2-OC
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDxNP-0005yM-Fa
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:06:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:40460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDxNN-0007Pj-OQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:06:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id c142so3435915pfb.7
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kz1djDywG9o2vGqIHANaqTAC7J89aU4D11miamrEf70=;
 b=OpIVGniEkYlGy5R1CJOJ3tY3u4R6qrUHtPDtTieWqPxexmWUZ/lI3cW5kNx3pRQRAS
 IFHS1TnAuEBRTUtEuvmZpjbNpycAz9gRMyX3qj3J9ratMTspDFSep7h5J28LOK32x0yj
 d5gWNcr6Em1S6FHt2JGZ6Ci6IK0X1STIogMV/Bfr0t9B2eJCvt43hz6xb1eZhNKdyk88
 FQ9d/6g2QmpH/1ec/jZ1LfRFVLXt5i/Ju9PwL7WP+NcnxEr1Jkx9wgaX++LAO6AY/Quz
 SJS5/crrRPCqpbQwqbwKRzbg3SmmqkvMLtGDZaj+nGSpN/pYeR8C/6IUNMmRIKXrCx0s
 J3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kz1djDywG9o2vGqIHANaqTAC7J89aU4D11miamrEf70=;
 b=fugVrj6bcK5LvuGNDFjblFSLhXzxD2VW7IvrZE1uhgauXSC9sW4sUHItVmU40BG70f
 OAogEeJB27HgfIFjxNtlQ1Wx0vNDskxqUjsAOy5L/2WtN9uhtas0O7+Tp+TAdEDG+wkT
 nVGPL0tSJwskE7cxUqLQ24yuFCfYTn1yc/aNc95uXYkITuNfx5UAk9+V88MTgT9QfLT3
 c6SbwNosEHYaWk3RKmFui6VXybZ1w7FPFYMkjruLaJ9KskzdDXtOrKOXw0g+bU8KphJ6
 SitSgKR/4759JJdvUA45gij/qr8ud38BpKx5U9clcgKTYJfJrJS0EG5famQtMBHpvRGQ
 R63w==
X-Gm-Message-State: AOAM530M5unWVfrbvIb/SHlutJf4jzxjbMGvukCwNoMAhlAiW6burLp6
 bpIxrfYdLB8bmdclf3nvhKOOI/QhWWh0Ng==
X-Google-Smtp-Source: ABdhPJx0CctEGfpnojC81zLEvlP8i6SNU8VQESo5VAlM3pItJBxdAoCdO+a1lHUEIbnlc8+iJO5zSw==
X-Received: by 2002:a17:902:544:: with SMTP id
 62mr6046560plf.162.1599170795759; 
 Thu, 03 Sep 2020 15:06:35 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id i14sm3341171pjy.24.2020.09.03.15.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: the error info not consistence with option.
Date: Fri,  4 Sep 2020 06:06:22 +0800
Message-Id: <20200903220622.504-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x432.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index e42d210e5f..ae63c4fd54 100755
--- a/configure
+++ b/configure
@@ -2545,7 +2545,7 @@ fi
 # vhost-user backends
 test "$vhost_net_user" = "" && vhost_net_user=$vhost_user
 if test "$vhost_net_user" = "yes" && test "$vhost_user" = "no"; then
-  error_exit "--enable-vhost-net-user requires --enable-vhost-user"
+  error_exit "--enable-vhost-net requires --enable-vhost-user"
 fi
 test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
 if test "$vhost_crypto" = "yes" && test "$vhost_user" = "no"; then
-- 
2.28.0.windows.1


