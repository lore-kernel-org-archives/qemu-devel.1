Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C745C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048EF20409
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="em6Q1FPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048EF20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGswy-0001Ec-5J
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGss8-0007hY-Ol
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGss7-0001yH-M7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGss7-0001y2-IO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585092131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Lrhho6TqU/l3pOfhr6S48e+sptwMOXROpkdXG+K1PI=;
 b=em6Q1FPwTkSJrKE6VQs5A9otvrJZydO8o8fy14oYII1/zOZYdEYxZbGt9WXbiwtlUojv0m
 ueVOCBRIoxNkGnAh/NaKPjrBNjwjprZOO/LegTiEu2qWko5oZWBpHFUX9Z64ryV62Kzx9U
 Iwomxcbk1nx+ZvBWnHdC9qAF5RSKcLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-KCJI1R1MNU2crXAyrjiCqg-1; Tue, 24 Mar 2020 19:22:09 -0400
X-MC-Unique: KCJI1R1MNU2crXAyrjiCqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA47E1020E8A;
 Tue, 24 Mar 2020 23:21:53 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A94815D9C5;
 Tue, 24 Mar 2020 23:21:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 08/14] iotests: touch up log function signature
Date: Tue, 24 Mar 2020 19:20:57 -0400
Message-Id: <20200324232103.4195-9-jsnow@redhat.com>
In-Reply-To: <20200324232103.4195-1-jsnow@redhat.com>
References: <20200324232103.4195-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Representing nested, recursive data structures in mypy is notoriously
difficult; the best we can reliably do right now is denote the atom
types as "Any" while describing the general shape of the data.

Regardless, this fully annotates the log() function.

Typing notes:

TypeVar is a Type variable that can optionally be constrained by a
sequence of possible types. This variable is bound per-invocation such
that the signature for filter=3D() requires that its callables take e.g. a
str and return a str.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index c93c6b4557..3a049ece5b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,6 +28,7 @@
 import struct
 import subprocess
 import sys
+from typing import (Any, Callable, Dict, Iterable, List, Optional, TypeVar=
)
 import unittest
=20
 # pylint: disable=3Dimport-error, wrong-import-position
@@ -353,9 +354,16 @@ def _filter(_key, value):
         return value
     return filter_qmp(qmsg, _filter)
=20
-def log(msg, filters=3D(), indent=3DNone):
-    '''Logs either a string message or a JSON serializable message (like Q=
MP).
-    If indent is provided, JSON serializable messages are pretty-printed.'=
''
+
+Msg =3D TypeVar('Msg', Dict[str, Any], List[Any], str)
+
+def log(msg: Msg,
+        filters: Iterable[Callable[[Msg], Msg]] =3D (),
+        indent: Optional[int] =3D None) -> None:
+    """
+    Logs either a string message or a JSON serializable message (like QMP)=
.
+    If indent is provided, JSON serializable messages are pretty-printed.
+    """
     for flt in filters:
         msg =3D flt(msg)
     if isinstance(msg, (dict, list)):
--=20
2.21.1


