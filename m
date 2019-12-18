Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD21C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71034206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1G4NhaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71034206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYsI-0003Rp-3E
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3s-0007KY-Cj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3r-0003R6-95
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:16 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3q-0003N5-VM
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id j42so1975332wrj.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=OjMB1EI/hWRJqhSpYyL+FZY8NSTWMA7fRjTMsv4X++c=;
 b=d1G4NhaJkpPtP161Y6mCgwK1HpeptY7sBTWJM19uRPyJORa/iU9gllx8UVP2Vekohq
 wdSJL5pMJ8RW5P1/Dn6yiymqfSWORK53QBfeYUQWXDI0DTAtfoFBNuz8ju9HdWlrbtEi
 eAmfQFfvz2I/Kum5gCr4lw6Hby6xWzijFROo4zXiefCY215IDsAg9lvVWLgoW2CI9qlQ
 CXsaZwopJmnD1jt87Cx6fLRYuovcHs7/2bSb79sMZ8katcyObs5/dqPNDvIEmcSLOrRv
 JNI0M985/2jZ6EPz571tInHR5BzGqJMJN1c+eIZpwUwUS3crrZfxVHO7+bsmV3tlVkmg
 RQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=OjMB1EI/hWRJqhSpYyL+FZY8NSTWMA7fRjTMsv4X++c=;
 b=FtylJM9ym9bpWInvqwsKXoa9lY7NZvY1PF6nI0kf0/onr7TMF8s9w+vme5PvqqWNG/
 msSwy/iouVW1PHXADxTcq9BnSyMgRU+XLEPd1yuPVZ7gLjGphB/lxgQ8sDymfLvJAeY4
 XZDZhbrXr+pBV6a0NTCDzkJ94VNLAqH9s+4ya0/aPU04V0+ChH9OZNOMfvyXny5mwWz8
 Ml2085doGTTf19XZyAlE0s6/IpBSfy6JqXHJoGMW79hFf/BT0RArev6CdxdK7wwoQ5dT
 Yjq/Iew87vJ58JrwpjC+hqAm1W5UH5Z+Yj021eA1AT4827TAfZwnrrUYXCerMWVmu6L5
 F5lA==
X-Gm-Message-State: APjAAAVvzE5jL76V7WbX3zNqyneO3cUbkyy29Uv+MAhN8+IDmXlIfNKA
 VfAwRN/pyeKGAcV1yHDHxMAbAVy2
X-Google-Smtp-Source: APXvYqxKGm+IzzpbwMffSczasJrnAoDWetkchP3rPpS5G1r6TzgVKVQgRv5retP0M7/Iebt+0mIhZw==
X-Received: by 2002:adf:81e3:: with SMTP id 90mr2437543wra.23.1576670653826;
 Wed, 18 Dec 2019 04:04:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 71/87] docs: add memory API reference
Date: Wed, 18 Dec 2019 13:02:37 +0100
Message-Id: <1576670573-48048-72-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add kernel-doc directive to parse and include doc comments from
include/exec/memory.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/memory.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index b6a4c37..5dc8a12 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -361,3 +361,8 @@ callbacks are called:
 - .impl.unaligned specifies that the *implementation* supports unaligned
   accesses; if false, unaligned accesses will be emulated by two aligned
   accesses.
+
+API Reference
+-------------
+
+.. kernel-doc:: include/exec/memory.h
-- 
1.8.3.1



