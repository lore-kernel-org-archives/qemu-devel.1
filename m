Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D927BC17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 11:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68732245A
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 11:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMiQaTds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68732245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUr5X-0003Ej-QD
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 06:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUr3v-0001rH-B9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUr3t-0001W4-TO
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:43:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44229
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUr3t-0001Vv-O9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573645429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B9wfHF6Z8mq74cy7glfE9DySkB2+gCVcwMpMkOfFtQ=;
 b=WMiQaTdsaPpN0Yu1g8EOgcEICli9yOzcAXygAwn7eGJfq7sK4zdM5pic3aqNk3CuT3WaH+
 b8YZKDz0Lq64cn++ItrdWR56uBI2/IR3W1VuCTEh4sq6ZWHZ3eG1rb1fZ9GCf5PE/J0Bi4
 aQ8RTNjgHb8XI840cIpGNHV+SaCSk5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-wxxy3-YEN0-eQ4GeFTGKMg-1; Wed, 13 Nov 2019 06:43:45 -0500
X-MC-Unique: wxxy3-YEN0-eQ4GeFTGKMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 731038048E2;
 Wed, 13 Nov 2019 11:43:44 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 462BC28DD1;
 Wed, 13 Nov 2019 11:43:38 +0000 (UTC)
Date: Wed, 13 Nov 2019 11:43:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 00/15] io_uring: add Linux io_uring AIO engine
Message-ID: <20191113114337.GD538417@stefanha-x1.localdomain>
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191104103233.GA6885@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191104103233.GA6885@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 11:32:33AM +0100, Stefan Hajnoczi wrote:
> On Fri, Oct 25, 2019 at 06:04:29PM +0200, Stefan Hajnoczi wrote:
> > v11:
> >  * Drop fd registration because it breaks QEMU's file locking and will =
need to
> >    be resolved in a separate patch series
> >  * Drop line-wrapping changes that accidentally broke several qemu-iote=
sts
> >=20
> > v10:
> >  * Dropped kernel submission queue polling, it requires root and has ad=
ditional
> >    limitations.  It should be benchmarked and considered for inclusion =
later,
> >    maybe even together with kernel side changes.
> >  * Add io_uring_register_files() return value to trace_luring_fd_regist=
er()
> >  * Fix indentation in luring_fd_unregister()
> >  * Set s->fd_reg.fd_array to NULL after g_free() to avoid dangling poin=
ters
> >  * Simplify fd registration code
> >  * Add luring_fd_unregister() and call it from file-posix.c to prevent
> >    fd leaks
> >  * Add trace_luring_fd_unregister() trace event
> >  * Add missing space to qemu-img command-line documentation
> >  * Update MAINTAINERS file [Julia]
> >  * Rename MAX_EVENTS to MAX_ENTRIES [Julia]
> >  * Define ioq_submit() before callers so the prototype isn't necessary =
[Julia]
> >  * Declare variables at the beginning of the block in luring_init() [Ju=
lia]
> >=20
> > This patch series is based on Aarushi Mehta's v9 patch series written f=
or
> > Google Summer of Code 2019:
> >=20
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00179.html
> >=20
> > It adds a new AIO engine that uses the new Linux io_uring API.  This is=
 the
> > successor to Linux AIO with a number of improvements:
> > 1. Both O_DIRECT and buffered I/O work
> > 2. fdatasync(2) is supported (no need for a separate thread pool!)
> > 3. True async behavior so the syscall doesn't block (Linux AIO got ther=
e to some degree...)
> > 4. Advanced performance optimizations are available (file registration,=
 memory
> >    buffer registration, completion polling, submission polling).
> >=20
> > Since Aarushi has been busy, I have taken up this patch series.  Bootin=
g a
> > guest works with -drive aio=3Dio_uring and -drive aio=3Dio_uring,cache=
=3Dnone with a
> > raw file on XFS.
> >=20
> > I currently recommend using -drive aio=3Dio_uring only with host block =
devices
> > (like NVMe devices).  As of Linux v5.4-rc1 I still hit kernel bugs when=
 using
