Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F456C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEDC22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQgfXDJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEDC22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrpK-0000Gl-Gp
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itrog-00085k-I4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itroe-0003bw-0K
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:35:30 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1itrod-0003bY-P6; Tue, 21 Jan 2020 06:35:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id m24so2582925wmc.3;
 Tue, 21 Jan 2020 03:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JQBpHdieQNSgTFPt+DNTFk/2CfvDLwQnxM5Y6F3vDyc=;
 b=PQgfXDJd8JW1JJibTiCGcqCn3mr/Gj2CtJ77edH19WbV77m4kK+9/4K2uxBcGMq33G
 kgMR9Co1huQIljvoYhTTQzvauOjRR66fhpbuE37n/3qkYzwr+kIl3HZ/olkMK7wKRsw3
 EBliaci2BnyVkchlSlope92fjeahXQ6Me0QjiEDuqqmui0fSCkqel1K0J5C1tEAX70UZ
 ofxBWqX/1GFZGcfJPzMvmdnRUR5OWhs8Gz8qDzBi5MjbhHDsGi458iCEMSMxzVcKRr7I
 05L7xyuO4HZvVjgkeVA0IAtY5ildtHr4DFvKD5ckMnGHW9CsdB08GJwp5EToenfSiCSH
 w5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JQBpHdieQNSgTFPt+DNTFk/2CfvDLwQnxM5Y6F3vDyc=;
 b=RQsYruBt0O2xAXme7Dtre2f9aRPnaEVqiyFjr/YwPxPlRNT1XVUSWRBtOk/Nwc3+UM
 uN2UbytRBVCW941b1KUV2QhFXaAKe3fEXogoiocb35bFCKW06nHav5YiNbsc6s5qerbU
 DPF43MPkSXFURI5QiAknwll7qcdNBarBqA3s+QrefcVZq8vEKnAQk5uWtf9UhcXGcWW7
 duFwKaaHfdmsVJxIsMNzgfYYY32GddO22kTmDby4LEXyaYwr3U9VaeoPSnknw7XbY2eA
 g5tNVR7hu+SSkABFZkQNT8lOoyt6nISUFVAIzNOUo5Q7ccm5nYWe9zKKgevjMgsco99y
 rbjw==
X-Gm-Message-State: APjAAAXww5l4Ira5tipclUzZ8eZ7+XmI3hZDQPjSu/gyCm3u/S682EUu
 W4Irt3nuJDmcyMf5UZufyg9oEeE20mWQuA==
X-Google-Smtp-Source: APXvYqyMQsscJYi1C8UeRP9JVgGfzS6+o1ypUx/mlhl/CmcsCclmj+qOIrnuYc5UF1/dVf3yeNxZiQ==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr3845939wmb.53.1579606526649; 
 Tue, 21 Jan 2020 03:35:26 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p15sm3355908wma.40.2020.01.21.03.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 03:35:25 -0800 (PST)
Date: Tue, 21 Jan 2020 11:35:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 00/15] io_uring: add Linux io_uring AIO engine
Message-ID: <20200121113524.GE630615@stefanha-x1.localdomain>
References: <20200114105921.131880-1-stefanha@redhat.com>
 <20200120103533.GD345995@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline
In-Reply-To: <20200120103533.GD345995@stefanha-x1.localdomain>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, oleksandr@redhat.com,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 10:35:33AM +0000, Stefan Hajnoczi wrote:
> On Tue, Jan 14, 2020 at 10:59:06AM +0000, Stefan Hajnoczi wrote:
> > v13:
> >  * Drop unnecessary changes in Patch 8 [Stefano]
> >=20
> > v12:
> >  * Reword BlockdevAioOptions QAPI schema commit description [Markus]
> >  * Increase QAPI "Since: 4.2" to "Since: 5.0"
> >  * Explain rationale for io_uring stubs in commit description [Kevin]
> >  * Tried to use file.aio=3Dio_uring instead of BDRV_O_IO_URING but it's=
 really
> >    hard to make qemu-iotests work.  Tests build blkdebug: and other gra=
phs so
> >    the syntax for io_uring is dependent on the test case.  I scrapped t=
his
> >    approach and went back to a global flag.
> >=20
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
> >  block.c                       |  22 ++
> >  block/Makefile.objs           |   3 +
> >  block/file-posix.c            |  85 +++++--
> >  block/io_uring.c              | 433 ++++++++++++++++++++++++++++++++++
> >  block/trace-events            |  12 +
> >  blockdev.c                    |  12 +-
> >  configure                     |  27 +++
> >  include/block/aio.h           |  16 +-
> >  include/block/block.h         |   2 +
> >  include/block/raw-aio.h       |  12 +
> >  qapi/block-core.json          |   4 +-
> >  qemu-img-cmds.hx              |   4 +-
> >  qemu-img.c                    |  11 +-
> >  qemu-img.texi                 |   5 +-
> >  qemu-io.c                     |  25 +-
> >  qemu-nbd.c                    |  12 +-
> >  qemu-nbd.texi                 |   4 +-
> >  stubs/Makefile.objs           |   1 +
> >  stubs/io_uring.c              |  32 +++
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
> >  util/async.c                  |  36 +++
> >  35 files changed, 787 insertions(+), 72 deletions(-)
> >  create mode 100644 block/io_uring.c
> >  create mode 100644 stubs/io_uring.c
> >=20
> > --=20
> > 2.24.1
> >=20
> >=20
>=20
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block

Kevin Wolf pointed out that BDRV_O_IO_URING isn't used by this series!
Oops, that means io_uring.c isn't being called anymore.  This bug
slipped in as part of v3.  I've sent a new revision.

Stefan

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4m4fwACgkQnKSrs4Gr
c8j96Af/X59rr39abFtBXGA2b7jyewRpYNgJ8Xtg5qeshwIhrFpgsCNx3RW2dRBY
vOIKmWkJJ4zwMjrh3JP1Fx+QbfadCr0KxY638jMupQc+p7rB36JFOI0EYBIr+q5Q
j4li4rdo0e++MF+2FSvXUpCFxi4Dykjl4jnsAr2ln5TkxFiPawe1Sf6AFq7PF68A
dyEUH8d2r/zfanpZv0pRU/DEU/PG5OPASb9hr1yJW41Iia6lj+hvhdD1Z2A5i/lY
ungJN0zjFbwgT+ntE3AxzJ3iOPFIENElkntY82IrnATNj0PGF47xhqDeWQe5GUQg
DKfIaXQODNmSkcZovMi2WDHImZYuMw==
=OhvJ
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--

