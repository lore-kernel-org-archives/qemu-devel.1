Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E11ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A1520873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A1520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNqh-0000bi-E1
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNnb-0006Pj-5W
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNna-0008Hb-4S
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNnW-0008BC-Ue; Tue, 15 Oct 2019 10:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DCA0307D98A;
 Tue, 15 Oct 2019 14:27:35 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A49D15D6B0;
 Tue, 15 Oct 2019 14:27:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 01/21] iotests/qcow2.py: Add dump-header-exts
Date: Tue, 15 Oct 2019 16:27:09 +0200
Message-Id: <20191015142729.18123-2-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 15 Oct 2019 14:27:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is useful for tests that want to whitelist fields from dump-header
(with grep) but still print all header extensions.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/qcow2.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index b392972d1b..d813b4fc81 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -154,6 +154,10 @@ def cmd_dump_header(fd):
     h.dump()
     h.dump_extensions()
=20
+def cmd_dump_header_exts(fd):
+    h =3D QcowHeader(fd)
+    h.dump_extensions()
+
 def cmd_set_header(fd, name, value):
     try:
         value =3D int(value, 0)
@@ -230,6 +234,7 @@ def cmd_set_feature_bit(fd, group, bit):
=20
 cmds =3D [
     [ 'dump-header',          cmd_dump_header,          0, 'Dump image h=
eader and header extensions' ],
+    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image h=
eader extensions' ],
     [ 'set-header',           cmd_set_header,           2, 'Set a field =
in the header'],
     [ 'add-header-ext',       cmd_add_header_ext,       2, 'Add a header=
 extension' ],
     [ 'add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header=
 extension, data from stdin' ],
--=20
2.21.0


