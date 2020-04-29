Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F535C83001
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 03:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D2020731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 03:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml9H7kdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D2020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTd6x-0004mO-0Z
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 23:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTd4T-0001yO-3i
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTd1f-0006b3-0H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:07:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jTd1e-0006av-Ke
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:04:42 -0400
Received: by mail-wm1-x341.google.com with SMTP id x4so306654wmj.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MFxxzEsM5GfOkfgyaKw8Kz24FnJBi9lLjF7uh1T3+yM=;
 b=Ml9H7kdFfKHLrPPnYLICG9djXTuB/GA+1a6LqrTQxGGNkNJxCNdRS2clqs+BPiSaDo
 SyDSYfAFPEVvMLZE53vt6LjJUGrWhyg2uP48+5Sp8JH/PFYvzj47b4hIdShvxZBnCvzt
 d/MHprmO+6eDewWi8n5QAuvcyvODR4vbkp3lFjbCmAr5WpDkeuyk8frileoa4IteY9nl
 63aJmdKg+mGax5YgJy6sQ5P8fsduxB/TCCu0sSM5W6EAyEP9+wr5mzYCYLTrFRWlaPgN
 vegKSMP7+zwJX5Dsx86WJlzPqx2lM0Ue6tru7DS1zb1UpztfuArjUPSTwPkXfGEVRaoA
 Jfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MFxxzEsM5GfOkfgyaKw8Kz24FnJBi9lLjF7uh1T3+yM=;
 b=Qc8vhArOIcg9bKe6MupO3ikZrEDdlegVjxNHUmGyL2gM64mkJ00LUyMn6pAIBUaOO4
 ql7gCgfZHbGos/yoW13S2Q+MmFM17InQJWx0mPabnlbofnhl6XTlpy6pM7NPrpsj/pdb
 ormiQONXg+qJljX+RwSH0uEqP9YizsRR6SBJLtVoKs7VOmpoFFjBTAoGMYV46CW1FvE7
 lt8CItV1TDC2dVr0GYrOhR1mOTX9LMLX3G/AFlg+amr7bdvgEgKFW8K0OGDwtpO3d8zj
 hRrPlHduRt6QXisXxjy7j+12uBH01yZwKMlaf14fgb/x1JEt/a85TCP5CUMSinLtkMt4
 ZQrQ==
X-Gm-Message-State: AGi0PuarpcNJYL9Kz+9yq7xUPuTn5As2zCSZlvUSfyeg2V6Yrtw7mPiq
 IUP3PCuvTW4dKi16bgpC0iIFo/iSXxHKcA==
X-Google-Smtp-Source: APiQypJ7i6XB4Z4DtGjW0thFBqIHvxddUzWj5q8KwPgw4tknkPlZoRrX8MoglxKZaemp9rCnP0Ki8A==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr525239wmb.127.1588129480910; 
 Tue, 28 Apr 2020 20:04:40 -0700 (PDT)
Received: from localhost.localdomain (public-gprs636909.centertel.pl.
 [5.184.31.46])
 by smtp.gmail.com with ESMTPSA id o6sm19713725wrw.63.2020.04.28.20.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 20:04:40 -0700 (PDT)
From: Grzegorz Uriasz <gorbak25@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] Improve legacy vbios handling
Date: Wed, 29 Apr 2020 03:04:09 +0000
Message-Id: <20200429030409.9406-3-gorbak25@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200429030409.9406-1-gorbak25@gmail.com>
References: <20200429030409.9406-1-gorbak25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=gorbak25@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: artur@puzio.waw.pl, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, Grzegorz Uriasz <gorbak25@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current method of getting the vbios is broken - it just isn't working on any device I've tested - the reason
for this is explained in the previous patch. The vbios is polymorphic and getting a proper unmodified copy is
often not possible without reverse engineering the firmware. We don't need an unmodified copy for most purposes -
an unmodified copy is only needed for initializing the bios framebuffer and providing the bios with a corrupted
copy of the rom won't do any damage as the bios will just ignore the rom.

After the i915 driver takes over the vbios is only needed for reading some metadata/configuration stuff etc...
I've tested that not having any kind of vbios in the guest actually works fine but on older generations of IGD
there are some slight hiccups. To maximize compatibility the best approach is to just copy the results of the vbios
execution directly to the guest. It turns out the vbios is always present on an hardcoded memory range in a reserved
memory range from real mode - all we need to do is to memcpy it into the guest.

The following patch does 2 things:
1) When pci_assign_dev_load_option_rom fails to read the vbios from sysfs(this works only when the igd is not the
boot gpu - this is unlikely to happen) it falls back to using /dev/mem to copy the vbios directly to the guest.
Using /dev/mem should be fine as there is more xen specific pci code which also relies on /dev/mem.
2) When dealing with IGD in the more generic code we skip the allocation of the rom resource - the reason for this is to prevent
a malicious guest from modifying the vbios in the host -> this is needed as someone might try to pwn the i915 driver in the host by doing so
(attach igd to guest, guest modifies vbios, the guest is terminated and the idg is reattached to the host, i915 driver in the host uses data from the modified vbios).
This is also needed to not overwrite the proper shadow copy made before.

