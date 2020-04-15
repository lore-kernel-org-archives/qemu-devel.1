Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E472072D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E472072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWXa-00020n-VT
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOy-0000vw-Nc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOx-000524-I9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:40 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWOx-00050q-4G
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:39 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 C2F0730747C6; Wed, 15 Apr 2020 03:59:34 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id AD7E7305B7A3;
 Wed, 15 Apr 2020 03:59:34 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 08/26] kvm: add VM introspection usage documentation
Date: Wed, 15 Apr 2020 03:59:20 +0300
Message-Id: <20200415005938.23895-9-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marian Rotariu <marian.c.rotariu@gmail.com>

Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 qemu-options.hx | 76 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 16debd03cb..6c5618e310 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5005,6 +5005,82 @@ SRST
         ::
=20
             (qemu) qom-set /objects/iothread1 poll-max-ns 100000
+
+    ``-object introspection,id=3Did,chardev=3Did[,key=3Did][,handshake_t=
imeout=3Dseconds][,unhook_timeout=3Dseconds][,command=3Did[,...]][,event=3D=
id[,...]]``
+        Defines a VM Introspection (VMI) object that will connect to
+        an introspection tool, initiate the handshake and hand over the =
connection
+        file descriptor to KVM. The introspection channel will be used b=
y
+        the introspection tool to talk directly with KVM. If the VM is p=
aused
+        or migrated, QEMU will delay the action, signal KVM, which in tu=
rn will
+        signal the introspection tool to remove its hooks (e.g. breakpoi=
nts
+        placed inside the guest).
+
+        The ``chardev`` parameter provides the introspection channel.
+        This is the id of a previously created chardev socket,
+        with a non-zero reconnect parameter.
+
+        The ``key`` parameter is an optional secret object used to
+        authenticate the instrospection tool.
+
+        The ``handshake_timeout`` parameter specify how long will QEMU
+        wait for the introspection tool during handshake (default is
+        10 seconds).
+
+        The ``unhook_timeout` parameter specify how long will QEMU
+        wait for the introspection tool on pause/migrate (default is
+        60 seconds).
+
+        The ``command`` parameter specify an allowed introspection comma=
nd.
+        It can be used multiple times. If omitted, all commands are
+        allowed. For example, ``command=3D10,command=3D8`` will allow th=
e
+        introspection tool to use two commands, KVMI_VCPU_PAUSE(10) and
+        KVMI_VM_WRITE_PHYSICAL(8), in addition to those that are used
+        to query the API, which are always allowed (KVMI_GET_VERSION,
+        KVMI_VM_CHECK_COMMAND and KVMI_VM_CHECK_EVENT).
+
+        The ``event` parameter specify an allowed introspection event.
+        It can be used multiple times. If omitted, all events
+        are allowed. For example, ``event=3D1,event=3D3`` will
+        allow the introspection tool to receive only two events,
+        KVMI_EVENT_PAUSE_VCPU(1) and KVMI_EVENT_BREAKPOINT(3).
+
+        VM introspected through a unix socket:
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \
+                 ......
+                 -chardev socket,id=3Dvmi_chardev,type=3Dunix,path=3D/tm=
p/vmi-guest1.sock,reconnect=3D10 \
+                 -object introspection,id=3Dvmi,chardev=3Dvmi_chardev
+
+        VM introspected by an authenticated introspection tool:
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \
+                 ......
+                 -chardev socket,id=3Dvmi_chardev,type=3Dunix,path=3D/tm=
p/vmi-guest1.sock,reconnect=3D10 \
+                 -object secret,id=3Dvmi_key,file=3D/etc/secret \
+                 -object introspection,id=3Dvmi,chardev=3Dvmi_chardev,ke=
y=3Dvmi_key
+
+        VM introspected through a virtual socket, with the introspection=
 tool
+        listening on port 4321 from another VM started with cid=3D1234:
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \
+                 ......
+                 -chardev socket,id=3Dvmi_chardev,type=3Dvsock,cid=3D123=
4,port=3D4321,reconnect=3D10 \
+                 -object introspection,id=3Dvmi,chardev=3Dvmi_chardev
+
+        VM running the introspection tool:
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \
+                 ......
+                 -device vhost-vsock-pci,id=3Dvhost-vsock-pci0,guest-cid=
=3D1234
+
 ERST
=20
=20

