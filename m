Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F39C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D467921783
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfJGUr+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D467921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX68k-0008L8-Ur
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63q-0001tO-KT
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63p-00066m-JJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63p-00065t-D6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id q70so3803822wme.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CTwwXQwwlbADAhtITpXxTkXx7WnAbK2L+Hoi9QvzJec=;
 b=vfJGUr+AF2qZ5xtiVbrHxp92JVMCWE3fHTQW37AhtCte0hEoLSt9MXm7W0nOpDYVyn
 kEA+F0cO/JBrluhWspDgegfb54ID1FW5qzVH03Ud8+84zZ1Go4ijNoZlgZIU5FzxovTP
 cRrlTAtKwabWQQylQVgIf13vQ1ur89Cja57RXHKYcKpHeQMy6QAjEjRqGKI9MSz3QM3r
 2yxVtVHf6dbNoW+FZtxv3ciHuoJAJZj0a8YcsYeft2kcwjreSc5avE4he5hAvdCL0c1B
 D2+A0caqhLDSJCknfnjZcPlElNH0zgqV5dLtGRrjsyWlmDFZq9ZlJYLF0BPPUt8NxreR
 3Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=CTwwXQwwlbADAhtITpXxTkXx7WnAbK2L+Hoi9QvzJec=;
 b=pWz+wyB54wWPPNF4l5Tl993cX2lfs5mBOUn1DNwDFn1Ra892uI9/OoRpaQqVHLX709
 05BwPz4J3e1ssTiTLWXO7yi6sJDdVTc/B1tpGg8Z7o3lSnmPTUKdcMnntdFm+SebPgnY
 b7NPULN1NWsQlch41vk7xKLa8R5U08nf3182jU4UWXn89+LBozIu0xFcfo55gco/2Grc
 4K27b61M39J+F/UQHrHrPHo3pCDXgRRVs8WFwDN3rnJfI5x4BIda15aGq4MQ7XpTWQLo
 lJ8eoRnYn7pqEA24+knVqTmuZJUabH+kGbj88g6GPt0x9r1nWmju9l6PUnIURmho+RQv
 ErQA==
X-Gm-Message-State: APjAAAXaQ5RHRezgFahdBvoCisZdscYdu9CY3O1ONL1EJ+BaSN5lNclO
 s/rfrV5s8L8oShcDcl2uF/Yf7ePy
X-Google-Smtp-Source: APXvYqwjCQncQYK3InuYyRpo3Wm322hApFEDxoRIItzYCyaNOOx8eGrwbXsnE1HQOLa5tITzOjwGXg==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr6412953wma.71.1574179738618; 
 Tue, 19 Nov 2019 08:08:58 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.08.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:08:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] docs/microvm.rst: fix alignment in "Limitations"
Date: Tue, 19 Nov 2019 17:08:43 +0100
Message-Id: <1574179728-35535-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Fix the alignment of the items in the "Limitations" section.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20191115161338.42864-2-slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/microvm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/microvm.rst b/docs/microvm.rst
index aae811a..4cf8474 100644
--- a/docs/microvm.rst
+++ b/docs/microvm.rst
@@ -33,9 +33,9 @@ Limitations
 
 Currently, microvm does *not* support the following features:
 
- - PCI-only devices.
- - Hotplug of any kind.
- - Live migration across QEMU versions.
+- PCI-only devices.
+- Hotplug of any kind.
+- Live migration across QEMU versions.
 
 
 Using the microvm machine type
-- 
1.8.3.1



