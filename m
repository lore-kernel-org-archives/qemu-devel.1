Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C92CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E3021D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSlIokNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E3021D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNym4-0002hE-ED
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNycF-0000v2-W6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNycE-0007ud-Hj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:22:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNycE-0007uX-Dx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572006170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0ndCbuoXggzDITfCRMynCmlmjj8dPfPxM5NvuYK+/ZY=;
 b=KSlIokNxR9QxbDj3SufmL3yqdhKHBBX3ilJMYZzGZY8b0xCFxXury4VWRvRJy/c08ADy2t
 kZhymZHImjHSONJBCchH6Z1DaeCV21xCEXgEkLvq7zsCYT3bidILeVlfz+zBrHT/LVtOHe
 h1jGDJ9m8JHjSOVOIqHrAI/EPHFLjfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-eLh2A9rzMlKpnh4371n4SA-1; Fri, 25 Oct 2019 08:22:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4271B1800E00;
 Fri, 25 Oct 2019 12:22:45 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A10160BE0;
 Fri, 25 Oct 2019 12:22:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] iothread: document -object iothread on man page
Date: Fri, 25 Oct 2019 14:22:36 +0200
Message-Id: <20191025122236.29815-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: eLh2A9rzMlKpnh4371n4SA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Zhenyu Ye <yezhenyu2@huawei.com>, dgilbert@redhat.com,
 xiexiangyou@huawei.com, jiangyiwen <jiangyiwen@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add -object iothread documentation to the man page, including references
to the query-iothread QMP command and qom-set syntax for adjusting
adaptive polling parameters at run-time.

Reported-by: Zhenyu Ye <yezhenyu2@huawei.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-options.hx | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 996b6fba74..23d2b75b54 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4872,6 +4872,44 @@ access
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
2.21.0


