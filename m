Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EEC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACBD2068F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SjtpMD1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACBD2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqeo-00028i-4A
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iXqaq-0000He-3W
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iXqal-0007Bm-Vk
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:12 -0500
Received: from mout.web.de ([217.72.192.78]:36019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iXqal-00078P-Eq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574358574;
 bh=mUHwoNP69oYZm/UPIrC3/73YAFFXYW+U5IJQHfNVy7c=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=SjtpMD1HazrfXz81cnNyQXbZePGqDYK/2pMaEeT6+TZWgXKgyLQVgbbvC3LL0EDOw
 xsNvMCNJGZNiKn7QVFfsin8cJx2o031I/RkvMIOx+gk4EVvIxZ7odCd4eMRDS2i8xa
 vAtYqASk3UNu5UJTxXD81bI58uUmhfson3+7mT4M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.160]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6DyQ-1he6Mu0tb8-00yCpe; Thu, 21
 Nov 2019 18:49:34 +0100
Date: Thu, 21 Nov 2019 18:49:33 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 2/4] colo: Introduce resource agent
Message-ID: <4b51cd192df72d880841794199a10d7a834688d4.1574356137.git.lukasstraub2@web.de>
In-Reply-To: <cover.1574356137.git.lukasstraub2@web.de>
References: <cover.1574356137.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Rw/WD3LMNj64X7tuHCO+rg8luc5pY+cClCe3ABrnKrgnzmU+HE
 ItiSDIA+oUyerx1CdAudnoAGdoc3v7MhiOddEHfZdJHaeECTio5SZr2oWio9qMLFmo6MDgC
 hdHBHSwR1GlbawrSu3vaCcqOLmj3sItg13+weWYSn7OSO6iWls/rRtRbyPnsjR49FdEAAlt
 YK+ZnuKRs0CktrUm+7cAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w+zOmB6bx4U=:XHcNMDC59/4IGWyErUZLM5
 KynbZh8XqKIbHRCQUSQqFUF1ftmul06Dt5dA/a6Nho+gLL1sMduKPuclNWaivk9uO59xKaNEd
 7hoKuuYUt9LYRYAjiQqUgg8mSk/6Qrj6Vb4fnbZxvHMpDojL8EmU9j6CwiKjbjoJ1cmJXX9yx
 OSFIozS3np5zJOU0SErIDRrl5+rFb+u54RQ1L39nlX/SI9aJVWChT+cEKX+CSuca6yck54V4d
 SqhOHqd24+AcTmAbSCDdUNMBp6OAeZWKw1kTvPP5mHMo3ZMxxoRDu62tuMZ8jPqzgW8DaCyxD
 ID68y+6+wP8sjLj/sXlBchTW864eeufG+3i8Q6BF61usuXpqKTD6LAmOCbNoZ2wBg2JSgVW66
 8ZxzwCuSZ8HBE809Q+clKJCCodrNztsqhKkBTPtMMATvcklrCBGgxOj4ROYIf8JfYqVd8gvFb
 w4H+QjvvuaONE1f9aN+Q6I2h625V/4PAPqFHCkkoYxUalgMEAbQrUesL7A9s89KQdvHupBHbY
 JH4jSk03DfLeByrPyag2NdDMqDw1v0fO0LO0A6YAya8pZBL4GLV2/NYHGCVYABt4uzTOpbSxo
 G8FxEx6G8f7MnoMqAePhpW2IiCc8yuSNTo2BAPaAbnUnzx1QzdwijmyMfDVWtZwW+9SumnKx4
 yWf53y3XhJeO5QQ+rY6wlf7y8Lckq32ruc/6ALAV8zlmk9S9D9ufIi1+Rfor2tA7dEYU+WKf4
 W4AeY0G95yYs/nDy/RsTJTLJUUHRHA/Zp/oslFOZRjlVSkmxvXKYE8TfTFcvPSngQ1LAMw1vY
 PZuDvMbJeR0+0YifFiOUp9QluAgG/sUja1W4LVSE2AoKbmtT3HlX0FiYDifkwMuGIromE2h8v
 D/w9ehw5KbyGWo46wTJBKXRs6wjsgghqqJUG8i8DBNfOlPRQ0dbqvQ9XaYWtb0Bge5w6/DTbj
 JX3H78Jd7kMrra1VQ6p/sW4OygJcS4WhrW3ZBbjaHn98mbAKyoOoBXqcBpYsfeBiMJBR6662l
 Kf3bsPWOfqaXEGQlFLEICF0RyccD3c7anutjkXmayXZDzuZ4vHjpIeSwLb1VxgAQV+Bqm/IjE
 m35QkkUJL/bUjERrjETkG3RRk9ts43XhXv0AdKUp+5Fj8KN2LOsAPGKaG81hPIhL4l/5m5sB/
 vAA7OaVAdp47HM9+wDrRaW9csYaAZQyKWNVQFyf8LAd/1Drg3CSig5Nf3X2vIiHt+AQ20qf9y
 m8iwR5+ubpHCN2kVB7Zd0KKuGrqqGEB8l4NeiYBLsmvJL5s62XVHlVUI/dVI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.78
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a resource agent which can be used in a
Pacemaker cluster to manage qemu COLO.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 scripts/colo-resource-agent/colo | 1026 ++++++++++++++++++++++++++++++
 1 file changed, 1026 insertions(+)
 create mode 100755 scripts/colo-resource-agent/colo

