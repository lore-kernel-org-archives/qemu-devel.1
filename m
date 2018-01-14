Received: from eggs.gnu.org ([2001:4830:134:3::10]:41432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxv-000081-LT
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxr-0002Il-26
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:03 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:47692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ealxq-0002Hc-Ra
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:20:58 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 14 Jan 2018 18:20:52 +0100
Message-Id: <20180114172053.1051-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
References: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] slirp: removed unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 1df6723357..59cf4aa918 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -233,17 +233,4 @@ struct	ipasfrag {
 #define ipf_next     ipf_link.next
 #define ipf_prev     ipf_link.prev
=20
-/*
- * Structure stored in mbuf in inpcb.ip_options
- * and passed to ip_output when ip options are in use.
- * The actual length of the options (including ipopt_dst)
- * is in m_len.
- */
-#define MAX_IPOPTLEN	40
-
-struct ipoption {
-	struct	in_addr ipopt_dst;	/* first-hop dst if source routed */
-	int8_t	ipopt_list[MAX_IPOPTLEN];	/* options proper */
-} QEMU_PACKED;
-
 #endif
--=20
2.15.1
