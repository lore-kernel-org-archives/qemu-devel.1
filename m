Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A3EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F0420836
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9PdZM61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F0420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9AwR-0000DV-SB
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j9Aus-0005sg-GX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j9Auq-0007CY-3g
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:01:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j9Aup-0007C5-TX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583254867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vH3sf2ImCSNIYjZVOyVm5ozvw71XtBvmQ0y+9fCrp4M=;
 b=F9PdZM61s0NVk1w+8+wcgGTT/ljFd/aRHjtjC64AdCLg2dREcL1zbYMEbXIgCD7biG6JGL
 31se91v4o9gZDjreFHZ/6I0r081Yb+m3LX8DOoVaB6GtsOT3r/j3QaS1sTlSjWikKmGL7R
 U6+T5nP6k44Hv9CemH1FK38/Ax6wMuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-KuKfufIrNKueke2dQC5aSw-1; Tue, 03 Mar 2020 12:01:02 -0500
X-MC-Unique: KuKfufIrNKueke2dQC5aSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50E67190D341;
 Tue,  3 Mar 2020 17:01:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-229.ams2.redhat.com [10.36.117.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 744731BC6D;
 Tue,  3 Mar 2020 17:00:56 +0000 (UTC)
Date: Tue, 3 Mar 2020 18:00:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 00/20] Add qemu-storage-daemon
Message-ID: <20200303170055.GE5733@linux.fritz.box>
References: <20200224143008.13362-1-kwolf@redhat.com>
 <20200228111626.GC326000@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200228111626.GC326000@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, coiby.xu@gmail.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.02.2020 um 12:16 hat Stefan Hajnoczi geschrieben:
> On Mon, Feb 24, 2020 at 03:29:48PM +0100, Kevin Wolf wrote:
> > This series adds a new tool 'qemu-storage-daemon', which can be used to
> > export and perform operations on block devices. There is some overlap
> > between qemu-img/qemu-nbd and the new qemu-storage-daemon, but there ar=
e
> > a few important differences:
> >=20
> > * The qemu-storage-daemon has QMP support. The command set is obviously
> >   restricted compared to the system emulator because there is no guest,
> >   but all of the block operations that are not tied to gues devices are
> >   present.
> >=20
> >   This means that it can access advanced options or operations that the
> >   qemu-img command line doesn't expose. For example, blockdev-create is
> >   a lot more powerful than 'qemu-img create', and qemu-storage-daemon
> >   allows to execute it without starting a guest.
> >=20
> >   Compared to qemu-nbd it means that, for example, block jobs can now b=
e
> >   executed on the server side, and backing chains shared by multiple VM=
s
> >   can be modified this way.
> >=20
> > * The existing tools all have a separately invented one-off syntax for
> >   the job at hand, which usually comes with restrictions compared to th=
e
> >   system emulator. qemu-storage-daemon shares the same syntax with the
> >   system emulator for most options and prefers QAPI based interfaces
> >   where possible (such as --blockdev), so it should be easy to make use
> >   of in libvirt.
> >=20
> >   The exception is --chardev, for which not clear design for a QAPIfied
> >   command line exists yet. We'll consider this interface unstable until
> >   we've figured out how to solve it. For now it just uses the same
> >   QemuOpts-based code as the system emulator.
> >=20
> > * While this series implements only NBD exports, the storage daemon is
> >   intended to serve multiple protocols and its syntax reflects this. In
> >   the past, we had proposals to add new one-off tools for exporting ove=
r
> >   new protocols like FUSE or TCMU.
> >=20
> >   With a generic storage daemon, additional export methods have a home
> >   without adding a new tool for each of them.
> >=20
> > The plan is to merge qemu-storage-daemon as an experimental feature wit=
h
> > a reduced API stability promise in 5.0.
> >=20
> > Kevin Wolf (20):
> >   qemu-storage-daemon: Add barebone tool
> >   stubs: Add arch_type
> >   block: Move system emulator QMP commands to block/qapi-sysemu.c
> >   block: Move common QMP commands to block-core QAPI module
> >   block: Move sysemu QMP commands to QAPI block module
> >   qemu-storage-daemon: Add --blockdev option
> >   qapi: Flatten object-add
> >   qemu-storage-daemon: Add --object option
> >   qemu-storage-daemon: Add --nbd-server option
> >   blockdev-nbd: Boxed argument type for nbd-server-add
> >   qemu-storage-daemon: Add --export option
> >   qemu-storage-daemon: Add main loop
> >   qemu-storage-daemon: Add --chardev option
> >   stubs: Update monitor stubs for qemu-storage-daemon
> >   qapi: Create 'pragma' module
> >   monitor: Create QAPIfied monitor_init()
> >   qmp: Fail gracefully if chardev is already in use
> >   hmp: Fail gracefully if chardev is already in use
> >   monitor: Add allow_hmp parameter to monitor_init()
> >   qemu-storage-daemon: Add --monitor option
> >=20
> >  qapi/block-core.json                 | 730 +++++++++++++--------------
> >  qapi/block.json                      | 512 +++++++++++--------
> >  qapi/control.json                    |  37 ++
> >  qapi/pragma.json                     |  24 +
> >  qapi/qapi-schema.json                |  25 +-
> >  qapi/qom.json                        |  12 +-
> >  qapi/transaction.json                |   2 +-
> >  configure                            |   2 +-
> >  include/block/nbd.h                  |   1 +
> >  include/monitor/monitor.h            |   6 +-
> >  include/qom/object_interfaces.h      |   7 +
> >  include/sysemu/arch_init.h           |   2 +
> >  block/qapi-sysemu.c                  | 590 ++++++++++++++++++++++
> >  blockdev-nbd.c                       |  40 +-
> >  blockdev.c                           | 559 --------------------
> >  chardev/char.c                       |   8 +-
> >  gdbstub.c                            |   2 +-
> >  hw/block/xen-block.c                 |  11 +-
> >  monitor/hmp-cmds.c                   |  21 +-
> >  monitor/hmp.c                        |   8 +-
> >  monitor/misc.c                       |   2 +
> >  monitor/monitor.c                    |  86 ++--
> >  monitor/qmp-cmds.c                   |   2 +-
> >  monitor/qmp.c                        |  11 +-
> >  qemu-storage-daemon.c                | 340 +++++++++++++
> >  qom/qom-qmp-cmds.c                   |  42 +-
> >  stubs/arch_type.c                    |   4 +
> >  stubs/monitor-core.c                 |  21 +
> >  stubs/monitor.c                      |  17 +-
> >  tests/test-util-sockets.c            |   4 +-
> >  scripts/qapi/gen.py                  |   5 +
> >  Makefile                             |  37 ++
> >  Makefile.objs                        |   9 +
> >  block/Makefile.objs                  |   4 +-
> >  monitor/Makefile.objs                |   2 +
> >  qapi/Makefile.objs                   |   7 +-
> >  qemu-deprecated.texi                 |   4 +
> >  qom/Makefile.objs                    |   1 +
> >  storage-daemon/Makefile.objs         |   1 +
> >  storage-daemon/qapi/Makefile.objs    |   1 +
> >  storage-daemon/qapi/qapi-schema.json |  26 +
> >  stubs/Makefile.objs                  |   2 +
> >  42 files changed, 1955 insertions(+), 1272 deletions(-)
> >  create mode 100644 qapi/pragma.json
> >  create mode 100644 block/qapi-sysemu.c
> >  create mode 100644 qemu-storage-daemon.c
> >  create mode 100644 stubs/arch_type.c
> >  create mode 100644 stubs/monitor-core.c
> >  create mode 100644 storage-daemon/Makefile.objs
> >  create mode 100644 storage-daemon/qapi/Makefile.objs
> >  create mode 100644 storage-daemon/qapi/qapi-schema.json
>=20
> I haven't reviewed the patches in detail since they are mostly concerned
> with command-line interfaces and monitor changes.
>=20
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to the block branch.

