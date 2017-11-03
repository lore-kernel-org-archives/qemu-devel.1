Received: from eggs.gnu.org ([2001:4830:134:3::10]:45762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1eAcnk-0001jM-7P
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1eAcnf-0006Wx-VG
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:18:28 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:57670 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lu.zhipeng@zte.com.cn>)
	id 1eAcnf-0006N5-K3
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:18:23 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Fri, 3 Nov 2017 22:18:05 +0800
Message-Id: <1509718685-7993-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] net: add print link status of nic in
 print_net_client function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

We can directly know the information of vm by executing "info network" comm=
and,
 including the link state of nics, without executing other commands again.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Reviewed-by: Jiyun Fan <fan.jiyun@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2: correct commit messages
---
 net/net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 39ef546..9e349cb 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1298,10 +1298,14 @@ void print=5Fnet=5Fclient(Monitor *mon, NetClientSt=
ate *nc)
 {
     NetFilterState *nf;
=20
-    monitor=5Fprintf(mon, "%s: index=3D%d,type=3D%s,%s\n", nc->name,
+    monitor=5Fprintf(mon, "%s: index=3D%d,type=3D%s,%s", nc->name,
                    nc->queue=5Findex,
                    NetClientDriver=5Fstr(nc->info->type),
                    nc->info=5Fstr);
+    if (nc->info->type =3D=3D NET=5FCLIENT=5FDRIVER=5FNIC) {
+        monitor=5Fprintf(mon, ",link status:%s", nc->link=5Fdown ? "down" =
: "up");
+    }
+    monitor=5Fprintf(mon, "\n");
     if (!QTAILQ=5FEMPTY(&nc->filters)) {
         monitor=5Fprintf(mon, "filters:\n");
     }
--=20
1.8.3.1
