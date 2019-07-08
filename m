Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E574C48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2E02084A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2E02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkO2Y-0003LJ-1M
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 03:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO14-000217-JE
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO13-0000ld-EX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkO12-0000jn-2U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 508FA883BA
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 07:24:45 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A3D737DD;
 Mon,  8 Jul 2019 07:24:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 11:24:34 +0400
Message-Id: <20190708072437.3339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 08 Jul 2019 07:24:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] Add dbus-vmstate
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

With external processes or helpers participating to the VM support, it
becomes necessary to handle their migration. Various options exist to
transfer their state:
1) as the VM memory, RAM or devices (we could say that's how
   vhost-user devices can be handled today, they are expected to
   restore from ring state)
2) other "vmstate" (as with TPM emulator state blobs)
3) left to be handled by management layer

1) is not practical, since an external processes may legitimatelly
need arbitrary state date to back a device or a service, or may not
even have an associated device.

2) needs ad-hoc code for each helper, but is simple and working

3) is complicated for management layer, QEMU has the migration timing

The proposed "dbus-vmstate" object will connect to a given D-Bus
address, and save/load from org.qemu.VMState1 owners on migration.

Thus helpers can easily have their state migrated with QEMU, without
implementing ad-hoc support (such as done for TPM emulation)

I chose D-Bus as it is ubiquitous on Linux (it is systemd IPC), and
can be made to work on various other OSes. There are several
implementations and good bindings for various languages.
(the tests/dbus-vmstate-test.c is a good example of how simple
the implementation of services can be, even in C)

The D-Bus protocol can be made to work peer-to-peer, but the most
common and practical way is through a bus daemon. This also has the
advantage of increased debuggability (you can eavesdrop on the bus and
introspect it).

dbus-vmstate is put into use by the libvirt series "[PATCH 00/23] Use
a slirp helper process".

Marc-Andr=C3=A9 Lureau (3):
  qemu-file: move qemu_{get,put}_counted_string() declarations
  tests: add qtest_set_exit_status()
  Add dbus-vmstate object

 MAINTAINERS                         |   6 +
 backends/Makefile.objs              |   4 +
 backends/dbus-vmstate.c             | 497 ++++++++++++++++++++++++++++
 configure                           |   7 +
 docs/interop/dbus-vmstate.rst       |  64 ++++
 docs/interop/index.rst              |   1 +
 include/migration/qemu-file-types.h |   4 +
 migration/qemu-file.h               |   4 -
 tests/Makefile.include              |  18 +-
 tests/dbus-vmstate-test.c           | 387 ++++++++++++++++++++++
 tests/dbus-vmstate1.xml             |  12 +
 tests/libqtest.c                    |  41 +--
 tests/libqtest.h                    |   9 +
 13 files changed, 1030 insertions(+), 24 deletions(-)
 create mode 100644 backends/dbus-vmstate.c
 create mode 100644 docs/interop/dbus-vmstate.rst
 create mode 100644 tests/dbus-vmstate-test.c
 create mode 100644 tests/dbus-vmstate1.xml

--=20
2.22.0.214.g8dca754b1e


