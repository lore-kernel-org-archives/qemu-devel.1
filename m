Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30174C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFBC2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ocgikygC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFBC2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMrnW-0003ic-KK
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMrlW-0002l4-KE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:56:22 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:54723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMrlT-0000Qv-Vq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=YL8i84GA34biQQKOy2ffYgwFfgkqerEw5D4jtLJFfK0=; b=ocgikygCASHt8Wj85D/nlpdf1z
 jHIpMyPPlJfJz9Iw3YR8QxA2rdCqW18137A5GYgi4vpgpJiYtXaPitYTf7oUEjz/F5BRIxVTy0lPX
 Fv1nL3mTWpWuHpH1V9sge2ftYMfPzSwc5xyC5naQHIlzY/ke7RdikbV64sQbCg/pC4Tkm1ROIoYBf
 OSr9VFMLNLli2IAYEm2dTVskUJafdHrmTJ42U2NMJDfzTONHq78V9ddNo0+DcVzjbjCWdbGsJtdij
 b/sgAbj5dyQ/bCLdAatWMpoVJFi6CP5XUdZ2rLTJJLpjLKV/Ry7FeMKkxZr4RZigYTtlip7lqJuqS
 JYJNR4wQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
Date: Mon, 28 Sep 2020 13:56:12 +0200
Message-ID: <3365834.oEZqtqHOuS@silver>
In-Reply-To: <7aba6fc7-6d9b-25b5-9dbf-04e15314707c@redhat.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <265f5d9a0fb10ce5e782455839d1baf678dbac48.1601203436.git.qemu_oss@crudebyte.com>
 <7aba6fc7-6d9b-25b5-9dbf-04e15314707c@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 07:56:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 28. September 2020 10:37:52 CEST Paolo Bonzini wrote:
> On 27/09/20 12:40, Christian Schoenebeck wrote:
> > +    qos_node_consumes("virtio-9p-device-local", "virtio-bus", &opts);
> > +    qos_node_produces("virtio-9p-device-local", "virtio-local");
> 
> This should produce "virtio", similar to what I remarked in the previous
> patch.

You're right, I missed that implied virtio test. That should be in the end:

index 599b73a9d7..1df3da18e9 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -140,8 +140,7 @@ static void *virtio_9p_get_driver(QVirtio9P *v_9p,
     {
         return v_9p;
     }
-    if (!g_strcmp0(interface, "virtio-synth") ||
-        !g_strcmp0(interface, "virtio-local"))
+    if (!g_strcmp0(interface, "virtio"))
     {
         return v_9p->vdev;
     }
@@ -248,7 +247,7 @@ static void virtio_9p_register_nodes(void)
     qos_node_create_driver_named("virtio-9p-device-synth", "virtio-9p-
device",
                                  virtio_9p_device_create);
     qos_node_consumes("virtio-9p-device-synth", "virtio-bus", &opts);
-    qos_node_produces("virtio-9p-device-synth", "virtio-synth");
+    qos_node_produces("virtio-9p-device-synth", "virtio");
     qos_node_produces("virtio-9p-device-synth", "virtio-9p-synth");
 
     /* virtio-9p-pci-synth */
@@ -258,7 +257,7 @@ static void virtio_9p_register_nodes(void)
                                  virtio_9p_pci_create);
     qos_node_consumes("virtio-9p-pci-synth", "pci-bus", &opts);
     qos_node_produces("virtio-9p-pci-synth", "pci-device");
-    qos_node_produces("virtio-9p-pci-synth", "virtio-synth");
+    qos_node_produces("virtio-9p-pci-synth", "virtio");
     qos_node_produces("virtio-9p-pci-synth", "virtio-9p-synth");
 
 
@@ -280,7 +279,7 @@ static void virtio_9p_register_nodes(void)
     qos_node_create_driver_named("virtio-9p-device-local", "virtio-9p-
device",
                                  virtio_9p_device_create);
     qos_node_consumes("virtio-9p-device-local", "virtio-bus", &opts);
-    qos_node_produces("virtio-9p-device-local", "virtio-local");
+    qos_node_produces("virtio-9p-device-local", "virtio");
     qos_node_produces("virtio-9p-device-local", "virtio-9p-local");
 
     /* virtio-9p-pci-local */
@@ -290,7 +289,7 @@ static void virtio_9p_register_nodes(void)
                                  virtio_9p_pci_create);
     qos_node_consumes("virtio-9p-pci-local", "pci-bus", &opts);
     qos_node_produces("virtio-9p-pci-local", "pci-device");
-    qos_node_produces("virtio-9p-pci-local", "virtio-local");
+    qos_node_produces("virtio-9p-pci-local", "virtio");
     qos_node_produces("virtio-9p-pci-local", "virtio-9p-local");
 }

I already tested that. Both the implied "virtio" test and the 9p 'synth' and 
'local' tests work as expected then.

