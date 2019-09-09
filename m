Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2631C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A852086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A852086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7GBg-00087M-Q5
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7GAd-0007Ym-Oo
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7GAa-0005hD-DA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:41:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7GAQ-0005ZV-Lp; Mon, 09 Sep 2019 05:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2AA8309BD1E;
 Mon,  9 Sep 2019 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A74AB5C21F;
 Mon,  9 Sep 2019 09:41:00 +0000 (UTC)
Date: Mon, 9 Sep 2019 11:40:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190909094059.GA17606@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-10-mreitz@redhat.com>
 <20190905130501.GA4911@localhost.localdomain>
 <e2d1cd43-cfac-32cd-cfb7-1ebd2dcc5091@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <e2d1cd43-cfac-32cd-cfb7-1ebd2dcc5091@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 09 Sep 2019 09:41:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 09/42] block: Include filters when
 freezing backing chain
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.09.2019 um 10:02 hat Max Reitz geschrieben:
> On 05.09.19 15:05, Kevin Wolf wrote:
> > Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >> In order to make filters work in backing chains, the associated
> >> functions must be able to deal with them and freeze all filter links, =
be
> >> they COW or R/W filter links.
> >>
> >> In the process, rename these functions to reflect that they now act on
> >> generalized chains of filter nodes instead of backing chains alone.
> >=20
> > I don't think this is a good idea. The functions are still following the
> > backing chain. A generic "chain" could mean following the bs->file links
> > or any other children, so the new name is confusing because it doesn't
> > really tell you any more what the function does. I'd prefer the name to
> > stay specific.
> They=E2=80=99re following backing chains, among others.
>=20
> It would make sense to rename s/backing_chain/filter_chain/, that is, in
> case you don=E2=80=98t find lumping COW and R/W filters together under =
=E2=80=9Cfilter=E2=80=9D
> too offensive.
>=20
> (Naming things is hard.  I=E2=80=99m open for suggestions, but I found the
> =E2=80=9Cfilter=E2=80=9D concept succinct, even if it does not fully alig=
n with our
> existing parlance.)

As you could see in my reply to patch 4, I didn't. :-)

I think it makes a lot more sense to just broaden the meaning of "backing
chain" to be what you call a "filter chain" (following the backing file
links, but accept filter nodes in between), because of how unspecific
"filter chain" is. The primary thing we're interested in is still the
backing files.

Kevin

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJddh4rAAoJEH8JsnLIjy/WujYP/2dgvsclqSAmG3PJjpYDfXwd
fKPjCksETS9m9Yw2wEerXBUObhMc4HuZvEbwuocZDCLj1K5l0pLSS0PGF5a5SkQ6
hMZykN949oJxskkj0Jc2mV6SjmpqP2C89f+S/2NDcs4xYvMQQ7PaZ9d+l17xJ1m9
v9v94UpsCNlY0E4ldHsqtP3LV5sAlwttv3zOCOV/eG+GZTWkzG/Aqfc1mHeJnDRX
7mKN8A1pUk2WyzW77xsynwprLgz8pHtqQnFjO3/Et9VO2yRDfVSRuob2Xa5j1W6Z
4OAXfnpfNlswzpfWsCQbSzXNjYvEuHNM9CtjNX2SSXNrIRG9qVEW6dZxsLVEoR1P
yv6Vs/mChZrCwhS/chsqPi02etzRrkrLo5/E3Yuht+8VgtSAvRgrNvUDY0/8Dt/W
4NpoHlzWmuSqv/uNK7y6G+PxFQvjdSqtxYPTl/BIqdCmwuXTRzDQsYgs3GqFg3Mo
6Xh3er5YLp81GA9lqiS33ozuUYrtsNVDrYgpVgLOPpR8Lfo14sde9Tywn6QTc49g
RNA+StFRRmzLQTDPXNS0YKVU7hQUGmzlcYK+gemuDN4RbyASqGEK+FTqyGCm5n0k
ELV/FqERdJt0E5cxskzXYXMVEoibtYuSXzj/bLdo3xesR8bKefMoj/zLB1dyGhpn
g2zjYEBubyVpyIwtI7Qt
=Venc
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

