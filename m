Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92510C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D04E20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYQPclDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D04E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrqr-0001qH-GH
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itrpg-0000qk-GG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itrpc-00040U-MF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:36:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1itrpc-0003zg-Et; Tue, 21 Jan 2020 06:36:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so2784956wrt.6;
 Tue, 21 Jan 2020 03:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cJpByploXju3SVbMyLO+91iwh9H3qc+8tKPsfMv6b+o=;
 b=YYQPclDAHp6tLfM7n4bulgV9CsYsXriH+1Bo/9e2yJq6++/cgc5rKzpgYLUWBto+Vx
 SbHO1NR0DowhZJzr+RnzgEQoMbvNJe5IwDJcG1xZ1HLokZwSUESMoEqxGEWW8jov8m75
 ioKKNQAwn7q2Rk4zYttDhWnPO4+l4/3zyXUucRPfOFfZNKTiw3ZtSMSGcmYVKm/Fw2ua
 6V0vuTgPnQaqIJ7QmhhDWgX+ScG3a7nabOOCRfnsIvL7lyxGGhOybH+lT9utXneT8HYV
 rhnkW+l7UGVmU+MOBzHsTTdOnk8TZlnk4Hsu5GPn5tuYfgyUGompBYS0uwX5bFQDaRZ6
 Zn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cJpByploXju3SVbMyLO+91iwh9H3qc+8tKPsfMv6b+o=;
 b=uKOnwYRckdynm/RGrp9XIHKb3K3RyATh5zAx2TVdSF9KgKsgMdfMp61kwQsgyKWnz6
 Qb97pWeC/UWGgfBIBLohLMEgykXn5JeiHEKQLWfUzvcSOljQnS1mzx6Z+sq6PKLAvtMy
 BhU3KvpQcZtfZ/U1/uHCqwmQZJ6sFIl4+J4nNNBe6T5JbZOxkW+e/K56hFURCoQOi7lo
 +gj6I6jJmfaVtqQikzDExKEXQZi7EMKH+sZ8Gb+0byPTNnaAW6m0Jj5h74Y0B+zcDKZv
 ZLaY8A2OdDkCPh04zwWDXSY1Y0aDEplHv/Ak8S7+XalMd1sR3QTkW68fjRGl7Lq4RxLZ
 I+Lg==
X-Gm-Message-State: APjAAAU8ia22r8KxiAmDr5lzOh0wEgHd0kLetmrP3cF/iELMiXMnRVzR
 +5380/OePWq5OTdNlJmwdiA=
X-Google-Smtp-Source: APXvYqywHaG7kwCe/4pekiDJAXJzPnj1rKahLaD2XstJK/qKyxrn4weg+NHttouMR9m7/cib5rfHrQ==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr4763781wrp.1.1579606587280;
 Tue, 21 Jan 2020 03:36:27 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r5sm51232991wrt.43.2020.01.21.03.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 03:36:26 -0800 (PST)
Date: Tue, 21 Jan 2020 11:36:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 00/15] io_uring: add Linux io_uring AIO engine
Message-ID: <20200121113625.GF630615@stefanha-x1.localdomain>
References: <20200120141858.587874-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <20200120141858.587874-1-stefanha@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 02:18:43PM +0000, Stefan Hajnoczi wrote:
> v5:
>  * Add back BDRV_O_IO_URING check that was dropped accidentally in v3
>    [Kevin]
>=20
> v4:
>  * Drop unnecessary changes in Patch 8 [Stefano]
>=20
> v3:
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
> v2:
>  * Drop fd registration because it breaks QEMU's file locking and will ne=
ed to
>    be resolved in a separate patch series
>  * Drop line-wrapping changes that accidentally broke several qemu-iotests
>=20
> This patch series is based on Aarushi Mehta's v9 patch series written for
> Outreachy 2019:
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
>  block/file-posix.c            |  98 ++++++--
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
>  35 files changed, 797 insertions(+), 75 deletions(-)
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

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4m4jkACgkQnKSrs4Gr
c8hDvAf/a5pKGEfHL0Jo1XRFG3887UDk2kkBCESDGLXqloetESEB//v07dRR5TI9
lCPUEbl9Sqgw8JpnfEDXbu0DJoXE+z8iEM6ANS+T3XI8/bOmAwfcEDRABc5BqsIM
/kIGLhkqMwlzoFOnP6c+CRCt0LrHW7h6YrP5KdErLAe8WPYt0eZ/CGUBiCgekVkR
b+58dZ6BtT87peWf5ZzBqlF5LAQlNcA8xpbyr3/LWKp+ksCEVq5QfHYc8dVw2uW7
WTMNfxEXNTDvfYcF0hv1vW7ZtQk8Rgu9+GlpCEZqPoDP2nDmNbr13wlA9htiYDcr
51u3WSHfZ/PcOWDa9w2f0nd4Y6P+/w==
=ClTu
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--

