Received: from eggs.gnu.org ([2001:4830:134:3::10]:40214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00081r-SQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQF-0004Fx-IB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:10 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQD-0004A3-Oi
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:07 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:55 +0100
Message-Id: <20181218230442.27887-18-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/64] slirp: remove FULL_BOLT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Looking at git history, this looks like something from the past, when
there was a tty layer. Let's remove it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/if.c           | 2 --
 slirp/slirp_config.h | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/slirp/if.c b/slirp/if.c
index 590753c658..aa88cc4e76 100644
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
--=20
2.19.2
