Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7AECDE20
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC1A206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC1A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MST-0004n4-LW
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8MR1-0003JE-KK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8MR0-0006Rk-ID
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:34:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8MQy-0006QX-EQ; Thu, 12 Sep 2019 06:34:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75DEE88302;
 Thu, 12 Sep 2019 10:34:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-179.ams2.redhat.com [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A1BF60852;
 Thu, 12 Sep 2019 10:34:38 +0000 (UTC)
Date: Thu, 12 Sep 2019 12:34:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190912103436.GG5383@linux.fritz.box>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
 <20190911082743.GC4907@localhost.localdomain>
 <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
 <20190911103123.GE4907@localhost.localdomain>
 <c22a405b-d79b-ad00-427f-c4e54e897f0d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <c22a405b-d79b-ad00-427f-c4e54e897f0d@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 12 Sep 2019 10:34:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.09.2019 um 13:00 hat Max Reitz geschrieben:
> On 11.09.19 12:31, Kevin Wolf wrote:
> > Am 11.09.2019 um 12:00 hat Max Reitz geschrieben:
> >> So all in all I think it=E2=80=99s best to make the callback mandatory=
 and add
> >> two global helper functions.  That=E2=80=99s simple enough and should =
prevent
> >> us from making mistakes by forgetting to adjust something in the
> >> future.
> >=20
> > Yes, that should work.
> >=20
> > We should probably still figure out what the relationship between the
> > child access functions and child roles is, even if we don't need it for
> > this solution. But it feels like an important part of the design.
>=20
> Hm.  It feels like something that should be done before this series,
> actually.
>=20
> So I think we should add at least a child role per child access function
> so that they match?  And then maybe in bdrv_attach_child() assert that a
> BDS never has more than one primary or filtered child (a filtered child
> acts as a primary child, too), or more than one COW child.  (And that
> these are always in bs->file or bs->backing so the child access
> functions do work.)

Makes sense to me.

Kevin

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdeh88AAoJEH8JsnLIjy/WdWQP/1tNqzCztlrnaqk2ACJxKOf3
Jz2LDdn1dtQv4YVwj9W+Ht/Ysz4cxEzKcGmLlN/Cb2mHsksCasY5b2ePwJ5awsxB
73IHk1AboeanVHW73tAx1H8Mjcadk6JO5E13a+tQvjlEAfdRsZPvldhw3mXSzdDZ
ij8SB5ztTfyZA5QgyhCajiqRzsBFNjOguWd8gXFedkkI+P2YVSri7CN4JNuE3/ti
laSp7iHZ+zT89B/ejYnSnxYVPNgWE2z/AfSh5p8wVPvP6W+3To4yPxCWuqPE5MAg
buDZKjVD/8ycgwt78vuCB8aQzSzkuWTqRaaBeuF/2hOOBZSd1MwDAyeCPO235BMS
WmgNLOyWBcu59mHsMFAYIKT51OokeLyv7Az8f12QbTrUK4WdiSsSXCZ7m9euwxAE
R69kr+NbGD2ArEGab195Hk7BqupR9DdJ9tzQVePTCkLWjaEuZH1TBlsT47Wp9lO+
IViRKJeA3CzZV49YpNJJZavBrt248cEkd0Gexh++qR9/XuJ4pJL/KjKuAeKgeWS5
mIPomI5VcQ3To7Qi9SjzqdrWltz0X7M+Z3EZngCLwPDzbrPh2gjhap1OzEoWYGwr
ktal5GTC6OwHxSz05raBavbwlwP3ThWFmz5n2xwO62r7QcAVEGn1KND5RXPAefvS
R8M41cvJ58MESmZf8Je2
=JDSy
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--

