Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E34C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5066206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI5HWVIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5066206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtcA-0000BP-ID
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFQ-0005V8-3e
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFO-0008E5-UN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFO-0008CK-OG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id d73so7442350wmd.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=krn7Kkhs4vLKmgRKkkOCYmFp/3LepaZDyU+ixJxoNEk=;
 b=MI5HWVICIvm0Aw5tsXio8fTjiwMpyNC9wXWZUPBdx7dtGvFw9o7N7QLaWxmBOeUdTz
 dDI+J4/LiTthRUp2/GinqCyHOdbMeFbKk3pQse6fM9t7ZerehZQFIW/O5au6QZX1TkF+
 ojRKk8Vfm2Eyr4EnTLhX0cjwrIqF5q9+DVjFP56WTGq9YEMFCEiNCXTsnV4/UCPZ2o4W
 EoB5OzzLvqgUKmFb8I15hKbL20fbJCbyYzQZYDw4G8EzFXN/A347rgAsYmnD70+sTWxI
 EiOcvyWMVYiuDjGckrOIVe+oWCZfJxhAbq5XOgkO7to1dA4Zs/vKgBt9E4WXancqAQSR
 JkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=krn7Kkhs4vLKmgRKkkOCYmFp/3LepaZDyU+ixJxoNEk=;
 b=Pen7CdIvQWeI3vPF/XmHdNENwB10R5J4BbJV0dTpapyZuBerZJicsX2zbLNvcbH39E
 GVqpBCgDdmnKGo9bf2kROYKGLS+aTWvdq9sYMulmATWzAfxCdlJ1VDuwQXEgXUOztr1h
 1l+Ts5zV6fqKeAqzvQZ1lY0EM7Zzgzfz2sZcK5+r45hy87HtGAIBXJ2Pw66L40UD/uGS
 n6Pelk5tizWx2NHaPVwiNqDfETgjY5e1fNPKmP6kRptxxo8ZLpYtLSuw21uyDM86uyL7
 sgerNohKVIeDQJgxp247RfAU/FAy9MHMprBSuvnYxinMhy7bz0B8wVvV2gWH/cpwKbkY
 g7mQ==
X-Gm-Message-State: APjAAAVHbbsvhk7uP12j7jMPunFsWvzziryMhlolQoN1pY6h4Jh5Gjh3
 8rwkVzsh1iiGsmwvtsetBCNebfxA
X-Google-Smtp-Source: APXvYqxhTr+pBbZlTbruBnhUvchDJ1UOOoA3SM7IH2MpPoezMxlfUOH6shSkbpHryrHUwaHjyTjmTA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr4429831wmb.80.1576513765521;
 Mon, 16 Dec 2019 08:29:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/62] tests: skip block layer tests if !CONFIG_TOOLS
Date: Mon, 16 Dec 2019 17:28:22 +0100
Message-Id: <1576513726-53700-39-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
index 8566f5f..7457be9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -169,7 +169,7 @@ check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
 check-qtest-i386-y += tests/ide-test$(EXESUF)
-check-qtest-i386-y += tests/ahci-test$(EXESUF)
+check-qtest-i386-$(CONFIG_TOOLS) += tests/ahci-test$(EXESUF)
 check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
 check-qtest-i386-y += tests/boot-order-test$(EXESUF)
 check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
@@ -1193,7 +1193,9 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
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



