Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC0C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B7421848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B7421848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0jF6-0002Bf-Qg
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 05:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i0jDx-0000T5-IU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i0jDv-0003TG-IR
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:17:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i0jCy-00035X-Cd; Thu, 22 Aug 2019 05:17:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 605C08980E4;
 Thu, 22 Aug 2019 09:16:39 +0000 (UTC)
Received: from localhost (ovpn-117-251.ams2.redhat.com [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4861F4F7B;
 Thu, 22 Aug 2019 09:16:36 +0000 (UTC)
Date: Thu, 22 Aug 2019 10:16:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190822091634.GC20491@stefanha-x1.localdomain>
References: <20190715201950.9444-1-stefanha@redhat.com>
 <3ccd9e30-d6ec-c752-fb0d-08318091fc6b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <3ccd9e30-d6ec-c752-fb0d-08318091fc6b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 22 Aug 2019 09:16:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block/io_uring: fix EINTR
 and resubmit short reads
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefan@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 06:20:39PM -0400, John Snow wrote:
>=20
>=20
> On 7/15/19 4:19 PM, Stefan Hajnoczi wrote:
> > Short reads are possible with cache=3Dwriteback (see Patch 3 for detail=
s).
> > Handle this by resubmitting requests until the read is completed.
> >=20
> > Patch 1 adds trace events useful for debugging io_uring.
> >=20
> > Patch 2 fixes EINTR.  This lays the groundwork for resubmitting request=
s in
> > Patch 3.
> >=20
> > Aarushi: Feel free to squash this into your patch series if you are hap=
py with
> > the code, I don't mind if the authorship information is lost.  After ap=
plying
> > these patches I can successfully boot a Fedora 30 guest qcow2 file with
> > cache=3Dwriteback.
> >=20
> > Based-on: <20190610134905.22294-1-mehta.aaru20@gmail.com>
> >=20
> > Stefan Hajnoczi (3):
> >   block/io_uring: add submission and completion trace events
> >   block/io_uring: fix EINTR request resubmission
> >   block/io_uring: resubmit short buffered reads
> >=20
> >  block/io_uring.c   | 136 ++++++++++++++++++++++++++++++++++-----------
> >  block/trace-events |   6 +-
> >  2 files changed, 108 insertions(+), 34 deletions(-)
> >=20
>=20
> Since this is over the 30 days mark, I'm going to assume this WAS
> squashed into Aarushi's patchset, and it's safe to drop this from the
> review queue for now?

Yes, Aarushi included in the io_uring patch series.

Stefan

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1eXXIACgkQnKSrs4Gr
c8hNfAgAtO/CC0ZGGfHP2mCnEaGasZika+GAeAy1N75At4VxFZRaAZL02X1uWY+j
NG3PCKaa4ia8ChVqd/zBCfqfzXRY8ZbFJmfY8eb4TJa6cQgQYg5hOJgw5qs7PZHi
OutuGIutfhsbpsWP0ElJ9BL0cSUVhlhisEjJqtP14KP6RkYU7ppDLG98ddDSYhJd
8Jsjcxs1Asqr3f9liej5FTUgHJDOP5BfMn9NucBfHePdIYmbbhaEPOkzHVNx8hIc
7zb0s/ZT17r5r/b34zNugEkZNswxZq0A7fYgxotIG4dxXJ0f2BILuh6/vaWEYebs
fHGTIg6WLPByki3zdGjcfGSfFFUX0w==
=3dwx
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

