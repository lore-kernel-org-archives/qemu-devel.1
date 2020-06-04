Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C049BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F562075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn/IP+gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F562075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgzSf-0006in-Q6
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 19:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgzPM-00034V-Pj
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 19:36:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:33513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgzPK-0005Cr-6w
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 19:36:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id t7so2846028plr.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q+RHqwELKYiFCK7HwXAH6upz4i9V56bsJoBxoQYrIkE=;
 b=Mn/IP+gIKNVDXWcSIK2M0v5f9zWl0jsdNTnIskuSLzGhnWDogFGTgVSX6vaRbyoPaC
 j5gVbKz5Hgm2stt4WkeByIFeiiCQLZD+mp6pszgdd8l5cIe5xE7WR0M/8ug4GdQ99LYA
 WnV2FXkJ3LjYgtJFV9TIORB6dMmFzg28GHK9O/VVCUGouJ16szB2E+n0Il0/nj6wd+mh
 3xWS2xD2Kpb5KqlzqIincT7ARzDvkIIofic9bFo2BWIb8o5Zx5wPlO1Ir9lshgJPWlXs
 vCXVmu7/tacBqyMOWNGf/j4znCdRimadrv5NZjcOzaIXIeau9NgXp/+52Z/sGaVEkb2h
 WUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q+RHqwELKYiFCK7HwXAH6upz4i9V56bsJoBxoQYrIkE=;
 b=h5DapAUJ7zIF8dgKZVPE4iCY2tQL1g02S3BFFgDUADbGr+qNR2pOpKNox50SHuYsiz
 rp0Qoqa0EObqRlgyu9F+4s809TdMsmAS883klKScl3QqeHtT4wKzGBJ/CZS2pSlXYIcv
 UkllISamybFz+6MHZrw6TKfeFRUG2DX944MElZSnYtuzoh5jRKzeGB7UyQMKtDW9vAPl
 v/U6yE99wu7oHIEQ+lIEiQCA9WYrKlQw9O1b6aRfnweb72m8KdQOIvBbGEz4iZd83ViB
 jWE0scCRXy8je5XzuM4/66S/z2LwifMnQlctqa6td51BusFSNCOpe8z16U7uSzutq2W9
 Nb1g==
X-Gm-Message-State: AOAM530PsaLoLRjwJs7S9wGBf0ldZyNY0MX+DMeeRbOCngCQLbYHu4lp
 gYEZkAbxOrAprxR6+KpHyTi1lQ4Qc0CZQBbA
X-Google-Smtp-Source: ABdhPJwguWJKG1Zy99wxg+mODN6IQFyA1iwtXDt2FsbO08EcRoRA8oCyaN9hvnGOQBrgWBD01R+Zxw==
X-Received: by 2002:a17:90a:970c:: with SMTP id
 x12mr8559841pjo.15.1591313779939; 
 Thu, 04 Jun 2020 16:36:19 -0700 (PDT)
Received: from localhost (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net.
 [2001:470:35:3d5::2])
 by smtp.gmail.com with ESMTPSA id e143sm5421144pfh.42.2020.06.04.16.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 16:36:19 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 4/4] new qTest case to test the vhost-user-blk-server
Date: Fri,  5 Jun 2020 07:35:38 +0800
Message-Id: <20200604233538.256325-5-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604233538.256325-1-coiby.xu@gmail.com>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test case has the same tests as tests/virtio-blk-test.c except for
tests have block_resize. Since vhost-user server can only server one
client one time, two instances of qemu-storage-daemon are launched
for the hotplug test.

In order to not block scripts/tap-driver.pl, vhost-user-blk-server will
send "quit" command to qemu-storage-daemon's QMP monitor. So a function
is added to libqtest.c to establish socket connection with socket
server.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 tests/Makefile.include              |   3 +-
 tests/qtest/Makefile.include        |   2 +
 tests/qtest/libqos/vhost-user-blk.c | 130 +++++
 tests/qtest/libqos/vhost-user-blk.h |  44 ++
 tests/qtest/libqtest.c              |  54 +-
 tests/qtest/libqtest.h              |  38 ++
 tests/qtest/vhost-user-blk-test.c   | 737 ++++++++++++++++++++++++++++
 7 files changed, 976 insertions(+), 32 deletions(-)
 create mode 100644 tests/qtest/libqos/vhost-user-blk.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.h
 create mode 100644 tests/qtest/vhost-user-blk-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6e3d6370df..d8578346b0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -636,7 +636,8 @@ endef
 $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(check-qtest-y)
 	$(call do_test_human,$(check-qtest-$*-y:%=tests/qtest/%$(EXESUF)) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)), \
 	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
