Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F211C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D41207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epo1pGI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D41207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbobz-00089o-83
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIg-0003Ts-E4
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:06 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIf-0006aW-JG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:06 -0400
Received: by mail-qk1-x744.google.com with SMTP id z80so7918986qka.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OzUdSzbvDHrAdBgz7T3QQ9Qj/8hER0zlUjzEzhKy+Cs=;
 b=epo1pGI3gpW88W5PHsy3ZFJt+SK4RoqLsF/r2FtdCz1E1btUeehJKBeB+0OEcyF5iu
 Rs/5AlC+AJxI8BUUF6VajZyYwQtuXamDh4fSkvY1ZFPPiU4zt8gKNk3Vnj9zJwKJtZtN
 YYlRewsQ9NRETBvne6hovJAJi0z1oOcTEbG3aCVVKsRfaICHfwloEVbY5r9pNl01EC2j
 /xFWudmPAZnfintZgM/2Y4hldekthLaS1+ZM/zMBRqgmYZHRru86pDVRRM/WWdHOPtLH
 81uQ2NQx2c92eGYM9bavoo/E1CGZ2wbrYecHJa6OuLuo/CfkhG1Onxb4OmeoWx6xVmyp
 C/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OzUdSzbvDHrAdBgz7T3QQ9Qj/8hER0zlUjzEzhKy+Cs=;
 b=tviNCnzwBYuf6n83wjT5g4njfRU9NmpQ30XZ1ylRGbZjI+/y0dt1RW7foRoSGZuZrL
 xUznilPiW6MN+xyllVyOHtfrdDQQwWTAR1f01Ztxt89ewSiyj7MagdN7XJS0isRG1SZe
 BCF0lCtJQAZ48MVxVCy9/lGinom8Xi9Idrl3THld0ne7utENWwKeEV/nOsMn0YUn+FFo
 Qb1BJTXljA0sYcfr2Mo2LXrt+YaQwFL2JQB43oU5jYvKz7bK9X5I5h5W+un+/ADxqYwj
 EW7rfwxL/zVAMhpQrsFOxpJI14itO6Rt90GPUyvtfBt5hZpsgzbWHRfTPdfBd3HcK6Yb
 4+xw==
X-Gm-Message-State: AOAM530qxB9r/y4IBANrtZyrD/7C8SI+8Uo9oMB1+L3UXwm2m3aOQvIL
 pH1TrUrUDrtRqVWkv+Imo/bNJHRJDeUX5Q==
X-Google-Smtp-Source: ABdhPJzk8jKKDYcROKl/Jf5+bM0JNQslgUJZHDsKb64J6WlgH4Ky8tuH8t4EGazyHhyxQtp61Re1SA==
X-Received: by 2002:a37:7904:: with SMTP id u4mr10743206qkc.297.1590079444291; 
 Thu, 21 May 2020 09:44:04 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:03 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 37/74] s390x: use cpu_reset_interrupt
Date: Thu, 21 May 2020 12:39:34 -0400
Message-Id: <20200521164011.638-38-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 qemu-s390x@nongnu.org, cota@braap.org, peter.puhov@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: qemu-s390x@nongnu.org
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/s390x/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index db6640ba2c..dde7afc2f0 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -530,7 +530,7 @@ try_deliver:
 
     /* we might still have pending interrupts, but not deliverable */
     if (!env->pending_int && !qemu_s390_flic_has_any(flic)) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 
     /* WAIT PSW during interrupt injection or STOP interrupt */
-- 
2.17.1


