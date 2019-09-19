Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F72217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F72217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwPC-0007bY-7U
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvse-0006Ji-Lu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvkw-0008Tk-Dn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvkv-0008R7-Iv; Thu, 19 Sep 2019 08:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 455FD10C030B;
 Thu, 19 Sep 2019 12:41:52 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3935C21E;
 Thu, 19 Sep 2019 12:41:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:48 +0200
Message-Id: <20190919124115.11510-8-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 12:41:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/34] s390x/tcg: MVPG: Check for specification
 exceptions
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Perform the checks documented in the PoP.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index c31cf4959358..7dfa848744a6 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -672,6 +672,13 @@ uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c=
, uint64_t s1, uint64_t s2)
 /* move page */
 uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint=
64_t r2)
 {
+    const bool f =3D extract64(r0, 11, 1);
+    const bool s =3D extract64(r0, 10, 1);
+
+    if ((f && s) || extract64(r0, 12, 4)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC(=
));
+    }
+
     /* ??? missing r0 handling, which includes access keys, but more
        importantly optional suppression of the exception!  */
     fast_memmove(env, r1, r2, TARGET_PAGE_SIZE, GETPC());
--=20
2.20.1


