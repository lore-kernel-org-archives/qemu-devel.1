Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C6C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CEA20874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CEA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb19N-0000NB-MQ
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 07:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58748)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hb0o3-0003LT-1K
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hb0o1-0002r6-Sr
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hb0o1-0002qt-MQ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0058C30842B0;
 Wed, 12 Jun 2019 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
 [10.36.116.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BA8F46;
 Wed, 12 Jun 2019 10:48:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 12:48:06 +0200
Message-Id: <20190612104808.6398-7-quintela@redhat.com>
In-Reply-To: <20190612104808.6398-1-quintela@redhat.com>
References: <20190612104808.6398-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 10:48:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/8] cutils: remove one unnecessary pointer
 operation
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Since we will not operate on the next address pointed by out, it is not
necessary to do addition on it.

After removing the operation, the function size reduced 16/18 bytes.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Message-Id: <20190610030852.16039-2-richardw.yang@linux.intel.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 util/cutils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 9aacc422ca..1933a68da5 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -754,11 +754,11 @@ int uleb128_encode_small(uint8_t *out, uint32_t n)
 {
     g_assert(n <=3D 0x3fff);
     if (n < 0x80) {
-        *out++ =3D n;
+        *out =3D n;
         return 1;
     } else {
         *out++ =3D (n & 0x7f) | 0x80;
-        *out++ =3D n >> 7;
+        *out =3D n >> 7;
         return 2;
     }
 }
@@ -766,7 +766,7 @@ int uleb128_encode_small(uint8_t *out, uint32_t n)
 int uleb128_decode_small(const uint8_t *in, uint32_t *n)
 {
     if (!(*in & 0x80)) {
-        *n =3D *in++;
+        *n =3D *in;
         return 1;
     } else {
         *n =3D *in++ & 0x7f;
@@ -774,7 +774,7 @@ int uleb128_decode_small(const uint8_t *in, uint32_t =
*n)
         if (*in & 0x80) {
             return -1;
         }
-        *n |=3D *in++ << 7;
+        *n |=3D *in << 7;
         return 2;
     }
 }
--=20
2.21.0


