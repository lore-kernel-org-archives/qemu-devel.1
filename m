Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F0C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E82214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA1uqNAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E82214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1AW-0001rP-ME
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iT197-0000IQ-EZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iT196-0006Je-5u
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:05:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iT196-0006JU-2P
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o2BqW75FcQ/QGfmXuaO4iWeubKRhDpX6nMSu4yDPQZA=;
 b=bA1uqNAL0JvYf2zn1Cwxnx4xHRDGnA+xys+hGKOXQPUUH77yFOtszvdg7xhqSUaaggExrO
 l7+GLNB1i1wkP62S+R1Gi9whp0ZNZmQaD/xNS6r3W4IGXqLMLKY/UvS6ShMR1sl1urXho5
 2VTlr5lnz3cuwcW8FkY1zP6HHjGE6+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-fICsfHJqMliPSHCzqknQKg-1; Fri, 08 Nov 2019 05:05:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B590B1005500
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 10:05:31 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48EBB1001DC2;
 Fri,  8 Nov 2019 10:05:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] documentation: link to nightly documentation
Date: Fri,  8 Nov 2019 11:05:26 +0100
Message-Id: <20191108100526.401847-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fICsfHJqMliPSHCzqknQKg-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Link to the documentation built from qemu.git/master once a day.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This depends on qemu.git "[PATCH 0/3] docs: build an index page for the
HTML docs".  We need that in order to build index.html.

 documentation.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/documentation.md b/documentation.md
index f4ef9f4..662750c 100644
--- a/documentation.md
+++ b/documentation.md
@@ -3,6 +3,8 @@ title: QEMU documentation
 permalink: /documentation/
 ---
=20
+The latest development version documentation is available [here](https://w=
iki.qemu.org/docs/index.html).
+
 The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be read=
 online, courtesy of Stefan Weil.
 More documentation is found in the <a href=3D"https://git.qemu.org/?p=3Dqe=
mu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
 directory of the QEMU git tree.
--=20
2.23.0


