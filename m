Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AF3C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E2C2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E2C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEMe-0005UU-TI
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:15:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL1-0004E0-PH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL0-0002LW-Sc
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEL0-0002LO-Lq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDCD630024D2;
	Thu,  2 May 2019 16:13:33 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A88F17D58;
	Thu,  2 May 2019 16:13:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 18:13:07 +0200
Message-Id: <20190502161310.15624-6-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 02 May 2019 16:13:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/8] configure: Add -Wno-typedef-redefinition to
 CFLAGS (for Clang)
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
Cc: Eduardo Otubo <otubo@redhat.com>, Helge Deller <deller@gmx.de>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502161307.8UqKbAdN1RikfvUMNwMmAo7iVOHGa83X4hU5iTjvBEA@z>

Without the -Wno-typedef-redefinition option, clang complains if a typede=
f
gets redefined in gnu99 mode (since this is officially a C11 feature). Th=
is
used to also happen with older versions of GCC, but since we've bumped ou=
r
minimum GCC version to 4.8, all versions of GCC that we support do not se=
em
to issue this warning in gnu99 mode anymore. So this has become a common
problem for people who only test their code with GCC - they do not notice
the issue until they submit their patches and suddenly patchew or a
maintainer complains.

Now that we do not urgently need to keep the code clean from typedef
redefintions anymore with recent versions of GCC, we can ease the
situation with clang, too, and simply shut these warnings off for good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190427154539.11336-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 60719ddcc5..362bfef637 100755
--- a/configure
+++ b/configure
@@ -1908,7 +1908,7 @@ gcc_flags=3D"-Wformat-security -Wformat-y2k -Winit-=
self -Wignored-qualifiers $gcc_
 gcc_flags=3D"-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gc=
c_flags"
 gcc_flags=3D"-Wendif-labels -Wno-shift-negative-value $gcc_flags"
 gcc_flags=3D"-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flag=
s"
-gcc_flags=3D"-Wno-string-plus-int $gcc_flags"
+gcc_flags=3D"-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
 # Note that we do not add -Werror to gcc_flags here, because that would
 # enable it for all configure tests. If a configure test failed due
 # to -Werror this would just silently disable some features,
--=20
2.21.0


