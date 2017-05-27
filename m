Received: from eggs.gnu.org ([2001:4830:134:3::10]:58871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXU-0005RL-7c
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXT-0003If-7d
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:24 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:47330)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXT-0003G9-18
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:23 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 27 May 2017 23:46:16 +0200
Message-Id: <20170527214618.32626-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170527214618.32626-1-samuel.thibault@ens-lyon.org>
References: <20170527214618.32626-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] slirp: Fix wrong mss bug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <ytht.net@gmail.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Tao Wu <lepton@google.com>

From: Tao Wu <ytht.net@gmail.com>

This bug was introduced by https://github.com/qemu/qemu/commit/98c6305

Signed-off-by: Tao Wu <lepton@google.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-bu: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tcp_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index edb98f06f3..07bcbdb2dd 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -1587,11 +1587,11 @@ tcp_mss(struct tcpcb *tp, u_int offer)
 	switch (so->so_ffamily) {
 	case AF_INET:
             mss =3D MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
-	                              + sizeof(struct ip);
+	                              - sizeof(struct ip);
 	    break;
 	case AF_INET6:
             mss =3D MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
-	                              + sizeof(struct ip6);
+	                              - sizeof(struct ip6);
 	    break;
 	default:
 	    g_assert_not_reached();
--=20
2.11.0
