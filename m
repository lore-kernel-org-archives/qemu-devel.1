Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87828C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB2A2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRtIH1HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB2A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtzmT-0003UW-HU
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 16:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtzlZ-0002Hy-PE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 16:37:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtzlX-00059F-CV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 16:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594413422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=8qlGmGrgHANwfMvpo6+UtQCStftgDKpMZzRk3Hfn5U0=;
 b=TRtIH1HL0P7lzQYOQKT8iDu9ag3iZOkAC6HanR81Clqgkq8r7u7IRfxfFp6cv+3k2ipJqF
 GKplxp0FmJEw+sF5IzvuVGVwx4Is974U959sT4C3tnGDNAeOYyFvkCWN3eZzY+AXTinLIg
 XFPEQQOlvwu6Iwkya4hxwudn6ucQUuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-h9LMx_KqOuqu02HeEBmO4w-1; Fri, 10 Jul 2020 16:36:57 -0400
X-MC-Unique: h9LMx_KqOuqu02HeEBmO4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C61B100A691;
 Fri, 10 Jul 2020 20:36:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4792874F50;
 Fri, 10 Jul 2020 20:36:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 92F2B17510; Fri, 10 Jul 2020 22:36:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] Revert "vga: build virtio-gpu as module"
Date: Fri, 10 Jul 2020 22:36:52 +0200
Message-Id: <20200710203652.9708-3-kraxel@redhat.com>
In-Reply-To: <20200710203652.9708-1-kraxel@redhat.com>
References: <20200710203652.9708-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 15:06:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 8d5a24c83dba90b08ef163bbf166d6dfbad9019b.

Compiling all virtio-gpu objects into a single module isn't a good plan
because the individual objects have different CONFIG_* dependencies.
Leads to module load failures on s390x due to vga support being
disabled, which in turn breaks '-device virtio-gpu-device' (flagged by
travis ci).

So back to the drawing board for modular virtio-gpu ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/module.c            |  6 ------
 hw/display/Makefile.objs | 23 ++++++++++-------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/util/module.c b/util/module.c
index 32b0547b8266..90e9bd42c6c7 100644
--- a/util/module.c
+++ b/util/module.c
@@ -266,12 +266,6 @@ static struct {
     { "usb-redir",             "hw-", "usb-redirect"          },
     { "qxl-vga",               "hw-", "display-qxl"           },
     { "qxl",                   "hw-", "display-qxl"           },
-    { "virtio-gpu-device",     "hw-", "display-virtio-gpu"    },
-    { "virtio-gpu-pci",        "hw-", "display-virtio-gpu"    },
-    { "virtio-vga",            "hw-", "display-virtio-gpu"    },
-    { "vhost-user-gpu-device", "hw-", "display-virtio-gpu"    },
-    { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu"    },
-    { "vhost-user-vga",        "hw-", "display-virtio-gpu"    },
     { "chardev-braille",       "chardev-", "baum"             },
 };
 
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index e907f3182b0c..d619594ad4d3 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -49,19 +49,16 @@ common-obj-m += qxl.mo
 qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
 endif
 
-ifeq ($(CONFIG_VIRTIO_GPU),y)
-common-obj-m += virtio-gpu.mo
-virtio-gpu-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
-virtio-gpu-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
-virtio-gpu-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
-virtio-gpu-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
-virtio-gpu-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
-virtio-gpu-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
-virtio-gpu.mo-objs := $(virtio-gpu-obj-y)
-virtio-gpu.mo-cflags := $(VIRGL_CFLAGS)
-virtio-gpu.mo-libs := $(VIRGL_LIBS)
-endif
-
+common-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
+common-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
+common-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
+common-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
+common-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
+common-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
+virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
+virtio-gpu.o-libs += $(VIRGL_LIBS)
+virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
+virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
 common-obj-$(CONFIG_DPCD) += dpcd.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
 
-- 
2.18.4


