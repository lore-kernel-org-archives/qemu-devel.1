Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A3C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985F6206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="durJYdeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985F6206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpGw-0002Qg-PX
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBW-0008Qd-Jv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBV-0003DR-BF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBV-0003C0-6P
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNscj4znfEFoxUyR2eitCsjwBW0o2g2YBibwWrrvxzw=;
 b=durJYdeUM0TRBu/gX3dQnZSfpWgVA+KuxLKRqqPerXzuBOLEUxtuNfXI7+XyZTlqzTIwKD
 Et6XJYdkmn/j6YqAigDT3MweTAl9SyC11/A/CUQcgU5QOA+prrPXKiR3KN1CdmkpbzE/pE
 4tLDuq6DiH6Vy2reIh7qsYa+1V1kL/Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-vw2RxISwP1yLFu33rPkvnw-1; Fri, 13 Mar 2020 14:37:23 -0400
X-MC-Unique: vw2RxISwP1yLFu33rPkvnw-1
Received: by mail-wr1-f71.google.com with SMTP id x14so4684216wrv.23
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UFdvn7QNDrVxUqibYwnc6bH6F2vFCMCHuZOu+Zd/Cpc=;
 b=RyPOiAlnsIMq2rFilZ1cL6TT3PFeCU2+9y/XHoenfP1d1PRV3rbsdrUOtab4rkxbuG
 0LgA6KzOA9H7FWAz7zgQ46wYdhYR1wOSmKIGJb4cEsvREvHp7YmubPYdu3eZ4JTV/e50
 a3YhsB9wsC9CEMn3LRSN+T2fONzYl758I1m6sx5lVx1EDPfTT6yUSqludpWZTMfvA/A2
 4qW+6IbKCctqGRvqunqfMIZB0aBJVYGnlnY6nQVtufvo9OYqxrWZ2saIuDI769mhC+cL
 O4qn5F+o+YAirx0O7IInT7H4R1ff/kwUN6p1IzggjU9okijhYzFSTheS0eSJ0e0GMDuy
 hk5g==
X-Gm-Message-State: ANhLgQ0Lte3xoUt4sIfxysUGYoq+393cU36xgLRLmzo7jsxiDcTewLeL
 MZ3N8o40ejteslSmj0TadVPSkB8m2xCB7D17wZtE+/U02YxpIntNBBWBoZDE7XpTE2Ynw7Tqh3n
 8q6Q/wW+vrP5R/Ls=
X-Received: by 2002:adf:ef92:: with SMTP id d18mr18557122wro.193.1584124641899; 
 Fri, 13 Mar 2020 11:37:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtYmL5ub8rSmVi8dir3DAkQWGyPCni3RmNUQh9poMuQNlUlVUmlvaOCY/piDuFUDxUIHX22Mg==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr18557095wro.193.1584124641662; 
 Fri, 13 Mar 2020 11:37:21 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id n2sm12942644wrr.62.2020.03.13.11.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/14] stubs/Makefile: Reduce the user-mode object list
Date: Fri, 13 Mar 2020 19:36:43 +0100
Message-Id: <20200313183652.10258-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These stubs are not required when configured with --disable-system.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 stubs/Makefile.objs | 52 ++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed..5ffa085c67 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,46 +1,54 @@
-stub-obj-y +=3D arch_type.o
-stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
-stub-obj-y +=3D blockdev-close-all-bdrv-states.o
-stub-obj-y +=3D clock-warp.o
 stub-obj-y +=3D cpu-get-clock.o
 stub-obj-y +=3D cpu-get-icount.o
 stub-obj-y +=3D dump.o
 stub-obj-y +=3D error-printf.o
 stub-obj-y +=3D fdset.o
 stub-obj-y +=3D gdbstub.o
-stub-obj-y +=3D get-vm-name.o
-stub-obj-y +=3D iothread.o
 stub-obj-y +=3D iothread-lock.o
 stub-obj-y +=3D is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
-stub-obj-y +=3D machine-init-done.o
-stub-obj-y +=3D migr-blocker.o
-stub-obj-y +=3D change-state-handler.o
-stub-obj-y +=3D monitor.o
 stub-obj-y +=3D monitor-core.o
 stub-obj-y +=3D notify-event.o
+stub-obj-y +=3D qmp_memory_device.o
 stub-obj-y +=3D qtest.o
+stub-obj-y +=3D ramfb.o
 stub-obj-y +=3D replay.o
-stub-obj-y +=3D replay-user.o
 stub-obj-y +=3D runstate-check.o
+stub-obj-$(CONFIG_SOFTMMU) +=3D semihost.o
 stub-obj-y +=3D set-fd-handler.o
+stub-obj-y +=3D vmgenid.o
 stub-obj-y +=3D sysbus.o
 stub-obj-y +=3D tpm.o
 stub-obj-y +=3D trace-control.o
-stub-obj-y +=3D uuid.o
-stub-obj-y +=3D vm-stop.o
 stub-obj-y +=3D vmstate.o
+
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
+stub-obj-y +=3D arch_type.o
+stub-obj-y +=3D bdrv-next-monitor-owned.o
+stub-obj-y +=3D blockdev-close-all-bdrv-states.o
+stub-obj-y +=3D change-state-handler.o
+stub-obj-y +=3D clock-warp.o
 stub-obj-y +=3D fd-register.o
-stub-obj-y +=3D qmp_memory_device.o
-stub-obj-y +=3D target-monitor-defs.o
-stub-obj-y +=3D target-get-monitor-def.o
-stub-obj-y +=3D vmgenid.o
-stub-obj-y +=3D xen-common.o
-stub-obj-y +=3D xen-hvm.o
+stub-obj-y +=3D fw_cfg.o
+stub-obj-y +=3D get-vm-name.o
+stub-obj-y +=3D iothread.o
+stub-obj-y +=3D machine-init-done.o
+stub-obj-y +=3D migr-blocker.o
+stub-obj-y +=3D monitor.o
 stub-obj-y +=3D pci-host-piix.o
 stub-obj-y +=3D ram-block.o
-stub-obj-y +=3D ramfb.o
-stub-obj-y +=3D fw_cfg.o
-stub-obj-$(CONFIG_SOFTMMU) +=3D semihost.o
+stub-obj-y +=3D replay-user.o
+stub-obj-y +=3D target-get-monitor-def.o
+stub-obj-y +=3D target-monitor-defs.o
+stub-obj-y +=3D uuid.o
+stub-obj-y +=3D vm-stop.o
+stub-obj-y +=3D xen-common.o
+stub-obj-y +=3D xen-hvm.o
+
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
--=20
2.21.1


