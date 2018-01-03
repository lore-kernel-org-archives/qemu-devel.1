Received: from eggs.gnu.org ([2001:4830:134:3::10]:33339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabZ-00019B-FD
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabV-0001s3-Bt
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  3 Jan 2018 15:24:07 +1100
Message-Id: <20180103042419.14520-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180103042419.14520-1-david@gibson.dropbear.id.au>
References: <20180103042419.14520-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/15] sm501: Add panel hardware cursor
 registers also to read function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

These were forgotten when adding panel layer support in ffd39257018
"SM501 emulation for R2D-SH4".

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[dwg: Added reference to earlier commit in message]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 7f1822421a..b9b611131e 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -956,6 +956,19 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, h=
waddr addr,
         ret =3D s->dc_panel_v_sync;
         break;
=20
+    case SM501_DC_PANEL_HWC_ADDR:
+        ret =3D s->dc_panel_hwc_addr;
+        break;
+    case SM501_DC_PANEL_HWC_LOC:
+        ret =3D s->dc_panel_hwc_location;
+        break;
+    case SM501_DC_PANEL_HWC_COLOR_1_2:
+        ret =3D s->dc_panel_hwc_color_1_2;
+        break;
+    case SM501_DC_PANEL_HWC_COLOR_3:
+        ret =3D s->dc_panel_hwc_color_3;
+        break;
+
     case SM501_DC_VIDEO_CONTROL:
         ret =3D s->dc_video_control;
         break;
--=20
2.14.3
