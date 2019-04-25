Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F12C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D965206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D965206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfn4-0007WG-Dv
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:55:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJfle-0006Yq-3t
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJfld-000311-3S
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJflc-0002zh-Te
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5BC5C0AC91A;
	Thu, 25 Apr 2019 14:54:27 +0000 (UTC)
Received: from localhost (ovpn-117-82.ams2.redhat.com [10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0275B60C9B;
	Thu, 25 Apr 2019 14:54:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Thu, 25 Apr 2019 15:54:20 +0100
Message-Id: <20190425145420.8888-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 25 Apr 2019 14:54:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425145420.utGKU0NEfIQZY_hijEmbnFzKnmMxYPMzxtbkj7oWQrI@z>

qemu.org hosts git repository mirrors of all submodules.  Update
.gitmodules to use the mirrors and not the upstream repositories.

Mirroring upstream repositories ensures that QEMU continues to build
even when upstream repositories are deleted or temporarily offline.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .gitmodules | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index aa77ce6f50..2857eec763 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -39,19 +39,19 @@
 	url =3D https://git.qemu.org/git/capstone.git
 [submodule "roms/seabios-hppa"]
 	path =3D roms/seabios-hppa
-	url =3D https://github.com/hdeller/seabios-hppa.git
+	url =3D https://git.qemu.org/git/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path =3D roms/u-boot-sam460ex
 	url =3D https://git.qemu.org/git/u-boot-sam460ex.git
 [submodule "tests/fp/berkeley-testfloat-3"]
 	path =3D tests/fp/berkeley-testfloat-3
-	url =3D https://github.com/cota/berkeley-testfloat-3
+	url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
 [submodule "tests/fp/berkeley-softfloat-3"]
 	path =3D tests/fp/berkeley-softfloat-3
-	url =3D https://github.com/cota/berkeley-softfloat-3
+	url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
 [submodule "roms/edk2"]
 	path =3D roms/edk2
-	url =3D https://github.com/tianocore/edk2.git
+	url =3D https://git.qemu.org/git/edk2.git
 [submodule "slirp"]
 	path =3D slirp
-	url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
+	url =3D https://git.qemu.org/git/libslirp.git
--=20
2.20.1


