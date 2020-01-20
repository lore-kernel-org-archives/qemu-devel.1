Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C213C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA0C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfRpbO0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA0C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUc6-0006OX-FW
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itUPE-0005Ve-Iy
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itUPC-0002KB-Ui
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:35:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1itUPC-0002JG-N0; Mon, 20 Jan 2020 05:35:38 -0500
Received: by mail-wr1-x443.google.com with SMTP id j42so28917720wrj.12;
 Mon, 20 Jan 2020 02:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3+YX0QZmDwtz0k4jsE+Xw95VveVoI58sDt0BkeQXgpg=;
 b=XfRpbO0Fj1X8no8jVJJbT2c+qb5gY5qXtwluuqW+2KQznF/n8GUXPOB/ylGJDmhn0Y
 k60tqH39FhsJrSOHu+kkKtCojfpZVepMBJn5IS2MDHaRiccvd97P5TKqnLeyJu3qjD/B
 PFZd1MulfGrUrb+x73gan+Qh01bOFAzbYA1Hzk9zAzmejKarsEapbxrxdTLu59nP/ruL
 dSdnZXi2ihlHH1U6nWc8MFvb4wkmyBCWAMRnGx/dP8BP7A07tunZTVK5ctINCqeUWV/r
 QXiKBaZt8Nt6vxZyQVAYdwwoadL0akKJCtUeHxpOS/qh+pIUi1yJqo6MLVDudVaq6JXZ
 fS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3+YX0QZmDwtz0k4jsE+Xw95VveVoI58sDt0BkeQXgpg=;
 b=Eu/BBkoRWH+ZaJIMrSF5GM3ccrDh12HLuqL+S/O4Dr70j0hJUb/pCHIJlG979tQPIN
 rTp722QPFii7EzTjxGVj/9kbG1mq3Li8c7LQiThj7wG5DmbYNL4tqi5HbkG+erjR5xkE
 4tNOGUzfIZcJnVNa8H7GRNRiXR9iseT7nxO+UUZH75jU55Ra6dlk6ODCTq3EuwbgLTsK
 tXjPhYccE2tvie5syYiyXeehdr2zZU/dcqxMV0GwnFJuGdO4QR6MRA6aPGp+OyUP60Hf
 FnIiPPjAz988E074IwixSr9uSHXA7c/RGpKBg4mUqSDlDaxPx/GjV5BQKftGkO1st1Ej
 EeXQ==
X-Gm-Message-State: APjAAAWJHmJfPX11UXbou0cVQjTbgMY/XL9yTXBDqMzP/k6J0vXuFXvL
 EpVMyZ55v29oqyn8o9vZVJw=
X-Google-Smtp-Source: APXvYqygT1dyhYEGFVkdDwiW6P4LcPBavqyy4txM/kiGBCLTF0tYDlxKvevkV7NrQgO6X/B4X108LQ==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr16784858wrf.385.1579516536178; 
 Mon, 20 Jan 2020 02:35:36 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t81sm2934652wmg.6.2020.01.20.02.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 02:35:34 -0800 (PST)
