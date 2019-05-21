Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A7C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 18:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A550F2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 18:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A550F2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57987 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT9vZ-0000zH-9z
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 14:55:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hT9u7-0008HJ-44
	for qemu-devel@nongnu.org; Tue, 21 May 2019 14:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hT9rA-0005PF-PN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 14:51:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hT9r8-0005Hy-AZ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 14:51:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 687AFF74A6;
	Tue, 21 May 2019 18:51:05 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF699646A0;
	Tue, 21 May 2019 18:51:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 15:50:57 -0300
Message-Id: <20190521185059.28236-2-ehabkost@redhat.com>
In-Reply-To: <20190521185059.28236-1-ehabkost@redhat.com>
References: <20190521185059.28236-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 21 May 2019 18:51:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] target/i386: define md-clear bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

md-clear is a new CPUID bit which is set when microcode provides the
mechanism to invoke a flush of various exploitable CPU buffers by invoking
the VERW instruction.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190515141011.5315-2-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2df56fa977..953d78b062 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1077,7 +1077,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "md-clear", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.18.0.rc1.1.g3f1ff2140


