Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8ABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 02:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0D122B48
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 02:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBwf0JhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0D122B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ykY-0008Tx-04
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 22:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.n.huhn@gmail.com>)
 id 1k0yjm-0007bT-K8
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 22:56:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif.n.huhn@gmail.com>)
 id 1k0yjk-00012k-KI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 22:56:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id a5so13459249wrm.6
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nl6raLUsbNq3/9uvbS2S/bPVJiFmOEgFqwV3lRZxT4c=;
 b=PBwf0JhF/iwSns876kYTnSQo9ZfA7fk/RPaiRsyCYhqzWGTpOslcJK02zI2gXFTc/U
 v+1f7D5eeBjm+MQ+BWKIHg1Ltmz1NhVZ6UKbAIfJH+5dsmXfU5ak0zGDHqVPvt1T+PWw
 wIKR519BMWt+nsh61EYGcOVEJUXVatjo+8mJKGvWlqze4CIPVdsaPevgrBv/RO7DW+Y7
 HnFfFKzhULTKZErW9FP4HAMMo9waG5/0QdgA49xPvTTkXv+0mROXXW13yHxKg+tEQLUk
 66jEPxFKa9L11ALRCZaGmOLQguWfXKg7X/k/mwmLTI9xjoj14mJQCgnxpdxYvOJCrpxz
 w4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nl6raLUsbNq3/9uvbS2S/bPVJiFmOEgFqwV3lRZxT4c=;
 b=nMxgw1av3EXCP/BgDM8ECcjIGSB67Gawe29CtwuwJYwxTDRPdUaxTc22+gTY/hpnA7
 wEbIXjlj2QuUmA47HnfFj0n/edzd58LqnQCtyfqWvcgrW1HfbfXDrR6UazKKdH7eXpjf
 OowaoEv1FGoZeao/z+KAZrKIlBA0v+tiuJTYuoe7Q29EEcRdK/NzPOIRyhLshZdU49xC
 aSKEHZNKmJA38HZWNUrHUPm7pcZgOElwtkpLrT3agTQWgcUywEtlscioYZAAD9lDUUs8
 s1gdbd3igY1SvwiCdVEt+j9oW7jkXBQYZzA3QQkc2DqA3aXVHKXSh2nfSWIxoaazoUSV
 pyGA==
X-Gm-Message-State: AOAM530S8v/HQ1B6Ddz0r/63f5MGem3XTfwJxAXvc6Zr3now2WJ4hGJL
 ZMC2XmVuGpt07vvDB36ICfEQUR3g
X-Google-Smtp-Source: ABdhPJxp4oTW/TJ7TI5RhhYUmdZchjbEWwGnkdqZqy80eh2SU+FSwKK7Oed0esIo0CbKSq91TPkXuA==
X-Received: by 2002:adf:e382:: with SMTP id e2mr614479wrm.306.1596077761934;
 Wed, 29 Jul 2020 19:56:01 -0700 (PDT)
Received: from lhuhn.localdomain
 (24-148-42-188.s4794.c3-0.grn-cbr1.chi-grn.il.cable.rcncustomer.com.
 [24.148.42.188])
 by smtp.gmail.com with ESMTPSA id p25sm6958025wma.39.2020.07.29.19.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 19:56:01 -0700 (PDT)
From: Leif N Huhn <leif.n.huhn@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] linux-user: Add support for SG_IO and SG_GET_VERSION_NUM
 raw SCSI ioctls
Date: Wed, 29 Jul 2020 21:55:48 -0500
Message-Id: <20200730025548.237905-2-leif.n.huhn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730025548.237905-1-leif.n.huhn@gmail.com>
References: <20200730025548.237905-1-leif.n.huhn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=leif.n.huhn@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Leif N Huhn <leif.n.huhn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionalities of following ioctls:

SG_GET_VERSION_NUM - Returns SG driver version number

    The sg version numbers are of the form "x.y.z" and the single number given
    by the SG_GET_VERSION_NUM ioctl() is calculated by
    (x * 10000 + y * 100 + z).

SG_IO - Permits user applications to send SCSI commands to a device

    It is logically equivalent to a write followed by a read.

