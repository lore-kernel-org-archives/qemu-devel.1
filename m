Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7DAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E17B20729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkv/Q3zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E17B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gLY-0003wh-Fb
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGV-00031c-FK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGU-000614-0j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id a5so15256162wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Mp8BiBSVdEYc0+9oVuuotBn7iphkJ1Zxzn3sgGCr1c=;
 b=kkv/Q3zOKVQQbtNrfctFlEG4IwDtKtJWjOAW6vL1uwwyvYw0TPOEiw/QP3ULzOtiQk
 DAWE/WiXLRft8TyKdhjlzbMNTMr2CYtRqWQyw/uicSwGLr0qBnOu2RJ585adAFM7nrqj
 fRfLTJb/B16dNAOo7WTqLxwDlur5g84IGgyTAsYyjME4j47jmeNOCM38oG1Z0SyZI4bn
 hv4qQ0sY4sTxfaMeYPdjkU2D2oPu1LoqLBfNq1hEJjhrKu8rBGLE8+SO4Bzt6ZzBEUr+
 y5LpLmc1t8QGgHh76OOMHR/xZiQgPQTzvqOuaWZj0Nw3VD7f8C0fuKL/wP5gQz2dxs+8
 7a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9Mp8BiBSVdEYc0+9oVuuotBn7iphkJ1Zxzn3sgGCr1c=;
 b=YX5WtPibfUc/ymY7KOdKiIk2mG18ayF08sbI3G0tqKE2M8EZ5eOcIIT7a7qsaXy1Cr
 x2A8s4V967HJxtK+tA31JR2gfNstUqL3LT7thnPlOxj8RoMOep32T1ME2gIBCyp5GI5y
 sHGEpmuUnCPOv7tta9F6fyKc9tQv/mM1/7fGo4gviMfVh3+q2/lXYULjAin5LlyrYLNU
 g9lroPp7Efwi58iXgOINlBrChjJlYyFlvx4MX5kbKAxrt9b472yUt13mjehHasj3DXEq
 S76BlwDzxVR60ksYbwqutS+AklYFizZEZHZo43zPQfGrUIEBwKPTywQCGEr45EJ3DgAj
 rAaw==
X-Gm-Message-State: AOAM531V1AVkAbF7FmzurriWa66V8YQ24B/U2z3259nH0uK2Y8hm+Xab
 ENEfWYIgiWNTwDPJsTSaeQHCp6nhxlo=
X-Google-Smtp-Source: ABdhPJwKaWus3GCD2XWrO4nKe0g1GXcfpqH1voAtRQnLUz6mL7G8YH7JQxSWC/PPyMq1IZ24Z0haXA==
X-Received: by 2002:adf:bc54:: with SMTP id a20mr15634006wrh.227.1597675052444; 
 Mon, 17 Aug 2020 07:37:32 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 006/150] build-sys hack: ensure target directory is there
Date: Mon, 17 Aug 2020 16:34:59 +0200
Message-Id: <20200817143723.343284-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

By removing some unnest-vars calls, we miss some directory creation
that may be required by some/dir/object.d.

This will go away once everything is converted to Meson.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rules.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rules.mak b/rules.mak
index 694865b63e..56ba540a32 100644
--- a/rules.mak
+++ b/rules.mak
@@ -66,6 +66,7 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
                   $(filter-out %.o %.mo,$1))
 
 %.o: %.c
+	@mkdir -p $(dir $@)
 	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
 	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-- 
2.26.2



