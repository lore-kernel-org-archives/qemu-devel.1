Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2405FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF973207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="deB9D2dE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF973207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelvA-0004nN-2p
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqc-0005nQ-Um
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:22 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqc-0000mx-0j
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:22 -0400
Received: by mail-pl1-x644.google.com with SMTP id x18so1700764pll.6
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DpQu0u1B+To4merP8lGd0wuHe3HC8iNvo+aly+1/stk=;
 b=deB9D2dEZRN/05bruWGmXhgcY0DHErO5T+ACOihxGcQryLJ+7JjPG5ZIAzZ3J816sM
 +14nSd8e46tqP5FPUoX+wYXMZppW+5PFlF8xhx1mwXhYfW9+Qh7GVHzou3/d5/map5bB
 JYfsfEFuiYJceVBpCB8xp1pkPdvsF6ryVHZHzLmWTSbmtR+rPgQd+fufIyzU1UQeSSor
 /zN6UfCGgqz9BLUJ8lCZAHg6u6vpI3NiJPN7ZnMWwzTrsr+VMWsNcQI0jLYw5/ii3LC8
 bpBrYUJSt0cPQZ3CvVJDAv3QglKRU2zKmstnzBt7kpj99k3YI4Q3Pe3LQSL+uV/0jgZv
 1F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DpQu0u1B+To4merP8lGd0wuHe3HC8iNvo+aly+1/stk=;
 b=fGfQ0kTUpmGRVgedt6STFjG4VV5/Qm0jEwNo9SlJ2fBcviI+nxNjQZonXtVu3ybGXn
 AVz5gSU99LhZH2hqBhPL/J0bS+AW2IrMY6f+7NQzv45gzWRyRgqxqvk+x0RSy/eGZJmg
 QUHCWo5aIcrQ/TRJ8CKwcZsXUCU9d30ZzBH0cna52ABdxI+DEhviYXvaI+QOhVMkMsos
 2vzQTUd101dIxU7dnRoj1uL15Be4cTQRKZ4ImyGhKYGBGQRArjOzuyc51m9skfMkJmTj
 r24scv9ZKfnviZwpAkudks6zm8YQqlD2QnxKvxfBPX/MA57hbRt6pYsTW98kCu2LNOZ7
 bNNA==
X-Gm-Message-State: AOAM533ALc0cbRkqFHnisoqwaLv6ehvXVznnO50Ift9MKBh93b6LM1aL
 Q+jyud4C51IQuOTW0PWg9RAfzr0arHVBQA==
X-Google-Smtp-Source: ABdhPJwEPj86GeDWt83c46t8vmHIdXjiXyuGZW59UYnMKorHeDcX9Jxpap/TWu9jUbCmHLfYLfuIsg==
X-Received: by 2002:a17:90a:e54d:: with SMTP id
 ei13mr9298411pjb.126.1590785000395; 
 Fri, 29 May 2020 13:43:20 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id t12sm282839pjf.3.2020.05.29.13.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 13:43:19 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/12] tests/vm: Pass --debug through for vm-boot-ssh.
Date: Fri, 29 May 2020 16:34:50 -0400
Message-Id: <20200529203458.1038-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529203458.1038-1-robert.foley@linaro.org>
References: <20200529203458.1038-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: Fam Zheng <fam@euphon.net>, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This helps debug issues that occur during the boot sequence.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d9b34eae63..e22c391a2a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -97,6 +97,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(V)$(DEBUG), --debug) \
 		--image "$<" \
 		--interactive \
 		false, \
-- 
2.17.1


