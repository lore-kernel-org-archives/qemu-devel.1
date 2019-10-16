Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6AEFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAE621A49
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYICwWLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAE621A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmaL-00075F-6r
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36293)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3dEinXQYKCpUHzB3725DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--sameid.bounces.google.com>)
 id 1iKmNc-0004Vc-D5
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3dEinXQYKCpUHzB3725DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--sameid.bounces.google.com>)
 id 1iKmNa-0006Kw-1c
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:32 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a]:34844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3dEinXQYKCpUHzB3725DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--sameid.bounces.google.com>)
 id 1iKmNZ-0006KZ-RM
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:29 -0400
Received: by mail-wr1-x44a.google.com with SMTP id 7so6732407wrl.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=NzlITaGA47lkkyjFV/anV49BZTCd68EIPlLQyW8+0JI=;
 b=lYICwWLXkb6KIuCOtCeNxC94Mpv+awURFjjLTDby1l56AvO3XNVJ9ZPUbFfjAF9p2X
 S45SrAAKKahrXOK06ABrfx+eRfevDNffJRXLoqfisYRVoP3zqJbdEUgYsA/RfhUf/IVC
 MSkkFNBBaM/9E8IyR0VseY/D0Mw4YkLiihPAbxAp7OYTvYWnaULs/ZfSakx39+pvRpuF
 l0vQcp/AXv9UbEunnTwx5paHHbnMpdndhenU0SY73tWJMDZ753aqXqDDkm58vVXyB1q0
 L3ioQDMxCdFz3K35X7ytJ1L08cgoZ/GpaGXCFhLf8ZNSkp2AftFjTpk9bOd5I11CLT9f
 6F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=NzlITaGA47lkkyjFV/anV49BZTCd68EIPlLQyW8+0JI=;
 b=J7G6es6t3ceBcC+WFuMJyKa5lnEHjG5JEIdvTVR1sPZeY9E0Nb8rnHLvBWLSI0KOOe
 Rg53VAaFmjKKfP2CGEJADSo507JksziPJH8sq7puwSwyQbpCcUlNijteYl0QBeAgHODB
 M3zLY2V1txusTmnAgLCstENZkxk0H30nv2H4UOR+r/vO9HLqqTt2KL71KK1y2snOJQAi
 cNtnB6UT8KLjMWWm4cMobgYhb/MOxxEiefCC/nMAjJ4kBMhMW4r2wMSH5g0ggwM5nuSE
 QXDMvfBPi7FR3F6a2SjnM3WOCu7fTYGcKK/UkMdaOugJcQb2ygr1x5BbnJ9Kq4JRFRjH
 hqcQ==
X-Gm-Message-State: APjAAAUfsZmf/jJDKCgkSUALF1xh8b/RgyquU/nwnNf/hlaPH6iJNeDH
 hd8sZBxry+51p1mOtwbPSzLZxftZb4txjAIm/xP22P1LE9GxEoniIF1IBf9bwUZyNObEgpdlWGp
 yPrubx5B7SzIiTIF1+JaUzlxXx+Y9OFYk1rlvH5juECWX2q4dzgv5tNW/l8Eq
X-Google-Smtp-Source: APXvYqxYHSsbeU/F/VCZ2FQbtYBNwoIuAVa/mgM7yjUhT6a+vWauNqm6sKOJGf05KmNpcuwE2Jv+GLlRKBk=
X-Received: by 2002:a5d:4285:: with SMTP id k5mr3501381wrq.344.1571244148360; 
 Wed, 16 Oct 2019 09:42:28 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:41:44 +0300
In-Reply-To: <20191016164145.115898-1-sameid@google.com>
Message-Id: <20191016164145.115898-9-sameid@google.com>
Mime-Version: 1.0
References: <20191016164145.115898-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v8 7/8] bootdevice: FW_CFG interface for LCHS values
From: Sam Eiderman <sameid@google.com>
To: qemu-devel@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, kevin@koconnor.net, 
 kraxel@redhat.com, kwolf@redhat.com, liran.alon@oracle.com, 
 qemu-block@nongnu.org, sameid@google.com, seabios@seabios.org, 
 lersek@redhat.com, philmd@redhat.com, jsnow@redhat.com, 
 Sam Eiderman <shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::44a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Using fw_cfg, supply logical CHS values directly from QEMU to the BIOS.

Non-standard logical geometries break under QEMU.

A virtual disk which contains an operating system which depends on
logical geometries (consistent values being reported from BIOS INT13
AH=3D08) will most likely break under QEMU/SeaBIOS if it has non-standard
logical geometries - for example 56 SPT (sectors per track).
No matter what QEMU will report - SeaBIOS, for large enough disks - will
use LBA translation, which will report 63 SPT instead.

In addition we cannot force SeaBIOS to rely on physical geometries at
all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
report more than 16 physical heads when moved to an IDE controller,
since the ATA spec allows a maximum of 16 heads - this is an artifact of
virtualization.

By supplying the logical geometries directly we are able to support such
"exotic" disks.

We serialize this information in a similar way to the "bootorder"
interface.
The new fw_cfg entry is "bios-geometry".

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
---
 bootdevice.c            | 31 +++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c       | 14 +++++++++++---
 include/sysemu/sysemu.h |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index 2cf6b37c57..03aaffcc8d 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -405,3 +405,34 @@ void del_boot_device_lchs(DeviceState *dev, const char=
 *suffix)
         }
     }
 }
+
+char *get_boot_devices_lchs_list(size_t *size)
+{
+    FWLCHSEntry *i;
+    size_t total =3D 0;
+    char *list =3D NULL;
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        char *bootpath;
+        char *chs_string;
+        size_t len;
+
+        bootpath =3D get_boot_device_path(i->dev, false, i->suffix);
+        chs_string =3D g_strdup_printf("%s %" PRIu32 " %" PRIu32 " %" PRIu=
32,
+                                     bootpath, i->lcyls, i->lheads, i->lse=
cs);
+
+        if (total) {
+            list[total - 1] =3D '\n';
+        }
+        len =3D strlen(chs_string) + 1;
+        list =3D g_realloc(list, total + len);
+        memcpy(&list[total], chs_string, len);
+        total +=3D len;
+        g_free(chs_string);
+        g_free(bootpath);
+    }
+
+    *size =3D total;
+
+    return list;
+}
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7dc3ac378e..18aff658c0 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *f=
ilename,
=20
 static void fw_cfg_machine_reset(void *opaque)
 {
+    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
+    FWCfgState *s =3D opaque;
     void *ptr;
     size_t len;
-    FWCfgState *s =3D opaque;
-    char *bootindex =3D get_boot_devices_list(&len);
+    char *buf;
=20
-    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
+    buf =3D get_boot_devices_list(&len);
+    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
     g_free(ptr);
+
+    if (!mc->legacy_fw_cfg_order) {
+        buf =3D get_boot_devices_lchs_list(&len);
+        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf, len=
);
+        g_free(ptr);
+    }
 }
=20
 static void fw_cfg_machine_ready(struct Notifier *n, void *data)
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5bc5c79cbc..80c57fdc4e 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices, Error **=
errp);
 void add_boot_device_lchs(DeviceState *dev, const char *suffix,
                           uint32_t lcyls, uint32_t lheads, uint32_t lsecs)=
;
 void del_boot_device_lchs(DeviceState *dev, const char *suffix);
+char *get_boot_devices_lchs_list(size_t *size);
=20
 /* handler to set the boot_device order for a specific type of MachineClas=
s */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
--=20
2.23.0.700.g56cf767bdb-goog


