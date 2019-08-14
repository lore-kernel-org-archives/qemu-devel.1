Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A469FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E623206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E623206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsGe-0004IA-Jn
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxsC5-0000Fx-9t
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxsC4-0001hQ-BK
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hxsC1-0001fJ-Rq; Wed, 14 Aug 2019 08:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 094BF2A09AC;
 Wed, 14 Aug 2019 12:15:52 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-203.brq.redhat.com [10.40.204.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7AD21B2F5;
 Wed, 14 Aug 2019 12:15:48 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 Pino Toscano <ptoscano@redhat.com>
Date: Wed, 14 Aug 2019 14:15:27 +0200
Message-Id: <20190814121527.17876-5-philmd@redhat.com>
In-Reply-To: <20190814121527.17876-1-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 14 Aug 2019 12:15:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] configure: Log the libssh version detected
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?=E5=91=A8=E6=96=87=E9=9D=92?= <1151451036@qq.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Log wether the version is 0.7 or 0.8 to better understand
user reports.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 040aa8eb6c..d06cee0ba0 100755
--- a/configure
+++ b/configure
@@ -3930,6 +3930,7 @@ if test "$libssh" !=3D "no" ; then
   if $pkg_config --exists libssh; then
     libssh_cflags=3D$($pkg_config libssh --cflags)
     libssh_libs=3D$($pkg_config libssh --libs)
+    libssh_version=3D$($pkg_config libssh --modversion)
     libssh=3Dyes
   else
     if test "$libssh" =3D "yes" ; then
@@ -3960,6 +3961,9 @@ int main(void) { return ssh_get_publickey(NULL, NUL=
L); }
 EOF
   if compile_object "$libssh_cflags -DHAVE_LIBSSH_0_8"; then
     libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
+  else
+    # If this is not libssh 0.8, this is likely 0.7
+    libssh_version=3D"0.7"
   fi
   if compile_object "$libssh_cflags -DHAVE_SSH_GET_SERVER_PUBLICKEY"; th=
en
     libssh_cflags=3D"-DHAVE_SSH_GET_SERVER_PUBLICKEY $libssh_cflags"
@@ -6466,7 +6470,7 @@ echo "GlusterFS support $glusterfs"
 echo "gcov              $gcov_tool"
 echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
-echo "libssh support    $libssh"
+echo "libssh support    $libssh $(echo_version $libssh $libssh_version)"
 echo "QOM debugging     $qom_cast_debug"
 echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
--=20
2.20.1


