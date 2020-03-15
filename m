Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB9C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9E3205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGG5lCrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9E3205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdRk-0000ym-7N
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd8p-0003RO-5Z
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8n-0000ov-UN
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8n-0000nN-Qc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l17us6jq1pYPOTfaYknNGXyL5N8ZYJP1n+BYX9B9Fwo=;
 b=gGG5lCrfg5/qlNEjwZVVeGvAUCZvk+OjiBEjHm9bKVWZbjPtymSV2yOVxzg40ludaLdKjJ
 CTswWZQoynJD5XDqudSnB1vvpm0QogHedxasv4tgUVf8kRgPMuNPTN3ld7E/50aBvqBV9S
 bbuZ0VUUQdNAJjmsv7S0RST0r/rVxkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-pFw_e8jXM5aqj2t32iDm3Q-1; Sun, 15 Mar 2020 19:57:53 -0400
X-MC-Unique: pFw_e8jXM5aqj2t32iDm3Q-1
Received: by mail-wr1-f70.google.com with SMTP id 94so3445674wrr.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YcKpL0Ym79XPzehk7z5gkhNURpeUg+HAgROgl8wu0Aw=;
 b=iUHEu6Ju2g+zgxKnr3aTe8a6UW5XO/uVzhxohtfznLr3xDkAqK3ccrv65K5C2MYJrh
 sYX/bk4c15B2Q2Vnqli0um3l6JqKuRd/vmRY8J8Py15vi5Gr+rGIS4XGCxgCA+8DkXe3
 HSO5F5aHKF+nneFgnajky2pC9soEguQAn8Wvw49o9di5J7MXZnzi2Sxu6EgYmrJggEjp
 Mz1+dLH7awzl6ubiUjIdoYPulqZ5ajQIdoLdDwj5vxXuw1A9Vu5nWQaRKwpVHgR0wE35
 dCN43C0XtO0TU4RQXo0mvYX1QhVxxp/BgiCcTG499BgSeC9rVZe0iN3Vcx+E3rS1GnEX
 96JA==
X-Gm-Message-State: ANhLgQ2zHIMjQ+OovVHuPg+1KlvcZxVUeeMs1R/NX9R8HWlTCQbp46T5
 Doo+tfPBIPmEybAWgJi0iuG4bAsX8h5izpfQledrVAw0QFn3wfBAPetUbUag9LWAzv1DBuSWLtV
 fnBM3jdtysaM2Zk0=
X-Received: by 2002:a7b:c148:: with SMTP id z8mr23479613wmi.174.1584316672441; 
 Sun, 15 Mar 2020 16:57:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu/11BS5Cv2KcCOfYg2Ppwwqj08Jgrf72nj8l1kJ3EXjBhC5oI7MoQ+pDxloAapX5wQaweKLA==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr23479596wmi.174.1584316672266; 
 Sun, 15 Mar 2020 16:57:52 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id s22sm25921427wmc.16.2020.03.15.16.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:57:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] stubs/Makefile: Reduce the user-mode object list
Date: Mon, 16 Mar 2020 00:57:10 +0100
Message-Id: <20200315235716.28448-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These stubs are not required when configured with --disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


