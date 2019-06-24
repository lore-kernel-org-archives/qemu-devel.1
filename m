Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B2C48BE8
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47415212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ao9hyd51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47415212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfOH1-0003RK-HC
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53776)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfOFL-0002aD-Mz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfOFJ-0001lZ-Na
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:38:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfOFH-0001fX-Pw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:38:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so13690610wrw.13
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 05:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AtHi5q/cNknUVhZfWVBa3uQSrmuqAHZIqdQKWtwfbR8=;
 b=Ao9hyd511aFQrrEA3NBpvSK9bCYt1TlOJHEfpV5llpbaYpqLIxFpz213Ud61yuqfgQ
 EFoY0QBx6D5rsVA3lH0jqCiUgDxhmIP9d8B8YNX0FXJ5MMffSUZHNMX6OJ0BIkaknRuP
 VJByA79YGOo6maDwnTuSzyZZtRlQlb6PfEAmN9ansIihdPUTHXUbWygtv40RewqqvMpD
 UWgy8G9Bwubu3iUFIEmzwnZYLqx0tYCkAwpNzRZfqEQFHHxMrrwfuMToVID4UBejouyT
 xHqdIArGAbKLxBaIPDK+Y0p84/Tl0zPS7yxBi5cZ5WKcMbAzXn21BZvRQDBTjRQbfdEt
 sbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AtHi5q/cNknUVhZfWVBa3uQSrmuqAHZIqdQKWtwfbR8=;
 b=aQK/qFyGbTfXk1TS6LzN53CGE3S4k/BDAiRc3h+dgEZNEohPPFoyLwgAbL+wSLKcup
 Ck0EK8gEYZ03iL0w+3vQ0FLHfnT7lDLBgLcXTz5IME/qnU/VI8PdyUbzbEi0W93DqYMC
 bq66NfN67kGIXevBR6/vig9/F3RC+kADGeYeSgFZz765+s5J4NROpB9drXE0IAGlmC4x
 RTGytMTHpu52GtFqaIrDaywLi9PWKZaAmBY48RYpRsbY+Fu1oY7iW+dRgsCogzM+goKp
 hxF0fsf9KrYnVs9fMPgpiSJfhRNnsxulGXtuYsPJUsT+26geZ4hpyjrydeP430Sp4ngs
 EA4w==
X-Gm-Message-State: APjAAAUg37LdzuSBRrEZgSVUsjKC6MY9r7pd92CsY+8aMqqg80IO3J5m
 AMsFIq97oyEcInVB5qdpR9eqLw==
X-Google-Smtp-Source: APXvYqwo73JeN5LmtvHVeO68gSQODEmqtGqXzI+WW4Uyglc1nW+rRCDm9Ke8RvESIZzTKVP97dC4Dw==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr51670531wrq.171.1561379928703; 
 Mon, 24 Jun 2019 05:38:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u1sm9781666wml.14.2019.06.24.05.38.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 05:38:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 964561FF87;
 Mon, 24 Jun 2019 13:38:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 13:38:35 +0100
Message-Id: <20190624123835.28869-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH] target/i386: fix feature check in hyperv-stub.c
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 2d384d7c8 broken the build when built with:

  configure --without-default-devices --disable-user

The reason was the conversion of cpu->hyperv_synic to
cpu->hyperv_synic_kvm_only although the rest of the patch introduces a
feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC in
hyperv-stub to do the same feature check as in the real hyperv.c

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
index fe548cbae2..0028527e79 100644
--- a/target/i386/hyperv-stub.c
+++ b/target/i386/hyperv-stub.c
@@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     switch (exit->type) {
     case KVM_EXIT_HYPERV_SYNIC:
-        if (!cpu->hyperv_synic) {
+        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
             return -1;
         }
 
-- 
2.20.1