> > image files on ext4 or XFS.
> >=20
> > Aarushi Mehta (15):
> >   configure: permit use of io_uring
> >   qapi/block-core: add option for io_uring
> >   block/block: add BDRV flag for io_uring
> >   block/io_uring: implements interfaces for io_uring
> >   stubs: add stubs for io_uring interface
> >   util/async: add aio interfaces for io_uring
> >   blockdev: adds bdrv_parse_aio to use io_uring
> >   block/file-posix.c: extend to use io_uring
> >   block: add trace events for io_uring
> >   block/io_uring: adds userspace completion polling
> >   qemu-io: adds option to use aio engine
> >   qemu-img: adds option to use aio engine for benchmarking
> >   qemu-nbd: adds option for aio engines
> >   tests/qemu-iotests: enable testing with aio options
> >   tests/qemu-iotests: use AIOMODE with various tests
> >=20
> >  MAINTAINERS                   |   9 +
> >  qapi/block-core.json          |   4 +-
> >  configure                     |  27 +++
> >  block/Makefile.objs           |   3 +
> >  stubs/Makefile.objs           |   1 +
> >  include/block/aio.h           |  16 +-
> >  include/block/block.h         |   2 +
> >  include/block/raw-aio.h       |  12 +
> >  block.c                       |  22 ++
> >  block/file-posix.c            |  99 ++++++--
> >  block/io_uring.c              | 433 ++++++++++++++++++++++++++++++++++
> >  blockdev.c                    |  12 +-
> >  qemu-img.c                    |  11 +-
> >  qemu-io.c                     |  25 +-
> >  qemu-nbd.c                    |  12 +-
> >  stubs/io_uring.c              |  32 +++
> >  util/async.c                  |  36 +++
> >  block/trace-events            |  12 +
> >  qemu-img-cmds.hx              |   4 +-
> >  qemu-img.texi                 |   5 +-
> >  qemu-nbd.texi                 |   4 +-
> >  tests/qemu-iotests/028        |   2 +-
> >  tests/qemu-iotests/058        |   2 +-
> >  tests/qemu-iotests/089        |   4 +-
> >  tests/qemu-iotests/091        |   4 +-
> >  tests/qemu-iotests/109        |   2 +-
> >  tests/qemu-iotests/147        |   5 +-
> >  tests/qemu-iotests/181        |   8 +-
> >  tests/qemu-iotests/183        |   4 +-
> >  tests/qemu-iotests/185        |  10 +-
> >  tests/qemu-iotests/200        |   2 +-
> >  tests/qemu-iotests/201        |   8 +-
> >  tests/qemu-iotests/check      |  15 +-
> >  tests/qemu-iotests/common.rc  |  14 ++
> >  tests/qemu-iotests/iotests.py |  12 +-
> >  35 files changed, 797 insertions(+), 76 deletions(-)
> >  create mode 100644 block/io_uring.c
> >  create mode 100644 stubs/io_uring.c
>=20
> Fixed up commit description as requested by Markus.
>=20
> Thanks, applied to my block-next tree for QEMU 4.3:
> https://github.com/stefanha/qemu/commits/block-next

Kevin and Max have raised some issues that I will address before this
gets merged into qemu.git/master.

Stefan

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3L7GkACgkQnKSrs4Gr
c8hHQAf/YWFowtFIj+VMw5qVH6VvUVsNmLJHxn1VJFwkvyjaywrdFtE8xY0UvIAA
pmRlEynyBXkogs+qkSDlR9nCaS8mGeXE9TiaI5XpOTpNTaAu9GsdndwUyGXA/1GO
1IA9j1w3qA8IUZLMvUVpx8pd9vVVk4yYHeJT6c8QRE4Hk7qamxLzsgs7nNw5ohlK
ib2dusbVRWY9z1daD2BD1xAz5Jh9UDTvmdfheBFIHlRGJIMigG0I/uIKG59hxhoZ
HlkynfJnZsfZgsavnr9CkQOnvywdo36bb+Au+1iBoE/trD2LZqZT0cO9U8AOExA3
VHGNiU47ShZcEBvndFBK6OrtU+dXDQ==
=jNhl
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--


