Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71511C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4257D20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OSE-0003TF-Bu
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAm-0003Os-FJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAl-0007aJ-7a
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:26:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i8OAl-0007ZW-0K
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:26:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCB6D3082B45
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:26:00 +0000 (UTC)
Received: from localhost (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08A0F5F700;
 Thu, 12 Sep 2019 12:25:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 16:25:13 +0400
Message-Id: <20190912122514.22504-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190912122514.22504-1-marcandre.lureau@redhat.com>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 12 Sep 2019 12:26:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 5/6] docs: start a document to describe
 D-Bus usage
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/dbus.rst  | 73 ++++++++++++++++++++++++++++++++++++++++++
 docs/interop/index.rst |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 docs/interop/dbus.rst

diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
new file mode 100644
index 0000000000..c08f026edc
--- /dev/null
+++ b/docs/interop/dbus.rst
@@ -0,0 +1,73 @@
+=3D=3D=3D=3D=3D
+D-Bus
+=3D=3D=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+QEMU may be running with various helper processes involved:
+ - vhost-user* processes (gpu, virtfs, input, etc...)
+ - TPM emulation (or other devices)
+ - user networking (slirp)
+ - network services (DHCP/DNS, samba/ftp etc)
+ - background tasks (compression, streaming etc)
+ - client UI
+ - admin & cli
+
+Having several processes allows stricter security rules, as well as
+greater modularity.
+
+While QEMU itself uses QMP as primary IPC (and Spice/VNC for remote
+display), D-Bus is the de facto IPC of choice on Unix systems. The
+wire format is machine friendly, good bindings exist for various
+languages, and there are various tools available.
+
+Using a bus, helper processes can discover and communicate with each
+other easily, without going through QEMU. The bus topology is also
+easier to apprehend and debug than a mesh. However, it is wise to
+consider the security aspects of it.
+
+Security
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+A QEMU D-Bus bus should be private to a single VM. Thus, only
+cooperative tasks are running on the same bus to serve the VM.
+
+D-Bus, the protocol and standard, doesn't have mechanisms to enforce
+security between peers once the connection is established. Peers may
+have additional mechanisms to enforce security rules, based for
+example on UNIX credentials.
+
+dbus-daemon can enforce various policies based on the UID/GID of the
+processes that are connected to it. It is thus a good idea to run
+helpers as different UID from QEMU and set appropriate policies (so
+helper processes are only allowed to talk to qemu for example).
+
+For example, this allows only ``qemu`` user to talk to ``qemu-helper``
+``org.qemu.Helper1`` service:
+
+.. code:: xml
+
+  <policy user=3D"qemu">
+     <allow send_destination=3D"org.qemu.Helper1"/>
+     <allow receive_sender=3D"org.qemu.Helper1"/>
+  </policy>
+
+  <policy user=3D"qemu-helper">
+     <allow own=3D"org.qemu.Helper1"/>
+  </policy>
+
+
+dbus-daemon can also perfom SELinux checks based on the security
+context of the source and the target. For example, ``virtiofs_t``
+could be allowed to send a message to ``svirt_t``, but ``virtiofs_t``
+wouldn't be allowed to send a message to ``virtiofs_t``.
+
+Guidelines
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+When implementing new D-Bus interfaces, it is recommended to follow
+the "D-Bus API Design Guidelines":
+https://dbus.freedesktop.org/doc/dbus-api-design.html
+
+The "org.qemu*" prefix is reserved for the QEMU project.
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index b4bfcab417..fa4478ce2e 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -13,6 +13,7 @@ Contents:
    :maxdepth: 2
=20
    bitmaps
+   dbus
    live-block-operations
    pr-helper
    vhost-user
--=20
2.23.0


