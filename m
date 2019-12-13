Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10FEC2D0CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3372465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLsm9z6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3372465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifm1c-0005TT-CX
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifm0b-0004Wm-HX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifm0a-0008GL-BP
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifm0a-0008FW-7A
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576247611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dyZzK+/rwkkyZTZ71KCvOWKB6vb2M8+p22eBPZs6Gc=;
 b=fLsm9z6qa4+vUgE69QCI/xk2vHI+Eo6FHhCLkxkaDHAxOoGZmp3M3KdjA/pq3oNREB4wO5
 50DXgryFxvgEPp1IbukrVzdS2rvsbFYCDe8N296+1Pxltuyb3m7GyQGTc9+EwOdjkItNZH
 ezkyHcze++tH4tdj/zEj4WQdtFGC8yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-CQOv34Q0Otq2o2EY2aSESw-1; Fri, 13 Dec 2019 09:33:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AF168D9F81;
 Fri, 13 Dec 2019 14:33:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCBED601A2;
 Fri, 13 Dec 2019 14:33:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] iothread: document -object iothread on man page
Date: Fri, 13 Dec 2019 14:33:14 +0000
Message-Id: <20191213143314.1198821-3-stefanha@redhat.com>
In-Reply-To: <20191213143314.1198821-1-stefanha@redhat.com>
References: <20191213143314.1198821-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CQOv34Q0Otq2o2EY2aSESw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Zhenyu Ye <yezhenyu2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add -object iothread documentation to the man page, including references
to the query-iothread QMP command and qom-set syntax for adjusting
adaptive polling parameters at run-time.

Reported-by: Zhenyu Ye <yezhenyu2@huawei.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20191025122236.29815-1-stefanha@redhat.com
Message-Id: <20191025122236.29815-1-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-options.hx | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 65c9473b73..68d1592ccc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4926,6 +4926,44 @@ access
 CN=3Dlaptop.example.com,O=3DExample Home,L=3DLondon,ST=3DLondon,C=3DGB
 @end example
=20
+@item -object iothread,id=3D@var{id},poll-max-ns=3D@var{poll-max-ns},poll-=
grow=3D@var{poll-grow},poll-shrink=3D@var{poll-shrink}
+
+Creates a dedicated event loop thread that devices can be assigned to.  Th=
is is
+known as an IOThread.  By default device emulation happens in vCPU threads=
 or
+the main event loop thread.  This can become a scalability bottleneck.
+IOThreads allow device emulation and I/O to run on other host CPUs.
+
+The @option{id} parameter is a unique ID that will be used to reference th=
is
+IOThread from @option{-device ...,iothread=3D@var{id}}.  Multiple devices =
can be
+assigned to an IOThread.  Note that not all devices support an
+@option{iothread} parameter.
+
+The @code{query-iothreads} QMP command lists IOThreads and reports their t=
hread
+IDs so that the user can configure host CPU pinning/affinity.
+
+IOThreads use an adaptive polling algorithm to reduce event loop latency.
+Instead of entering a blocking system call to monitor file descriptors and=
 then
+pay the cost of being woken up when an event occurs, the polling algorithm
+spins waiting for events for a short time.  The algorithm's default parame=
ters
+are suitable for many cases but can be adjusted based on knowledge of the
+workload and/or host device latency.
+
+The @option{poll-max-ns} parameter is the maximum number of nanoseconds to=
 busy
+wait for events.  Polling can be disabled by setting this value to 0.
+
+The @option{poll-grow} parameter is the multiplier used to increase the po=
lling
+time when the algorithm detects it is missing events due to not polling lo=
ng
+enough.
+
+The @option{poll-shrink} parameter is the divisor used to decrease the pol=
ling
+time when the algorithm detects it is spending too long polling without
+encountering events.
+
+The polling parameters can be modified at run-time using the @code{qom-set=
} command (where @code{iothread1} is the IOThread's @code{id}):
+
+@example
+(qemu) qom-set /objects/iothread1 poll-max-ns 100000
+@end example
=20
 @end table
=20
--=20
2.23.0


