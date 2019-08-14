Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027D0206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027D0206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsF0-00024D-VI
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxsC5-0000Gt-Vn
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxsC4-0001he-Kq
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hxsBz-0001eE-Pv; Wed, 14 Aug 2019 08:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E5708EB34;
 Wed, 14 Aug 2019 12:15:48 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-203.brq.redhat.com [10.40.204.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEAE01B2F5;
 Wed, 14 Aug 2019 12:15:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 Pino Toscano <ptoscano@redhat.com>
Date: Wed, 14 Aug 2019 14:15:26 +0200
Message-Id: <20190814121527.17876-4-philmd@redhat.com>
In-Reply-To: <20190814121527.17876-1-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 14 Aug 2019 12:15:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] configure: Improve checking libssh version
 is 0.8
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

To figure out which libssh version is installed, checking for
ssh_get_server_publickey() is not sufficient.

ssh_get_server_publickey() has been introduced in libssh
commit bbd052202 (predating 0.8) but distributions also
backported other pre-0.8 patches, such libssh commit
963c46e4f which introduce the ssh_known_hosts_e enum.

Check the enum is available to assume the version is 0.8.

This fixes build failure on Ubuntu 18.04:

    CC      block/ssh.o
  block/ssh.c: In function 'check_host_key_knownhosts':
  block/ssh.c:281:28: error: storage size of 'state' isn't known
       enum ssh_known_hosts_e state;
                              ^~~~~
  rules.mak:69: recipe for target 'block/ssh.o' failed
  make: *** [block/ssh.o] Error 1

Reported-by: =E5=91=A8=E6=96=87=E9=9D=92 <1151451036@qq.com>
Fixes: https://bugs.launchpad.net/qemu/+bug/1838763
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index fe3fef9309..040aa8eb6c 100755
--- a/configure
+++ b/configure
@@ -3949,18 +3949,24 @@ fi
 if test "$libssh" =3D "yes"; then
   cat > $TMPC <<EOF
 #include <libssh/libssh.h>
+#ifdef HAVE_LIBSSH_0_8
+static const enum ssh_known_hosts_e val =3D SSH_KNOWN_HOSTS_OK;
+#endif
 #ifdef HAVE_SSH_GET_SERVER_PUBLICKEY
 int main(void) { return ssh_get_server_publickey(NULL, NULL); }
 #else
 int main(void) { return ssh_get_publickey(NULL, NULL); }
 #endif
 EOF
-  if compile_object "$libssh_cflags"; then
+  if compile_object "$libssh_cflags -DHAVE_LIBSSH_0_8"; then
     libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
   fi
   if compile_object "$libssh_cflags -DHAVE_SSH_GET_SERVER_PUBLICKEY"; th=
en
     libssh_cflags=3D"-DHAVE_SSH_GET_SERVER_PUBLICKEY $libssh_cflags"
   fi
+  if ! compile_object "$libssh_cflags"; then
+    error_exit "cannot use with libssh (is it broken?)"
+  fi
 fi
=20
 ##########################################
--=20
2.20.1


