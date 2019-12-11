Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F49C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8DA20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMSjB4Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8DA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if37A-0001ow-E9
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2vB-00072w-Gp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2vA-0005JN-Di
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:24:57 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2vA-0005IL-5z; Wed, 11 Dec 2019 09:24:56 -0500
Received: by mail-wr1-x443.google.com with SMTP id d16so24212132wre.10;
 Wed, 11 Dec 2019 06:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=34Nd+ALMHwz8bW3VQb5UBosP3gUl7lWCXti3VJM7gaI=;
 b=mMSjB4XqPMx/gZEN4gf2TK9ZPPVCFIS9BSumJRdt/kt+2nyatWRiRflTcczACbahq1
 CP/jgPPfrGAZoqc7W1hgvU7eE4e4PSVI+GjWHLVaSnq3kN9NoRwOWYb2f+/WaSRQoIFz
 SQVX0ztzP356XGF607qTIS2xj5mqBRZHyWa9S0CMol9kavXGy8D/3f5VrrMfcZPkGEVD
 tHJQiz7UtloZ5BLwFYz9U4p91PqXa9fegHqaPOaH547YfSCkTlmmPO2zwKTn9UZm3ktH
 EvHZZaNOfu5s2c22TbdNXxU5Q35erMhxRvuVzcmEXUswn0aMgVJHaHEjRfmoUKoQESwu
 Zafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=34Nd+ALMHwz8bW3VQb5UBosP3gUl7lWCXti3VJM7gaI=;
 b=RLh+LqTEE3JtMiEQ2Jm67lngyfWDDdzdoLUwJl19lz+3ki57G5VcEjWkj3zn2dNKZw
 hnLAG8MfRzyG7Ul7Yjl5bEqgOf5gZSd+OUwq0t+qZlqvoRhtrbgdj95D80AuTnZaKQHG
 aqcAkyxwYsmqZBoqu56VsqwplEtH2NS6YOP1a9ZaUUNMN6INYVx3bxT+iCPaUf2v9W2i
 AKy+4d7cutwSVf8my1f0vCye77wDEgQ4riDlNoTVpWOU2XUwTwsvgGiZiT51JhQH3hrH
 F8Cu/yejRSr5BV6kmI7TaZfEMOgWz1H19eC05BwORjxFwY0OYXyicuu0RCz5sTISLpcs
 dE/g==
X-Gm-Message-State: APjAAAU8GzNxRhd/2ojTmxbom5wpKhAW301lAeDapU6Nhz3lad+8I8Pd
 /hFYb+dGO3mbS8EGBPayiym6aMXK
X-Google-Smtp-Source: APXvYqzrlIyf8O0Aw0bvmwSgPH0PUoEkTMmgJbV3R8D0ZwEq4tlNu3Gm4WtSk3EE3ocSkdTuYryNcg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id
 i3mr68020wrx.244.1576074294987; 
 Wed, 11 Dec 2019 06:24:54 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 4sm2428473wmg.22.2019.12.11.06.24.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:24:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: skip block layer tests if !CONFIG_TOOLS
Date: Wed, 11 Dec 2019 15:24:53 +0100
Message-Id: <1576074293-53357-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The block tests, as well as ahci-test needs qemu-img.  Do not run
them if it wasn't built.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8566f5f..f07c761 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -169,7 +169,9 @@ check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
 check-qtest-i386-y += tests/ide-test$(EXESUF)
+ifeq ($(CONFIG_TOOLS),y)
 check-qtest-i386-y += tests/ahci-test$(EXESUF)
+endif
 check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
 check-qtest-i386-y += tests/boot-order-test$(EXESUF)
 check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
@@ -1193,7 +1195,9 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 .PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean
 check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
+ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
+endif
 check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
-- 
1.8.3.1