Implementation notes:

    For SG_GET_VERSION_NUM the value is an int and the implementation is
    straightforward.

    For SG_IO, the generic thunk mechanism is used, and works correctly when
    the host and guest architecture have the same pointer size. A special ioctl
    handler may be needed in other situations and is not covered in this
    implementation.

Signed-off-by: Leif N Huhn <leif.n.huhn@gmail.com>
---
 linux-user/ioctls.h        |  2 ++
 linux-user/syscall.c       |  1 +
 linux-user/syscall_defs.h  | 33 +++++++++++++++++++++++++++++++++
 linux-user/syscall_types.h |  5 +++++
 4 files changed, 41 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0713ae1311..92e2f65e05 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -333,6 +333,8 @@
   IOCTL(CDROM_DRIVE_STATUS, 0, TYPE_NULL)
   IOCTL(CDROM_DISC_STATUS, 0, TYPE_NULL)
   IOCTL(CDROMAUDIOBUFSIZ, 0, TYPE_INT)
+  IOCTL(SG_GET_VERSION_NUM, 0, TYPE_INT)
+  IOCTL(SG_IO, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_sg_io_hdr)))
 
 #if 0
   IOCTL(SNDCTL_COPR_HALT, IOC_RW, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 945fc25279..d846ef1af2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -115,6 +115,7 @@
 #ifdef HAVE_DRM_H
 #include <libdrm/drm.h>
 #endif
+#include <scsi/sg.h>
 #include "linux_loop.h"
 #include "uname.h"
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..0e3004eb31 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2774,4 +2774,37 @@ struct target_statx {
    /* 0x100 */
 };
 
+/* from kernel's include/scsi/sg.h */
+
+#define TARGET_SG_GET_VERSION_NUM 0x2282 /* Example: version 2.1.34 yields 20134 */
+/* synchronous SCSI command ioctl, (only in version 3 interface) */
+#define TARGET_SG_IO 0x2285   /* similar effect as write() followed by read() */
+
+struct target_sg_io_hdr
+{
+    int interface_id;           /* [i] 'S' for SCSI generic (required) */
+    int dxfer_direction;        /* [i] data transfer direction  */
+    unsigned char cmd_len;      /* [i] SCSI command length */
+    unsigned char mx_sb_len;    /* [i] max length to write to sbp */
+    unsigned short iovec_count; /* [i] 0 implies no scatter gather */
+    unsigned int dxfer_len;     /* [i] byte count of data transfer */
+    abi_ulong    dxferp;	/* [i], [*io] points to data transfer memory
+					      or scatter gather list */
+    abi_ulong    cmdp;          /* [i], [*i] points to command to perform */
+    abi_ulong    sbp;		/* [i], [*o] points to sense_buffer memory */
+    unsigned int timeout;       /* [i] MAX_UINT->no timeout (unit: millisec) */
+    unsigned int flags;         /* [i] 0 -> default, see SG_FLAG... */
+    int pack_id;                /* [i->o] unused internally (normally) */
+    abi_ulong     usr_ptr;      /* [i->o] unused internally */
+    unsigned char status;       /* [o] scsi status */
+    unsigned char masked_status;/* [o] shifted, masked scsi status */
+    unsigned char msg_status;   /* [o] messaging level data (optional) */
+    unsigned char sb_len_wr;    /* [o] byte count actually written to sbp */
+    unsigned short host_status; /* [o] errors from host adapter */
+    unsigned short driver_status;/* [o] errors from software driver */
+    int resid;                  /* [o] dxfer_len - actual_transferred */
+    unsigned int duration;      /* [o] time taken by cmd (unit: millisec) */
+    unsigned int info;          /* [o] auxiliary information */
+};  /* 64 bytes long (on i386) */
+
 #endif
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 3f1f033464..3752d217e2 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -59,6 +59,11 @@ STRUCT(cdrom_read_audio,
        TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_INT, TYPE_PTRVOID,
        TYPE_NULL)
 
+STRUCT(sg_io_hdr,
+       TYPE_INT, TYPE_INT, TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_INT, TYPE_PTRVOID,
+       TYPE_PTRVOID, TYPE_PTRVOID, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_PTRVOID, TYPE_CHAR,
+       TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_SHORT, TYPE_INT, TYPE_INT, TYPE_INT)
+
 STRUCT(hd_geometry,
        TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_ULONG)
 
-- 
2.28.0


