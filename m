Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D00C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A4A20815
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A4A20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCFI-0001bv-CS
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:36:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUCDS-0008I1-E7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUC3Y-0005Xd-ET
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hUC3U-0005Uv-Fp; Fri, 24 May 2019 11:24:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDF223005626;
	Fri, 24 May 2019 15:24:20 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E8692CFD6;
	Fri, 24 May 2019 15:24:19 +0000 (UTC)
Date: Fri, 24 May 2019 16:24:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Julia Suvorova <jusual@mail.ru>
Message-ID: <20190524152418.GD31070@stefanha-x1.localdomain>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
	<20190524140337.13415-5-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20190524140337.13415-5-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 24 May 2019 15:24:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/9] stubs: add aio interface stubs
 for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	saket.sinha89@gmail.com, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 07:33:32PM +0530, Aarushi Mehta wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3cacd751bf..b8fc1e3fe3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2504,6 +2504,16 @@ F: block/file-posix.c
>  F: block/file-win32.c
>  F: block/win32-aio.c
>=20
> +Linux io_uring
> +M: Aarushi Mehta <mehta.aaru20@gmail.com>
> +R: Stefan Hajnoczi <stefan@redhat.com>

Julia: Are you willing to review io_uring.c patches in the future too?
I'd like to have all three of us here so we can share the work of
reviewing patches in this area after Outreachy.

> diff --git a/stubs/io_uring.c b/stubs/io_uring.c
> new file mode 100644
> index 0000000000..622d1e4648
> --- /dev/null
> +++ b/stubs/io_uring.c
> @@ -0,0 +1,32 @@
> +/*
> + * Linux io_uring support.
> + *
> + * Copyright (C) 2009 IBM, Corp.
> + * Copyright (C) 2009 Red Hat, Inc.

You could add yourself here and to other files if you wish:

  Copyright (C) 2019 Aarushi Mehta

Git logs carry fine-grained authorship information already, so people
often don't bother.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzoDKIACgkQnKSrs4Gr
c8ie0wf/Qp/MBh3ft9xwLHzESd0kjfZ8FTgyTCN4FQfORWcrh+VeE/5/AUZijBe1
5ALkCU9BcLvQZjiJ5SGVjpQvFG/6k41AIhkwD4CfZ2LawBOYWel8iTKTtmcf8KWt
GFgUIIYQN52q3qjhpH/GaubFSz8qOeAomp7MfbVVfUMjS4mSNS2xwH06gjQ8TngC
D0iUSxN1m4G+SC2ohb2u8nTIKmrveM73Tni9ec+C6KpTxKbJEyoRPSk+ob4IMYsc
rmVktmB/yLZh4fArjaIaJC4xzk9vdDN5PSRoXbqvxol/KPWdREoLajItF3XwanSE
xHtP1v0qTkHhwWVnXSRheIp1iPSnBQ==
=qoIX
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--

