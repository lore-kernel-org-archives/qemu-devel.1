Received: from eggs.gnu.org ([2001:4830:134:3::10]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRZ-0000kA-4A
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRX-0001cl-FZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuRV-0001ZN-J0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:50 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:13 +0400
Message-Id: <20181114123643.24091-12-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 11/41] slirp: remove FULL_BOLT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Looking at git history, this looks like something from the past, when
there was a tty layer. Let's remove it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/slirp_config.h | 7 -------
 slirp/if.c           | 2 --
 2 files changed, 9 deletions(-)

diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 721667e3ef..f0cc1c781b 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -5,13 +5,6 @@
 /* Define to 1 if you want KEEPALIVE timers */
 #define DO_KEEPALIVE 0
=20
-/* Define this if you want slirp to write to the tty as fast as it can *=
/
-/* This should only be set if you are using load-balancing, slirp does a=
 */
-/* pretty good job on single modems already, and seting this will make *=
/
-/* interactive sessions less responsive */
-/* XXXXX Talk about having fast modem as unit 0 */
-#undef FULL_BOLT
-
 /*********************************************************/
 /*
  * Autoconf defined configuration options
diff --git a/slirp/if.c b/slirp/if.c
index 1c96869831..1a9122a732 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -131,12 +131,10 @@ diddit:
 		}
 	}
=20
-#ifndef FULL_BOLT
 	/*
 	 * This prevents us from malloc()ing too many mbufs
 	 */
 	if_start(ifm->slirp);
-#endif
 }
=20
 /*
--=20
2.19.1.708.g4ede3d42df
