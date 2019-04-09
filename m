Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8AFC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404A320830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404A320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzns-0000AU-Ed
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:05:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjR-0005KR-53
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjQ-0001Bz-6n
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzjP-0001BX-V5
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D8413099FCA;
	Tue,  9 Apr 2019 23:00:43 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B66A4104C421;
	Tue,  9 Apr 2019 23:00:40 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:12 +0200
Message-Id: <20190409230022.6462-3-lersek@redhat.com>
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 09 Apr 2019 23:00:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 02/12] roms/edk2-funcs.sh: require
 gcc-4.8+ for building i386 and x86_64
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
Message-ID: <20190409230012.t3bQpX18wQYWvKJ3RNkdG2fnTN0hoV8fG9X7ep1Ca5I@z>

Adapt the qemu_edk2_get_toolchain() function in "roms/edk2-funcs.sh" in
advance to edk2 commit 8d7cdfae8cb8 ("OvmfPkg: require GCC48 or later",
2019-01-08), which is part of the "edk2-stable201903" tag.

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

 roms/edk2-funcs.sh | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 8930479dcb44..d1cb1e4a111e 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -149,23 +149,11 @@ qemu_edk2_get_toolchain()
       # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more informati=
on on
       # the mapping below.
       case "$gcc_version" in
-        ([1-3].*|4.[0-3].*)
+        ([1-3].*|4.[0-7].*)
           printf '%s: unsupported gcc version "%s"\n' \
             "$program_name" "$gcc_version" >&2
           return 1
           ;;
-        (4.4.*)
-          printf 'GCC44\n'
-          ;;
-        (4.5.*)
-          printf 'GCC45\n'
-          ;;
-        (4.6.*)
-          printf 'GCC46\n'
-          ;;
-        (4.7.*)
-          printf 'GCC47\n'
-          ;;
         (4.8.*)
           printf 'GCC48\n'
           ;;
--=20
2.19.1.3.g30247aa5d201