Date: Mon, 20 Jan 2020 10:35:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 00/15] io_uring: add Linux io_uring AIO engine
Message-ID: <20200120103533.GD345995@stefanha-x1.localdomain>
References: <20200114105921.131880-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20200114105921.131880-1-stefanha@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 10:59:06AM +0000, Stefan Hajnoczi wrote:
> v13:
>  * Drop unnecessary changes in Patch 8 [Stefano]
>=20
> v12:
>  * Reword BlockdevAioOptions QAPI schema commit description [Markus]
>  * Increase QAPI "Since: 4.2" to "Since: 5.0"
>  * Explain rationale for io_uring stubs in commit description [Kevin]
>  * Tried to use file.aio=3Dio_uring instead of BDRV_O_IO_URING but it's r=
eally
>    hard to make qemu-iotests work.  Tests build blkdebug: and other graph=
s so
>    the syntax for io_uring is dependent on the test case.  I scrapped this
>    approach and went back to a global flag.
>=20
> v11:
>  * Drop fd registration because it breaks QEMU's file locking and will ne=
ed to
>    be resolved in a separate patch series
>  * Drop line-wrapping changes that accidentally broke several qemu-iotests
>=20
> v10:
>  * Dropped kernel submission queue polling, it requires root and has addi=
tional
>    limitations.  It should be benchmarked and considered for inclusion la=
ter,
>    maybe even together with kernel side changes.
>  * Add io_uring_register_files() return value to trace_luring_fd_register=
()
>  * Fix indentation in luring_fd_unregister()
>  * Set s->fd_reg.fd_array to NULL after g_free() to avoid dangling pointe=
rs
>  * Simplify fd registration code
>  * Add luring_fd_unregister() and call it from file-posix.c to prevent
>    fd leaks
>  * Add trace_luring_fd_unregister() trace event
>  * Add missing space to qemu-img command-line documentation
>  * Update MAINTAINERS file [Julia]
>  * Rename MAX_EVENTS to MAX_ENTRIES [Julia]
>  * Define ioq_submit() before callers so the prototype isn't necessary [J=
ulia]
>  * Declare variables at the beginning of the block in luring_init() [Juli=
a]
>=20
> This patch series is based on Aarushi Mehta's v9 patch series written for
> Google Summer of Code 2019:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00179.html
>=20
> It adds a new AIO engine that uses the new Linux io_uring API.  This is t=
he
> successor to Linux AIO with a number of improvements:
> 1. Both O_DIRECT and buffered I/O work
> 2. fdatasync(2) is supported (no need for a separate thread pool!)
> 3. True async behavior so the syscall doesn't block (Linux AIO got there =
to some degree...)
> 4. Advanced performance optimizations are available (file registration, m=
emory
>    buffer registration, completion polling, submission polling).
>=20
> Since Aarushi has been busy, I have taken up this patch series.  Booting a
> guest works with -drive aio=3Dio_uring and -drive aio=3Dio_uring,cache=3D=
none with a
> raw file on XFS.
>=20
> I currently recommend using -drive aio=3Dio_uring only with host block de=
vices
> (like NVMe devices).  As of Linux v5.4-rc1 I still hit kernel bugs when u=
sing
> image files on ext4 or XFS.
>=20
> Aarushi Mehta (15):
>   configure: permit use of io_uring
>   qapi/block-core: add option for io_uring
>   block/block: add BDRV flag for io_uring
>   block/io_uring: implements interfaces for io_uring
>   stubs: add stubs for io_uring interface
>   util/async: add aio interfaces for io_uring
>   blockdev: adds bdrv_parse_aio to use io_uring
>   block/file-posix.c: extend to use io_uring
>   block: add trace events for io_uring
>   block/io_uring: adds userspace completion polling
>   qemu-io: adds option to use aio engine
>   qemu-img: adds option to use aio engine for benchmarking
>   qemu-nbd: adds option for aio engines
>   tests/qemu-iotests: enable testing with aio options
>   tests/qemu-iotests: use AIOMODE with various tests
>=20
>  MAINTAINERS                   |   9 +
>  block.c                       |  22 ++
>  block/Makefile.objs           |   3 +
>  block/file-posix.c            |  85 +++++--
>  block/io_uring.c              | 433 ++++++++++++++++++++++++++++++++++
>  block/trace-events            |  12 +
>  blockdev.c                    |  12 +-
>  configure                     |  27 +++
>  include/block/aio.h           |  16 +-
>  include/block/block.h         |   2 +
>  include/block/raw-aio.h       |  12 +
>  qapi/block-core.json          |   4 +-
>  qemu-img-cmds.hx              |   4 +-
>  qemu-img.c                    |  11 +-
>  qemu-img.texi                 |   5 +-
>  qemu-io.c                     |  25 +-
>  qemu-nbd.c                    |  12 +-
>  qemu-nbd.texi                 |   4 +-
>  stubs/Makefile.objs           |   1 +
>  stubs/io_uring.c              |  32 +++
>  tests/qemu-iotests/028        |   2 +-
>  tests/qemu-iotests/058        |   2 +-
>  tests/qemu-iotests/089        |   4 +-
>  tests/qemu-iotests/091        |   4 +-
>  tests/qemu-iotests/109        |   2 +-
>  tests/qemu-iotests/147        |   5 +-
>  tests/qemu-iotests/181        |   8 +-
>  tests/qemu-iotests/183        |   4 +-
>  tests/qemu-iotests/185        |  10 +-
>  tests/qemu-iotests/200        |   2 +-
>  tests/qemu-iotests/201        |   8 +-
>  tests/qemu-iotests/check      |  15 +-
>  tests/qemu-iotests/common.rc  |  14 ++
>  tests/qemu-iotests/iotests.py |  12 +-
>  util/async.c                  |  36 +++
>  35 files changed, 787 insertions(+), 72 deletions(-)
>  create mode 100644 block/io_uring.c
>  create mode 100644 stubs/io_uring.c
>=20
> --=20
> 2.24.1
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4lgnUACgkQnKSrs4Gr
c8jKHQgAg/2oUgsjvBv3FYbqCCa3L/TQc6gHYM8BnkhTxww6OGURqSJAESsViVUr
i1kHVPOfulzUGakqhv2fS279ddAYfyDUNW5opgk3igbW/NtnCDZB8ddZ7oS5h4QX
xz0aNjlCeY/XV4e/nMYVaQTFdkkIyZJfjZ13nXNUYIuv0K2/RPT4NRvA2RFutLLx
b1S5NaHKmfCvpaJLXUZ8EISsX8kSWaWL7vOFJcvr98rdQfE/fz/Yi/J+mx1jiVyy
OWkmacPtMYk/pGm3OWPgmshupM51PuwCjiOGTqxV/om3AgMI3L9baNoebxl5WVKZ
l0LWLk13m9p7YA9CcnoADPoZ4ABpDg==
=kT7Q
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

