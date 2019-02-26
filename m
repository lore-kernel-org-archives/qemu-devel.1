Received: from eggs.gnu.org ([209.51.188.92]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlo-0005w5-0Y
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUln-0003Ej-AR
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:54 +1100
Message-Id: <20190226045304.25618-41-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/50] spapr_events: add support for phb hotplug
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Extend the existing EPOW event format we use for PCI
devices to emit PHB plug/unplug events.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059671405.1466090.535964535260503283.stgit@bahia.lab.toul=
ouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index b9c7ecb9e9..ab9a1f0063 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -526,6 +526,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
         hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_CPU;
         break;
+    case SPAPR_DR_CONNECTOR_TYPE_PHB:
+        hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PHB;
+        break;
     default:
         /* we shouldn't be signaling hotplug events for resources
          * that don't support them
--=20
2.20.1
