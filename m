Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7EECA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209BA20731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YulGLjtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209BA20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYakN-000177-Tc
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYael-0000Kg-CW
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:35 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaej-0001qb-9S
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:34 -0400
Received: by mail-qk1-x742.google.com with SMTP id s186so13074878qkd.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4XbTsG1xyE6Gxli83WzwDvPJ23B7Sb+sDM/S8AQT0kE=;
 b=YulGLjtUHkItKXBp2mvpG0BSnoD7x5Abn5xaxyttQ9x46Pr6Bhxy1ULYU+FRfbbf++
 N5RNOlVMetpf3SopdQt0MP+pckmbuzlg92D55iICB3RzIOomnhkiCnvwstSSDeeP6jbx
 S+cLKZ9h8e2NAp6lyd0l8ly1kh7tehgNlCWaT+A/kZI+b183MneujKOoH81g15gIzKVy
 qXW0TMyO2IHmMWumofCHmrsFE6W2ck/oS5yVh9R/H8+EDv7i8nEPdGOdLv9Kkwcvn0L/
 iFeruBhlpSC4Vcl4qR0R9ofVizmTkyYaWUwI5h/LP28ykPnw2WdgL7HDEvQZAKYqK8NL
 G0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4XbTsG1xyE6Gxli83WzwDvPJ23B7Sb+sDM/S8AQT0kE=;
 b=K3bT1oYm4sV4hXBVjVpjWC9BeNaVEEKrURp6X08A0bUraqUlmJl/FKVdGlGv+94sNZ
 nsj3kD1VBY5/tMhDiaTslsHGU9uoVJL5crfS4ZSijYyjew7b9nWjd2Xe/POeQfNVKeZ+
 UU36O8+Q9asGKuWMVOLoytiZ9EckpvDfEJvDr0G4nOKGRtP8DVdD4f7nq4v/qAPyilRY
 kTiWMuMGl2tot7Z60g1F9RjKMQmplb7gx7aYXcTGzsoL72+8XkGKTfWUS3xS5Uugkwwg
 RX6hIxzXvmyOx5/6SUQ3AllgGfwljm9d3rQduAjoU9rbFO6x72tHxU2CkTZshG9SDxgq
 R44w==
X-Gm-Message-State: AGi0PuYveh8SL93cmsM5qtOViuCsP46Lavip0SOYQAls8HYKN7z+IjLO
 F1mPhSlkZdwtdvfXruMuz1KrZup+zzuk1A==
X-Google-Smtp-Source: APiQypLldCQOX0gsM8DlUHod5SeNX0iZ9lCPg6rysW8wYNqIbI4NxGPNMd82tUvnRyYZBknRIMvzEw==
X-Received: by 2002:a37:7dc4:: with SMTP id
 y187mr14833780qkc.412.1589312011969; 
 Tue, 12 May 2020 12:33:31 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:d31:9f53:b3eb:9b53])
 by smtp.gmail.com with ESMTPSA id j45sm2100998qtk.14.2020.05.12.12.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 12:33:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/9] tests/vm: Pass --debug through for vm-boot-ssh.
Date: Tue, 12 May 2020 15:33:34 -0400
Message-Id: <20200512193340.265-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512193340.265-1-robert.foley@linaro.org>
References: <20200512193340.265-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This helps debug issues that occur during the boot sequence.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 78a2de1f82..4e041103b7 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -96,6 +96,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(V)$(DEBUG), --debug) \
 		--image "$<" \
 		--interactive \
 		false, \
-- 
2.17.1


