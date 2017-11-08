Received: from eggs.gnu.org ([2001:4830:134:3::10]:34753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMX-0000VP-Qt
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMU-0003aI-NA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:25 -0500
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com
	([104.47.41.53]:34400
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZMU-0003ZY-8w
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:22 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:07 -0800
Message-ID: <35c73e90f5667cfee146a2f69fffea10862c4f7c.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 26/45] hw/net: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Manually remove a trailing '.' from hw/net/pcnet.c

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V3:
 - Drop tailing '.'
V2:
 - Split hw patch into individual directories

 hw/net/fsl_etsec/etsec.c |  2 +-
 hw/net/pcnet.c           |  2 +-
 hw/net/smc91c111.c       |  5 +++--
 hw/net/vhost_net.c       | 16 ++++++++--------
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 9da1932970..965effa314 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -347,7 +347,7 @@ static ssize_t etsec_receive(NetClientState *nc,
     eTSEC *etsec =3D qemu_get_nic_opaque(nc);
=20
 #if defined(HEX_DUMP)
-    fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
+    error_report("%s receive size:%zd", nc->name, size);
     qemu_hexdump((void *)buf, stderr, "", size);
 #endif
     /* Flush is unnecessary as are already in receiving path */
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 654455355f..e7c89b41a8 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1070,7 +1070,7 @@ ssize_t pcnet_receive(NetClientState *nc, const uint8=
_t *buf, size_t size_)
             if (!s->looptest) {
                 if (size > 4092) {
 #ifdef PCNET_DEBUG_RMD
-                    fprintf(stderr, "pcnet: truncates rx packet.\n");
+                    error_report("pcnet: truncates rx packet");
 #endif
                     size =3D 4092;
                 }
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 3b16dcf5a1..ae40fd6e6e 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/devices.h"
@@ -362,9 +363,9 @@ static void smc91c111_writeb(void *opaque, hwaddr offse=
t,
             return;
         case 12: /* Control */
             if (value & 1)
-                fprintf(stderr, "smc91c111:EEPROM store not implemented\n"=
);
+                error_report("smc91c111:EEPROM store not implemented");
             if (value & 2)
-                fprintf(stderr, "smc91c111:EEPROM reload not implemented\n=
");
+                error_report("smc91c111:EEPROM reload not implemented");
             value &=3D ~3;
             SET_LOW(ctr, value);
             return;
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db63a3..37d0cce560 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -135,7 +135,7 @@ static int vhost_net_get_fd(NetClientState *backend)
     case NET_CLIENT_DRIVER_TAP:
         return tap_get_fd(backend);
     default:
-        fprintf(stderr, "vhost-net requires tap backend\n");
+        error_report("vhost-net requires tap backend");
         return -EBADFD;
     }
 }
@@ -148,7 +148,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *optio=
ns)
     uint64_t features =3D 0;
=20
     if (!options->net_backend) {
-        fprintf(stderr, "vhost-net requires net backend to be setup\n");
+        error_report("vhost-net requires net backend to be setup");
         goto fail;
     }
     net->nc =3D options->net_backend;
@@ -186,8 +186,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *optio=
ns)
             net->dev.features &=3D ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
         if (~net->dev.features & net->dev.backend_features) {
-            fprintf(stderr, "vhost lacks feature mask %" PRIu64
-                   " for backend\n",
+            error_report("vhost lacks feature mask %" PRIu64
+                   " for backend",
                    (uint64_t)(~net->dev.features & net->dev.backend_featur=
es));
             goto fail;
         }
@@ -197,8 +197,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *optio=
ns)
     if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) {
         features =3D vhost_user_get_acked_features(net->nc);
         if (~net->dev.features & features) {
-            fprintf(stderr, "vhost lacks feature mask %" PRIu64
-                    " for backend\n",
+            error_report("vhost lacks feature mask %" PRIu64
+                    " for backend",
                     (uint64_t)(~net->dev.features & features));
             goto fail;
         }
@@ -349,7 +349,7 @@ err_start:
     }
     e =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
     if (e < 0) {
-        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
+        error_report("vhost guest notifier cleanup failed: %d", e);
         fflush(stderr);
     }
 err:
@@ -370,7 +370,7 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *=
ncs,
=20
     r =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
     if (r < 0) {
-        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
+        error_report("vhost guest notifier cleanup failed: %d", r);
         fflush(stderr);
     }
     assert(r >=3D 0);
--=20
2.14.1
