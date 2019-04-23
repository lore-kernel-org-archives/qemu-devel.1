Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93692C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679A320835
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679A320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzAv-0003rP-LY
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:25:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1q-0005Hv-0F
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1o-0005tb-0l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz1n-0005sn-RI
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77E75308A107;
	Tue, 23 Apr 2019 17:16:18 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1CF6A19729;
	Tue, 23 Apr 2019 17:16:04 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 19:15:13 +0200
Message-Id: <20190423171520.4511-6-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 23 Apr 2019 17:16:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/12] roms/edk2-funcs.sh: add the
 qemu_edk2_get_thread_count() function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423171513.0rNYwP2CXwFYNfccyenV3kSKp4YMvk_brqCG90XhhjM@z>

The edk2 "build" utility natively supports building modules (that is, INF
files) in parallel. The feature is not useful when building a single
module (with the "-m" option), but it is useful for platform firmware
builds (which include many modules). Add a function that determines the
"-n" option argument for "build", from the MAKEFLAGS variable (i.e. based
on the presence of a make job server).

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Igor's T-b
   =20
    v2:
   =20
    - pick up Phil's R-b / T-b
   =20
    - pick up Michal's and Michael's R-b's

 roms/edk2-funcs.sh | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index d1cb1e4a111e..a9fae7ee891b 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -226,3 +226,28 @@ qemu_edk2_set_cross_env()
=20
   eval "export $cross_prefix_var=3D\$cross_prefix"
 }
+
+
+# Determine the "-n" option argument (that is, the number of modules to =
build
+# in parallel) for the edk2 "build" utility. Print the result to the sta=
ndard
+# output.
+#
+# Parameters:
+#   $1: the value of the MAKEFLAGS variable
+qemu_edk2_get_thread_count()
+{
+  local makeflags=3D"$1"
+
+  if [[ "$makeflags" =3D=3D *--jobserver-auth=3D* ]] ||
+     [[ "$makeflags" =3D=3D *--jobserver-fds=3D* ]]; then
+    # If there is a job server, allow the edk2 "build" utility to parall=
elize
+    # as many module builds as there are logical CPUs in the system. The=
 "make"
+    # instances forked by "build" are supposed to limit themselves throu=
gh the
+    # job server. The zero value below causes the edk2 "build" utility t=
o fetch
+    # the logical CPU count with Python's multiprocessing.cpu_count() me=
thod.
+    printf '0\n'
+  else
+    # Build a single module at a time.
+    printf '1\n'
+  fi
+}
--=20
2.19.1.3.g30247aa5d201



