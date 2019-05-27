Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7AAC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308C22075E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308C22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVBWr-0005Be-20
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:02:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVBVh-0004hA-Uy
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVBVg-00067v-OE
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hVBVd-0005sg-RB; Mon, 27 May 2019 05:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5481F3088A65;
	Mon, 27 May 2019 09:01:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 93EEE5D723;
	Mon, 27 May 2019 09:01:06 +0000 (UTC)
Date: Mon, 27 May 2019 10:01:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190527090103.GA25631@stefanha-x1.localdomain>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
	<155894555550.3183.17796312000148467282@d1b27de2824c>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <155894555550.3183.17796312000148467282@d1b27de2824c>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 27 May 2019 09:01:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Add support for io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com,
	saket.sinha89@gmail.com, jusual@mail.ru, mehta.aaru20@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 01:25:56AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190527080327.10780-1-mehta.aaru20=
@gmail.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Subject: [Qemu-devel] [PATCH v3 0/8] Add support for io_uring
> Type: series
> Message-id: 20190527080327.10780-1-mehta.aaru20@gmail.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 75fc7f1 block/fileposix: extend to use io_uring
> d03ae39 blockdev: accept io_uring as option
> cae30ee util/async: add aio interfaces for io_uring
> f3be807 stubs: add stubs for io_uring interface
> 85c03de block/io_uring: implements interfaces for io_uring
> 5c4a14a block/block: add BDRV flag for io_uring
> 9a6594d qapi/block-core: add option for io_uring
> 460c72d configure: permit use of io_uring
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/8 Checking commit 460c72d1a8df (configure: permit use of io_uring)
> 2/8 Checking commit 9a6594daa76c (qapi/block-core: add option for io_urin=
g)
> 3/8 Checking commit 5c4a14a301f5 (block/block: add BDRV flag for io_uring)
> 4/8 Checking commit 85c03de16186 (block/io_uring: implements interfaces f=
or io_uring)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #49:=20
> new file mode 100644
>=20
> ERROR: space required before the open parenthesis '('
> #196: FILE: block/io_uring.c:143:
> +    while(!s->io_q.in_queue) {
>=20
> ERROR: trailing whitespace
> #209: FILE: block/io_uring.c:156:
> +        if (ret <=3D 0) { $
>=20
> total: 2 errors, 1 warnings, 387 lines checked
>=20
> Patch 4/8 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 5/8 Checking commit f3be80708ad1 (stubs: add stubs for io_uring interface)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #35:=20
> new file mode 100644
>=20
> total: 0 errors, 1 warnings, 46 lines checked
>=20
> Patch 5/8 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 6/8 Checking commit cae30ee1388f (util/async: add aio interfaces for io_u=
ring)
> 7/8 Checking commit d03ae39c331c (blockdev: accept io_uring as option)
> 8/8 Checking commit 75fc7f1d8a3e (block/fileposix: extend to use io_uring)
> =3D=3D=3D OUTPUT END =3D=3D=3D

Hi Aarushi,
I use this git hook to identify checkpatch.pl issues at git-commit(1)
time:
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html

This way I don't need to resend patch series because the issues were
already taken care of earlier in the development process.

Stefan

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzrp08ACgkQnKSrs4Gr
c8iLBwgAlRjzAzGP77yetVsN8gmp9+ohj7MhdPBoInt02EbfxLzIN9GnlxXE1ovj
gUZ2CNJNtAvE41ov0fiG4MaWENe+SixcCh7LPPzKmhUpV93iKXhshsEIEYKyjDJs
DPAS7+oXL33z3nmfbpRV7/smJTFZdEmATHgEWEoVnfpFaehAhfaecQl/k1uYl1de
F4150Cbwu5eifJU0YYrIeFZooabkUQun9ye9YUdHE1RrMFKp5ZALgSLppKduwW1T
B9nBWzUvG+tagCkyrOhTX1cLrntU537a/i6tVijnjafEljAwlEHflzDBBkC5yjcE
UFuWP7YBJJsB2EN2eRbKfzvnRFUT9g==
=mS8p
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

