Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C0C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DC1217D8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DC1217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55641 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6jl-0001He-Hp
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:31:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hT6gf-0007FG-9q
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hT6gd-0001FT-5s
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hT6gd-0001FG-0q; Tue, 21 May 2019 11:28:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52E8A307D855;
	Tue, 21 May 2019 15:28:18 +0000 (UTC)
Received: from localhost (ovpn-204-120.brq.redhat.com [10.40.204.120])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DAA50176C3;
	Tue, 21 May 2019 15:28:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 17:28:09 +0200
Message-Id: <20190521152810.21353-2-cohuck@redhat.com>
In-Reply-To: <20190521152810.21353-1-cohuck@redhat.com>
References: <20190521152810.21353-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 21 May 2019 15:28:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 46/55] update-linux-headers: handle new
 header file
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to copy sve_context.h for aarch64.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 scripts/update-linux-headers.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh
index c3819d2b983d..f76d77363bba 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -122,6 +122,9 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd-oabi.h" "$output/linux-headers/as=
m-arm/"
         cp "$tmpdir/include/asm/unistd-common.h" "$output/linux-headers/=
asm-arm/"
     fi
+    if [ $arch =3D arm64 ]; then
+        cp "$tmpdir/include/asm/sve_context.h" "$output/linux-headers/as=
m-arm64/"
+    fi
     if [ $arch =3D x86 ]; then
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-=
x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm=
-x86/"
--=20
2.20.1