-	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
+	  QTEST_QEMU_IMG=./qemu-img$(EXESUF) \
+	  QTEST_QEMU_STORAGE_DAEMON_BINARY=./qemu-storage-daemon$(EXESUF))
 
 check-unit: $(check-unit-y)
 	$(call do_test_human, $^)
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 9e5a51d033..b6f081cb26 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -186,6 +186,7 @@ libqos-obj-y += tests/qtest/libqos/virtio.o
 libqos-obj-$(CONFIG_VIRTFS) += tests/qtest/libqos/virtio-9p.o
 libqos-obj-y += tests/qtest/libqos/virtio-balloon.o
 libqos-obj-y += tests/qtest/libqos/virtio-blk.o
+libqos-obj-$(CONFIG_LINUX) += tests/qtest/libqos/vhost-user-blk.o
 libqos-obj-y += tests/qtest/libqos/virtio-mmio.o
 libqos-obj-y += tests/qtest/libqos/virtio-net.o
 libqos-obj-y += tests/qtest/libqos/virtio-pci.o
@@ -230,6 +231,7 @@ qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/qtest/vhost-user-test.o $(chardev
 qos-test-obj-y += tests/qtest/virtio-test.o
 qos-test-obj-$(CONFIG_VIRTFS) += tests/qtest/virtio-9p-test.o
 qos-test-obj-y += tests/qtest/virtio-blk-test.o
+qos-test-obj-$(CONFIG_LINUX) += tests/qtest/vhost-user-blk-test.o
 qos-test-obj-y += tests/qtest/virtio-net-test.o
 qos-test-obj-y += tests/qtest/virtio-rng-test.o
 qos-test-obj-y += tests/qtest/virtio-scsi-test.o
diff --git a/tests/qtest/libqos/vhost-user-blk.c b/tests/qtest/libqos/vhost-user-blk.c
new file mode 100644
index 0000000000..3de9c59194
--- /dev/null
+++ b/tests/qtest/libqos/vhost-user-blk.c
@@ -0,0 +1,130 @@
+/*
+ * libqos driver framework
+ *
+ * Based on tests/qtest/libqos/virtio-blk.c
+ *
+ * Copyright (c) 2020 Coiby Xu <coiby.xu@gmail.com>
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2.1 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "standard-headers/linux/virtio_blk.h"
+#include "libqos/qgraph.h"
+#include "libqos/vhost-user-blk.h"
+
+#define PCI_SLOT                0x04
+#define PCI_FN                  0x00
+
+/* virtio-blk-device */
+static void *qvhost_user_blk_get_driver(QVhostUserBlk *v_blk,
+                                    const char *interface)
+{
+    if (!g_strcmp0(interface, "vhost-user-blk")) {
+        return v_blk;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_blk->vdev;
+    }
+
+    fprintf(stderr, "%s not present in vhost-user-blk-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvhost_user_blk_device_get_driver(void *object,
+                                           const char *interface)
+{
+    QVhostUserBlkDevice *v_blk = object;
+    return qvhost_user_blk_get_driver(&v_blk->blk, interface);
+}
+
+static void *vhost_user_blk_device_create(void *virtio_dev,
+                                      QGuestAllocator *t_alloc,
+                                      void *addr)
+{
+    QVhostUserBlkDevice *vhost_user_blk = g_new0(QVhostUserBlkDevice, 1);
+    QVhostUserBlk *interface = &vhost_user_blk->blk;
+
+    interface->vdev = virtio_dev;
+
+    vhost_user_blk->obj.get_driver = qvhost_user_blk_device_get_driver;
+
+    return &vhost_user_blk->obj;
+}
+
+/* virtio-blk-pci */
+static void *qvhost_user_blk_pci_get_driver(void *object, const char *interface)
+{
+    QVhostUserBlkPCI *v_blk = object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_blk->pci_vdev.pdev;
+    }
+    return qvhost_user_blk_get_driver(&v_blk->blk, interface);
+}
+
+static void *vhost_user_blk_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                      void *addr)
+{
+    QVhostUserBlkPCI *vhost_user_blk = g_new0(QVhostUserBlkPCI, 1);
+    QVhostUserBlk *interface = &vhost_user_blk->blk;
+    QOSGraphObject *obj = &vhost_user_blk->pci_vdev.obj;
+
+    virtio_pci_init(&vhost_user_blk->pci_vdev, pci_bus, addr);
+    interface->vdev = &vhost_user_blk->pci_vdev.vdev;
+
+    g_assert_cmphex(interface->vdev->device_type, ==, VIRTIO_ID_BLOCK);
+
+    obj->get_driver = qvhost_user_blk_pci_get_driver;
+
+    return obj;
+}
+
+static void vhost_user_blk_register_nodes(void)
+{
+    /*
+     * FIXME: every test using these two nodes needs to setup a
+     * -drive,id=drive0 otherwise QEMU is not going to start.
+     * Therefore, we do not include "produces" edge for virtio
+     * and pci-device yet.
+     */
+
+    char *arg = g_strdup_printf("id=drv0,chardev=char1,addr=%x.%x",
+                                PCI_SLOT, PCI_FN);
+
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(PCI_SLOT, PCI_FN),
+    };
+
+    QOSGraphEdgeOptions opts = { };
+
+    /* virtio-blk-device */
+    /** opts.extra_device_opts = "drive=drive0"; */
+    qos_node_create_driver("vhost-user-blk-device", vhost_user_blk_device_create);
+    qos_node_consumes("vhost-user-blk-device", "virtio-bus", &opts);
+    qos_node_produces("vhost-user-blk-device", "vhost-user-blk");
+
+    /* virtio-blk-pci */
+    opts.extra_device_opts = arg;
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("vhost-user-blk-pci", vhost_user_blk_pci_create);
+    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
+    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
+
+    g_free(arg);
+}
+
+libqos_init(vhost_user_blk_register_nodes);
diff --git a/tests/qtest/libqos/vhost-user-blk.h b/tests/qtest/libqos/vhost-user-blk.h
new file mode 100644
index 0000000000..ef4ef09cca
--- /dev/null
+++ b/tests/qtest/libqos/vhost-user-blk.h
@@ -0,0 +1,44 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#ifndef TESTS_LIBQOS_VHOST_USER_BLK_H
+#define TESTS_LIBQOS_VHOST_USER_BLK_H
+
+#include "libqos/qgraph.h"
+#include "libqos/virtio.h"
+#include "libqos/virtio-pci.h"
+
+typedef struct QVhostUserBlk QVhostUserBlk;
+typedef struct QVhostUserBlkPCI QVhostUserBlkPCI;
+typedef struct QVhostUserBlkDevice QVhostUserBlkDevice;
+
+struct QVhostUserBlk {
+    QVirtioDevice *vdev;
+};
+
+struct QVhostUserBlkPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVhostUserBlk blk;
+};
+
+struct QVhostUserBlkDevice {
+    QOSGraphObject obj;
+    QVhostUserBlk blk;
+};
+
+#endif
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 49075b55a1..a7b7c96206 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -31,40 +31,9 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 
-#define MAX_IRQ 256
 #define SOCKET_TIMEOUT 50
 #define SOCKET_MAX_FDS 16
 
