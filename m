Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ED5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64402073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqB36ZMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64402073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUYs-0001st-49
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itUOI-0004TJ-8c
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itUOE-0001lR-Bu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:34:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itUOE-0001kY-82
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1X5yO7SYwJyW5YJ1Ti/f3xeheBlw3XFdVPw3SMbN8dw=;
 b=bqB36ZMQSXR7qFb6/8C/YUvGurd5OvgvzKE6+bmxpVLH1NIORTwO2li9bGpF9U9VQ66DpC
 qxVRM1rX6KHDRIlm9QLi4qbzu9kJd0GON2tNyDYuaYN2HF73Qj3Kwp3EwpzcvczUkqHKOf
 lZt0hBRbBpTX9BlVHI9ibDUG2wYzYZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-UvFtvpPdOd-8dNj7yvfQFA-1; Mon, 20 Jan 2020 05:34:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3148D1005510;
 Mon, 20 Jan 2020 10:34:33 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6B59860E5;
 Mon, 20 Jan 2020 10:34:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] ram.c: remove unneeded labels
Date: Mon, 20 Jan 2020 11:33:17 +0100
Message-Id: <20200120103340.25118-7-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
References: <20200120103340.25118-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UvFtvpPdOd-8dNj7yvfQFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

ram_save_queue_pages() has an 'err' label that can be replaced by
'return -1' instead.

Same thing with ram_discard_range(), and in this case we can also
get rid of the 'ret' variable and return either '-1' on error
or the result of ram_block_discard_range().

CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f946282adb..17cd8d524b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2459,7 +2459,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr=
_t start, ram_addr_t len)
              * it's the 1st request.
              */
             error_report("ram_save_queue_pages no previous block");
-            goto err;
+            return -1;
         }
     } else {
         ramblock =3D qemu_ram_block_by_name(rbname);
@@ -2467,7 +2467,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr=
_t start, ram_addr_t len)
         if (!ramblock) {
             /* We shouldn't be asked for a non-existent RAMBlock */
             error_report("ram_save_queue_pages no block '%s'", rbname);
-            goto err;
+            return -1;
         }
         rs->last_req_rb =3D ramblock;
     }
@@ -2476,7 +2476,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr=
_t start, ram_addr_t len)
         error_report("%s request overrun start=3D" RAM_ADDR_FMT " len=3D"
                      RAM_ADDR_FMT " blocklen=3D" RAM_ADDR_FMT,
                      __func__, start, len, ramblock->used_length);
-        goto err;
+        return -1;
     }
=20
     struct RAMSrcPageRequest *new_entry =3D
@@ -2492,9 +2492,6 @@ int ram_save_queue_pages(const char *rbname, ram_addr=
_t start, ram_addr_t len)
     qemu_mutex_unlock(&rs->src_page_req_mutex);
=20
     return 0;
-
-err:
-    return -1;
 }
=20
 static bool save_page_use_compression(RAMState *rs)
@@ -3097,8 +3094,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState *=
ms)
  */
 int ram_discard_range(const char *rbname, uint64_t start, size_t length)
 {
-    int ret =3D -1;
-
     trace_ram_discard_range(rbname, start, length);
=20
     RCU_READ_LOCK_GUARD();
@@ -3106,7 +3101,7 @@ int ram_discard_range(const char *rbname, uint64_t st=
art, size_t length)
=20
     if (!rb) {
         error_report("ram_discard_range: Failed to find block '%s'", rbnam=
e);
-        goto err;
+        return -1;
     }
=20
     /*
@@ -3118,10 +3113,7 @@ int ram_discard_range(const char *rbname, uint64_t s=
tart, size_t length)
                      length >> qemu_target_page_bits());
     }
=20
-    ret =3D ram_block_discard_range(rb, start, length);
-
-err:
-    return ret;
+    return ram_block_discard_range(rb, start, length);
 }
=20
 /*
--=20
2.24.1