Kevin

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeXo1HAAoJEH8JsnLIjy/Wg50QAIFyPROsy6r8ClOwDB2CDU24
1nwaHGZNOFk+O1dVl2k4to67vXi1U2fp+UE/LhbC8Ks4sBKxAd6rhPiFY3fH/gWQ
MxN4+boekYZATvyOiQ1so+hKtLItIittpTcOZFL51OmQrGdC40m/B5NCsAclya/h
R46SNoyaaxEUCJLDkM976KPZSJXDwBNH6l4msMh8/Nr47t5kcZNV71c9fPUwCMxE
dLwfPcWh7LgTan+FlY2k4BGGGHUG0dUuUXUN3C3sxwyPwZnBx/cd9exFQ+PslsLd
9a9DqElUsVJP7gKx1dNAb7i4U/Sxn0XeWZU+N1pAss8D/kjGorklgxqe4v8kmCMF
jLc+wdeLDHbVG56ZLuiMnxgHWBL3se/As9BxmrvRBWVWW6MkQugV1I+VwnAmj0nl
GlIxY3OWwluFtE/zvuS6T+6l21xIRHNPLwtCgj6HRBJ4kof/CvqVtxNsAtmYwQbR
39lh9E4U4v0UKONx1WfQFSsNOutcrB/WtWNJT6Wid0g3PK/U6aVW7ntW6HONeaBC
T9vpyhQ0xwFm0kMI7ORIRVjhSi6oG0fJ2Z8YNEJPwcJs582IB+tS4ZbYqF1GoK5D
dYiG+qQQBun4NlwR0n8bqMvcWzHCgb7oKVr0SaOrQNtu8+JpLrZqYquxWoo5wsly
/yym38h4PnorP8+MefQw
=DcjC
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