diff --git a/scripts/colo-resource-agent/colo b/scripts/colo-resource-agen=
t/colo
new file mode 100755
index 0000000000..5fd9cfc0b5
=2D-- /dev/null
+++ b/scripts/colo-resource-agent/colo
@@ -0,0 +1,1026 @@
+#!/usr/bin/env python
+
+# Resource agent for qemu COLO for use with Pacemaker CRM
+#
+# Copyright (c) Lukas Straub <lukasstraub2@web.de>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from __future__ import print_function
+import subprocess
+import sys
+import os
+import os.path
+import signal
+import socket
+import json
+import re
+import time
+import logging
+import logging.handlers
+
+# Constants
+OCF_SUCCESS =3D 0
+OCF_ERR_GENERIC =3D 1
+OCF_ERR_ARGS =3D 2
+OCF_ERR_UNIMPLEMENTED =3D 3
+OCF_ERR_PERM =3D 4
+OCF_ERR_INSTALLED =3D 5
+OCF_ERR_CONFIGURED =3D 6
+OCF_NOT_RUNNING =3D 7
+OCF_RUNNING_MASTER =3D 8
+OCF_FAILED_MASTER =3D 9
+
+# Get environment variables
+OCF_RESKEY_CRM_meta_notify_type \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_type")
+OCF_RESKEY_CRM_meta_notify_operation \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_operation")
+OCF_RESKEY_CRM_meta_notify_start_uname \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_start_uname", "")
+OCF_RESKEY_CRM_meta_notify_stop_uname \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_stop_uname", "")
+OCF_RESKEY_CRM_meta_notify_active_uname \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_active_uname", "")
+OCF_RESKEY_CRM_meta_notify_promote_uname \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_promote_uname", "")
+OCF_RESKEY_CRM_meta_notify_demote_uname \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_demote_uname", "")
+OCF_RESKEY_CRM_meta_notify_master_uname \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_master_uname", "")
+OCF_RESKEY_CRM_meta_notify_slave_uname \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify_slave_uname", "")
+
+HA_RSCTMP =3D os.getenv("HA_RSCTMP", "/run/resource-agents")
+HA_LOGFACILITY =3D os.getenv("HA_LOGFACILITY")
+HA_LOGFILE =3D os.getenv("HA_LOGFILE")
+HA_DEBUGLOG =3D os.getenv("HA_DEBUGLOG")
+OCF_RESOURCE_INSTANCE =3D os.getenv("OCF_RESOURCE_INSTANCE", "default-ins=
tance")
+OCF_RESKEY_CRM_meta_timeout \
+    =3D int(os.getenv("OCF_RESKEY_CRM_meta_timeout", "60000"))
+OCF_RESKEY_CRM_meta_interval \
+    =3D int(os.getenv("OCF_RESKEY_CRM_meta_interval", "1"))
+OCF_RESKEY_CRM_meta_clone_max \
+    =3D int(os.getenv("OCF_RESKEY_CRM_meta_clone_max", "1"))
+OCF_RESKEY_CRM_meta_clone_node_max \
+    =3D int(os.getenv("OCF_RESKEY_CRM_meta_clone_node_max", "1"))
+OCF_RESKEY_CRM_meta_master_max \
+    =3D int(os.getenv("OCF_RESKEY_CRM_meta_master_max", "1"))
+OCF_RESKEY_CRM_meta_master_node_max \
+    =3D int(os.getenv("OCF_RESKEY_CRM_meta_master_node_max", "1"))
+OCF_RESKEY_CRM_meta_notify \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_notify")
+OCF_RESKEY_CRM_meta_globally_unique \
+    =3D os.getenv("OCF_RESKEY_CRM_meta_globally_unique")
+
+HOSTNAME =3D os.getenv("OCF_RESKEY_CRM_meta_on_node", socket.gethostname(=
))
+
+OCF_ACTION =3D os.getenv("__OCF_ACTION")
+if not OCF_ACTION and len(sys.argv) =3D=3D 2:
+    OCF_ACTION =3D sys.argv[1]
+
+# Resource parameters
+OCF_RESKEY_binary_default =3D "qemu-system-x86_64"
+OCF_RESKEY_log_dir_default =3D HA_RSCTMP
+OCF_RESKEY_options_default =3D ""
+OCF_RESKEY_disk_size_default =3D ""
+OCF_RESKEY_active_hidden_dir_default =3D ""
+OCF_RESKEY_listen_address_default =3D "0.0.0.0"
+OCF_RESKEY_base_port_default =3D "9000"
+OCF_RESKEY_checkpoint_interval_default =3D "20000"
+OCF_RESKEY_debug_default =3D "false"
+
+OCF_RESKEY_binary =3D os.getenv("OCF_RESKEY_binary", OCF_RESKEY_binary_de=
fault)
+OCF_RESKEY_log_dir =3D os.getenv("OCF_RESKEY_log_dir", OCF_RESKEY_log_dir=
_default)
+OCF_RESKEY_options =3D os.getenv("OCF_RESKEY_options", OCF_RESKEY_options=
_default)
+OCF_RESKEY_disk_size \
+    =3D os.getenv("OCF_RESKEY_disk_size", OCF_RESKEY_disk_size_default)
+OCF_RESKEY_active_hidden_dir \
+    =3D os.getenv("OCF_RESKEY_active_hidden_dir", \
+                OCF_RESKEY_active_hidden_dir_default)
+OCF_RESKEY_listen_address \
+    =3D os.getenv("OCF_RESKEY_listen_address", OCF_RESKEY_listen_address_=
default)
+OCF_RESKEY_base_port \
+    =3D os.getenv("OCF_RESKEY_base_port", OCF_RESKEY_base_port_default)
+OCF_RESKEY_checkpoint_interval \
+    =3D os.getenv("OCF_RESKEY_checkpoint_interval", \
+                OCF_RESKEY_checkpoint_interval_default)
+OCF_RESKEY_debug =3D os.getenv("OCF_RESKEY_debug", OCF_RESKEY_debug_defau=
lt)
+
+ACTIVE_IMAGE =3D os.path.join(OCF_RESKEY_active_hidden_dir, \
+                            OCF_RESOURCE_INSTANCE + "-active.qcow2")
+HIDDEN_IMAGE =3D os.path.join(OCF_RESKEY_active_hidden_dir, \
+                            OCF_RESOURCE_INSTANCE + "-hidden.qcow2")
+
+QMP_SOCK =3D os.path.join(HA_RSCTMP, OCF_RESOURCE_INSTANCE + "-qmp.sock")
+COMP_SOCK =3D os.path.join(HA_RSCTMP, OCF_RESOURCE_INSTANCE + "-compare.s=
ock")
+COMP_OUT_SOCK =3D os.path.join(HA_RSCTMP, OCF_RESOURCE_INSTANCE \
+                                        + "-comp_out.sock")
+
+PID_FILE =3D os.path.join(HA_RSCTMP, OCF_RESOURCE_INSTANCE + "-qemu.pid")
+
+QMP_LOG =3D os.path.join(OCF_RESKEY_log_dir, OCF_RESOURCE_INSTANCE + "-qm=
p.log")
+QEMU_LOG =3D os.path.join(OCF_RESKEY_log_dir, OCF_RESOURCE_INSTANCE + "-q=
emu.log")
+
+# Exception only raised by ourself
+class Error(Exception):
+    pass
+
+def setup_constants():
+    # This function is called after the parameters where validated
+    global MIGRATE_PORT, MIROR_PORT, COMPARE_IN_PORT, NBD_PORT
+    MIGRATE_PORT =3D int(OCF_RESKEY_base_port)
+    MIROR_PORT =3D int(OCF_RESKEY_base_port) + 1
+    COMPARE_IN_PORT =3D int(OCF_RESKEY_base_port) + 2
+    NBD_PORT =3D int(OCF_RESKEY_base_port) + 3
+
+    global QEMU_PRIMARY_CMDLINE
+    QEMU_PRIMARY_CMDLINE =3D ("'%(OCF_RESKEY_binary)s' %(OCF_RESKEY_optio=
ns)s"
+        " -chardev socket,id=3Dcomp0,path=3D'%(COMP_SOCK)s',server,nowait=
"
+        " -chardev socket,id=3Dcomp0-0,path=3D'%(COMP_SOCK)s'"
+        " -chardev socket,id=3Dcomp_out,path=3D'%(COMP_OUT_SOCK)s',server=
,nowait"
+        " -chardev socket,id=3Dcomp_out0,path=3D'%(COMP_OUT_SOCK)s'"
+        " -drive if=3Dnone,node-name=3Dcolo-disk0,driver=3Dquorum,read-pa=
ttern=3Dfifo,"
+        "vote-threshold=3D1,children.0=3Dparent0"
+        " -qmp unix:'%(QMP_SOCK)s',server,nowait"
+        " -daemonize -D '%(QEMU_LOG)s' -pidfile '%(PID_FILE)s'") % global=
s()
+
+    global QEMU_SECONDARY_CMDLINE
+    QEMU_SECONDARY_CMDLINE =3D ("'%(OCF_RESKEY_binary)s' %(OCF_RESKEY_opt=
ions)s"
+        " -chardev socket,id=3Dred0,host=3D'%(OCF_RESKEY_listen_address)s=
',"
+        "port=3D%(MIROR_PORT)s,server,nowait"
+        " -chardev socket,id=3Dred1,host=3D'%(OCF_RESKEY_listen_address)s=
',"
+        "port=3D%(COMPARE_IN_PORT)s,server,nowait"
+        " -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=
=3Dred0"
+        " -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outde=
v=3Dred1"
+        " -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall"
+        " -drive if=3Dnone,node-name=3Dchilds0,top-id=3Dcolo-disk0,"
+        "driver=3Dreplication,mode=3Dsecondary,file.driver=3Dqcow2,"
+        "file.file.filename=3D'%(ACTIVE_IMAGE)s',file.backing.driver=3Dqc=
ow2,"
+        "file.backing.file.filename=3D'%(HIDDEN_IMAGE)s',"
+        "file.backing.backing=3Dparent0"
+        " -drive if=3Dnone,node-name=3Dcolo-disk0,driver=3Dquorum,read-pa=
ttern=3Dfifo,"
+        "vote-threshold=3D1,children.0=3Dchilds0"
+        " -incoming tcp:'%(OCF_RESKEY_listen_address)s':%(MIGRATE_PORT)s"
+        " -qmp unix:'%(QMP_SOCK)s',server,nowait"
+        " -daemonize -D '%(QEMU_LOG)s' -pidfile '%(PID_FILE)s'") % global=
s()
+
+def qemu_colo_meta_data():
+    print("""\
+<?xml version=3D"1.0"?>
+<!DOCTYPE resource-agent SYSTEM "ra-api-1.dtd">
+<resource-agent name=3D"colo">
+
+    <version>0.1</version>
+    <longdesc lang=3D"en">
+Resource agent for qemu COLO. (https://wiki.qemu.org/Features/COLO)
+
+After defining the master/slave instance, the master score has to be
+manually set to show which node has up-to-date data. So you copy your
+image to one host (and create empty images the other host(s)) and then
+run "crm_master -r name_of_your_primitive -v 10" on that host.
+
+Also, you have to set 'notify=3Dtrue' in the metadata attributes when
+defining the master/slave instance.
+    </longdesc>
+    <shortdesc lang=3D"en">Qemu COLO</shortdesc>
+
+    <parameters>
+
+    <parameter name=3D"binary" unique=3D"0" required=3D"0">
+        <longdesc lang=3D"en">Qemu binary to use</longdesc>
+        <shortdesc lang=3D"en">Qemu binary</shortdesc>
+        <content type=3D"string" default=3D\"""" \
+            + OCF_RESKEY_binary_default + """\"/>
+    </parameter>
+
+    <parameter name=3D"log_dir" unique=3D"0" required=3D"0">
+        <longdesc lang=3D"en">Directory to place logs in</longdesc>
+        <shortdesc lang=3D"en">Log directory</shortdesc>
+        <content type=3D"string" default=3D\"""" \
+            + OCF_RESKEY_log_dir_default + """\"/>
+    </parameter>
+
+    <parameter name=3D"options" unique=3D"0" required=3D"1">
+        <longdesc lang=3D"en">
+Options to pass to qemu. These will be passed alongside COLO specific
+options, so you need to follow these conventions: The netdev should have
+id=3Dhn0 and the disk controller drive=3Dcolo-disk0. The image node shoul=
d
+have id/node-name=3Dparent0, but should not be connected to the guest.
+Example:
+-vnc :0 -enable-kvm -cpu qemu64,+kvmclock -m 512 -netdev bridge,id=3Dhn0
+-device virtio-net,netdev=3Dhn0 -device virtio-blk,drive=3Dcolo-disk0
+-drive if=3Dnone,id=3Dparent0,format=3Dqcow2,file=3D/mnt/vms/vm01.qcow2
+        </longdesc>
+        <shortdesc lang=3D"en">Options to pass to qemu.</shortdesc>
+    </parameter>
+
+    <parameter name=3D"disk_size" unique=3D"0" required=3D"1">
+        <longdesc lang=3D"en">Disk size of the image</longdesc>
+        <shortdesc lang=3D"en">Disk size of the image</shortdesc>
+        <content type=3D"string" default=3D\"""" \
+            + OCF_RESKEY_disk_size_default + """\"/>
+    </parameter>
+
+    <parameter name=3D"active_hidden_dir" unique=3D"0" required=3D"1">
+        <longdesc lang=3D"en">
+Directory where the active and hidden images will be stored. It is
+recommended to put this on a ramdisk.
+        </longdesc>
+        <shortdesc lang=3D"en">Path to active and hidden images</shortdes=
c>
+        <content type=3D"string" default=3D\"""" \
+            + OCF_RESKEY_active_hidden_dir_default + """\"/>
+    </parameter>
+
+    <parameter name=3D"listen_address" unique=3D"0" required=3D"0">
+        <longdesc lang=3D"en">Address to listen on.</longdesc>
+        <shortdesc lang=3D"en">Listen address</shortdesc>
+        <content type=3D"string" default=3D\"""" \
+            + OCF_RESKEY_listen_address_default + """\"/>
+    </parameter>
+
+    <parameter name=3D"base_port" unique=3D"1" required=3D"0">
+        <longdesc lang=3D"en">
+4 tcp ports that are unique for each instance. (base_port to base_port + =
3)
+        </longdesc>
+        <shortdesc lang=3D"en">Ports to use</shortdesc>
+        <content type=3D"integer" default=3D\"""" \
+            + OCF_RESKEY_base_port_default + """\"/>
+    </parameter>
+
+    <parameter name=3D"checkpoint_interval" unique=3D"0" required=3D"0">
+        <longdesc lang=3D"en">
+Interval for regular checkpoints in milliseconds.
+        </longdesc>
+        <shortdesc lang=3D"en">Interval for regular checkpoints</shortdes=
c>
+        <content type=3D"integer" default=3D\"""" \
+            + OCF_RESKEY_checkpoint_interval_default + """\"/>
+    </parameter>
+
+    <parameter name=3D"debug" unique=3D"0" required=3D"0">
+        <longdesc lang=3D"en">Enable debuging</longdesc>
+        <shortdesc lang=3D"en">Enable debuging</shortdesc>
+        <content type=3D"string" default=3D\"""" \
+            + OCF_RESKEY_debug_default + """\"/>
+    </parameter>
+
+    </parameters>
+
+    <actions>
+        <action name=3D"start"        timeout=3D"30s" />
+        <action name=3D"stop"         timeout=3D"20s" />
+        <action name=3D"monitor"      timeout=3D"40s" \
+            interval=3D"12s" depth=3D"0" />
+        <action name=3D"monitor"      timeout=3D"40s" \
+            interval=3D"10s" depth=3D"0" role=3D"Slave" />
+        <action name=3D"monitor"      timeout=3D"40s" \
+            interval=3D"11s" depth=3D"0" role=3D"Master" />
+        <action name=3D"notify"       timeout=3D"120s" />
+        <action name=3D"promote"      timeout=3D"120s" />
+        <action name=3D"demote"       timeout=3D"120s" />
+        <action name=3D"meta-data"    timeout=3D"5s" />
+        <action name=3D"validate-all" timeout=3D"20s" />
+    </actions>
+
+</resource-agent>
+""")
+
+def logs_open():
+    global log
+    log =3D logging.getLogger(OCF_RESOURCE_INSTANCE)
+    log.setLevel(logging.DEBUG)
+    formater =3D logging.Formatter("(%(name)s) %(levelname)s: %(message)s=
")
+
+    if sys.stdout.isatty():
+        handler =3D logging.StreamHandler(stream=3Dsys.stderr)
+        handler.setFormatter(formater)
+        log.addHandler(handler)
+
+    if HA_LOGFACILITY:
+        handler =3D logging.handlers.SysLogHandler("/dev/log")
+        handler.setFormatter(formater)
+        log.addHandler(handler)
+
+    if HA_LOGFILE:
+        handler =3D logging.FileHandler(HA_LOGFILE)
+        handler.setFormatter(formater)
+        log.addHandler(handler)
+
+    if HA_DEBUGLOG and HA_DEBUGLOG !=3D HA_LOGFILE:
+        handler =3D logging.FileHandler(HA_DEBUGLOG)
+        handler.setFormatter(formater)
+        log.addHandler(handler)
+
+    global qmp_log
+    qmp_log =3D logging.getLogger("qmp_log")
+    qmp_log.setLevel(logging.DEBUG)
+    formater =3D logging.Formatter("%(message)s")
+
+    if is_true(OCF_RESKEY_debug):
+        handler =3D logging.handlers.WatchedFileHandler(QMP_LOG)
+        handler.setFormatter(formater)
+        qmp_log.addHandler(handler)
+    else:
+        handler =3D logging.NullHandler()
+        qmp_log.addHandler(handler)
+
+def rotate_logfile(logfile, numlogs):
+    numlogs -=3D 1
+    for n in range(numlogs, -1, -1):
+        file =3D logfile
+        if n !=3D 0:
+            file =3D "%s.%s" % (file, n)
+        if os.path.exists(file):
+            if n =3D=3D numlogs:
+                os.remove(file)
+            else:
+                newname =3D "%s.%s" % (logfile, n + 1)
+                os.rename(file, newname)
+
+def is_writable(file):
+    return os.access(file, os.W_OK)
+
+def is_executable_file(file):
+    return os.path.isfile(file) and os.access(file, os.X_OK)
+
+def is_true(var):
+    return re.match("yes|true|1|YES|TRUE|True|ja|on|ON", str(var)) !=3D N=
one
+
+# Check if the binary exists and is executable
+def check_binary(binary):
+    if is_executable_file(binary):
+        return True
+    PATH =3D os.getenv("PATH", os.defpath)
+    for dir in PATH.split(os.pathsep):
+        if is_executable_file(os.path.join(dir, binary)):
+            return True
+    log.error("binary \"%s\" doesn't exist or not executable" % binary)
+    return False
+
+def run_command(commandline):
+    proc =3D subprocess.Popen(commandline, shell=3DTrue, stdout=3Dsubproc=
ess.PIPE,\
+                          stderr=3Dsubprocess.STDOUT, universal_newlines=
=3DTrue)
+    stdout, stderr =3D proc.communicate()
+    if proc.returncode !=3D 0:
+        log.error("command \"%s\" failed with code %s:\n%s" \
+                    % (commandline, proc.returncode, stdout))
+        raise Error()
+
+# Functions for setting and getting the master score to tell Pacemaker wh=
ich
+# host has the most recent data
+def set_master_score(score):
+    if score <=3D 0:
+        os.system("crm_master -q -l forever -D")
+    else:
+        os.system("crm_master -q -l forever -v %s" % score)
+
+def set_remote_master_score(remote, score):
+    if score <=3D 0:
+        os.system("crm_master -q -l forever -N '%s' -D" % remote)
+    else:
+        os.system("crm_master -q -l forever -N '%s' -v %s" % (remote, sco=
re))
+
+def get_master_score():
+    proc =3D subprocess.Popen("crm_master -q -G", shell=3DTrue, \
+                            stdout=3Dsubprocess.PIPE, universal_newlines=
=3DTrue)
+    stdout, stderr =3D proc.communicate()
+    if proc.returncode !=3D 0:
+        return 0
+    else:
+        return int(str.strip(stdout))
+
+def get_remote_master_score(remote):
+    proc =3D subprocess.Popen("crm_master -q -N '%s' -G" % remote, shell=
=3DTrue, \
+                            stdout=3Dsubprocess.PIPE, universal_newlines=
=3DTrue)
+    stdout, stderr =3D proc.communicate()
+    if proc.returncode !=3D 0:
+        return 0
+    else:
+        return int(str.strip(stdout))
+
+def recv_line(fd):
+    line =3D ""
+    while True:
+        tmp =3D fd.recv(1)
+        if tmp =3D=3D "\n":
+            break
+        line +=3D tmp
+    return line
+
+# Filter out events
+def read_answer(fd):
+    while True:
+        line =3D recv_line(fd)
+        qmp_log.debug(line)
+
+        answer =3D json.loads(line)
+        # Ignore everything else
+        if "return" in answer or "error" in answer:
+            break
+    return answer
+
+# Execute one or more qmp commands
+def qmp_execute(fd, commands, ignore_error =3D False):
+    for command in commands:
+        if not command:
+            continue
+
+        try:
+            to_send =3D json.dumps(command)
+            fd.sendall(to_send + "\n")
+            qmp_log.debug(to_send)
+
+            answer =3D read_answer(fd)
+        except Exception as e:
+            log.error("while executing qmp command: %s\n%s" \
+                        % (json.dumps(command), e))
+            raise Error()
+
+        if not ignore_error and ("error" in answer):
+            log.error("qmp command returned error:\n%s\n%s" \
+                        % (json.dumps(command), json.dumps(answer)))
+            raise Error()
+
+    return answer
+
+# Open qemu qmp connection
+def qmp_open(fail_fast =3D False):
+    # Timeout for commands =3D our timeout minus 10s
+    timeout =3D max(1, (OCF_RESKEY_CRM_meta_timeout/1000)-10)
+
+    try:
+        fd =3D socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        if fail_fast:
+            fd.settimeout(min(10, (OCF_RESKEY_CRM_meta_timeout/1000)))
+        else:
+            fd.settimeout(timeout)
+        fd.connect(QMP_SOCK)
+
+        answer =3D qmp_execute(fd, [{"execute": "qmp_capabilities"}], Tru=
e)
+    except Exception as e:
+        log.error("while connecting to qmp socket: %s" % e)
+        raise Error()
+
+    if "error" in answer:
+        log.error("while connecting to qmp socket: %s" % json.dumps(answe=
r))
+        raise Error()
+
+    fd.settimeout(timeout)
+    return fd
+
+# Check qemu health and colo role
+def qmp_check_state(fd):
+    answer =3D qmp_execute(fd, [{"execute": "query-status"}])
+    vm_status =3D answer["return"]
+
+    answer =3D qmp_execute(fd, [{"execute": "query-colo-status"}])
+    colo_status =3D answer["return"]
+
+    if vm_status["status"] =3D=3D "inmigrate":
+        role =3D OCF_SUCCESS
+        replication =3D OCF_NOT_RUNNING
+
+    elif (vm_status["status"] =3D=3D "running" \
+          or vm_status["status"] =3D=3D "colo" \
+          or vm_status["status"] =3D=3D "finish-migrate") \
+         and colo_status["mode"] =3D=3D "none" \
+         and (colo_status["reason"] =3D=3D "request" \
+              or colo_status["reason"] =3D=3D "none"):
+        role =3D OCF_RUNNING_MASTER
+        replication =3D OCF_NOT_RUNNING
+
+    elif (vm_status["status"] =3D=3D "running" \
+          or vm_status["status"] =3D=3D "colo" \
+          or vm_status["status"] =3D=3D "finish-migrate") \
+         and colo_status["mode"] =3D=3D "secondary":
+        role =3D OCF_SUCCESS
+        replication =3D OCF_SUCCESS
+
+    elif (vm_status["status"] =3D=3D "running" \
+          or vm_status["status"] =3D=3D "colo" \
+          or vm_status["status"] =3D=3D "finish-migrate") \
+         and colo_status["mode"] =3D=3D "primary":
+        role =3D OCF_RUNNING_MASTER
+        replication =3D OCF_SUCCESS
+
+    else:
+        log.error("unknown qemu status: vm status: %s colo mode: %s" \
+                    % (vm_status["status"], colo_status["mode"]))
+        role =3D OCF_ERR_GENERIC
+        replication =3D OCF_ERR_GENERIC
+
+    return role, replication
+
+# Get the host of the nbd node
+def qmp_get_nbd_remote(fd):
+    block_nodes =3D qmp_execute(fd, [{"execute": "query-named-block-nodes=
"}])
+    for node in block_nodes["return"]:
+        if node["node-name"] =3D=3D "nbd0":
+            url =3D str(node["image"]["filename"])
+            return str.split(url, "//")[1].split("/")[0].split(":")[0]
+    return None
+
+# Check if we are currently resyncing
+def qmp_check_resync(fd):
+    answer =3D qmp_execute(fd, [{"execute": "query-block-jobs"}])
+    for job in answer["return"]:
+        if job["device"] =3D=3D "resync":
+            return job
+    return None
+
+def qmp_start_resync(fd, remote):
+    qmp_execute(fd, [
+        {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-=
name": "nbd0", "server": {"type": "inet", "host": str(remote), "port": str=
(NBD_PORT)}, "export": "parent0"}},
+        {"execute": "blockdev-mirror", "arguments": {"device": "colo-disk=
0", "job-id": "resync", "target": "nbd0", "sync": "full", "auto-dismiss": =
False}}
+        ])
+
+def qmp_cancel_resync(fd):
+    if qmp_check_resync(fd)["status"] !=3D "concluded":
+        qmp_execute(fd, [{"execute": "block-job-cancel", "arguments": {"d=
evice": "resync", "force": True}}], True)
+        # Wait for the block-job to finish
+        while qmp_check_resync(fd)["status"] !=3D "concluded":
+            time.sleep(1)
+
+    qmp_execute(fd, [
+        {"execute": "block-job-dismiss", "arguments": {"id": "resync"}},
+        {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"}}
+        ])
+
+def qmp_start_colo(fd, remote):
+    # Check if we have a filter-rewriter
+    answer =3D qmp_execute(fd, [{"execute": "qom-list", "arguments": {"pa=
th": "/objects/rew0"}}], True)
+    if "error" in answer:
+        if answer["error"]["class"] =3D=3D "DeviceNotFound":
+            have_filter_rewriter =3D False
+        else:
+            log.error("while checking for filter-rewriter:\n%s" \
+                        % json.dumps(answer))
+            raise Error()
+    else:
+        have_filter_rewriter =3D True
+
+    # Pause VM and cancel resync
+    qmp_execute(fd, [
+        {"execute": "stop"},
+        {"execute": "block-job-cancel", "arguments": {"device": "resync"}=
}
+        ])
+
+    # Wait for the block-job to finish
+    while qmp_check_resync(fd)["status"] !=3D "concluded":
+        time.sleep(1)
+
+    # Add the replication node
+    qmp_execute(fd, [
+        {"execute": "block-job-dismiss", "arguments": {"id": "resync"}},
+        {"execute": "blockdev-add", "arguments": {"driver": "replication"=
, "node-name": "replication0", "mode": "primary", "file": "nbd0"}},
+        {"execute": "x-blockdev-change", "arguments": {"parent": "colo-di=
sk0", "node": "replication0"}}
+        ])
+
+    # Connect mirror and compare_in to secondary
+    qmp_execute(fd, [
+        {"execute": "chardev-add", "arguments": {"id": "mirror0", "backen=
d": {"type": "socket", "data": {"addr": {"type": "inet", "data": {"host": =
str(remote), "port": str(MIROR_PORT)}}, "server": False, "reconnect": 1}}}=
},
+        {"execute": "chardev-add", "arguments": {"id": "compare1", "backe=
nd": {"type": "socket", "data": {"addr": {"type": "inet", "data": {"host":=
 str(remote), "port": str(COMPARE_IN_PORT)}}, "server": False, "reconnect"=
: 1}}}}
+        ])
+
+    # Add the COLO filters
+    if have_filter_rewriter:
+        qmp_execute(fd, [
+            {"execute": "object-add", "arguments": {"qom-type": "filter-m=
irror", "id": "m0", "props": {"insert": "before", "position": "id=3Drew0",=
 "netdev": "hn0", "queue": "tx", "outdev": "mirror0"}}},
+            {"execute": "object-add", "arguments": {"qom-type": "filter-r=
edirector", "id": "redire0", "props": {"insert": "before", "position": "id=
=3Drew0", "netdev": "hn0", "queue": "rx", "indev": "comp_out"}}},
+            {"execute": "object-add", "arguments": {"qom-type": "filter-r=
edirector", "id": "redire1", "props": {"insert": "before", "position": "id=
=3Drew0", "netdev": "hn0", "queue": "rx", "outdev": "comp0"}}},
+            {"execute": "object-add", "arguments": {"qom-type": "iothread=
", "id": "iothread1"}},
+            {"execute": "object-add", "arguments": {"qom-type": "colo-com=
pare", "id": "comp0", "props": {"primary_in": "comp0-0", "secondary_in": "=
compare1", "outdev": "comp_out0", "iothread": "iothread1"}}}
+            ])
+    else:
+        qmp_execute(fd, [
+            {"execute": "object-add", "arguments": {"qom-type": "filter-m=
irror", "id": "m0", "props": {"netdev": "hn0", "queue": "tx", "outdev": "m=
irror0"}}},
+            {"execute": "object-add", "arguments": {"qom-type": "filter-r=
edirector", "id": "redire0", "props": {"netdev": "hn0", "queue": "rx", "in=
dev": "comp_out"}}},
+            {"execute": "object-add", "arguments": {"qom-type": "filter-r=
edirector", "id": "redire1", "props": {"netdev": "hn0", "queue": "rx", "ou=
tdev": "comp0"}}},
+            {"execute": "object-add", "arguments": {"qom-type": "iothread=
", "id": "iothread1"}},
+            {"execute": "object-add", "arguments": {"qom-type": "colo-com=
pare", "id": "comp0", "props": {"primary_in": "comp0-0", "secondary_in": "=
compare1", "outdev": "comp_out0", "iothread": "iothread1"}}}
+            ])
+
+    # Start COLO
+    qmp_execute(fd, [
+        {"execute": "migrate-set-capabilities", "arguments": {"capabiliti=
es": [{"capability": "x-colo", "state": True }] }},
+        {"execute": "migrate-set-parameters" , "arguments": {"x-checkpoin=
t-delay": int(OCF_RESKEY_checkpoint_interval)}},
+        {"execute": "migrate", "arguments": {"uri": "tcp:%s:%s" % (remote=
, MIGRATE_PORT)}}
+        ])
+
+    # Wait for COLO to start
+    while qmp_execute(fd, [{"execute": "query-status"}])["return"]["statu=
s"] \
+            =3D=3D "paused":
+        time.sleep(1)
+
+def qmp_primary_failover(fd):
+    qmp_execute(fd, [
+        {"execute": "x-blockdev-change", "arguments": {"parent": "colo-di=
sk0", "child": "children.1"}},
+        {"execute": "blockdev-del", "arguments": {"node-name": "replicati=
on0"}},
+        {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"}},
+        {"execute": "object-del", "arguments": {"id": "comp0"}},
+        {"execute": "object-del", "arguments": {"id": "iothread1"}},
+        {"execute": "object-del", "arguments": {"id": "m0"}},
+        {"execute": "object-del", "arguments": {"id": "redire0"}},
+        {"execute": "object-del", "arguments": {"id": "redire1"}},
+        {"execute": "chardev-remove", "arguments": {"id": "mirror0"}},
+        {"execute": "chardev-remove", "arguments": {"id": "compare1"}},
+        {"execute": "x-colo-lost-heartbeat"}
+        ])
+
+def qmp_secondary_failover(fd):
+    # Stop the NBD server, and resume
+    qmp_execute(fd, [
+        {"execute": "nbd-server-stop"},
+        {"execute": "x-colo-lost-heartbeat"}
+        ])
+
+    # Prepare for continuing replication when we have a new secondary
+    qmp_execute(fd, [
+        {"execute": "object-del", "arguments": {"id": "f2"}},
+        {"execute": "object-del", "arguments": {"id": "f1"}},
+        {"execute": "chardev-remove", "arguments": {"id": "red1"}},
+        {"execute": "chardev-remove", "arguments": {"id": "red0"}},
+        {"execute": "chardev-add", "arguments": {"id": "comp0", "backend"=
: {"type": "socket", "data": {"addr": {"type": "unix", "data": {"path": st=
r(COMP_SOCK)}}, "server": True}}}},
+        {"execute": "chardev-add", "arguments": {"id": "comp0-0", "backen=
d": {"type": "socket", "data": {"addr": {"type": "unix", "data": {"path": =
str(COMP_SOCK)}}, "server": False}}}},
+        {"execute": "chardev-add", "arguments": {"id": "comp_out", "backe=
nd": {"type": "socket", "data": {"addr": {"type": "unix", "data": {"path":=
 str(COMP_OUT_SOCK)}}, "server": True}}}},
+        {"execute": "chardev-add", "arguments": {"id": "comp_out0", "back=
end": {"type": "socket", "data": {"addr": {"type": "unix", "data": {"path"=
: str(COMP_OUT_SOCK)}}, "server": False}}}}
+        ])
+
+# Sanity checks: check parameters, files, binaries, etc.
+def qemu_colo_validate_all():
+    # Check resource parameters
+    if not str.isdigit(OCF_RESKEY_base_port):
+        log.error("base_port needs to be a number")
+        return OCF_ERR_CONFIGURED
+
+    if not str.isdigit(OCF_RESKEY_checkpoint_interval):
+        log.error("checkpoint_interval needs to be a number")
+        return OCF_ERR_CONFIGURED
+
+    if not OCF_RESKEY_active_hidden_dir:
+        log.error("active_hidden_dir needs to be specified")
+        return OCF_ERR_CONFIGURED
+
+    if not OCF_RESKEY_disk_size:
+        log.error("disk_size needs to be specified")
+        return OCF_ERR_CONFIGURED
+
+    # Check resource meta configuration
+    if OCF_ACTION !=3D "stop":
+        if OCF_RESKEY_CRM_meta_master_max !=3D 1:
+            log.error("only one master allowed")
+            return OCF_ERR_CONFIGURED
+
+        if OCF_RESKEY_CRM_meta_clone_max > 2:
+            log.error("maximum 2 clones allowed")
+            return OCF_ERR_CONFIGURED
+
+        if OCF_RESKEY_CRM_meta_master_node_max !=3D 1:
+            log.error("only one master per node allowed")
+            return OCF_ERR_CONFIGURED
+
+        if OCF_RESKEY_CRM_meta_clone_node_max !=3D 1:
+            log.error("only one clone per node allowed")
+            return OCF_ERR_CONFIGURED
+
+    # Check if notify is enabled
+    if OCF_ACTION !=3D "stop" and OCF_ACTION !=3D "monitor":
+        if not is_true(OCF_RESKEY_CRM_meta_notify) \
+           and not OCF_RESKEY_CRM_meta_notify_start_uname:
+            log.error("notify needs to be enabled")
+            return OCF_ERR_CONFIGURED
+
+    # Check that globally-unique is disabled
+    if is_true(OCF_RESKEY_CRM_meta_globally_unique):
+        log.error("globally-unique needs to be disabled")
+        return OCF_ERR_CONFIGURED
+
+    # Check binaries
+    if not check_binary(OCF_RESKEY_binary):
+        return OCF_ERR_INSTALLED
+
+    if not check_binary("qemu-img"):
+        return OCF_ERR_INSTALLED
+
+    # Check paths and files
+    if not is_writable(OCF_RESKEY_active_hidden_dir) \
+        or not os.path.isdir(OCF_RESKEY_active_hidden_dir):
+        log.error("active and hidden image directory missing or not writa=
ble")
+        return OCF_ERR_PERM
+
+    return OCF_SUCCESS
+
+# Check if qemu is running
+def check_pid():
+    if not os.path.exists(PID_FILE):
+        return OCF_NOT_RUNNING, None
+
+    fd =3D open(PID_FILE, "r")
+    pid =3D int(str.strip(fd.readline()))
+    fd.close()
+    try:
+        os.kill(pid, 0)
+    except OSError:
+        log.info("qemu is not running")
+        return OCF_NOT_RUNNING, pid
+    else:
+        return OCF_SUCCESS, pid
+
+def qemu_colo_monitor(fail_fast =3D False):
+    status, pid =3D check_pid()
+    if status !=3D OCF_SUCCESS:
+        return status, OCF_ERR_GENERIC
+
+    fd =3D qmp_open(fail_fast)
+
+    role, replication =3D qmp_check_state(fd)
+    if role !=3D OCF_SUCCESS and role !=3D OCF_RUNNING_MASTER:
+        return role, replication
+
+    if not fail_fast and OCF_RESKEY_CRM_meta_interval !=3D 0:
+        # This isn't a probe monitor
+        block_job =3D qmp_check_resync(fd)
+        if block_job !=3D None:
+            if "error" in block_job:
+                log.error("resync error: %s" % block_job["error"])
+                qmp_cancel_resync(fd)
+                # TODO: notify pacemaker about peer failure
+            elif block_job["ready"] =3D=3D True:
+                log.info("resync done, starting colo")
+                peer =3D qmp_get_nbd_remote(fd)
+                qmp_start_colo(fd, peer)
+                # COLO started, our secondary now can be promoted if the
+                # primary fails
+                set_remote_master_score(peer, 100)
+            else:
+                pct_done =3D (float(block_job["offset"]) \
+                            / float(block_job["len"])) * 100
+                log.info("resync %.2f%% done" % pct_done)
+
+    fd.close()
+
+    return role, replication
+
+def qemu_colo_start():
+    if check_pid()[0] =3D=3D OCF_SUCCESS:
+        log.info("qemu is already running")
+        return OCF_SUCCESS
+
+    run_command("qemu-img create -q -f qcow2 %s %s" \
+                % (ACTIVE_IMAGE, OCF_RESKEY_disk_size))
+    run_command("qemu-img create -q -f qcow2 %s %s" \
+                % (HIDDEN_IMAGE, OCF_RESKEY_disk_size))
+
+    rotate_logfile(QMP_LOG, 4)
+    rotate_logfile(QEMU_LOG, 4)
+    run_command(QEMU_SECONDARY_CMDLINE)
+
+    fd =3D qmp_open()
+    qmp_execute(fd, [
+        {"execute": "nbd-server-start", "arguments": {"addr": {"type": "i=
net", "data": {"host": str(OCF_RESKEY_listen_address), "port": str(NBD_POR=
T)}}}},
+        {"execute": "nbd-server-add", "arguments": {"device": "parent0", =
"writable": True}}
+        ])
+    fd.close()
+
+    return OCF_SUCCESS
+
+def env_do_shutdown_guest():
+    return OCF_RESKEY_CRM_meta_notify_active_uname \
+           and OCF_RESKEY_CRM_meta_notify_stop_uname \
+           and str.strip(OCF_RESKEY_CRM_meta_notify_active_uname) \
+               =3D=3D str.strip(OCF_RESKEY_CRM_meta_notify_stop_uname)
+
+def env_find_secondary():
+    # slave(s) =3D
+    # OCF_RESKEY_CRM_meta_notify_slave_uname
+    # - OCF_RESKEY_CRM_meta_notify_stop_uname
+    # + OCF_RESKEY_CRM_meta_notify_start_uname
+    # Filter out hosts that are stopping and ourselves
+    for host in str.split(OCF_RESKEY_CRM_meta_notify_slave_uname, " "):
+        if host:
+            for stopping_host \
+                in str.split(OCF_RESKEY_CRM_meta_notify_stop_uname, " "):
+                if host =3D=3D stopping_host:
+                    break
+            else:
+                if host !=3D HOSTNAME:
+                    # we found a valid secondary
+                    return host
+
+    for host in str.split(OCF_RESKEY_CRM_meta_notify_start_uname, " "):
+        if host !=3D HOSTNAME:
+            # we found a valid secondary
+            return host
+
+    # we found no secondary
+    return None
+
+def _qemu_colo_stop(monstatus, shutdown_guest):
+    # stop action must do everything possible to stop the resource
+    try:
+        now =3D time.time()
+        timeout =3D now + (OCF_RESKEY_CRM_meta_timeout/1000)-10
+        force_stop =3D False
+
+        if monstatus =3D=3D OCF_NOT_RUNNING:
+            log.info("resource is already stopped")
+            return OCF_SUCCESS
+        elif monstatus =3D=3D OCF_RUNNING_MASTER or monstatus =3D=3D OCF_=
SUCCESS:
+            force_stop =3D False
+        else:
+            force_stop =3D True
+
+        if not force_stop:
+            fd =3D qmp_open(True)
+            if shutdown_guest:
+                if monstatus =3D=3D OCF_RUNNING_MASTER:
+                    qmp_execute(fd, [{"execute": "system_powerdown"}])
+            else:
+                qmp_execute(fd, [{"execute": "quit"}])
+            fd.close()
+
+            # wait for qemu to stop
+            while time.time() < timeout:
+                status, pid =3D check_pid()
+                if status =3D=3D OCF_NOT_RUNNING:
+                    # qemu stopped
+                    return OCF_SUCCESS
+                elif status =3D=3D OCF_SUCCESS:
+                    # wait
+                    time.sleep(1)
+                else:
+                    # something went wrong, force stop instead
+                    break
+
+            log.warning("clean stop timeout reached")
+    except Exception as e:
+        log.warning("error while stopping: \"%s\"" % e.message)
+
+    log.info("force stopping qemu")
+
+    status, pid =3D check_pid()
+    if status =3D=3D OCF_NOT_RUNNING:
+        return OCF_SUCCESS
+    try:
+        os.kill(pid, signal.SIGTERM)
+        time.sleep(2)
+        os.kill(pid, signal.SIGKILL)
+    except Exception:
+        pass
+
+    while check_pid()[0] !=3D OCF_NOT_RUNNING:
+        time.sleep(1)
+
+    return OCF_SUCCESS
+
+def qemu_colo_stop():
+    shutdown_guest =3D env_do_shutdown_guest()
+    try:
+        role, replication =3D qemu_colo_monitor(True)
+    except Exception:
+        role, replication =3D OCF_ERR_GENERIC, OCF_ERR_GENERIC
+
+    status =3D _qemu_colo_stop(role, shutdown_guest)
+
+    if HOSTNAME =3D=3D str.strip(OCF_RESKEY_CRM_meta_notify_master_uname)=
:
+        peer =3D env_find_secondary()
+        if peer and (get_remote_master_score(peer) > 10) \
+           and not shutdown_guest:
+            # We where a healthy primary and had a healthy secondary. We =
where
+            # stopped so outdate ourselves, as the secondary will take ov=
er.
+            set_master_score(0)
+        else:
+            if role =3D=3D OCF_RUNNING_MASTER:
+                # We where a healthy primary but had no healty secondary =
or it
+                # was stopped as well. So we have up-to-date data.
+                set_master_score(10)
+            else:
+                # We where a unhealthy primary but also had no healty sec=
ondary.
+                # So we still should have up-to-date data.
+                set_master_score(5)
+    else:
+        if get_master_score() > 10:
+            if role =3D=3D OCF_SUCCESS:
+                if shutdown_guest:
+                    # We where a healthy secondary and (probably) had a h=
ealthy
+                    # primary and both where stopped. So we have up-to-da=
te data
+                    # too.
+                    set_master_score(10)
+                else:
+                    # We where a healthy secondary and (probably) had a h=
ealthy
+                    # primary still running. So we are now out of date.
+                    set_master_score(0)
+            else:
+                # We where a unhealthy secondary. So we are now out of da=
te.
+                set_master_score(0)
+
+    return status
+
+def qemu_colo_notify():
+    action =3D "%s-%s" % (OCF_RESKEY_CRM_meta_notify_type, \
+                        OCF_RESKEY_CRM_meta_notify_operation)
+
+    if action =3D=3D "post-start":
+        if HOSTNAME =3D=3D str.strip(OCF_RESKEY_CRM_meta_notify_master_un=
ame):
+            peer =3D str.strip(OCF_RESKEY_CRM_meta_notify_start_uname)
+            fd =3D qmp_open()
+            qmp_start_resync(fd, peer)
+            fd.close()
+            # The secondary has inconsistent data until resync is finishe=
d
+            set_remote_master_score(peer, 0)
+
+    elif action =3D=3D "pre-stop":
+        if not env_do_shutdown_guest() \
+           and HOSTNAME =3D=3D str.strip(OCF_RESKEY_CRM_meta_notify_maste=
r_uname):
+            fd =3D qmp_open()
+            peer =3D qmp_get_nbd_remote(fd)
+            if peer =3D=3D str.strip(OCF_RESKEY_CRM_meta_notify_stop_unam=
e):
+                if qmp_check_resync(fd) !=3D None:
+                    qmp_cancel_resync(fd)
+                elif peer and get_remote_master_score(peer) > 10:
+                    qmp_primary_failover(fd)
+            fd.close()
+
+    return OCF_SUCCESS
+
+def qemu_colo_promote():
+    role, replication =3D qemu_colo_monitor()
+
+    if role =3D=3D OCF_SUCCESS and replication =3D=3D OCF_NOT_RUNNING:
+        status =3D _qemu_colo_stop(role, False)
+        if status !=3D OCF_SUCCESS:
+            return status
+
+        rotate_logfile(QMP_LOG, 4)
+        rotate_logfile(QEMU_LOG, 4)
+        run_command(QEMU_PRIMARY_CMDLINE)
+        set_master_score(101)
+
+        peer =3D env_find_secondary()
+        if peer:
+            fd =3D qmp_open()
+            qmp_start_resync(fd, peer)
+            # The secondary has inconsistent data until resync is finishe=
d
+            set_remote_master_score(peer, 0)
+            fd.close()
+        return OCF_SUCCESS
+    elif role =3D=3D OCF_SUCCESS and replication =3D=3D OCF_SUCCESS:
+        fd =3D qmp_open()
+        qmp_secondary_failover(fd)
+        set_master_score(101)
+
+        peer =3D env_find_secondary()
+        if peer:
+            qmp_start_resync(fd, peer)
+            # The secondary has inconsistent data until resync is finishe=
d
+            set_remote_master_score(peer, 0)
+        fd.close()
+        return OCF_SUCCESS
+    else:
+        return OCF_ERR_GENERIC
+
+def qemu_colo_demote():
+    status =3D qemu_colo_stop()
+    if status !=3D OCF_SUCCESS:
+        return status
+    return qemu_colo_start()
+
+
+if OCF_ACTION =3D=3D "meta-data":
+    qemu_colo_meta_data()
+    exit(OCF_SUCCESS)
+
+logs_open()
+
+status =3D qemu_colo_validate_all()
+# Exit here if our sanity checks fail, but try to continue if we need to =
stop
+if status !=3D OCF_SUCCESS and OCF_ACTION !=3D "stop":
+    exit(status)
+
+setup_constants()
+
+os.system("echo 'Action: %s' >> /tmp/ra-env.log" % OCF_ACTION)
+os.system("env >> /tmp/ra-env.log")
+
+try:
+    if OCF_ACTION =3D=3D "start":
+        status =3D qemu_colo_start()
+    elif OCF_ACTION =3D=3D "stop":
+        status =3D qemu_colo_stop()
+    elif OCF_ACTION =3D=3D "monitor":
+        status =3D qemu_colo_monitor()[0]
+    elif OCF_ACTION =3D=3D "notify":
+        status =3D qemu_colo_notify()
+    elif OCF_ACTION =3D=3D "promote":
+        status =3D qemu_colo_promote()
+    elif OCF_ACTION =3D=3D "demote":
+        status =3D qemu_colo_demote()
+    elif OCF_ACTION =3D=3D "validate-all":
+        status =3D qemu_colo_validate_all()
+    else:
+        status =3D OCF_ERR_UNIMPLEMENTED
+except Error:
+    exit(OCF_ERR_GENERIC)
+else:
+    exit(status)
=2D-
2.20.1


