Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147ADC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D839E20830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D839E20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzlc-0006jy-2K
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:03:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjh-0005XX-5b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjg-0001My-2P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzjf-0001MP-Qx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02C9B307EAA4;
	Tue,  9 Apr 2019 23:00:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 684EC1001DC0;
	Tue,  9 Apr 2019 23:00:56 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:15 +0200
Message-Id: <20190409230022.6462-6-lersek@redhat.com>
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 09 Apr 2019 23:00:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 05/12] roms/edk2-funcs.sh: add the
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
Message-ID: <20190409230015.taaWQjPcatvBWyFe8kX6p5u9Gn1v8HMfrP63i8WPoAI@z>

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
---

Notes:
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



