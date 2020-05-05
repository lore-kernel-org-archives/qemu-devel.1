Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BAC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600022073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sqw5BT5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600022073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxJF-0000ST-GF
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9w-0001ND-C8
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9v-0000mu-Kk
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQR0M9fWCh4ng08cJMMLE0yhSJzmSpgm/cT233yhunA=;
 b=Sqw5BT5OPuO5oVsGefNBKN7Fctc8+MoLOXmp3wHPnZkVvVlWPx/lzqgVk4IiGLVB7xbm1X
 cOzA2rbmm95mj9XkAL0SbQxOnO6+nU+lb2AZri+kvdYTcobJXSJgjJqcpde+JU7yMtY/EY
 2V5XWNZIn26UD93h42464obUbeiGzDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-voh5NsUNPQeQMHMLUaInxg-1; Tue, 05 May 2020 08:58:46 -0400
X-MC-Unique: voh5NsUNPQeQMHMLUaInxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E11971005510;
 Tue,  5 May 2020 12:58:45 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A375C1D3;
 Tue,  5 May 2020 12:58:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/24] iotests: touch up log function signature
Date: Tue,  5 May 2020 14:58:10 +0200
Message-Id: <20200505125826.1001451-9-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Representing nested, recursive data structures in mypy is notoriously
difficult; the best we can reliably do right now is denote the leaf
types as "Any" while describing the general shape of the data.

Regardless, this fully annotates the log() function.

Typing notes:

TypeVar is a Type variable that can optionally be constrained by a
sequence of possible types. This variable is bound to a specific type
per-invocation, like a Generic.

log() behaves as log<Msg>() now, where the incoming type informs the
signature it expects for any filter arguments passed in. If Msg is a
str, then filter should take and return a str.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200331000014.11581-9-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 374a8f6077..69f24223d2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,6 +28,7 @@ import signal
 import struct
 import subprocess
 import sys
+from typing import (Any, Callable, Dict, Iterable, List, Optional, TypeVar=
)
 import unittest
=20
 # pylint: disable=3Dimport-error, wrong-import-position
@@ -354,9 +355,16 @@ def filter_qmp_imgfmt(qmsg):
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
2.26.2


