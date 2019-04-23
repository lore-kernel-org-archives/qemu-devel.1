Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B759C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAD920835
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAD920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIz6J-0008VU-NK
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:20:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1U-00058K-8e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1T-0005SS-4B
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz1S-0005RH-TK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2495B307EA96;
	Tue, 23 Apr 2019 17:15:58 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FD2219729;
	Tue, 23 Apr 2019 17:15:55 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 19:15:11 +0200
Message-Id: <20190423171520.4511-4-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 23 Apr 2019 17:15:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/12] tests/uefi-test-tools/build.sh: work
 around TianoCore#1607
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
Message-ID: <20190423171511._WOt-Q3NUwV7kKYwqBBXTAQf_avC3NkD3ZQml3ueTv4@z>

The edk2-stabe201903 release introduced Python3 support to edk2's
BaseTools; however the Python3 enablement breaks in a corner case (which
is nevertheless supported by the edk2 community), namely the in-module
parallelization that we utilize.

This is tracked under
<https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>. For now, work
around the issue (in advance) by forcing Python2. (The workaround is a
no-op before we move to edk2-stabe201903 in the roms/edk2 submodule.)

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

 tests/uefi-test-tools/build.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/build=
.sh
index e2b52c855c39..8aa7935c43bb 100755
--- a/tests/uefi-test-tools/build.sh
+++ b/tests/uefi-test-tools/build.sh
@@ -29,6 +29,9 @@ export PACKAGES_PATH=3D$(realpath -- "$edk2_dir")
 export WORKSPACE=3D$PWD
 mkdir -p Conf
=20
+# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>.
+export PYTHON_COMMAND=3Dpython2
+
 # Source "edksetup.sh" carefully.
 set +e +u +C
 source "$PACKAGES_PATH/edksetup.sh"
--=20
2.19.1.3.g30247aa5d201



