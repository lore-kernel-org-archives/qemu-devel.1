Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F267FC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C010D27134
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C010D27134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39066 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrVw-0008Vv-1E
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:16:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOA-00020W-TV
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrO9-00009N-Ea
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrO1-0008Ju-VX
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so10485369qtk.11
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=s3n2L882ltXjPfEswBbEwB7+zfGhmxcdhpoO8/YoZaM=;
	b=I1ADiDrCrgd+ZvppfP74yyDLI2vJ4/vFwT+g7wilUlj+MoSff7jlkiaZJMcvlqIXqJ
	91NxjTXS5kbVDKWBEqP7uQZlJ0k2Y3cvhj5p6lZXKvJQvNanOQ23uEYXz1lBywB34iUX
	vomNJERiIpsFS2GNBm4z22pH13SNxkRBmTYWhfK7y7rFrdZ3fvcyTOHmrT4X5IPVzASv
	I9Nwno8R6w0ht5iA7FQ34sVZuCymWeBh/lYwClYGEIXWI4YKPAFVACLOwdC/x6E5FGhZ
	2hORYVsWOt632JYWcSzkreRfDVz10CNxsN6Bqu/BiSZnt5mpFXoEEuVey4I16W3H+QIK
	VBMg==
X-Gm-Message-State: APjAAAULgYmg8FEukYgxAVMEXypEAeneta6JHZ6DlAe8+tjqXav08bz/
	pxJrX+2wLxdnSn3tXNpNTkIWKgKlK6g=
X-Google-Smtp-Source: APXvYqx/MmlIT7K+NW9fhzgRAYLK2q3VvdgNJPZtNVxUiBkusKjU+gBtcCwu3xkUMcpxD5sSIWvzew==
X-Received: by 2002:ac8:70cf:: with SMTP id g15mr22406426qtp.254.1559585325057;
	Mon, 03 Jun 2019 11:08:45 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	z123sm8185862qka.7.2019.06.03.11.08.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:08:44 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:08:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190513061939.3464-6-david@gibson.dropbear.id.au>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] [PULL v2 05/14] pci: Fold pci_get_bus_devfn() into its
 sole caller
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190603180842.7RJOuRR_Ve2Ex9FBThPxT_4_Lb9L6ACF74iEnDmq0j8@z>

From: David Gibson <david@gibson.dropbear.id.au>

The only remaining caller of pci_get_bus_devfn() is pci_nic_init_nofail(),
itself an old compatibility function.  Fold the two together to avoid
re-using the stale interface.

While we're there replace the explicit fprintf()s with error_report().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190513061939.3464-6-david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/pci/pci.c | 60 ++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 7e5f8d001b..d3893bdfe1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -723,37 +723,6 @@ static int pci_parse_devaddr(const char *addr, int *domp, int *busp,
     return 0;
 }
 
-static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root,
-                                 const char *devaddr)
-{
-    int dom, bus;
-    unsigned slot;
-
-    if (!root) {
-        fprintf(stderr, "No primary PCI bus\n");
-        return NULL;
-    }
-
-    assert(!root->parent_dev);
-
-    if (!devaddr) {
-        *devfnp = -1;
-        return pci_find_bus_nr(root, 0);
-    }
-
-    if (pci_parse_devaddr(devaddr, &dom, &bus, &slot, NULL) < 0) {
-        return NULL;
-    }
-
-    if (dom != 0) {
-        fprintf(stderr, "No support for non-zero PCI domains\n");
-        return NULL;
-    }
-
-    *devfnp = PCI_DEVFN(slot, 0);
-    return pci_find_bus_nr(root, bus);
-}
-
 static void pci_init_cmask(PCIDevice *dev)
 {
     pci_set_word(dev->cmask + PCI_VENDOR_ID, 0xffff);
@@ -1895,6 +1864,8 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
     DeviceState *dev;
     int devfn;
     int i;
+    int dom, busnr;
+    unsigned slot;
 
     if (nd->model && !strcmp(nd->model, "virtio")) {
         g_free(nd->model);
@@ -1928,7 +1899,32 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
         exit(1);
     }
 
-    bus = pci_get_bus_devfn(&devfn, rootbus, devaddr);
+    if (!rootbus) {
+        error_report("No primary PCI bus");
+        exit(1);
+    }
+
+    assert(!rootbus->parent_dev);
+
+    if (!devaddr) {
+        devfn = -1;
+        busnr = 0;
+    } else {
+        if (pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) < 0) {
+            error_report("Invalid PCI device address %s for device %s",
+                         devaddr, nd->model);
+            exit(1);
+        }
+
+        if (dom != 0) {
+            error_report("No support for non-zero PCI domains");
+            exit(1);
+        }
+
+        devfn = PCI_DEVFN(slot, 0);
+    }
+
+    bus = pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, nd->model);
-- 
MST


