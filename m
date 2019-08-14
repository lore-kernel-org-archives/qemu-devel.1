Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE10C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A626D2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsEz-000208-I0
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxsC5-0000Fd-3E
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxsC4-0001hH-1j
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hxsBz-0001dV-Oy; Wed, 14 Aug 2019 08:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10B0E31752A2;
 Wed, 14 Aug 2019 12:15:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-203.brq.redhat.com [10.40.204.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA5848309C;
 Wed, 14 Aug 2019 12:15:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 Pino Toscano <ptoscano@redhat.com>
Date: Wed, 14 Aug 2019 14:15:25 +0200
Message-Id: <20190814121527.17876-3-philmd@redhat.com>
In-Reply-To: <20190814121527.17876-1-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 14 Aug 2019 12:15:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] configure: Avoid using libssh deprecated
 API
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
 Andrea Bolognani <abologna@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?=E5=91=A8=E6=96=87=E9=9D=92?= <1151451036@qq.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The libssh packaged by a distribution can predate version 0.8,
but still provides the newer API introduced after version 0.7.

Using the deprecated API leads to build failure, as on Ubuntu 18.04:

    CC      block/ssh.o
  block/ssh.c: In function 'check_host_key_hash':
  block/ssh.c:444:5: error: 'ssh_get_publickey' is deprecated [-Werror=3D=
deprecated-declarations]
       r =3D ssh_get_publickey(s->session, &pubkey);
       ^
  In file included from block/ssh.c:27:0:
  /usr/include/libssh/libssh.h:489:31: note: declared here
   SSH_DEPRECATED LIBSSH_API int ssh_get_publickey(ssh_session session, s=
sh_key *key);
                                 ^~~~~~~~~~~~~~~~~
  rules.mak:69: recipe for target 'block/ssh.o' failed
  make: *** [block/ssh.o] Error 1

Fix by using the newer API if available.

Suggested-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/ssh.c | 2 +-
 configure   | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/ssh.c b/block/ssh.c
index 501933b855..f5fea921c6 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -438,7 +438,7 @@ check_host_key_hash(BDRVSSHState *s, const char *hash=
,
     unsigned char *server_hash;
     size_t server_hash_len;
=20
-#ifdef HAVE_LIBSSH_0_8
+#ifdef HAVE_SSH_GET_SERVER_PUBLICKEY
     r =3D ssh_get_server_publickey(s->session, &pubkey);
 #else
     r =3D ssh_get_publickey(s->session, &pubkey);
diff --git a/configure b/configure
index 1d5c07de1f..fe3fef9309 100755
--- a/configure
+++ b/configure
@@ -3949,11 +3949,18 @@ fi
 if test "$libssh" =3D "yes"; then
   cat > $TMPC <<EOF
 #include <libssh/libssh.h>
+#ifdef HAVE_SSH_GET_SERVER_PUBLICKEY
 int main(void) { return ssh_get_server_publickey(NULL, NULL); }
+#else
+int main(void) { return ssh_get_publickey(NULL, NULL); }
+#endif
 EOF
   if compile_object "$libssh_cflags"; then
     libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
   fi
+  if compile_object "$libssh_cflags -DHAVE_SSH_GET_SERVER_PUBLICKEY"; th=
en
+    libssh_cflags=3D"-DHAVE_SSH_GET_SERVER_PUBLICKEY $libssh_cflags"
+  fi
 fi
=20
 ##########################################
--=20
2.20.1


