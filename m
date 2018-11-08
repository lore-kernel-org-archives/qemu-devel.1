Received: from eggs.gnu.org ([2001:4830:134:3::10]:43418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFL-0005Gh-4h
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFI-0003qe-Nr
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:38 +1100
Message-Id: <20181108121646.26173-15-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/22] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fix missing terminator in VMStateDescription

Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index d25344f888..6e6d96c8c5 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu_adb =3D {
         VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
         VMSTATE_UINT8(adb_reply_size, PMUState),
         VMSTATE_BUFFER(adb_reply, PMUState),
+        VMSTATE_END_OF_LIST()
     }
 };
=20
--=20
2.19.1
