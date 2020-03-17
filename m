Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F3DC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2D9206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDTBYnzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2D9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0OW-0005VY-TA
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 20:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE0IL-00045w-CQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE0IK-0005E5-2u
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE0IJ-0005Bh-VM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584405679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCY8JCzM+hnfV11ZZ8UCF8U0f91cQV7idL0tWXRh6Ik=;
 b=CDTBYnzspmn6tefXebH/r0DXKhgePJlD3d8P34PsbMBv1AA7Jq42hj8Ok6E9Bh4JuJF9f3
 vHVywtA9iDbaa0UGTdboB1H7zpZ8xDrmPCzBEkvFI29PTqo+T+Nhod/nAnETyCcSgvtNZz
 flRmEkoJwK7YxlCfWS1Hwp0GJFXNqFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-SG8Iu65YMzqgcGR-XFDSxQ-1; Mon, 16 Mar 2020 20:41:15 -0400
X-MC-Unique: SG8Iu65YMzqgcGR-XFDSxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9DF2107ACC7;
 Tue, 17 Mar 2020 00:41:14 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D771393531;
 Tue, 17 Mar 2020 00:41:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/11] iotests: drop Python 3.4 compatibility code
Date: Mon, 16 Mar 2020 20:41:00 -0400
Message-Id: <20200317004105.27059-7-jsnow@redhat.com>
In-Reply-To: <20200317004105.27059-1-jsnow@redhat.com>
References: <20200317004105.27059-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We no longer need to accommodate 3.4, drop this code.
(Also, the line is over 79 characters, so drop it.)

Touch up the docstring a little bit while we're here.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7cd74e7cb1..3d90fb157d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -22,6 +22,7 @@
 import unittest
 import sys
 import struct
+from typing import Optional
 import json
 import signal
 import logging
@@ -350,18 +351,17 @@ def _filter(_key, value):
         return value
     return filter_qmp(qmsg, _filter)
=20
-def log(msg, filters=3D(), indent=3DNone):
-    '''Logs either a string message or a JSON serializable message (like Q=
MP).
-    If indent is provided, JSON serializable messages are pretty-printed.'=
''
+def log(msg, filters=3D(), indent: Optional[int] =3D None) -> None:
+    """
+    Logs either a string message or a JSON serializable message (like QMP)=
.
+    If indent is provided, JSON serializable messages are pretty-printed.
+    """
     for flt in filters:
         msg =3D flt(msg)
     if isinstance(msg, (dict, list)):
-        # Python < 3.4 needs to know not to add whitespace when pretty-pri=
nting:
-        separators =3D (', ', ': ') if indent is None else (',', ': ')
         # Don't sort if it's already sorted
         do_sort =3D not isinstance(msg, OrderedDict)
-        print(json.dumps(msg, sort_keys=3Ddo_sort,
-                         indent=3Dindent, separators=3Dseparators))
+        print(json.dumps(msg, sort_keys=3Ddo_sort, indent=3Dindent))
     else:
         print(msg)
=20
--=20
2.21.1


