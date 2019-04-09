Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D75C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CC32084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX/myj8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CC32084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtkW-00072Q-35
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:37:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWn-0004b9-AK
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWm-0003Wv-EF
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWm-0003Vv-6m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id k11so21730020wro.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rDCyQEV68QiNrEEjUa3/5MOv4E0APgi3UE7jUK7dh9w=;
	b=fX/myj8Rudaimerv+kTIou3DvYgG2Zjcy5RoUWWomnAKwfUhiDpl7sUAktx2Mq6Fxf
	8F1/Jjnz3vz9QRaiY+iMUNaOsHHiImj22FmRQ97Ut4b/PLX9rxricu3s2UPZB9ne2otI
	eElWxvauMOJ2SjA4Fxijflp63fEIZLtSa8+B4wgQ1R8+Sxx/BCkT0Dc2+fyvP9PrFIfQ
	mqsfYsPBUm3R9P5O/gbebnytDjvsAURzonb/RSoKK8nHYWcJCy+9rkIss7u5P5ITJGZM
	rr/5IbU9TPLf0DodLcxrCD0t4NwdMIFDh6yK1V7s/KYgE+qG5nB8Dxz77O/JpdoBkTbu
	lOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=rDCyQEV68QiNrEEjUa3/5MOv4E0APgi3UE7jUK7dh9w=;
	b=bUlGtFoFhmVZm1LnfWm3U1YizvCut/4CtLdcVk2Y/6Lc4VQdowvbFdexJo7DC6/1r6
	4hFHdPII2OndlH652DGUs1Fk8h+ZcoPWUJgWAGTIL+UUVFATAgz1pbwBMgoZSXMhAD3Z
	+BEVkhyhcUouw+HSezXhSUlpByDvTeCo5Mzs/K0GyQvL1MpLVw9oyLlEFPgyOSJLP1HB
	ksZEvLjoI8vmNOu7HBQm34hk31/NtJdH65+XFc/9cI2MclGD0soos+DC186p1xDSy6Zo
	y85zcG9+VeLBORcW1jNq14t+pKyWO8yxMVh0gFTs+i355LCY24CaLXVZdrVKx5w+e3Xi
	rj/g==
X-Gm-Message-State: APjAAAVR2NVojlcY6WSJrBFPzE5WYL//bAcqIutkB6rBMaC7UNcvzU3j
	ubLTWh88qZ8zmmT3Ungfq2q9EH+H
X-Google-Smtp-Source: APXvYqyeLQa9BvTuBVZ7X0ojWQZrCU2pVHTleMWRc8HVwe+Qd0NroWnTAwETRs+13hxJq7Gz+g37jw==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr25218670wrv.19.1554826995063; 
	Tue, 09 Apr 2019 09:23:15 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e1sm59579736wrw.66.2019.04.09.09.23.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:23:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:23:06 +0200
Message-Id: <1554826986-37164-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
References: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 5/5] tests: Make check-block a phony target
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409162306.CUfaLjK5T3eXTzpASoILvHOhs09sND5tmT7yXVUwrYE@z>

From: Markus Armbruster <armbru@redhat.com>

Fixes: b93b63f574c "test makefile overhaul"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190319072104.32591-1-armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6b904d7..36fc73f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1164,7 +1164,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 
 # Consolidated targets
 
-.PHONY: check-qapi-schema check-qtest check-unit check check-clean
+.PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-- 
1.8.3.1


