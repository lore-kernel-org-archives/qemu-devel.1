Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E8EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01CC20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01CC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUD1D-0008G1-3W
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:26:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUCun-0002Yi-Nj
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUCum-0001Oy-Ph
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:19:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hUCui-0001IF-Ts; Fri, 24 May 2019 12:19:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6E843003E44;
	Fri, 24 May 2019 16:19:18 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D0A95F7DB;
	Fri, 24 May 2019 16:19:17 +0000 (UTC)
Date: Fri, 24 May 2019 17:19:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190524161916.GH31070@stefanha-x1.localdomain>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
	<20190524140337.13415-9-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <20190524140337.13415-9-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 24 May 2019 16:19:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 8/9] block/file-posix: extends to
 use with io_uring
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
	saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 07:33:36PM +0530, Aarushi Mehta wrote:
> @@ -557,7 +559,9 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
>      s->shared_perm =3D BLK_PERM_ALL;
>=20
>  #ifdef CONFIG_LINUX_AIO
> -     /* Currently Linux does AIO only for files opened with O_DIRECT */
> +     /*
> +      * Currently Linux does AIO only for files opened with O_DIRECT
> +      */
>      if (s->use_linux_aio) {

The comment's indentation looks off.  Is it 4 spaces?

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzoGYQACgkQnKSrs4Gr
c8j8uwgAiRL1JM24Ef+UOkXC7GxOHo6XJzEDILwJ1oKOSyWEmpenY2rAp9OQ/yIs
wpohUq+vTGWnPhQsOtUkTBUlO5HEMhbrxNGuS33jfwt8LB9ot29lrLInIi5XjVfM
QC7njJxSwgeSFfKoVZktj2c7Bj9o1wtFIvkXPVoapdMeSZkoD+ejrWjUzKD6fq/H
EQct25BSMt6hF8zTeiiqAAsmoahtZ7gPAEgKcMlsuXcpbNNVKieeL9oT+16QtPj5
YmpGf5ND2TobJedfkhbFgdRg8t8SmB9OKffvdFJtUPZeXFPpBqNJOOKWWUPeofLX
7q+ZacAeKTINBR6HIhNCyRZ8SRRYCg==
=xc9e
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--

