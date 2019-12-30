Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC07C2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA27D20748
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxM+IpRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA27D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilqR1-0005pf-0O
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 03:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilqQQ-0005Pi-Fx
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilqQN-0004r1-Hc
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:29:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilqQN-0004pw-1j
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577694553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oo/U1rvbRH+8RtsjYrZRwzl+91nPbCMgko4ef0/lwa0=;
 b=LxM+IpRjHA2Xr4MDR0XjQGzDgsjNP07WyX/IZJcGx3SBLYg1+sXdGbyDDL2oLIhPYS/q82
 7zvfh17p2AoysF/fY7sCpSD7AF+1TFZ2yJJFIiWdDB6/ezI0+4Jf71F6K91RF9B1YunbRC
 Jd88x/OyESPg0cvlJtJ/hHhcvYSlKTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-DwHRBmnEMD-JTBSgXR4iUQ-1; Mon, 30 Dec 2019 03:29:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B1F18543A0;
 Mon, 30 Dec 2019 08:29:09 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 557C7808DA;
 Mon, 30 Dec 2019 08:28:59 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/git.orderfile: Display decodetree before C source
Date: Mon, 30 Dec 2019 09:28:56 +0100
Message-Id: <20191230082856.30556-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DwHRBmnEMD-JTBSgXR4iUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Stafford Horne <shorne@gmail.com>, Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid scrolling each instruction when reviewing tcg
helpers written for the decodetree script, display the
.decode files (similar to header declarations) before
the C source (implementation of previous declarations).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/git.orderfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index e89790941c..1f747b583a 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -25,5 +25,8 @@ qga/*.json
 # headers
 *.h
=20
+# decoding tree specification
+*.decode
+
 # code
 *.c
--=20
2.21.0


