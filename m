Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74178C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5FD20726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFRouoSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5FD20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00Ma-00053y-EG
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1j00Li-00045y-Aj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1j00Lg-00070H-Lu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:54:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1j00Lg-0006yu-ID
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581069296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AN5OEky6D4oYKbeemXq5L4usGQTYVf9ZivJAlrymxKg=;
 b=QFRouoSM8tkD1KsI1VEUMutdHfcWBCCZ8EenBeVuns4uhR0aKXysVDlKfV3DlYGpLEQWX8
 tcgLf75U4AKZrMHCisnJKgTBrK0xg4dqBIbZrj3q9LE1Q+Me+YeOHVPg2p28egD7zSIM+Y
 7FfEM2uZzo3Q3YzPNwcihuiMMcDzGuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-N8qJ8B96NG6KOU_FL9T9fA-1; Fri, 07 Feb 2020 04:54:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62133801FB4
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 09:54:53 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-229.ams2.redhat.com
 [10.36.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09CD78EA10;
 Fri,  7 Feb 2020 09:54:12 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] tests/vhost-user-bridge: move to contrib/
Date: Fri,  7 Feb 2020 10:54:11 +0100
Message-Id: <20200207095412.794912-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: N8qJ8B96NG6KOU_FL9T9fA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhost-user-bridge is not a test. Move it to contrib/ and
add it to the tools list.

It will be built only if tools (--enable-tools) and
vhost-user (--enable-vhost-user) are enabled (both are set
by default).

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---

Notes:
    v2: update docs

 Makefile                                                      | 3 +++
 Makefile.objs                                                 | 1 +
 configure                                                     | 3 +++
 contrib/vhost-user-bridge/Makefile.objs                       | 1 +
 tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c | 0
 docs/devel/migration.rst                                      | 2 +-
 tests/Makefile.include                                        | 1 -
 7 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 contrib/vhost-user-bridge/Makefile.objs
 rename tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c (10=
0%)

diff --git a/Makefile b/Makefile
index 461d40bea6c2..23342a433e11 100644
--- a/Makefile
+++ b/Makefile
@@ -442,6 +442,7 @@ dummy :=3D $(call unnest-vars,, \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
+                vhost-user-bridge-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -672,6 +673,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libv=
host-user.a
 =09$(call LINK, $^)
 vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
 =09$(call LINK, $^)
+vhost-user-bridge$(EXESUF): $(vhost-user-bridge-obj-y) libvhost-user.a
+=09$(call LINK, $^)
=20
 rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 26b9cff95436..0240100b9a17 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -109,6 +109,7 @@ vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
 vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
+vhost-user-bridge-obj-y =3D contrib/vhost-user-bridge/
 rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 vhost-user-input-obj-y =3D contrib/vhost-user-input/
 vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
diff --git a/configure b/configure
index 115dc38085f3..0415eb5c99d3 100755
--- a/configure
+++ b/configure
@@ -6223,6 +6223,9 @@ if test "$want_tools" =3D "yes" ; then
   if [ "$curl" =3D "yes" ]; then
       tools=3D"elf2dmp\$(EXESUF) $tools"
   fi
+  if [ "$vhost_user" =3D "yes" ]; then
+      tools=3D"vhost-user-bridge\$(EXESUF) $tools"
+  fi
 fi
 if test "$softmmu" =3D yes ; then
   if test "$linux" =3D yes; then
diff --git a/contrib/vhost-user-bridge/Makefile.objs b/contrib/vhost-user-b=
ridge/Makefile.objs
new file mode 100644
index 000000000000..36a8d9b49a05
--- /dev/null
+++ b/contrib/vhost-user-bridge/Makefile.objs
@@ -0,0 +1 @@
+vhost-user-bridge-obj-y =3D main.o
diff --git a/tests/vhost-user-bridge.c b/contrib/vhost-user-bridge/main.c
similarity index 100%
rename from tests/vhost-user-bridge.c
rename to contrib/vhost-user-bridge/main.c
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index e88918f7639e..d00424460e23 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -807,7 +807,7 @@ The Linux kernel userfault support works on `/dev/shm` =
memory and on `hugetlbfs`
 for hugetlbfs which may be a problem in some configurations).
=20
 The vhost-user code in QEMU supports clients that have Postcopy support,
-and the `vhost-user-bridge` (in `tests/`) and the DPDK package have change=
s
+and the `vhost-user-bridge` (in `contrib/`) and the DPDK package have chan=
ges
 to support postcopy.
=20
 The client needs to open a userfaultfd and register the areas
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2f1cafed720d..78cdbe91aed5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -586,7 +586,6 @@ include $(SRC_PATH)/tests/qtest/Makefile.include
=20
 tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
-tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a
=20
 SPEED =3D quick
=20
--=20
2.24.1


