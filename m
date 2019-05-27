Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9999C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB6C21721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB6C21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVCAn-0001pl-TT
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:44:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVC9A-0000jJ-0Z
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVC99-0005XP-5C
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hVC96-0005TZ-Qk; Mon, 27 May 2019 05:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 228438667D;
	Mon, 27 May 2019 09:42:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A7395D97C;
	Mon, 27 May 2019 09:42:13 +0000 (UTC)
Date: Mon, 27 May 2019 10:42:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190527094207.GC25631@stefanha-x1.localdomain>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
	<20190527080327.10780-9-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <20190527080327.10780-9-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 27 May 2019 09:42:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 8/8] block/fileposix: extend to use
 io_uring
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
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 01:33:27PM +0530, Aarushi Mehta wrote:
> @@ -1920,24 +1947,40 @@ static int coroutine_fn raw_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
> =20
>  static void raw_aio_plug(BlockDriverState *bs)
>  {
> -#ifdef CONFIG_LINUX_AIO
> +#if defined CONFIG_LINUX_AIO || defined CONFIG_LINUX_IO_URING
>      BDRVRawState *s =3D bs->opaque;
> +#endif

It would be nice to avoid the extra ifdefs.  Here is an alternative
without #ifdef:

  BDRVRawState __attribute__((unused)) *s =3D bs->opaque;

> @@ -1963,8 +2006,10 @@ static int raw_co_flush_to_disk(BlockDriverState *=
bs)
>  static void raw_aio_attach_aio_context(BlockDriverState *bs,
>                                         AioContext *new_context)
>  {
> +#if defined CONFIG_LINUX_AIO || defined CONFIG_LINUX_IO_URING
> +        BDRVRawState *s =3D bs->opaque;

Indentation?

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzrsO8ACgkQnKSrs4Gr
c8gFEggAq2/qxXrgAY3MZ1rnHgBq9k5652R6qUmzsdbvlo9YIq9D6Pyr5mU3V9gK
VshPJVNcRrIa3hASX/5uuo45QUk+MB/rBKoUbNORjsSYY4kOA3s6Oa+4JhLU2711
3wNLCLsZwm4vNlA9an3sAqsJIU1KD8LwLcXbNe4Yzub8oOeWTSc+LwXLEM8NFfNa
0m+weqzngzCCpMK+1zoY59gv1TE0InCu9n3oLGNd+pr+ZS7Fc59XYJan2+TjDQU6
xUtfjjnt+fb6rVFHxdkcTK63ewjGE69mFPqnaOit/rfW3Jyyfl6/fS3xpt5ipY2G
EO6ISHyFT94G1bevGM6IMXV/CKuV3A==
=eTfP
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--