I've tested this patch and it works fine - the guest isn't complaining about the missing vbios tables and the pci config
space in the guest looks fine.

Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
---
 hw/xen/xen_pt.c          |  8 +++++--
 hw/xen/xen_pt_graphics.c | 48 +++++++++++++++++++++++++++++++++++++---
 hw/xen/xen_pt_load_rom.c |  2 +-
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index b91082cb8b..ffc3559dd4 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -483,8 +483,12 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
                    i, r->size, r->base_addr, type);
     }
 
-    /* Register expansion ROM address */
-    if (d->rom.base_addr && d->rom.size) {
+    /*
+     * Register expansion ROM address. If we are dealing with a ROM
+     * shadow copy for legacy vga devices then don't bother to map it
+     * as previous code creates a proper shadow copy
+     */
+    if (d->rom.base_addr && d->rom.size && !(is_igd_vga_passthrough(d))) {
         uint32_t bar_data = 0;
 
         /* Re-set BAR reported by OS, otherwise ROM can't be read. */
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index a3bc7e3921..fe0ef2685c 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -129,7 +129,7 @@ int xen_pt_unregister_vga_regions(XenHostPCIDevice *dev)
     return 0;
 }
 
-static void *get_vgabios(XenPCIPassthroughState *s, int *size,
+static void *get_sysfs_vgabios(XenPCIPassthroughState *s, int *size,
                        XenHostPCIDevice *dev)
 {
     return pci_assign_dev_load_option_rom(&s->dev, size,
@@ -137,6 +137,45 @@ static void *get_vgabios(XenPCIPassthroughState *s, int *size,
                                           dev->dev, dev->func);
 }
 
+static void xen_pt_direct_vbios_copy(XenPCIPassthroughState *s, Error **errp)
+{
+    int fd = -1;
+    void *guest_bios = NULL;
+    void *host_vbios = NULL;
+    /* This is always 32 pages in the real mode reserved region */
+    int bios_size = 32 << XC_PAGE_SHIFT;
+    int vbios_addr = 0xc0000;
+
+    fd = open("/dev/mem", O_RDONLY);
+    if (fd == -1) {
+        error_setg(errp, "Can't open /dev/mem: %s", strerror(errno));
+        return;
+    }
+    host_vbios = mmap(NULL, bios_size,
+            PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, fd, vbios_addr);
+    close(fd);
+
+    if (host_vbios == MAP_FAILED) {
+        error_setg(errp, "Failed to mmap host vbios: %s", strerror(errno));
+        return;
+    }
+
+    memory_region_init_ram(&s->dev.rom, OBJECT(&s->dev),
+            "legacy_vbios.rom", bios_size, &error_abort);
+    guest_bios = memory_region_get_ram_ptr(&s->dev.rom);
+    memcpy(guest_bios, host_vbios, bios_size);
+
+    if (munmap(host_vbios, bios_size) == -1) {
+        XEN_PT_LOG(&s->dev, "Failed to unmap host vbios: %s\n", strerror(errno));
+    }
+
+    cpu_physical_memory_write(vbios_addr, guest_bios, bios_size);
+    memory_region_set_address(&s->dev.rom, vbios_addr);
+    pci_register_bar(&s->dev, PCI_ROM_SLOT, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->dev.rom);
+    s->dev.has_rom = true;
+    XEN_PT_LOG(&s->dev, "Legacy VBIOS registered\n");
+}
+
 /* Refer to Seabios. */
 struct rom_header {
     uint16_t signature;
@@ -179,9 +218,11 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
         return;
     }
 
-    bios = get_vgabios(s, &bios_size, dev);
+    bios = get_sysfs_vgabios(s, &bios_size, dev);
     if (!bios) {
-        error_setg(errp, "VGA: Can't get VBIOS");
+        XEN_PT_LOG(&s->dev, "Unable to get host VBIOS from sysfs - "
+                            "falling back to a direct copy of memory ranges\n");
+        xen_pt_direct_vbios_copy(s, errp);
         return;
     }
 
@@ -223,6 +264,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
 
     /* Currently we fixed this address as a primary for legacy BIOS. */
     cpu_physical_memory_write(0xc0000, bios, bios_size);
+    XEN_PT_LOG(&s->dev, "Legacy VBIOS registered\n");
 }
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 9f100dc159..8cd9aa84dc 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -65,7 +65,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
         goto close_rom;
     }
 
-    pci_register_bar(dev, PCI_ROM_SLOT, 0, &dev->rom);
+    pci_register_bar(dev, PCI_ROM_SLOT, PCI_BASE_ADDRESS_SPACE_MEMORY, &dev->rom);
     dev->has_rom = true;
     *size = st.st_size;
 close_rom:
-- 
2.26.1