-
-typedef void (*QTestSendFn)(QTestState *s, const char *buf);
-typedef void (*ExternalSendFn)(void *s, const char *buf);
-typedef GString* (*QTestRecvFn)(QTestState *);
-
-typedef struct QTestClientTransportOps {
-    QTestSendFn     send;      /* for sending qtest commands */
-
-    /*
-     * use external_send to send qtest command strings through functions which
-     * do not accept a QTestState as the first parameter.
-     */
-    ExternalSendFn  external_send;
-
-    QTestRecvFn     recv_line; /* for receiving qtest command responses */
-} QTestTransportOps;
-
-struct QTestState
-{
-    int fd;
-    int qmp_fd;
-    pid_t qemu_pid;  /* our child QEMU process */
-    int wstatus;
-    int expected_status;
-    bool big_endian;
-    bool irq_level[MAX_IRQ];
-    GString *rx;
-    QTestTransportOps ops;
-};
-
 static GHookList abrt_hooks;
 static struct sigaction sigact_old;
 
@@ -101,6 +70,29 @@ static int init_socket(const char *socket_path)
     return sock;
 }
 
+int qtest_socket_client(char *server_socket_path)
+{
+    struct sockaddr_un serv_addr;
+    int sock;
+    int ret;
+    int retries = 0;
+    sock = socket(PF_UNIX, SOCK_STREAM, 0);
+    g_assert_cmpint(sock, !=, -1);
+    serv_addr.sun_family = AF_UNIX;
+    snprintf(serv_addr.sun_path, sizeof(serv_addr.sun_path), "%s", server_socket_path);
+
+    do {
+        ret = connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
+        if (ret == 0) {
+            break;
+        }
+        retries += 1;
+        g_usleep(G_USEC_PER_SEC);
+    } while (retries < 3);
+
+    g_assert_cmpint(ret, ==, 0);
+    return sock;
+}
 static int socket_accept(int sock)
 {
     struct sockaddr_un addr;
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f5cf93c386..a6774d8781 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -20,8 +20,38 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
 
+#define MAX_IRQ 256
+
 typedef struct QTestState QTestState;
 
+typedef void (*QTestSendFn)(QTestState *s, const char *buf);
+typedef void (*ExternalSendFn)(void *s, const char *buf);
+typedef GString* (*QTestRecvFn)(QTestState *);
+
+typedef struct QTestClientTransportOps {
+    QTestSendFn     send;      /* for sending qtest commands */
+
+    /*
+     * use external_send to send qtest command strings through functions which
+     * do not accept a QTestState as the first parameter.
+     */
+    ExternalSendFn  external_send;
+
+    QTestRecvFn     recv_line; /* for receiving qtest command responses */
+} QTestTransportOps;
+
+struct QTestState {
+    int fd;
+    int qmp_fd;
+    pid_t qemu_pid;  /* our child QEMU process */
+    int wstatus;
+    int expected_status;
+    bool big_endian;
+    bool irq_level[MAX_IRQ];
+    GString *rx;
+    QTestTransportOps ops;
+};
+
 /**
  * qtest_initf:
  * @fmt...: Format for creating other arguments to pass to QEMU, formatted
@@ -626,6 +656,14 @@ void qtest_add_data_func_full(const char *str, void *data,
 
 void qtest_add_abrt_handler(GHookFunc fn, const void *data);
 
+/**
+ * qtest_socket_client:
+ * @server_socket_path: the socket server's path
+ *
+ * Connect to a socket server.
+ */
+int qtest_socket_client(char *server_socket_path);
+
 /**
  * qtest_qmp_assert_success:
  * @qts: QTestState instance to operate on
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
new file mode 100644
index 0000000000..07fbe1508f
--- /dev/null
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -0,0 +1,737 @@
+/*
+ * QTest testcase for VirtIO Block Device
+ *
+ * Copyright (c) 2014 SUSE LINUX Products GmbH
+ * Copyright (c) 2014 Marc Marí
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "qemu/bswap.h"
+#include "qemu/module.h"
+#include "standard-headers/linux/virtio_blk.h"
+#include "standard-headers/linux/virtio_pci.h"
+#include "libqos/qgraph.h"
+#include "libqos/vhost-user-blk.h"
+#include "libqos/libqos-pc.h"
+
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
+#define TEST_IMAGE_SIZE         (64 * 1024 * 1024)
+#define QVIRTIO_BLK_TIMEOUT_US  (30 * 1000 * 1000)
+#define PCI_SLOT_HP             0x06
+
+typedef struct QVirtioBlkReq {
+    uint32_t type;
+    uint32_t ioprio;
+    uint64_t sector;
+    char *data;
+    uint8_t status;
+} QVirtioBlkReq;
+
+
+#ifdef HOST_WORDS_BIGENDIAN
+static const bool host_is_big_endian = true;
+#else
+static const bool host_is_big_endian; /* false */
+#endif
+
+static inline void virtio_blk_fix_request(QVirtioDevice *d, QVirtioBlkReq *req)
+{
+    if (qvirtio_is_big_endian(d) != host_is_big_endian) {
+        req->type = bswap32(req->type);
+        req->ioprio = bswap32(req->ioprio);
+        req->sector = bswap64(req->sector);
+    }
+}
+
+
+static inline void virtio_blk_fix_dwz_hdr(QVirtioDevice *d,
+    struct virtio_blk_discard_write_zeroes *dwz_hdr)
+{
+    if (qvirtio_is_big_endian(d) != host_is_big_endian) {
+        dwz_hdr->sector = bswap64(dwz_hdr->sector);
+        dwz_hdr->num_sectors = bswap32(dwz_hdr->num_sectors);
+        dwz_hdr->flags = bswap32(dwz_hdr->flags);
+    }
+}
+
+static uint64_t virtio_blk_request(QGuestAllocator *alloc, QVirtioDevice *d,
+                                   QVirtioBlkReq *req, uint64_t data_size)
+{
+    uint64_t addr;
+    uint8_t status = 0xFF;
+
+    switch (req->type) {
+    case VIRTIO_BLK_T_IN:
+    case VIRTIO_BLK_T_OUT:
+        g_assert_cmpuint(data_size % 512, ==, 0);
+        break;
+    case VIRTIO_BLK_T_DISCARD:
+    case VIRTIO_BLK_T_WRITE_ZEROES:
+        g_assert_cmpuint(data_size %
+                         sizeof(struct virtio_blk_discard_write_zeroes), ==, 0);
+        break;
+    default:
+        g_assert_cmpuint(data_size, ==, 0);
+    }
+
+    addr = guest_alloc(alloc, sizeof(*req) + data_size);
+
+    virtio_blk_fix_request(d, req);
+
+    memwrite(addr, req, 16);
+    memwrite(addr + 16, req->data, data_size);
+    memwrite(addr + 16 + data_size, &status, sizeof(status));
+
+    return addr;
+}
+
+/* Returns the request virtqueue so the caller can perform further tests */
+static QVirtQueue *test_basic(QVirtioDevice *dev, QGuestAllocator *alloc)
+{
+    QVirtioBlkReq req;
+    uint64_t req_addr;
+    uint64_t capacity;
+    uint64_t features;
+    uint32_t free_head;
+    uint8_t status;
+    char *data;
+    QTestState *qts = global_qtest;
+    QVirtQueue *vq;
+
+    features = qvirtio_get_features(dev);
+    features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                    (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                    (1u << VIRTIO_RING_F_EVENT_IDX) |
+                    (1u << VIRTIO_BLK_F_SCSI));
+    qvirtio_set_features(dev, features);
+
+    capacity = qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
+
+    vq = qvirtqueue_setup(dev, alloc, 0);
+
+    qvirtio_set_driver_ok(dev);
+
+    /* Write and read with 3 descriptor layout */
+    /* Write request */
+    req.type = VIRTIO_BLK_T_OUT;
+    req.ioprio = 1;
+    req.sector = 0;
+    req.data = g_malloc0(512);
+    strcpy(req.data, "TEST");
+
+    req_addr = virtio_blk_request(alloc, dev, &req, 512);
+
+    g_free(req.data);
+
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+
+    qvirtqueue_kick(qts, dev, vq, free_head);
+
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
+    status = readb(req_addr + 528);
+    g_assert_cmpint(status, ==, 0);
+
+    guest_free(alloc, req_addr);
+
+    /* Read request */
+    req.type = VIRTIO_BLK_T_IN;
+    req.ioprio = 1;
+    req.sector = 0;
+    req.data = g_malloc0(512);
+
+    req_addr = virtio_blk_request(alloc, dev, &req, 512);
+
+    g_free(req.data);
+
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+
+    qvirtqueue_kick(qts, dev, vq, free_head);
+
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
+    status = readb(req_addr + 528);
+    g_assert_cmpint(status, ==, 0);
+
+    data = g_malloc0(512);
+    memread(req_addr + 16, data, 512);
+    g_assert_cmpstr(data, ==, "TEST");
+    g_free(data);
+
+    guest_free(alloc, req_addr);
+
+    if (features & (1u << VIRTIO_BLK_F_WRITE_ZEROES)) {
+        struct virtio_blk_discard_write_zeroes dwz_hdr;
+        void *expected;
+
+        /*
+         * WRITE_ZEROES request on the same sector of previous test where
+         * we wrote "TEST".
+         */
+        req.type = VIRTIO_BLK_T_WRITE_ZEROES;
+        req.data = (char *) &dwz_hdr;
+        dwz_hdr.sector = 0;
+        dwz_hdr.num_sectors = 1;
+        dwz_hdr.flags = 0;
+
+        virtio_blk_fix_dwz_hdr(dev, &dwz_hdr);
+
+        req_addr = virtio_blk_request(alloc, dev, &req, sizeof(dwz_hdr));
+
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, sizeof(dwz_hdr), false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16 + sizeof(dwz_hdr), 1, true,
+                       false);
+
+        qvirtqueue_kick(qts, dev, vq, free_head);
+
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status = readb(req_addr + 16 + sizeof(dwz_hdr));
+        g_assert_cmpint(status, ==, 0);
+
+        guest_free(alloc, req_addr);
+
+        /* Read request to check if the sector contains all zeroes */
+        req.type = VIRTIO_BLK_T_IN;
+        req.ioprio = 1;
+        req.sector = 0;
+        req.data = g_malloc0(512);
+
+        req_addr = virtio_blk_request(alloc, dev, &req, 512);
+
+        g_free(req.data);
+
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+
+        qvirtqueue_kick(qts, dev, vq, free_head);
+
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status = readb(req_addr + 528);
+        g_assert_cmpint(status, ==, 0);
+
+        data = g_malloc(512);
+        expected = g_malloc0(512);
+        memread(req_addr + 16, data, 512);
+        g_assert_cmpmem(data, 512, expected, 512);
+        g_free(expected);
+        g_free(data);
+
+        guest_free(alloc, req_addr);
+    }
+
+    if (features & (1u << VIRTIO_BLK_F_DISCARD)) {
+        struct virtio_blk_discard_write_zeroes dwz_hdr;
+
+        req.type = VIRTIO_BLK_T_DISCARD;
+        req.data = (char *) &dwz_hdr;
+        dwz_hdr.sector = 0;
+        dwz_hdr.num_sectors = 1;
+        dwz_hdr.flags = 0;
+
+        virtio_blk_fix_dwz_hdr(dev, &dwz_hdr);
+
+        req_addr = virtio_blk_request(alloc, dev, &req, sizeof(dwz_hdr));
+
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, sizeof(dwz_hdr), false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16 + sizeof(dwz_hdr),
+                       1, true, false);
+
+        qvirtqueue_kick(qts, dev, vq, free_head);
+
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status = readb(req_addr + 16 + sizeof(dwz_hdr));
+        g_assert_cmpint(status, ==, 0);
+
+        guest_free(alloc, req_addr);
+    }
+
+    if (features & (1u << VIRTIO_F_ANY_LAYOUT)) {
+        /* Write and read with 2 descriptor layout */
+        /* Write request */
+        req.type = VIRTIO_BLK_T_OUT;
+        req.ioprio = 1;
+        req.sector = 1;
+        req.data = g_malloc0(512);
+        strcpy(req.data, "TEST");
+
+        req_addr = virtio_blk_request(alloc, dev, &req, 512);
+
+        g_free(req.data);
+
+        free_head = qvirtqueue_add(qts, vq, req_addr, 528, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+        qvirtqueue_kick(qts, dev, vq, free_head);
+
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status = readb(req_addr + 528);
+        g_assert_cmpint(status, ==, 0);
+
+        guest_free(alloc, req_addr);
+
+        /* Read request */
+        req.type = VIRTIO_BLK_T_IN;
+        req.ioprio = 1;
+        req.sector = 1;
+        req.data = g_malloc0(512);
+
+        req_addr = virtio_blk_request(alloc, dev, &req, 512);
+
+        g_free(req.data);
+
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, 513, true, false);
+
+        qvirtqueue_kick(qts, dev, vq, free_head);
+
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status = readb(req_addr + 528);
+        g_assert_cmpint(status, ==, 0);
+
+        data = g_malloc0(512);
+        memread(req_addr + 16, data, 512);
+        g_assert_cmpstr(data, ==, "TEST");
+        g_free(data);
+
+        guest_free(alloc, req_addr);
+    }
+
+    return vq;
+}
+
+static void basic(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVhostUserBlk *blk_if = obj;
+    QVirtQueue *vq;
+
+    vq = test_basic(blk_if->vdev, t_alloc);
+    qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
+
+}
+
+static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
+{
+    QVirtQueue *vq;
+    QVhostUserBlk *blk_if = obj;
+    QVirtioDevice *dev = blk_if->vdev;
+    QVirtioBlkReq req;
+    QVRingIndirectDesc *indirect;
+    uint64_t req_addr;
+    uint64_t capacity;
+    uint64_t features;
+    uint32_t free_head;
+    uint8_t status;
+    char *data;
+    QTestState *qts = global_qtest;
+
+    features = qvirtio_get_features(dev);
+    g_assert_cmphex(features & (1u << VIRTIO_RING_F_INDIRECT_DESC), !=, 0);
+    features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_EVENT_IDX) |
+                            (1u << VIRTIO_BLK_F_SCSI));
+    qvirtio_set_features(dev, features);
+
+    capacity = qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
+
+    vq = qvirtqueue_setup(dev, t_alloc, 0);
+    qvirtio_set_driver_ok(dev);
+
+    /* Write request */
+    req.type = VIRTIO_BLK_T_OUT;
+    req.ioprio = 1;
+    req.sector = 0;
+    req.data = g_malloc0(512);
+    strcpy(req.data, "TEST");
+
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
+
+    g_free(req.data);
+
+    indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 528, false);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 528, 1, true);
+    free_head = qvirtqueue_add_indirect(qts, vq, indirect);
+    qvirtqueue_kick(qts, dev, vq, free_head);
+
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
+    status = readb(req_addr + 528);
+    g_assert_cmpint(status, ==, 0);
+
+    g_free(indirect);
+    guest_free(t_alloc, req_addr);
+
+    /* Read request */
+    req.type = VIRTIO_BLK_T_IN;
+    req.ioprio = 1;
+    req.sector = 0;
+    req.data = g_malloc0(512);
+    strcpy(req.data, "TEST");
+
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
+
+    g_free(req.data);
+
+    indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 16, false);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 16, 513, true);
+    free_head = qvirtqueue_add_indirect(qts, vq, indirect);
+    qvirtqueue_kick(qts, dev, vq, free_head);
+
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
+    status = readb(req_addr + 528);
+    g_assert_cmpint(status, ==, 0);
+
+    data = g_malloc0(512);
+    memread(req_addr + 16, data, 512);
+    g_assert_cmpstr(data, ==, "TEST");
+    g_free(data);
+
+    g_free(indirect);
+    guest_free(t_alloc, req_addr);
+    qvirtqueue_cleanup(dev->bus, vq, t_alloc);
+}
+
+
+static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
+{
+    QVirtQueue *vq;
+    QVhostUserBlkPCI *blk = obj;
+    QVirtioPCIDevice *pdev = &blk->pci_vdev;
+    QVirtioDevice *dev = &pdev->vdev;
+    QVirtioBlkReq req;
+    uint64_t req_addr;
+    uint64_t capacity;
+    uint64_t features;
+    uint32_t free_head;
+    uint32_t write_head;
+    uint32_t desc_idx;
+    uint8_t status;
+    char *data;
+    QOSGraphObject *blk_object = obj;
+    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
+    QTestState *qts = global_qtest;
+
+    if (qpci_check_buggy_msi(pci_dev)) {
+        return;
+    }
+
+    qpci_msix_enable(pdev->pdev);
+    qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
+
+    features = qvirtio_get_features(dev);
+    features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_F_NOTIFY_ON_EMPTY) |
+                            (1u << VIRTIO_BLK_F_SCSI));
+    qvirtio_set_features(dev, features);
+
+    capacity = qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
+
+    vq = qvirtqueue_setup(dev, t_alloc, 0);
+    qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
+
+    qvirtio_set_driver_ok(dev);
+
+    /* Write request */
+    req.type = VIRTIO_BLK_T_OUT;
+    req.ioprio = 1;
+    req.sector = 0;
+    req.data = g_malloc0(512);
+    strcpy(req.data, "TEST");
+
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
+
+    g_free(req.data);
+
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
+
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
+
+    /* Write request */
+    req.type = VIRTIO_BLK_T_OUT;
+    req.ioprio = 1;
+    req.sector = 1;
+    req.data = g_malloc0(512);
+    strcpy(req.data, "TEST");
+
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
+
+    g_free(req.data);
+
+    /* Notify after processing the third request */
+    qvirtqueue_set_used_event(qts, vq, 2);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
+    write_head = free_head;
+
+    /* No notification expected */
+    status = qvirtio_wait_status_byte_no_isr(qts, dev,
+                                             vq, req_addr + 528,
+                                             QVIRTIO_BLK_TIMEOUT_US);
+    g_assert_cmpint(status, ==, 0);
+
+    guest_free(t_alloc, req_addr);
+
+    /* Read request */
+    req.type = VIRTIO_BLK_T_IN;
+    req.ioprio = 1;
+    req.sector = 1;
+    req.data = g_malloc0(512);
+
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
+
+    g_free(req.data);
+
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+
+    qvirtqueue_kick(qts, dev, vq, free_head);
+
+    /* We get just one notification for both requests */
+    qvirtio_wait_used_elem(qts, dev, vq, write_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
+    g_assert(qvirtqueue_get_buf(qts, vq, &desc_idx, NULL));
+    g_assert_cmpint(desc_idx, ==, free_head);
+
+    status = readb(req_addr + 528);
+    g_assert_cmpint(status, ==, 0);
+
+    data = g_malloc0(512);
+    memread(req_addr + 16, data, 512);
+    g_assert_cmpstr(data, ==, "TEST");
+    g_free(data);
+
+    guest_free(t_alloc, req_addr);
+
+    /* End test */
+    qpci_msix_disable(pdev->pdev);
+
+    qvirtqueue_cleanup(dev->bus, vq, t_alloc);
+}
+
+static void pci_hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtioPCIDevice *dev1 = obj;
+    QVirtioPCIDevice *dev;
+    QTestState *qts = dev1->pdev->bus->qts;
+
+    /* plug secondary disk */
+    qtest_qmp_device_add(qts, "vhost-user-blk-pci", "drv1",
+                         "{'addr': %s, 'chardev': 'char2'}",
+                         stringify(PCI_SLOT_HP) ".0");
+
+    dev = virtio_pci_new(dev1->pdev->bus,
+                         &(QPCIAddress) { .devfn = QPCI_DEVFN(PCI_SLOT_HP, 0)
+                                        });
+    g_assert_nonnull(dev);
+    g_assert_cmpint(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
+    qvirtio_pci_device_disable(dev);
+    qos_object_destroy((QOSGraphObject *)dev);
+
+    /* unplug secondary disk */
+    qpci_unplug_acpi_device_test(qts, "drv1", PCI_SLOT_HP);
+}
+
+/*
+ * Check that setting the vring addr on a non-existent virtqueue does
+ * not crash.
+ */
+static void test_nonexistent_virtqueue(void *obj, void *data,
+                                       QGuestAllocator *t_alloc)
+{
+    QVhostUserBlkPCI *blk = obj;
+    QVirtioPCIDevice *pdev = &blk->pci_vdev;
+    QPCIBar bar0;
+    QPCIDevice *dev;
+
+    dev = qpci_device_find(pdev->pdev->bus, QPCI_DEVFN(4, 0));
+    g_assert(dev != NULL);
+    qpci_device_enable(dev);
+
+    bar0 = qpci_iomap(dev, 0, NULL);
+
+    qpci_io_writeb(dev, bar0, VIRTIO_PCI_QUEUE_SEL, 2);
+    qpci_io_writel(dev, bar0, VIRTIO_PCI_QUEUE_PFN, 1);
+
+    g_free(dev);
+}
+
+static const char *qtest_qemu_storage_daemon_binary(void)
+{
+    const char *qemu_storage_daemon_bin;
+
+    qemu_storage_daemon_bin = getenv("QTEST_QEMU_STORAGE_DAEMON_BINARY");
+    if (!qemu_storage_daemon_bin) {
+        fprintf(stderr, "Environment variable "
+                        "QTEST_QEMU_STORAGE_DAEMON_BINARY required\n");
+        exit(0);
+    }
+
+    return qemu_storage_daemon_bin;
+}
+
+static void drive_destroy(void *path)
+{
+    unlink(path);
+    g_free(path);
+    qos_invalidate_command_line();
+}
+
+
+static char *drive_create(void)
+{
+    int fd, ret;
+    /** vhost-user-blk won't recognize drive located in /tmp */
+    char *t_path = g_strdup("qtest.XXXXXX");
+
+    /** Create a temporary raw image */
+    fd = mkstemp(t_path);
+    g_assert_cmpint(fd, >=, 0);
+    ret = ftruncate(fd, TEST_IMAGE_SIZE);
+    g_assert_cmpint(ret, ==, 0);
+    close(fd);
+
+    g_test_queue_destroy(drive_destroy, t_path);
+    return t_path;
+}
+
+static char sock_path_tempate[] = "/tmp/qtest.vhost_user_blk.XXXXXX";
+static char qmp_sock_path_tempate[] = "/tmp/qtest.vhost_user_blk.qmp.XXXXXX";
+
+
+static void quit_storage_daemon(void *qmp_test_state)
+{
+    qobject_unref(qtest_qmp((QTestState *)qmp_test_state, "{ 'execute': 'quit' }"));
+    g_free(qmp_test_state);
+}
+
+static char *start_vhost_user_blk(void)
+{
+    int fd, qmp_fd;
+    char *sock_path = g_strdup(sock_path_tempate);
+    char *qmp_sock_path = g_strdup(qmp_sock_path_tempate);
+    fd = mkstemp(sock_path);
+    g_assert_cmpint(fd, >=, 0);
+    g_test_queue_destroy(drive_destroy, sock_path);
+
+
+    qmp_fd = mkstemp(qmp_sock_path);
+    g_assert_cmpint(qmp_fd, >=, 0);
+    g_test_queue_destroy(drive_destroy, qmp_sock_path);
+    QTestState *qmp_test_state = g_new0(QTestState, 1);
+
+    /*
+     * Ask qemu-storage-daemon to quit so it
+     * will not block scripts/tap-driver.pl.
+     */
+    g_test_queue_destroy(quit_storage_daemon, qmp_test_state);
+    /* create image file */
+    const char *img_path = drive_create();
+
+    const char *vhost_user_blk_bin = qtest_qemu_storage_daemon_binary();
+    gchar *command = g_strdup_printf(
+            "exec %s "
+            "--blockdev driver=file,node-name=disk,filename=%s "
+            "--object vhost-user-blk-server,id=disk,unix-socket=%s,"
+            "node-name=disk,writable=on "
+            "--chardev socket,id=qmp,path=%s,server,nowait --monitor chardev=qmp",
+            vhost_user_blk_bin, img_path, sock_path, qmp_sock_path);
+
+
+    g_test_message("starting vhost-user backend: %s", command);
+    pid_t pid = fork();
+    if (pid == 0) {
+        execlp("/bin/sh", "sh", "-c", command, NULL);
+        exit(1);
+    }
+    g_free(command);
+    qmp_test_state->qmp_fd = qtest_socket_client(qmp_sock_path);
+
+    qobject_unref(qtest_qmp(qmp_test_state,
+                  "{ 'execute': 'qmp_capabilities' }"));
+    return sock_path;
+}
+
+
+static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
+{
+    char *sock_path1 = start_vhost_user_blk();
+    g_string_append_printf(cmd_line,
+                           " -object memory-backend-memfd,id=mem,size=128M,share=on -numa node,memdev=mem "
+                           "-chardev socket,id=char1,path=%s ", sock_path1);
+    return arg;
+}
+
+
+/*
+ * Setup for hotplug.
+ *
+ * Since vhost-user server only serves one vhost-user client one time,
+ * another exprot
+ *
+ */
+static void *vhost_user_blk_hotplug_test_setup(GString *cmd_line, void *arg)
+{
+    vhost_user_blk_test_setup(cmd_line, arg);
+    char *sock_path2 = start_vhost_user_blk();
+    /* "-chardev socket,id=char2" is used for pci_hotplug*/
+    g_string_append_printf(cmd_line, "-chardev socket,id=char2,path=%s",
+                           sock_path2);
+    return arg;
+}
+
+static void register_vhost_user_blk_test(void)
+{
+    QOSGraphTestOptions opts = {
+        .before = vhost_user_blk_test_setup,
+    };
+
+    /*
+     * tests for vhost-user-blk and vhost-user-blk-pci
+     * The tests are borrowed from tests/virtio-blk-test.c. But some tests
+     * regarding block_resize don't work for vhost-user-blk.
+     * vhost-user-blk device doesn't have -drive, so tests containing
+     * block_resize are also abandoned,
+     *  - config
+     *  - resize
+     */
+    qos_add_test("basic", "vhost-user-blk", basic, &opts);
+    qos_add_test("indirect", "vhost-user-blk", indirect, &opts);
+    qos_add_test("idx", "vhost-user-blk-pci", idx, &opts);
+    qos_add_test("nxvirtq", "vhost-user-blk-pci",
+                 test_nonexistent_virtqueue, &opts);
+
+    opts.before = vhost_user_blk_hotplug_test_setup;
+    qos_add_test("hotplug", "vhost-user-blk-pci", pci_hotplug, &opts);
+}
+
+libqos_init(register_vhost_user_blk_test);
-- 
2.26.2


