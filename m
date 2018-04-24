Received: from eggs.gnu.org ([2001:4830:134:3::10]:36598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DL-0007KI-Gu
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DK-00073r-Mq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:51 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:9785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DK-00071c-Cs
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:50 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Tue, 24 Apr 2018 18:58:25 +0100
Message-ID: <1524592709-6553-13-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 12/16] xen: Remove now-obsolete
 xen_xc_domain_add_to_physmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

The last user was just removed; remove this function, accordingly.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 include/hw/xen/xen_common.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 2eed6fc..5f1402b 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -645,28 +645,6 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
 
 #endif
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40600
-static inline int xen_xc_domain_add_to_physmap(xc_interface *xch, uint32_t domid,
-                                               unsigned int space,
-                                               unsigned long idx,
-                                               xen_pfn_t gpfn)
-{
-    return xc_domain_add_to_physmap(xch, domid, space, idx, gpfn);
-}
-#else
-static inline int xen_xc_domain_add_to_physmap(xc_interface *xch, uint32_t domid,
-                                               unsigned int space,
-                                               unsigned long idx,
-                                               xen_pfn_t gpfn)
-{
-    /* In Xen 4.6 rc is -1 and errno contains the error value. */
-    int rc = xc_domain_add_to_physmap(xch, domid, space, idx, gpfn);
-    if (rc == -1)
-        return errno;
-    return rc;
-}
-#endif
-
 #ifdef CONFIG_XEN_PV_DOMAIN_BUILD
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40700
 static inline int xen_domain_create(xc_interface *xc, uint32_t ssidref,
-- 
2.1.4
