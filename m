Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54C5C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E7E20658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+aQHsC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E7E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7dds-00086Z-ON
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j7ddD-0007YS-4I
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j7ddB-0002cE-CK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:16:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j7ddB-0002bu-6s
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582888592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gbz6AWGt5oo130iG/bqflep+2Vo2s2tt06cN5Es++mQ=;
 b=c+aQHsC587/a3tXjliggVZmENr2IJL1M6lx+BoW3llW0BrefYpexaPhJuo6BxtPxnQMprj
 YAm7U3pi6hH2f8tTp1c3lwh3CACQGQT0248VDTC6GgngTElH+Hvyu0Yvm5QDQLJmk1QWuU
 90yMfZyLEkeHdebaxSuyyXD9TQ+bTkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-6nepMzdtNDqEmzjDA4DgBQ-1; Fri, 28 Feb 2020 06:16:29 -0500
X-MC-Unique: 6nepMzdtNDqEmzjDA4DgBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4EEE800D53;
 Fri, 28 Feb 2020 11:16:28 +0000 (UTC)
Received: from localhost (unknown [10.36.118.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 078278C089;
 Fri, 28 Feb 2020 11:16:27 +0000 (UTC)
Date: Fri, 28 Feb 2020 11:16:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/20] Add qemu-storage-daemon
Message-ID: <20200228111626.GC326000@stefanha-x1.localdomain>
References: <20200224143008.13362-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200224143008.13362-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, coiby.xu@gmail.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 03:29:48PM +0100, Kevin Wolf wrote:
> This series adds a new tool 'qemu-storage-daemon', which can be used to
> export and perform operations on block devices. There is some overlap
> between qemu-img/qemu-nbd and the new qemu-storage-daemon, but there are
> a few important differences:
>=20
> * The qemu-storage-daemon has QMP support. The command set is obviously
>   restricted compared to the system emulator because there is no guest,
>   but all of the block operations that are not tied to gues devices are
>   present.
>=20
>   This means that it can access advanced options or operations that the
>   qemu-img command line doesn't expose. For example, blockdev-create is
>   a lot more powerful than 'qemu-img create', and qemu-storage-daemon
>   allows to execute it without starting a guest.
>=20
>   Compared to qemu-nbd it means that, for example, block jobs can now be
>   executed on the server side, and backing chains shared by multiple VMs
>   can be modified this way.
>=20
> * The existing tools all have a separately invented one-off syntax for
>   the job at hand, which usually comes with restrictions compared to the
>   system emulator. qemu-storage-daemon shares the same syntax with the
>   system emulator for most options and prefers QAPI based interfaces
>   where possible (such as --blockdev), so it should be easy to make use
>   of in libvirt.
>=20
>   The exception is --chardev, for which not clear design for a QAPIfied
>   command line exists yet. We'll consider this interface unstable until
>   we've figured out how to solve it. For now it just uses the same
>   QemuOpts-based code as the system emulator.
>=20
> * While this series implements only NBD exports, the storage daemon is
>   intended to serve multiple protocols and its syntax reflects this. In
>   the past, we had proposals to add new one-off tools for exporting over
>   new protocols like FUSE or TCMU.
>=20
>   With a generic storage daemon, additional export methods have a home
>   without adding a new tool for each of them.
>=20
> The plan is to merge qemu-storage-daemon as an experimental feature with
> a reduced API stability promise in 5.0.
>=20
> Kevin Wolf (20):
>   qemu-storage-daemon: Add barebone tool
>   stubs: Add arch_type
>   block: Move system emulator QMP commands to block/qapi-sysemu.c
>   block: Move common QMP commands to block-core QAPI module
>   block: Move sysemu QMP commands to QAPI block module
>   qemu-storage-daemon: Add --blockdev option
>   qapi: Flatten object-add
>   qemu-storage-daemon: Add --object option
>   qemu-storage-daemon: Add --nbd-server option
>   blockdev-nbd: Boxed argument type for nbd-server-add
>   qemu-storage-daemon: Add --export option
>   qemu-storage-daemon: Add main loop
>   qemu-storage-daemon: Add --chardev option
>   stubs: Update monitor stubs for qemu-storage-daemon
>   qapi: Create 'pragma' module
>   monitor: Create QAPIfied monitor_init()
>   qmp: Fail gracefully if chardev is already in use
>   hmp: Fail gracefully if chardev is already in use
>   monitor: Add allow_hmp parameter to monitor_init()
>   qemu-storage-daemon: Add --monitor option
>=20
>  qapi/block-core.json                 | 730 +++++++++++++--------------
>  qapi/block.json                      | 512 +++++++++++--------
>  qapi/control.json                    |  37 ++
>  qapi/pragma.json                     |  24 +
>  qapi/qapi-schema.json                |  25 +-
>  qapi/qom.json                        |  12 +-
>  qapi/transaction.json                |   2 +-
>  configure                            |   2 +-
>  include/block/nbd.h                  |   1 +
>  include/monitor/monitor.h            |   6 +-
>  include/qom/object_interfaces.h      |   7 +
>  include/sysemu/arch_init.h           |   2 +
>  block/qapi-sysemu.c                  | 590 ++++++++++++++++++++++
>  blockdev-nbd.c                       |  40 +-
>  blockdev.c                           | 559 --------------------
>  chardev/char.c                       |   8 +-
>  gdbstub.c                            |   2 +-
>  hw/block/xen-block.c                 |  11 +-
>  monitor/hmp-cmds.c                   |  21 +-
>  monitor/hmp.c                        |   8 +-
>  monitor/misc.c                       |   2 +
>  monitor/monitor.c                    |  86 ++--
>  monitor/qmp-cmds.c                   |   2 +-
>  monitor/qmp.c                        |  11 +-
>  qemu-storage-daemon.c                | 340 +++++++++++++
>  qom/qom-qmp-cmds.c                   |  42 +-
>  stubs/arch_type.c                    |   4 +
>  stubs/monitor-core.c                 |  21 +
>  stubs/monitor.c                      |  17 +-
>  tests/test-util-sockets.c            |   4 +-
>  scripts/qapi/gen.py                  |   5 +
>  Makefile                             |  37 ++
>  Makefile.objs                        |   9 +
>  block/Makefile.objs                  |   4 +-
>  monitor/Makefile.objs                |   2 +
>  qapi/Makefile.objs                   |   7 +-
>  qemu-deprecated.texi                 |   4 +
>  qom/Makefile.objs                    |   1 +
>  storage-daemon/Makefile.objs         |   1 +
>  storage-daemon/qapi/Makefile.objs    |   1 +
>  storage-daemon/qapi/qapi-schema.json |  26 +
>  stubs/Makefile.objs                  |   2 +
>  42 files changed, 1955 insertions(+), 1272 deletions(-)
>  create mode 100644 qapi/pragma.json
>  create mode 100644 block/qapi-sysemu.c
>  create mode 100644 qemu-storage-daemon.c
>  create mode 100644 stubs/arch_type.c
>  create mode 100644 stubs/monitor-core.c
>  create mode 100644 storage-daemon/Makefile.objs
>  create mode 100644 storage-daemon/qapi/Makefile.objs
>  create mode 100644 storage-daemon/qapi/qapi-schema.json

I haven't reviewed the patches in detail since they are mostly concerned
with command-line interfaces and monitor changes.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5Y9ooACgkQnKSrs4Gr
c8iO1QgAup42ZoJBJIiPSf2BxPZuPYM2AEck7tMkOd3gmwb48de51I+MGi8vEPMz
Z2hw4CSBCVW1OEy1GqgvnNf2SCv7Htu/WxCd7ZRNjluJc6zdpQiFmnlZbnrhsDHh
KkBEQHYxGcy35ZFkVKdSG0ZCxd+RbthXDIiSudEbLTtK97t708FNyL+paBzQHIVR
To1ipr9j1PSny6rSu/F4SzHL5VLTsjO8Jytx0JoJH9GRDQi6qK7x92bJB6v66GGy
51OlJt+A1aiSRg4AmrqNV7D/iALZTcUcHntrAWpVjnCHvP4Qx0DHpoK5HeFy11it
YtveTmxARAvN9EgagxS5I7RlbYznGg==
=A8jW
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--


