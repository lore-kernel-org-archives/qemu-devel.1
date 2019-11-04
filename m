Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EDBCA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545CB21D81
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjyZktDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545CB21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRZg1-0002Pv-GS
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 05:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iRZf7-0001VM-33
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iRZf4-0004uQ-1c
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:32:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iRZf3-0004tr-Oj; Mon, 04 Nov 2019 05:32:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id t26so11367209wmi.4;
 Mon, 04 Nov 2019 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/PrQQK85saa8qKsZmaUViO9yRgieimJ3kZbXiFTzLUA=;
 b=ZjyZktDK/KHp3K5+gaH65QUD/25KkpY/XtJoaGPLF46JKHZK24LOQs7E5SZQtrMK1i
 90Owxnl4Z0O8AY89YFKE7MGHHCiwE7bLMOoQLr6Nye7FNNRsbXN0J+QK3cIvOf085e1B
 W1RwO0duQulTCzVZLb5Qjd4zrRzWcYgE8591pwhY/O/Lw/vCgGNYHoOtXE3cl17JnZWH
 w0KjAGYwFREChJ4IwnDrlmbvUsUEb5ABUVeHloIPXxuh5Q/6Nx8wMuCtKiQCBAYwT5ps
 Qy6cKrekmHz2DiXkUr5hGv1D/5ATYe/0JG7PYmmkcmMc941Pdid2T9l9y18T6yYIrrFQ
 C9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/PrQQK85saa8qKsZmaUViO9yRgieimJ3kZbXiFTzLUA=;
 b=BD/S8uqhr5O72pvkJk1tFYySAkypx3XQXVaauf2D9spNmIpQG2kU5oS/XCGi1KwDYh
 lWxTZdxzROnGugr6azkdN2vAVT9mWkKvmTJAJToxgclgCqWqPvawEhDCKpaoqcc0THaD
 H/Qj3lL9M1T1AWotVyxkJljzzDmAEaLcKyxmncwlMEHRHHyWkwVYBe4vYz41O9Suj5UZ
 ZWgGoNYtVqBr5GtUYmjC6nVgG43igzw2tmDpeq/LhGa53BmPBJC0dj3/tdBKdW+dJvrT
 osbH3hjaRYA7iOAr3t+YY3i0fLPmdkF+7+765yIkZwB0EHJC0VZtRa+FSZuyK4JnI0L/
 TQRA==
X-Gm-Message-State: APjAAAU5uWblEw2jx4g8QIs0gXlvBAGv5lMa4IXblUzfmKNrLLm1p3yB
 bLtew7ZX8JgRZopJ2kbWrQs=
X-Google-Smtp-Source: APXvYqwg8w1PdSc6XcdE7c/wt0lSSaWtwoLYoINGDVeiQP3lUuPJh2RW+wgPI4qGcpGuMfDPiJHgJA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr19372112wmj.140.1572863555955; 
 Mon, 04 Nov 2019 02:32:35 -0800 (PST)
Received: from localhost (91.141.0.86.wireless.dyn.drei.com. [91.141.0.86])
 by smtp.gmail.com with ESMTPSA id z15sm16045572wrr.19.2019.11.04.02.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 02:32:34 -0800 (PST)
Date: Mon, 4 Nov 2019 11:32:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 00/15] io_uring: add Linux io_uring AIO engine
Message-ID: <20191104103233.GA6885@stefanha-x1.localdomain>
References: <20191025160444.31632-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20191025160444.31632-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 06:04:29PM +0200, Stefan Hajnoczi wrote:
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
>  qapi/block-core.json          |   4 +-
>  configure                     |  27 +++
>  block/Makefile.objs           |   3 +
>  stubs/Makefile.objs           |   1 +
>  include/block/aio.h           |  16 +-
>  include/block/block.h         |   2 +
>  include/block/raw-aio.h       |  12 +
>  block.c                       |  22 ++
>  block/file-posix.c            |  99 ++++++--
>  block/io_uring.c              | 433 ++++++++++++++++++++++++++++++++++
>  blockdev.c                    |  12 +-
>  qemu-img.c                    |  11 +-
>  qemu-io.c                     |  25 +-
>  qemu-nbd.c                    |  12 +-
>  stubs/io_uring.c              |  32 +++
>  util/async.c                  |  36 +++
>  block/trace-events            |  12 +
>  qemu-img-cmds.hx              |   4 +-
>  qemu-img.texi                 |   5 +-
>  qemu-nbd.texi                 |   4 +-
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
>  35 files changed, 797 insertions(+), 76 deletions(-)
>  create mode 100644 block/io_uring.c
>  create mode 100644 stubs/io_uring.c

Fixed up commit description as requested by Markus.

Thanks, applied to my block-next tree for QEMU 4.3:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2//kAACgkQnKSrs4Gr
c8jhzQf8CQTw/LetCl+E9Ylut6qcBw5QxYWzK5K1ANxLD4dSAYaxeAeSKkXIjaZ+
laR6iAzyohKWnCwR7hwafb9WBEIoVwjn+CmEBD5WKyOYS/1y4GF/XOJNVAkrbGZ6
Vm00tHU2eQXol/z6NLHTivge7JqbPQ/wuH6jehkSfJImqyruOlFwPDGnCQ5tYmUI
2lPoRgczmY7GEXeWI1x0w4haC0L2g5MthVkMY8hhTOXZV8zOlIo/ihaS3QbeV4Ir
AiJJ9O5r9ZP1Q7cnZAzwTH82Sni8wTE5vHQpF7SrFmsbuUan8jVamZYRrC/HlzJu
wdMwDqjG4PRc72emJFUuLknbE4JomQ==
=HM+R
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

