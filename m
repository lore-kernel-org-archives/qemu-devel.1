Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE86C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72920205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72920205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKM7g-0001pe-IG
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 08:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iKM6V-0001FV-Kd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iKM6U-00029p-Bk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:39:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iKM6R-000291-VT; Tue, 15 Oct 2019 08:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 773B369081;
 Tue, 15 Oct 2019 12:39:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 905C95C290;
 Tue, 15 Oct 2019 12:39:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] doc: Describe missing generic -blockdev options
Date: Tue, 15 Oct 2019 14:38:54 +0200
Message-Id: <20191015123854.12039-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 15 Oct 2019 12:39:02 +0000 (UTC)
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We added more generic options after introducing -blockdev and forgot to
update the documentation (man page and --help output) accordingly. Do
that now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-options.hx | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 793d70ff93..9f6aa3dde3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -849,7 +849,8 @@ ETEXI
 DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
     "-blockdev [driver=3D]driver[,node-name=3DN][,discard=3Dignore|unmap=
]\n"
     "          [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
-    "          [,read-only=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
+    "          [,read-only=3Don|off][,auto-read-only=3Don|off]\n"
+    "          [,force-share=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
     "          [,driver specific parameters...]\n"
     "                configure a block backend\n", QEMU_ARCH_ALL)
 STEXI
@@ -885,6 +886,22 @@ name is not intended to be predictable and changes b=
etween QEMU invocations.
 For the top level, an explicit node name must be specified.
 @item read-only
 Open the node read-only. Guest write attempts will fail.
+
+Note that some block drivers support only read-only access, either gener=
ally or
+in certain configurations. In this case, the default value
+@option{read-only=3Doff} does not work and the option must be specified
+explicitly.
+@item auto-read-only
+If @option{auto-read-only=3Don} is set, QEMU is allowed not to open the =
image
+read-write even if @option{read-only=3Doff} is requested, but fall back =
to
+read-only instead (and switch between the modes later), e.g. depending o=
n
+whether the image file is writable or whether a writing user is attached=
 to the
+node.
+@item force-share
+Override the image locking system of QEMU and force the node to allowing
+sharing all permissions with other uses.
+
+Enabling @option{force-share=3Don} requires @option{read-only=3Don}.
 @item cache.direct
 The host page cache can be avoided with @option{cache.direct=3Don}. This=
 will
 attempt to do disk IO directly to the guest's memory. QEMU may still per=
form an
--=20
2.20.1