> > +    qos_node_produces("virtio-9p-device-local", "virtio-9p-local");
> > +
> > +    /* virtio-9p-pci-local */
> > +    opts.extra_device_opts = local_str_addr;
> > +    add_qpci_address(&opts, &addr);
> > +    qos_node_create_driver_named("virtio-9p-pci-local", "virtio-9p-pci",
> > +                                 virtio_9p_pci_create);
> > +    qos_node_consumes("virtio-9p-pci-local", "pci-bus", &opts);
> > +    qos_node_produces("virtio-9p-pci-local", "pci-device");
> > +    qos_node_produces("virtio-9p-pci-local", "virtio-local");
> > +    qos_node_produces("virtio-9p-pci-local", "virtio-9p-local");
> > 
> >  }
> 
> The implementation in patches 1 and 2 is reasonable, but what is the
> advantage of this as opposed to specifying the fsdev in the edge options
> for the test (similar to virtio-net)?  I was expecting both
> virtio-9p-device-synth and virtio-9p-device-local to produce virtio-9p,
> so that the existing tests would be reused automatically by the qos
> graph walk.
> 
> As things stand, I don't see any reason to have separate devices for
> different backends.

I thought to fix the problem at its root, by removing that singular device 
limitation in qos. That would also allow to cleanly separate tests suites that 
are not related to each other instead of having to depend on each other, 
taking care about other one's command line skeleton and more.

Plus I just tried what you suggested as alternative:

-Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
+Subproject commit 88f18909db731a627456f26d779445f84e449536
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index c45c706d4f..7f588a9a92 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1035,12 +1035,22 @@ static void fs_create_dir(void *obj, void *data, 
QGuestAllocator *t_alloc)
     g_free(root_path);
 }
 
+static void *modifycmdline(GString *cmd_line, void *arg)
+{
+    fprintf(stderr, "\n\nbefore modifycmdline(): '%s'\n\n", cmd_line->str);
+    g_string_append(cmd_line, "MODIFYCMDLINE ");
+    return arg;
+}
 
 static void register_virtio_9p_test(void)
 {
     /* selects the 9pfs 'synth' filesystem driver for the respective test */
     const char *synth_driver = "virtio-9p-synth";
 
+    QOSGraphTestOptions opts = {
+        //.before = modifycmdline,
+    };
+
     qos_add_test("config", synth_driver, pci_config, NULL);
     qos_add_test("fs/version/basic", synth_driver, fs_version, NULL);
     qos_add_test("fs/attach/basic", synth_driver, fs_attach, NULL);
@@ -1064,8 +1074,13 @@ static void register_virtio_9p_test(void)
     /* selects the 9pfs 'local' filesystem driver for the respective test */
     const char *local_driver = "virtio-9p-local";
 
-    qos_add_test("config", local_driver, pci_config, NULL);
-    qos_add_test("fs/create_dir", local_driver, fs_create_dir, NULL);
+    opts.before = modifycmdline,
+    opts.edge.extra_device_opts = "EXTRADEVICEOPTS";
+    opts.edge.before_cmd_line = "BEFORECMDLINE";
+    opts.edge.after_cmd_line = "AFTERCMDLINE";
+
+    qos_add_test("config", local_driver, pci_config, &opts);
+    qos_add_test("fs/create_dir", local_driver, fs_create_dir, &opts);
 }
 

Output:


QTEST_DEBUG=1 tests/qtest/qos-test
...

/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci-local/virtio-9p-
local/virtio-9p-local-tests/config: 

before modifycmdline(): '-M pc  -fsdev local,id=fsdev1,path='/home/me/git/
qemu/build/qtest-9p-local',security_model=mapped-xattr -device virtio-9p-
pci,fsdev=fsdev1,addr=04.1,mount_tag=qtest-local BEFORECMDLINE,EXTRADEVICEOPTS 
AFTERCMDLINE'

run QEMU with: '-M pc  -fsdev local,id=fsdev1,path='/home/me/git/qemu/build/
qtest-9p-local',security_model=mapped-xattr -device virtio-9p-
pci,fsdev=fsdev1,addr=04.1,mount_tag=qtest-local BEFORECMDLINE,EXTRADEVICEOPTS 
AFTERCMDLINEMODIFYCMDLINE '


So your suggested solution is fine for appending extra arguments past the 
command line. However I would not be able to prepend something (easily) in 
front of '-device virtio-9p-pci'.

So I would be forced to parse the existing command line in modifycmdline() 
callback and then insert the required arguments appropriately. I would not 
find that very clean.

I mean yes, you might do hacks for making this patch set work without qos 
patches 1 and 2, however somewhere in future you are probably back at square 
one when facing this single device limitation again. So I still think this qos 
change (patch 1 & 2) make sense.

Best regards,
Christian Schoenebeck



