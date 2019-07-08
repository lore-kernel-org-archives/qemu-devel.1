Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A1C606C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C60C216E3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C60C216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkVq7-00061y-IF
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 11:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hkVoN-0005T9-7R
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hkVoM-0002br-2h
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:44:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hkVoL-0002at-QJ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C2CC30C5859
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 15:44:13 +0000 (UTC)
Received: from work-vm (ovpn-117-74.ams2.redhat.com [10.36.117.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 969F8608A4;
 Mon,  8 Jul 2019 15:44:09 +0000 (UTC)
Date: Mon, 8 Jul 2019 16:44:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190708154406.GL2746@work-vm>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190708072437.3339-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 08 Jul 2019 15:44:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Add dbus-vmstate
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
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi,
>=20
> With external processes or helpers participating to the VM support, it
> becomes necessary to handle their migration. Various options exist to
> transfer their state:
> 1) as the VM memory, RAM or devices (we could say that's how
>    vhost-user devices can be handled today, they are expected to
>    restore from ring state)
> 2) other "vmstate" (as with TPM emulator state blobs)
> 3) left to be handled by management layer
>=20
> 1) is not practical, since an external processes may legitimatelly
> need arbitrary state date to back a device or a service, or may not
> even have an associated device.
>=20
> 2) needs ad-hoc code for each helper, but is simple and working
>=20
> 3) is complicated for management layer, QEMU has the migration timing
>=20
> The proposed "dbus-vmstate" object will connect to a given D-Bus
> address, and save/load from org.qemu.VMState1 owners on migration.

Some very high level questions:
  a) If I've got two QEMU's running, how do the right devices
   end up migrating to the right qemu?
  b) Why use dbus for the comms? Don't all of the daemons have some
   protocol'd socket between QEMU and the daemon? If so they could
   send up a separate FD for migration data
  c) Your 1MB limit is pretty aribtary - it's nice to have a limit
    but it's hard to justify why it's that one.

Dave

> Thus helpers can easily have their state migrated with QEMU, without
> implementing ad-hoc support (such as done for TPM emulation)
>=20
> I chose D-Bus as it is ubiquitous on Linux (it is systemd IPC), and
> can be made to work on various other OSes. There are several
> implementations and good bindings for various languages.
> (the tests/dbus-vmstate-test.c is a good example of how simple
> the implementation of services can be, even in C)
>=20
> The D-Bus protocol can be made to work peer-to-peer, but the most
> common and practical way is through a bus daemon. This also has the
> advantage of increased debuggability (you can eavesdrop on the bus and
> introspect it).
>=20
> dbus-vmstate is put into use by the libvirt series "[PATCH 00/23] Use
> a slirp helper process".
>=20
> Marc-Andr=E9 Lureau (3):
>   qemu-file: move qemu_{get,put}_counted_string() declarations
>   tests: add qtest_set_exit_status()
>   Add dbus-vmstate object
>=20
>  MAINTAINERS                         |   6 +
>  backends/Makefile.objs              |   4 +
>  backends/dbus-vmstate.c             | 497 ++++++++++++++++++++++++++++
>  configure                           |   7 +
>  docs/interop/dbus-vmstate.rst       |  64 ++++
>  docs/interop/index.rst              |   1 +
>  include/migration/qemu-file-types.h |   4 +
>  migration/qemu-file.h               |   4 -
>  tests/Makefile.include              |  18 +-
>  tests/dbus-vmstate-test.c           | 387 ++++++++++++++++++++++
>  tests/dbus-vmstate1.xml             |  12 +
>  tests/libqtest.c                    |  41 +--
>  tests/libqtest.h                    |   9 +
>  13 files changed, 1030 insertions(+), 24 deletions(-)
>  create mode 100644 backends/dbus-vmstate.c
>  create mode 100644 docs/interop/dbus-vmstate.rst
>  create mode 100644 tests/dbus-vmstate-test.c
>  create mode 100644 tests/dbus-vmstate1.xml
>=20
> --=20
> 2.22.0.214.g8dca754b1e
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

