Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC36C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEE220853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iIRiECDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEE220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVix-00084c-Bf
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaO-0006rH-N9
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaL-00085U-KF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095Io85S076947;
 Mon, 5 Oct 2020 18:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=CtnFM+IC1NPVEh+cYAlovprBurg049QysOGrulu5FsM=;
 b=iIRiECDY4/JxmCY90V8TRtaJGQXn6UfnhRZf4QAS4F/cHVP+jt0KVuiqBFMmM/1DMvP6
 yOFeEREw6J+dgJdPIvMMg5/E7jhTQAK2WreoK7gnNPJwqRa+nbHpoFCuexg4mlAeLEef
 kvcljFszROfoNUp4SsvaiBFmHRVWYuB2vi09mi3HVwG47ZwFpNpkbBQYZjVfgPVIQwD7
 +KBiWnWZHBF1rnfWuiZcGd8rYwcXKceG0WXP6w1Es78d2Q1q4xF1yW+DgganJRiMocYl
 iEYerFQX12CQgv37nbhcaHxUqMw3dWJ7CO5YgwHhpOcKPw2U0EbBgjHjJN45KEPmyU8D bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 33ym34c9t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:51:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095IpDjC182554;
 Mon, 5 Oct 2020 18:51:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 33y2vkvfja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095IpbD6005454;
 Mon, 5 Oct 2020 18:51:37 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:37 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 16/19] multi-process: Retrieve PCI info from remote process
Date: Mon,  5 Oct 2020 11:51:04 -0700
Message-Id: <4f08bd231a2d8078a1f14f0fda8c5980f567b6cc.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=3 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=3 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 14:51:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Retrieve PCI configuration info about the remote device and
configure the Proxy PCI object based on the returned information

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/pci/proxy.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 029e78e85f..1e4b18e5b2 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -24,6 +24,8 @@
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
 
+static void probe_pci_info(PCIDevice *dev, Error **errp);
+
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
     pdev->ioc = qio_channel_new_fd(fd, errp);
@@ -87,6 +89,7 @@ static void setup_irqfd(PCIProxyDev *dev)
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    uint8_t *pci_conf = device->config;
     int fd;
 
     if (dev->fd) {
@@ -114,9 +117,14 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     qemu_mutex_init(&dev->io_mutex);
     qio_channel_set_blocking(dev->ioc, true, NULL);
 
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01;
+
     configure_memory_sync(&dev->sync, dev->ioc);
 
     setup_irqfd(dev);
+
+    probe_pci_info(PCI_DEVICE(dev), errp);
 }
 
 static void pci_proxy_dev_exit(PCIDevice *pdev)
@@ -266,3 +274,80 @@ const MemoryRegionOps proxy_mr_ops = {
         .max_access_size = 8,
     },
 };
+
+static void probe_pci_info(PCIDevice *dev, Error **errp)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    uint32_t orig_val, new_val, base_class, val;
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    DeviceClass *dc = DEVICE_CLASS(pc);
+    uint8_t type;
+    int i, size;
+    char *name;
+
+    config_op_send(pdev, PCI_VENDOR_ID, &val, 2, PCI_CONFIG_READ);
+    pc->vendor_id = (uint16_t)val;
+
+    config_op_send(pdev, PCI_DEVICE_ID, &val, 2, PCI_CONFIG_READ);
+    pc->device_id = (uint16_t)val;
+
+    config_op_send(pdev, PCI_CLASS_DEVICE, &val, 2, PCI_CONFIG_READ);
+    pc->class_id = (uint16_t)val;
+
+    config_op_send(pdev, PCI_SUBSYSTEM_ID, &val, 2, PCI_CONFIG_READ);
+    pc->subsystem_id = (uint16_t)val;
+
+    base_class = pc->class_id >> 4;
+    switch (base_class) {
+    case PCI_BASE_CLASS_BRIDGE:
+        set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+        break;
+    case PCI_BASE_CLASS_STORAGE:
+        set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+        break;
+    case PCI_BASE_CLASS_NETWORK:
+        set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+        break;
+    case PCI_BASE_CLASS_INPUT:
+        set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+        break;
+    case PCI_BASE_CLASS_DISPLAY:
+        set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+        break;
+    case PCI_BASE_CLASS_PROCESSOR:
+        set_bit(DEVICE_CATEGORY_CPU, dc->categories);
+        break;
+    default:
+        set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+        break;
+    }
+
+    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &orig_val, 4,
+                       PCI_CONFIG_READ);
+        new_val = 0xffffffff;
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &new_val, 4,
+                       PCI_CONFIG_WRITE);
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &new_val, 4,
+                       PCI_CONFIG_READ);
+        size = (~(new_val & 0xFFFFFFF0)) + 1;
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &orig_val, 4,
+                       PCI_CONFIG_WRITE);
+        type = (new_val & 0x1) ?
+                   PCI_BASE_ADDRESS_SPACE_IO : PCI_BASE_ADDRESS_SPACE_MEMORY;
+
+        if (size) {
+            pdev->region[i].dev = pdev;
+            pdev->region[i].present = true;
+            if (type == PCI_BASE_ADDRESS_SPACE_MEMORY) {
+                pdev->region[i].memory = true;
+            }
+            name = g_strdup_printf("bar-region-%d", i);
+            memory_region_init_io(&pdev->region[i].mr, OBJECT(pdev),
+                                  &proxy_mr_ops, &pdev->region[i],
+                                  name, size);
+            pci_register_bar(dev, i, type, &pdev->region[i].mr);
+            g_free(name);
+        }
+    }
+}
-- 
2.25.GIT


