Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E51BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143F82083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOScTWY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143F82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHcO-00048N-53
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHWY-0002Lp-3N
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHWI-0000lW-41
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHWI-0000lO-07
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aY59D12iK9EuHf67AzITwqwSdm0FUzPT3g3NX2Qq8xQ=;
 b=JOScTWY18MRerETozS+PUeHZVxoV1Boq57uOc/IiwYsh3aIDcSWswfqOi/nCEZtnCaShzO
 e5nWBh57nfib5kXCX98WYVXkb1DnReabP8DtXX4en4kd4Y/FXSZgw36j1GZkpKYROCVTOi
 /w2Ca//O+tPstpSKxOX/YygYMAl8bgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-zykWt2SkPCGM92aN8gdr3w-1; Thu, 30 Jan 2020 16:38:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC8018A6EC0;
 Thu, 30 Jan 2020 21:38:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3380A84BCE;
 Thu, 30 Jan 2020 21:38:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] docs/devel/tracing.txt: Recommend only
 trace_event_get_state_backends()
Date: Thu, 30 Jan 2020 21:38:11 +0000
Message-Id: <20200130213814.334195-3-stefanha@redhat.com>
In-Reply-To: <20200130213814.334195-1-stefanha@redhat.com>
References: <20200130213814.334195-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zykWt2SkPCGM92aN8gdr3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Instead of recommending checking the TRACE_FOO_ENABLED macro to
skip expensive computations needed only for tracing, recommend
only using trace_event_get_state_backends(). This works for both
compile-time and run-time disabling of events, and has no extra
performance impact if the event is compile-time disabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200120151142.18954-2-peter.maydell@linaro.org
Message-Id: <20200120151142.18954-2-peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/tracing.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 8c0376fefa..cb5f685de9 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -342,8 +342,10 @@ edit the "trace-events-all" file).
=20
 In addition, there might be cases where relatively complex computations mu=
st be
 performed to generate values that are only used as arguments for a trace
-function. In these cases you can use the macro 'TRACE_${EVENT_NAME}_ENABLE=
D' to
-guard such computations and avoid its compilation when the event is disabl=
ed:
+function. In these cases you can use 'trace_event_get_state_backends()' to
+guard such computations, so they are skipped if the event has been either
+compile-time disabled or run-time disabled. If the event is compile-time
+disabled, this check will have no performance impact.
=20
     #include "trace.h"  /* needed for trace event prototype */
    =20
@@ -356,7 +358,7 @@ guard such computations and avoid its compilation when =
the event is disabled:
             align =3D getpagesize();
         }
         ptr =3D qemu_memalign(align, size);
-        if (TRACE_QEMU_VMALLOC_ENABLED) { /* preprocessor macro */
+        if (trace_event_get_state_backends(TRACE_QEMU_VMALLOC)) {
             void *complex;
             /* some complex computations to produce the 'complex' value */
             trace_qemu_vmalloc(size, ptr, complex);
@@ -364,10 +366,6 @@ guard such computations and avoid its compilation when=
 the event is disabled:
         return ptr;
     }
=20
-You can check both if the event has been disabled and is dynamically enabl=
ed at
-the same time using the 'trace_event_get_state_backends' routine (see head=
er
-"trace/control.h" for more information).
-
 =3D=3D=3D "tcg" =3D=3D=3D
=20
 Guest code generated by TCG can be traced by defining an event with the "t=
cg"
--=20
2.24.1


