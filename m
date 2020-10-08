Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D40AC46466
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70676215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfURCGdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70676215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYIR-00069O-EI
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQYEL-0001s3-UN
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQYEJ-0002uy-6F
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602172398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LAAuBQtgR4XzpIlueYof343LEvr48mTFdAFpbbNRGnk=;
 b=DfURCGdumALn2nLytV5FPpZamD54YbP8TvJv5H5PbIMLkSJk7GcrYR1oxMuhBhxnhRa3G+
 MNe6jl/EzXrGqWoEtvOytCLcTusjPEMLmPS1WDoFm0fFP7KfOgimgdWfVOXuEjmLWeDZNJ
 UD8ECkLR0Vp7gSyfVfq8LELR2coaBm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-VZU2TzSDPyaoeyHrOAG5Kg-1; Thu, 08 Oct 2020 11:53:16 -0400
X-MC-Unique: VZU2TzSDPyaoeyHrOAG5Kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7FBA1074653;
 Thu,  8 Oct 2020 15:53:14 +0000 (UTC)
Received: from localhost (ovpn-113-63.ams2.redhat.com [10.36.113.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5EC55760;
 Thu,  8 Oct 2020 15:53:14 +0000 (UTC)
Date: Thu, 8 Oct 2020 16:53:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v8 00/14] monitor: Optionally run handlers in coroutines
Message-ID: <20201008155313.GB31472@stefanha-x1.localdomain>
References: <20201005155855.256490-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201005155855.256490-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: marcandre.lureau@gmail.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 05:58:41PM +0200, Kevin Wolf wrote:
> Some QMP command handlers can block the main loop for a relatively long
> time, for example because they perform some I/O. This is quite nasty.
> Allowing such handlers to run in a coroutine where they can yield (and
> therefore release the BQL) while waiting for an event such as I/O
> completion solves the problem.
>=20
> This series adds the infrastructure to allow this and switches
> block_resize to run in a coroutine as a first example.
>=20
> This is an alternative solution to Marc-Andr=E9's "monitor: add
> asynchronous command type" series.
>=20
> v8:
> - Replaced bdrv_co_move_to_aio_context() with bdrv_co_enter()/leave(),
>   added bdrv_co_lock()/unlock() and fixed the iothread support in
>   qmp_block_resize() with the new functions [Stefan]
> - More detailed documentation of 'coroutine' flag for commands [Markus]
> - Improved comment for dropping out of coroutine context in
>   qmp_dispatch() [Markus]
> - Coding style changes [Markus]
> - Resolve some more merge conflicts on rebase
>=20
> v7:
> - Added patch 2 to add a Monitor parameter to monitor_get_cpu_index(),
>   too [Markus]
> - Let monitor_set_cur() return the old monitor [Markus]
> - Fixed comment about linking stub objects in test-util-sockets [Markus]
> - More detailed commit message for per-coroutine current monitor and
>   document that monitor_set_cur(NULL) must be called eventually [Markus]
> - Resolve some merge conflicts on rebase
>=20
> v6:
> - Fixed cur_mon behaviour: It should always point to the Monitor while
>   we're in the handler coroutine, but be NULL while the handler
>   coroutines has yielded. [Markus]
> - Give HMP handlers the coroutine option, too, because they will call
>   QMP handlers, and life is easier when we know whether we are in
>   coroutine context or not.
> - Fixed block_resize for block devices in iothreads and for HMP
> - Resolved some merge conflict with QAPI generator and monitor
>   refactorings that were merged in the meantime
>=20
> v5:
> - Improved comments and documentation [Markus]
>=20
> v4:
> - Forbid 'oob': true, 'coroutine': true [Markus]
> - Removed Python type hints [Markus]
> - Introduced separate bool qmp_dispatcher_co_shutdown to make it clearer
>   how a shutdown request is signalled to the dispatcher [Markus]
> - Allow using aio_poll() with iohandler_ctx and use that instead of
>   aio_bh_poll() [Markus]
> - Removed coroutine_fn from qmp_block_resize() again because at least
>   one caller (HMP) calls it outside of coroutine context [Markus]
> - Tried to make the synchronisation between dispatcher and the monitor
>   thread clearer, and fixed a race condition
> - Improved documentation and comments
>=20
> v3:
> - Fix race between monitor thread and dispatcher that could schedule the
>   dispatcher coroutine twice if a second requests comes in before the
>   dispatcher can wake up [Patchew]
>=20
> v2:
> - Fix typo in a commit message [Eric]
> - Use hyphen instead of underscore for the test command [Eric]
> - Mark qmp_block_resize() as coroutine_fn [Stefan]
>=20
>=20
> Kevin Wolf (14):
>   monitor: Add Monitor parameter to monitor_set_cpu()
>   monitor: Add Monitor parameter to monitor_get_cpu_index()
>   monitor: Use getter/setter functions for cur_mon
>   hmp: Update current monitor only in handle_hmp_command()
>   qmp: Assert that no other monitor is active
>   qmp: Call monitor_set_cur() only in qmp_dispatch()
>   monitor: Make current monitor a per-coroutine property
>   qapi: Add a 'coroutine' flag for commands
>   qmp: Move dispatcher to a coroutine
>   hmp: Add support for coroutine command handlers
>   util/async: Add aio_co_reschedule_self()
>   block: Add bdrv_co_enter()/leave()
>   block: Add bdrv_lock()/unlock()
>   block: Convert 'block_resize' to coroutine
>=20
>  qapi/block-core.json                    |   3 +-
>  docs/devel/qapi-code-gen.txt            |  29 ++++++
>  docs/sphinx/qapidoc.py                  |   2 +-
>  include/block/aio.h                     |  10 ++
>  include/block/block.h                   |  31 ++++++
>  include/monitor/monitor.h               |   7 +-
>  include/qapi/qmp/dispatch.h             |   5 +-
>  monitor/monitor-internal.h              |   7 +-
>  audio/wavcapture.c                      |   8 +-
>  block.c                                 |  50 +++++++++
>  blockdev.c                              |  16 +--
>  dump/dump.c                             |   2 +-
>  hw/core/machine-hmp-cmds.c              |   2 +-
>  hw/scsi/vhost-scsi.c                    |   2 +-
>  hw/virtio/vhost-vsock.c                 |   2 +-
>  migration/fd.c                          |   4 +-
>  monitor/hmp-cmds.c                      |   4 +-
>  monitor/hmp.c                           |  44 ++++++--
>  monitor/misc.c                          |  38 +++----
>  monitor/monitor.c                       | 101 ++++++++++++++++--
>  monitor/qmp-cmds-control.c              |   2 +
>  monitor/qmp-cmds.c                      |   2 +-
>  monitor/qmp.c                           | 131 +++++++++++++++++-------
>  net/socket.c                            |   2 +-
>  net/tap.c                               |   6 +-
>  qapi/qmp-dispatch.c                     |  65 +++++++++++-
>  qapi/qmp-registry.c                     |   3 +
>  qga/main.c                              |   2 +-
>  softmmu/cpus.c                          |   2 +-
>  stubs/monitor-core.c                    |  10 +-
>  tests/test-qmp-cmds.c                   |  10 +-
>  tests/test-util-sockets.c               |  12 +--
>  trace/control.c                         |   2 +-
>  util/aio-posix.c                        |   8 +-
>  util/async.c                            |  30 ++++++
>  util/qemu-error.c                       |   6 +-
>  util/qemu-print.c                       |   3 +-
>  util/qemu-sockets.c                     |   1 +
>  scripts/qapi/commands.py                |  10 +-
>  scripts/qapi/expr.py                    |  11 +-
>  scripts/qapi/introspect.py              |   2 +-
>  scripts/qapi/schema.py                  |  13 ++-
>  tests/qapi-schema/test-qapi.py          |   7 +-
>  hmp-commands.hx                         |   1 +
>  tests/qapi-schema/meson.build           |   1 +
>  tests/qapi-schema/oob-coroutine.err     |   2 +
>  tests/qapi-schema/oob-coroutine.json    |   2 +
>  tests/qapi-schema/oob-coroutine.out     |   0
>  tests/qapi-schema/qapi-schema-test.json |   1 +
>  tests/qapi-schema/qapi-schema-test.out  |   2 +
>  50 files changed, 573 insertions(+), 143 deletions(-)
>  create mode 100644 tests/qapi-schema/oob-coroutine.err
>  create mode 100644 tests/qapi-schema/oob-coroutine.json
>  create mode 100644 tests/qapi-schema/oob-coroutine.out
>=20
> --=20
> 2.25.4
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9/NekACgkQnKSrs4Gr
c8hj0AgAsMeGy7puzGIw0wyTnlfiENdUB/skP7RRltQrKQa4batxT/iUulN+9b71
oNoe1F0InReE7ltE6QifvkYQsD78BQj++zUtUbRCL5SBbtWu8PG/CoJ0oyQ5y2wr
q7pmvRWdPkhjsau3Rfpowg6kRzFynhsuRT4WwKWPw+13ldC+9dJu/o1eyeqhY2uH
UL58zZ6XYgYhlFO7z80trMdFHwXFYWaHaeoRsiYufYClYBegGG3jt8enwqMBFoSo
MD1EeVKRdec96JKFz0+QMOZqDn46fGpSNKKz+MlhYTMom1DmUzbQ8m6b65Hwkka5
o9zpLWnnuks4UxzGucBhDXxEVMo6zA==
=yh5y
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--


