Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFB2C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42ADE206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLgukEaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ADE206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32933 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvkR-0001Ju-IA
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveW-0001AW-ER
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveW-0004GO-0c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveV-0004FY-KL
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoAyx/faVahlrymiqKqLC0TBQQ5qCmKH51d5hFH8O+s=;
 b=iLgukEazfGyBxn2a8K0X1z6KutGfEuFohbz5isO5vX/4Ndx4SSm2fPFCplXyyzh/ZanaHd
 Onp5SyzW37wkESC26/VuS26hNx7tQtz26ixtYp9GjIrGz8KQmdVq9NYoDL2s0lCL1zwQ23
 TQlMYb4t8bHacAYS9maVelRB0u4tHlE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-tubhFZVjPbibSjKo6ihItw-1; Tue, 21 Apr 2020 12:21:37 -0400
X-MC-Unique: tubhFZVjPbibSjKo6ihItw-1
Received: by mail-qv1-f69.google.com with SMTP id f4so14336880qvu.19
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mrsxtz6M3n9ykP7SzORGfdZlM7nc/uxySWadcjQY4u8=;
 b=G5ak33C7DS/jzOjch/PejhVab/CCp4zc7wGgt6Na+kdEuO1YuffWy9I8jQOeMIC8V3
 0eP/Du+zaSlw5vXtaB3onxje2MYbzer0B08k7wPjk3FPAhpQZdxBoyZFBpp8B7buKMP4
 nRXllRKOyrbx+lC2Wxniao4q0XpYFs52saYyVXIIzskSf6d/0AeQY2Z3GRt52alAEvW5
 WpmzjKYGD5IDx31rT6H0B1mIwmhOV+6FzGSzheEEsyCF0pFyU8NxJlONFPxxPv0fq0JO
 vYzIJNQfhpeeWd/1eAXjtWUlZRWTl9My13K1Q81dH+0bv1R+qDwGop2X6fqUwUqXwwt2
 ntXw==
X-Gm-Message-State: AGi0PuaQSar/7PXikJX87YIE8ppDcm94kwZ/EGfTUIHkbCng6ZknvgLh
 I+E8DWKkUswtUaW1Pt9/nkO91ErZQBD5oUDGeq8IqdklvJJ0A1r0F+yaaaU5BLskkGTbIDf46Ab
 C7VO21XeZ+m/Hj6I=
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr21843442qtv.328.1587486096560; 
 Tue, 21 Apr 2020 09:21:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypLaoyJsoVjkhMvfPHx+qU5GHgTmn2Pa9J9KC3AqJd4l3B6nxvw9g2ONkSbhpYgOUC3C71JLFQ==
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr21843421qtv.328.1587486096332; 
 Tue, 21 Apr 2020 09:21:36 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k2sm2106359qta.39.2020.04.21.09.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] memory: Delay the transaction pop() until commit completed
Date: Tue, 21 Apr 2020 12:21:08 -0400
Message-Id: <20200421162108.594796-9-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should be functionally the same as before, but this allows the
memory_region_transaction_depth to be non-zero during commit, which can hel=
p us
to do sanity check on misuses.

Since at it, fix an indentation issue on the bracket.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index 2f8dc9721f..357f7276ee 100644
--- a/memory.c
+++ b/memory.c
@@ -1089,8 +1089,7 @@ void memory_region_transaction_commit(void)
     assert(memory_region_transaction_depth);
     assert(qemu_mutex_iothread_locked());
=20
-    memory_region_transaction_pop();
-    if (!memory_region_transaction_depth) {
+    if (memory_region_transaction_depth =3D=3D 1) {
         if (memory_region_update_pending) {
             flatviews_reset();
=20
@@ -1109,7 +1108,14 @@ void memory_region_transaction_commit(void)
             }
             ioeventfd_update_pending =3D false;
         }
-   }
+    }
+
+    /*
+     * Pop the depth at last, so that memory_region_transaction_depth will
+     * still be non-zero during committing.  This can help us to do some s=
anity
+     * check within the process of committing.
+     */
+    memory_region_transaction_pop();
 }
=20
 static void memory_region_destructor_none(MemoryRegion *mr)
--=20
2.24.1


