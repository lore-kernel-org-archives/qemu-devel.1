Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51186C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD7B208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSJ2I0B2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD7B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iah0V-0000Bg-2t
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagr2-0002Kv-Q0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqt-0003SR-CM
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iagqs-0003Oq-E4
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id b6so5692696wrq.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h1QbsiBqD4r5lnwOURLn9f9iSFyppDHdfk3gzxS4r6U=;
 b=tSJ2I0B2seMeP/UtIUygaGcCRA/q1CkN/xkDd6INo/COSc4Xk6eahl120pirFFstgP
 NaJm5SZJOXqjquD2XpmvQ8b4lZkIRXnrkxbFBIhdyEpx7m5PjpkThHKgje4D7TdAcPCB
 w+TX0sM3oTd2f3efgHUXuBafAtwtpvIX/DO+e8P9OtBBPPlFWQpUXkFSJRIlVpCXD4xF
 0aZHjzI3pVVxQpM4JKKU9gIkioET7xGjzNh3KiZTgaQ7SF297k98dVeLG+2zi8LLdynn
 BmuHc2NTzTodfzAGNeSHhhhDLWD6KP+McIZ5S2V+Sh/0bB35GSzHv08rCobQ13kkvQyn
 WSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h1QbsiBqD4r5lnwOURLn9f9iSFyppDHdfk3gzxS4r6U=;
 b=RyANwkZenPQhqXcvnOo7YYZ1eVZ7B/posbs3z7cUbkTZvUTCuEbmfU24/Dupc/cbVh
 PPY7Q3tBWg/31Cw92Qx+wXXBEE3f9jnJ8jdljvXljBt/Qd2URwHPd0/AbVKm/CKSh/ik
 vXq3k3/5f5ADteYmxHDxkwiTFj4oAUipFZKYpzGEicuwVqF11ogzq1i7ENus2ojQJbJC
 cqE0VzSB6Bn6Lyn5Mnpp9iu+oG/llkkeOwo6Y6mGIen6XHjK9yRbQ8MGqKLGgg9I6fuH
 POzFYGy4AQYMD2z0bYINgpVad6p3LCQsrbfmYcto2AXfQ/tOWegEXzDFh84Twos+ftrx
 xmzA==
X-Gm-Message-State: APjAAAW4InEiEkHWrTxACN2nTSW/i02xOEGpMU7Q0ueQz6amrb/dujhw
 YJzYiwW51449CbY67s2u3FYkLZN+
X-Google-Smtp-Source: APXvYqx1WIIInDGb72aBl/1BYgPYZS9QYZ9ueLZMgQsQ0y72hW7dPZan8LMGS1i9vAnFAI7pXRtUsg==
X-Received: by 2002:a05:6000:1602:: with SMTP id
 u2mr57822402wrb.249.1575036146566; 
 Fri, 29 Nov 2019 06:02:26 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e7sm14190030wrp.43.2019.11.29.06.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 06:02:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] docs: add memory API reference
Date: Fri, 29 Nov 2019 15:02:17 +0100
Message-Id: <20191129140217.17797-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129140217.17797-1-pbonzini@redhat.com>
References: <20191129140217.17797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org
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
index b6a4c37ea5..5dc8a12682 100644
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
2.21.0


