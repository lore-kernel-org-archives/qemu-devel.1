Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46052086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46052086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLsD-0000g1-PO
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iBLen-0007gD-L3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iBLel-0008Dq-S9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iBLef-0008Aq-N2; Fri, 20 Sep 2019 12:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6614307CDE7;
 Fri, 20 Sep 2019 16:21:08 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-81.ams2.redhat.com
 [10.36.117.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD2A646A1;
 Fri, 20 Sep 2019 16:21:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/4] iotests: Require Python 3.6 or later
Date: Fri, 20 Sep 2019 18:20:57 +0200
Message-Id: <20190920162058.29743-4-kwolf@redhat.com>
In-Reply-To: <20190920162058.29743-1-kwolf@redhat.com>
References: <20190920162058.29743-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 20 Sep 2019 16:21:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running iotests is not required to build QEMU, so we can have stricter
version requirements for Python here and can make use of new features
and drop compatibility code earlier.

This makes qemu-iotests skip all Python tests if a Python version before
3.6 is used for the build.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/check | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 875399d79f..588c453a94 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -633,6 +633,12 @@ then
     export SOCKET_SCM_HELPER=3D"$build_iotests/socket_scm_helper"
 fi
=20
+python_usable=3Dfalse
+if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >=3D (3,6) els=
e 1)'
+then
+    python_usable=3Dtrue
+fi
+
 default_machine=3D$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*=
//p')
 default_alias_machine=3D$($QEMU_PROG -machine help | \
    sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
@@ -809,7 +815,12 @@ do
         start=3D$(_wallclock)
=20
         if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/en=
v python" ]; then
-            run_command=3D"$PYTHON $seq"
+            if $python_usable; then
+                run_command=3D"$PYTHON $seq"
+            else
+                run_command=3D"false"
+                echo "Unsupported Python version" > $seq.notrun
+            fi
         else
             run_command=3D"./$seq"
         fi
--=20
2.20.1


