Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A93C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD23E21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY4dAjrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD23E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYM9-0007qb-6g
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3E-0006Rp-DV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3D-0000xs-93
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:36 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3C-0000sr-Tc
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:35 -0500
Received: by mail-wr1-x42b.google.com with SMTP id g17so2023311wro.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mfpu4YCJ7dJvQ7hqXOMh4Cdm0EQQJgAWWvy/fePDydo=;
 b=eY4dAjrR4BenAwAvVqApiGbu2+qico3fnFjfdModZaarIiZ+R+lmSw45PfQfbTikKo
 iXL0PgWG7R9H2UmRZPgkEI2Sqa+um/iEGRnd4n9+/x6r13yGR9WfFyNgU107MM9k7Cjb
 Mg6nP/RcEn+gXMdP+ibc6lIkjD51ua9UXYSPoD66iKX4wb8wrLubA1fbcam3kWKbvP2H
 Jtn+ITNvfvynWwBt2glIXGFzjpPDxWHwtU2o2vf8vthvTQvUrXIX6L1aFWe42xyEecw5
 VpQ+fdTw0ukqrkOPG4j32mSTKyQO/8jj30WIMeGjyXRcSDS98cyqXvQcfz3OzNkiM4I5
 TS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mfpu4YCJ7dJvQ7hqXOMh4Cdm0EQQJgAWWvy/fePDydo=;
 b=I/LXfAM0kJ2+S4BrusmdVJOTIvuDuMTQ/47mN6w1fHjEPt06H6O2xoW3xYbKR8t9bJ
 dnI8+d203Zb73SS0F0o1vEJHZqIZax1R1MpmqoMTXNOoTevFj3lOPyO9dFCqZiHbQ2Mn
 PA2eTkVweVT/rRw8dct1BA5AkxnrgUF84m5ayiGY7daBEuvOXzrMCOjeTTa64znlTEe9
 0K+pESkt5pSffJGNyxPgI4VfDQlyl5naKUgaLlegsNSqayTOPOwIDtu0/+yJcQgC2V0g
 NiPI3uUIaB1BGpRHfD0NGAyw6VMHwEQL1oFv99tgSBVkCcEQcwC5NSg63L8l2vNtHnWG
 MX8A==
X-Gm-Message-State: APjAAAVk3ww0HUnyuVQ0ELwgQ+RfOyrEU50axWrFeUKp2sDu5lEk+Aq9
 +FmdVI/mCW742WfO4d2WmKHiCutt
X-Google-Smtp-Source: APXvYqzOPeJDy3NTt/HGG/6KwgbqOa88zuH2ot01zUAVuW0PbtlPQrT/SXwryZkjSoIjzicox8ecCg==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr2361840wrx.90.1576670613222; 
 Wed, 18 Dec 2019 04:03:33 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/87] tests: skip block layer tests if !CONFIG_TOOLS
Date: Wed, 18 Dec 2019 13:02:04 +0100
Message-Id: <1576670573-48048-39-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

The block tests, as well as ahci-test needs qemu-img.  Do not run
them if it wasn't built.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b381387..31b8667 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -167,7 +167,7 @@ check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
 check-qtest-i386-y += tests/ide-test$(EXESUF)
-check-qtest-i386-y += tests/ahci-test$(EXESUF)
+check-qtest-i386-$(CONFIG_TOOLS) += tests/ahci-test$(EXESUF)
 check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
 check-qtest-i386-y += tests/boot-order-test$(EXESUF)
 check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
@@ -1191,7 +1191,9 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
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



