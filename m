Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A8C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4D720862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4D720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTkHZ-0005aq-My
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 05:45:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hTkGh-0005H0-OP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hTkGg-0006oz-UR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hTkGe-0006mq-JN; Thu, 23 May 2019 05:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CA7081E08;
	Thu, 23 May 2019 09:44:02 +0000 (UTC)
Received: from localhost (ovpn-116-196.ams2.redhat.com [10.36.116.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0E831802F;
	Thu, 23 May 2019 09:43:58 +0000 (UTC)
Date: Thu, 23 May 2019 10:43:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190523094357.GD26632@stefanha-x1.localdomain>
References: <20190521084522.15050-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20190521084522.15050-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 23 May 2019 09:44:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] block: qiov_offset parameter for io
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 11:45:19AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is idea of adding qiov_offset parameter to io path, to avoid
> a lot of places with same pattern of creating local_qiov or hd_qiov
> variables. Here is only read path for qcow2, if we like it, I'll
> make v2 with both read and write paths for qcow2.
>=20
> Vladimir Sementsov-Ogievskiy (3):
>   block/io: introduce bdrv_co_preadv_part
>   block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>   block/qcow2: implement .bdrv_co_preadv_part
>=20
>  include/block/block_int.h |  6 +++
>  block/io.c                | 87 ++++++++++++++++++++++++++-------------
>  block/qcow2.c             | 67 +++++++++++++++---------------
>  3 files changed, 97 insertions(+), 63 deletions(-)

I like it!

Stefan

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzma10ACgkQnKSrs4Gr
c8gPBggAsZcyFq0mGR0wVcMiIC6Z3p7B7SCMwZmNGiUUr10SV0T3dYkxouuGiIFM
ooXiPLg2fnfdqxiYQidqUUt/kUO8creex7J3W2ro0VvAMJycvrdASV49AYrITcuS
9e8/IgZ3k5FgIRqNQB+MxEvz2zJrVbfH3gvJK6QXQSbNwrZ3WLfopvK4o+rXXdTa
xppa+mYRbJyL5UX5LKcE50PW/4VzWiyoXpX3S18UZeupnDGsPrFT6Q6jeZ8cISvt
k7YjCID7vhrrc9kQNTIZVnlPNBXwbBNK4GuEmE23Fhw3kGjFnTkMqL33pKY8t009
DHOEckKcfc640tPXJ5DG5ifxtRKW1w==
=45c2
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

