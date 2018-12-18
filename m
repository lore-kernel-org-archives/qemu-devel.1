Received: from eggs.gnu.org ([2001:4830:134:3::10]:50719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6oR-0004Rb-9q
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6oN-0006Cu-9v
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:16:55 -0500
Date: Mon, 17 Dec 2018 23:16:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-3-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 02/31] pc:piix4: Update smbus I/O space after a
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Corey Minyard <cminyard@mvista.com>

Otherwise it won't be set up correctly and won't work after
miigration.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/piix4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e330f24c71..2f4dd03b83 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -173,6 +173,7 @@ static int vmstate_acpi_post_load(void *opaque, int version_id)
     PIIX4PMState *s = opaque;
 
     pm_io_space_update(s);
+    smbus_io_space_update(s);
     return 0;
 }
 
-- 
MST
