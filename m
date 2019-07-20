Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EEC76196
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B98E2084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHrWALR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B98E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1horAP-0005th-JB
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39922)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8Y-0006KJ-Hx
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8X-0008Ce-A4
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8X-0008Bp-2t
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id p17so34986183wrf.11
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v8dpyNBhtLVCL3x1WrV5A15VpIlNKEu8CU2xcQnGtNs=;
 b=KHrWALR9QKdOmEKqRPGwJWplCLF+xTAG0/cj83BL90uw+Q9O/abxFBYSfM8xqNztB8
 dzRvLhC2JTgOfapaEsxaaCDy6gw9zTDm4jg6HdTdh1PtrFQioxuoYexG1Gk6afdVc7HG
 //81V4aCFrEsNGyobnj2MMGAP7wrZw90EqegliQBfctM6GxU0xQ2V2E7qKrR6pp802uf
 A39gd7+lqit5oaPQjixzXgkKnXJDAVJwW0VTjjv5qYJzDo675ehkKG3nHOBxn5Ptd+P3
 sPT45Mc1O8FhYPD0hD61FKdeuJ3qauzyb/wA+GulPDk5Y72fJ6MxCz2DeDWFZRhuj4ZT
 nzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v8dpyNBhtLVCL3x1WrV5A15VpIlNKEu8CU2xcQnGtNs=;
 b=Z2lO7TEaNrtFaYphLmgOHm95ogheepBYBpGLQUMh4252NpiFUPzPP2sP6A6pRJyI6h
 aNt09Pdx2oiccgfsym5PhbwI1bFmPvm8sTaMsLkBG61ggLyTRSKYrOC/tKIb8gaGS05A
 //niy09GyNF2uUvYf2YFKzD1uyInEqBufVWeyxLdiHRuy51V/iULla6Cgwf9GtbKi9T9
 MnjtFLhZEAVgLnU1RukNNtSMmnjVDd4TywIzTrgzbAnoZ4ifn+G53rrgKTMCcbrbqcmh
 2xkjJDs05VpoFq1J8uCdn6XPclKAz7YmavSub7vLDdmMQBtk5pcSJ5sY12FfsBsCJDzj
 X15A==
X-Gm-Message-State: APjAAAU0htSQgQqdh0qmpPMNwEfE52y/LZ3qY5HTjsqmv3D+09tjgxJn
 HZ3FwIKZZdsVlcF25gBBIdPosnkSGpA=
X-Google-Smtp-Source: APXvYqxVzjBkj4vMkIXcUTFPYYb6yU+oIUxVX6+oqdEfGcfIHASAjLhc+EDSdAht7ZCd1jW9+7ey8g==
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr13847516wrw.323.1563635939904; 
 Sat, 20 Jul 2019 08:18:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:45 +0200
Message-Id: <20190720151846.7450-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 11/12] i386: indicate that 'pconfig' feature was
 removed intentionally
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
Cc: "Denis V. Lunev" <den@openvz.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Denis V. Lunev" <den@openvz.org>

pconfig feature was added in 5131dc433df and removed in 712f807e196.
This patch mark this feature as known to QEMU and removed by
intentinally. This follows the convention of 9ccb9784b57 and f1a23522b03
dealing with 'osxsave' and 'ospke'.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190719111222.14943-1-den@openvz.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 805ce95..e3320f5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1083,7 +1083,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, "md-clear", NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL /* pconfig */, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
             NULL, "arch-capabilities", "core-capability", "ssbd",
-- 
1.8.3.1



