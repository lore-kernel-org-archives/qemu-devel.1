Received: from eggs.gnu.org ([2001:4830:134:3::10]:38799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdM-0005ya-0G
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdL-0002kV-6K
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdL-0002jn-02
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:27 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:08 +0200
Message-Id: <20170919164337.18555-10-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/38] s390x/css: remove unused error
 handling branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

The case in question actually never happens. Let us get rid of the dead
code.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170908152446.14606-4-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 6d599477b2..75d4f301fb 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -980,13 +980,6 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
                     SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
             s->cpa = sch->channel_prog + 8;
             break;
-        case -EBUSY:
-            /* subchannel busy, generate deferred cc 1 */
-            s->flags &= ~SCSW_FLAGS_MASK_CC;
-            s->flags |= (1 << 8);
-            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |= SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
-            break;
         case -EINPROGRESS:
             /* channel program has been suspended */
             s->ctrl &= ~SCSW_ACTL_START_PEND;
-- 
2.13.5
