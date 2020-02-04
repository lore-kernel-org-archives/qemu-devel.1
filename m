Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377AFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0299320674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdyH9rbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0299320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz0c-0002XE-77
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyyvj-0004Up-MN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyyvi-0003Xr-LO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyyvi-0003U8-Go
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580825514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJLhoD6eH1RO0HHewTMQIjJx6ctfWM30l45DwMD9bdI=;
 b=bdyH9rbjoV3EgeDjrcdkjWH8M2nmJQUACCGGt3bd9r6kHzclOM8AZ7Ke3SndUkVcaIGDzD
 d+LQ5owvvnfwzy7srGYFGtU/9uLFqYuWeyHF4aM2saRFxMcM+Ki5zfejz6tzeI/t1IlCcy
 MF/fNTMA3eUyzy8J1mNnqier5JPSYj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-Wpc5lCfoOYSm_RXUhGwc3w-1; Tue, 04 Feb 2020 09:11:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2D6218A6EC0
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CDD2842A9;
 Tue,  4 Feb 2020 14:11:47 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] python/qemu: qmp: Remove unnused attributes
Date: Tue,  4 Feb 2020 11:11:11 -0300
Message-Id: <20200204141111.3207-6-wainersm@redhat.com>
In-Reply-To: <20200204141111.3207-1-wainersm@redhat.com>
References: <20200204141111.3207-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Wpc5lCfoOYSm_RXUhGwc3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: jsnow@redhat.com, philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The `error` and `timeout` attributes in QEMUMonitorProtocol are
not used, so this delete them.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 486a566da0..4b9a362240 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -45,10 +45,6 @@ class QEMUMonitorProtocol:
=20
     #: Logger object for debugging messages
     logger =3D logging.getLogger('QMP')
-    #: Socket's error class
-    error =3D socket.error
-    #: Socket's timeout
-    timeout =3D socket.timeout
=20
     def __init__(self, address, server=3DFalse):
         """
--=20
2.23.0


