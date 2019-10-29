Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E2CCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4979F20717
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3aGq4Hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4979F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUMZ-00013Z-Vi
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 12:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGn-00024l-BH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGm-0004w5-9x
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iPUGm-0004uP-3c
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id w18so14364083wrt.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h1QbsiBqD4r5lnwOURLn9f9iSFyppDHdfk3gzxS4r6U=;
 b=L3aGq4Hl598VyZ1Flp2BUR6RW92uCJKTIK9G5LlNdQnG04M7NIrVh/cfvWQsOK1y2+
 RnkftyYzZg8zSvFrfhUHacozowRrXKrQJfvGo4DiJ3t1CtQsnd3jAU0wGq5zuQa8bagC
 L7YLyzf6irZIirWXoQL+VjA0DN7qj9YGS3L/99pwUPijms2yKA7RRH0N2e4MRYPptwj8
 +5zz4d1zYLlDNvnRCqyhj8XlUd5XCB4HU2EsEO/nJpA6o6SfpzSY20BeSTCyIhNxMerI
 CGu8/cO2VTxHj8aZPmJF+KPpDiejY/4/inHx53DbeVHdIV3pltvD1lombOQJFECRAJTJ
 /Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h1QbsiBqD4r5lnwOURLn9f9iSFyppDHdfk3gzxS4r6U=;
 b=UuptgmNG5ANPsobkJUOzfJBDwAIF2dP4IGlFwtBSBdzAf0uVejUd7yzySdHXEa/80+
 bO5HaO6eCPYzVQQkI9cX+P++89xPIMKX8EWPrZ15GqJrvjF0hLsmUneHqPdV5njPaoKQ
 b/Wgz3HB+tTFb4JxLiHES1LxzQxp2gdJzCSFvZR+SHRouv4M5NtnROkLQZDZSuXDLNvc
 A4mfyEixF/XWrOovDVhabQs7VMCMdO6uMo9+y8Ho7kSjXhUaSfjGpiMvPqZc88RtAwnN
 bHxyeagmxuK3mMNAVMOCBRGQwFXCk3FCIwArYJEI1sKnbsDZR6qSgrArFUzCtfAYMOIB
 xzQw==
X-Gm-Message-State: APjAAAX2+YJ0B5UIImmJDG/UsYCe8Zd9pzjy03zWn/Kmh/WIH3ZffLW9
 JSRmMgkh+heYpZybLaKU8stmc+Qdj6Q=
X-Google-Smtp-Source: APXvYqwBuwWeGY2vqsXFXN08nj198hdvdjBF4z0lk8WH7L0gP/bK5wfbwgp4j9sV6fnoV9dOy0k9Yg==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr4422790wrv.205.1572366174870; 
 Tue, 29 Oct 2019 09:22:54 -0700 (PDT)
Received: from donizetti.metropole.lan (94.222.26.109.rev.sfr.net.
 [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id q12sm9285661wrw.91.2019.10.29.09.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 09:22:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] docs: add memory API reference
Date: Tue, 29 Oct 2019 17:22:47 +0100
Message-Id: <20191029162248.13383-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029162248.13383-1-pbonzini@redhat.com>
References: <20191029162248.13383-1-pbonzini@redhat.com>
MIME-Version: 1.0
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



