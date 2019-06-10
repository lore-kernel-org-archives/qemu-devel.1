Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43357C28D16
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15345207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaw+MK5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15345207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haIKc-0000u6-Bo
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 07:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGb-00071v-97
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGa-0000S0-Ge
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1haIGa-0000Qu-8V
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id d18so8742421wrs.5
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=WyANGAEE9NsiT8vOFmuxFH7zVf5CQD/04rtusUXksTk=;
 b=jaw+MK5RMB4LJJZgZLq5gMFXL44EoXYTrA8sryfOJFFhDURtaaQ50TfeLZUv+lgpI1
 3Z1pksE8H/qy6j4wzycmIYU5NKZnWEcffFEh5mfFKMtn8QFZ2jC/WJOs4lIktpY/LKeQ
 hS20epoF9J75gdqIiKGJ6lmjhRNv4rWTmzildRj2iIGFua3opm5z2l9bsPYi1kLhZVZ4
 YJmIJJpdf/5l2spGxxAR8xKNpZKUAd9hkdW/XvOsG2RPBFbSP4laSohQY3vei8NZIEdT
 x7vJzh8qTSjxmiIVnOx5Ya7TfB8ppnstYzYGOfrXacsNwvgkLrIZJ/EUZR3h1yMZtBO6
 H6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=WyANGAEE9NsiT8vOFmuxFH7zVf5CQD/04rtusUXksTk=;
 b=llsfVa6ZWzKg+4qWOiKWpHG7KnkQlYbzCfHXmVDNSZ8/fNLSBSXky9vmh9YT2jM8EY
 XPtXTQL0QB8QJCrN+x7LhpoOcjhACGlrhrTXlIAYdLm+3+ki9w0GMZ8R05RbFbn0Iiac
 lNiMAhcfAyw6gpi5pijb1//SZDj0HOLwQKEzGAkIDRIKKVKt9+4cE2B2anotuV/brJ6o
 lvo/MSPAWlI+rHM7Pz5Q/8yXvhfhg4g2aTi2QZcNcz/9vIa84/P41t8y3ASioWVISt3Y
 MmT5BA617vZMoGf15agxh2mYI5y1W+bGtO3rJbeMCmtTTJKIX9oiF5cPeAFBe5br98CF
 JmWQ==
X-Gm-Message-State: APjAAAVMByiJgJj2bIUSlon+1M+twiGGC7xLgJToZYYzh+TtY10LxjmZ
 77kLSxUverslasnBPkMK9yt0h4tH
X-Google-Smtp-Source: APXvYqyJSGpGFDDc6kMDJs5RJRCK89O0jozLM/XT60sgEiIN1R7e2wMSG1Se+xF4li6qtA9mqnZPJQ==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr32944368wrn.122.1560165306928; 
 Mon, 10 Jun 2019 04:15:06 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u13sm11934414wrq.62.2019.06.10.04.15.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 04:15:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 13:14:56 +0200
Message-Id: <1560165301-39026-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PATCH 2/7] configure: set $PYTHON to a full path
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

This will make it possible to replace it in a shebang line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 203dece..0814a5f 100755
--- a/configure
+++ b/configure
@@ -918,7 +918,7 @@ for binary in "${PYTHON-python3}" python python2
 do
     if has "$binary"
     then
-        python="$binary"
+        python=$(type -p "$binary")
         break
     fi
 done
-- 
1.8.3.1



