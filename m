Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BBBC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1672133D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXYoMufp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1672133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45129 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDt7X-0000cW-PD
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:57:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00085S-Di
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5t-0004hC-86
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5s-0004bc-Ts
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id h4so21584283wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rDCyQEV68QiNrEEjUa3/5MOv4E0APgi3UE7jUK7dh9w=;
	b=QXYoMufpXyP6aea4NrTIs2gkRl+RFCRAg9A6CONgkUL2qiU7R3RF2L/0nNX6RzCarp
	md+d97qA2DHVEY7jXdHVr6XJOFIxQPa4WGKX//aPV7KNsbJpLz8s7iTTm1kCg0OVBadr
	W1K8nR706B3wRO5T4wsw+t7U5PfVBGNquMGaQCCol7fFtUWe7K17YAGRFEpa+iBVs2uO
	ZEuBgtQL3P/AuUxwgmJpjaCRO0ttAmGuEZIq5+ngwG1qz+i7y/D2saBVAkAbENpte5Q+
	7H1sBIcljAr9XmyPirDInGj2lsAvMSFQAoMqD1yX0UQMzVh7IRxvyeIN4yRyvTGHb3sB
	6WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=rDCyQEV68QiNrEEjUa3/5MOv4E0APgi3UE7jUK7dh9w=;
	b=TDk7jFxYr+LHKkhLac5CQRDD84o1XUxoDS4H263hIYO4OMPuhh3Gn7SPjf0AM1/Esq
	lXvK070qNfWc52sloRqv83NaZNtcCBx9Xw3Pm+vJgGcVqfJGRobqBcPOGQZxChk9eXde
	Xw8cr2+56RG9PElXRbCTd/NF7TkPFVdXQx6HL25SH2OnKoE0N/AVRHpVkEjyCxWLCwWE
	mgYw8nUnPOu+4cgvpqRfw6K2ler+1FaxZ9I8QcpqiFFoXL3iYTtjBJ9zVJKl03Wsuio/
	h9tY1EQCiOA3R1yzJzfZN3Cl0WjCAqCJekevpcxWiIyM0sGTBegDpisIUTHGxf9UllG5
	AeeQ==
X-Gm-Message-State: APjAAAX/RZvHhH51kxwcRI75e9enkxd2HwP2dR5Z6V4Sy5f9e7GDyY4v
	vwxAKJqJBlK9PqYfdGKmqbxqPqpC
X-Google-Smtp-Source: APXvYqzzFdcvReecMVCOcu3Mv5RKoRGsC9MJPqCbnKpUWCn1QkCUb3lxDhcvFOKPivEL9/aFeJuYcg==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr15675455wrq.151.1554825322691; 
	Tue, 09 Apr 2019 08:55:22 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g84sm23117586wmf.25.2019.04.09.08.55.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:55:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 17:55:16 +0200
Message-Id: <1554825316-33288-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Message-ID: <20190409155516.w4lGTEmtaGQr9mTmnqd9CxsjL190yP5gH8deABO5mXQ@z>

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


