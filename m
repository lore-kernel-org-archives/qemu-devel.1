Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1773DC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7952075B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7952075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs0pb-0004B2-5H
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hs0p9-0003kb-Fi
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hs0p8-0005W4-IO
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hs0p8-0005U6-Bg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:16:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39C0590901;
 Mon, 29 Jul 2019 08:16:00 +0000 (UTC)
Received: from localhost (ovpn-117-148.ams2.redhat.com [10.36.117.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D49A5D6A9;
 Mon, 29 Jul 2019 08:15:57 +0000 (UTC)
Date: Mon, 29 Jul 2019 09:15:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Liu Bo <bo.liu@linux.alibaba.com>
Message-ID: <20190729081555.GA3369@stefanha-x1.localdomain>
References: <20190726091103.23503-1-stefanha@redhat.com>
 <20190726091103.23503-3-stefanha@redhat.com>
 <20190726212613.24lionrtvt3kz2g3@US-160370MP2.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20190726212613.24lionrtvt3kz2g3@US-160370MP2.local>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 29 Jul 2019 08:16:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 2/5] virtiofsd: prevent
 lo_lookup() NULL pointer	dereference
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 02:26:14PM -0700, Liu Bo wrote:
> On Fri, Jul 26, 2019 at 10:11:00AM +0100, Stefan Hajnoczi wrote:
> > Most lo_do_lookup() have already checked that the parent inode exists.
> > lo_lookup() hasn't and can therefore hit a NULL pointer dereference when
> > lo_inode(req, parent) returns NULL.
> >
>=20
> Sigh...this one has been fixed by 3 different developers...Me, Pengtao an=
d Stefan.
>=20
> The following one on the ML did the exactly same thing.
> ---
> Subject: [Virtio-fs] [PATCH] virtiofsd: fix lo_do_lookup panic
>=20
> It needs to check for invalid parent dir.
>=20
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> ---

One of the previously posted patches will be merged before mine.  It's a
shame that work has been duplicated.  As a contributor I will send a
ping email if there has been no response to a patch after a few days.

Stefan

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0+qzsACgkQnKSrs4Gr
c8iJXgf/U/VBNuvKL5LjEl5+H6xgeDHD1ZgRS47yfQQbb1wC9RcEUptTYcR7xtcc
AUcoV/kfg+kLHxxUljUWAJ5mznHQ0GPB4LmZ+DQVYjUny3SyMLn8lNqQqzoObzFV
d1sntaJVR7NA1n+UT2j96pjbFMemCRY5wwAs7JJyd/CzDbSoYf7PZNTNuEx94ZMo
6Jp20u5bZ/kTR0kQ/e4ctdBOPMZgeDYQDlNedl2vee/B/tMW03+0Fh5fpRqS2fMV
5ZfYM4Lyl2r1tBOgx/vNtm0fDsS7B/uZ/YDesF0ZyqyY9ke9hgxdVzJKGatypz3I
ZJZwkWcz9fDtLbFowfKYGj30Vnbe0w==
=uqIi
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

