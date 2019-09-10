Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F8AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6663B21019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6663B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aWv-0004sT-Lx
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7aVR-0003jV-3Q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7aVP-0004Ze-10
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55484)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7aVL-0004YN-4O; Tue, 10 Sep 2019 03:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E334191865C;
 Tue, 10 Sep 2019 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-217.ams2.redhat.com
 [10.36.116.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B188378D;
 Tue, 10 Sep 2019 07:23:55 +0000 (UTC)
Date: Tue, 10 Sep 2019 09:23:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190910072354.GB4446@localhost.localdomain>
References: <20190903133553.6500-1-mreitz@redhat.com>
 <20190903133553.6500-2-mreitz@redhat.com>
 <CAFEAcA_Gpw14Hjr7rW0Z-9Ngj5Udbxv0ZEMZAo0W0PT0nCwe2g@mail.gmail.com>
 <3311e590-d2c1-2388-27cf-981c917881ab@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <3311e590-d2c1-2388-27cf-981c917881ab@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 10 Sep 2019 07:23:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PULL v2 01/16] qemu-io: add pattern
 file for write command
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.09.2019 um 09:19 hat Max Reitz geschrieben:
> On 09.09.19 19:26, Peter Maydell wrote:
> > On Tue, 3 Sep 2019 at 14:35, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> From: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >>
> >> The patch allows to provide a pattern file for write
> >> command. There was no similar ability before.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> Message-id: 20190820164616.4072-1-dplotnikov@virtuozzo.com
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >> [mreitz: Keep optstring in alphabetical order]
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >=20
> > Hi; Coverity finds a FILE* leak in this code (CID 1405303):
>=20
> Thanks for the heads-up.  Denis, do you want to write a patch?

I already sent one.

Kevin

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdd0+KAAoJEH8JsnLIjy/WlLMP/35Ex3EwvBRviFWHEFZtvfMD
CG6zOyQLmkl/KbEDsWdkosxSJfutaYkj/Ums1QIgeDx7YUD4YsDRvMmBjAhPphUf
sJ0i2dWLdc4zt36he7kWa0XB3y0EOX8XgWsNPoBzUGoAScLui0qTAUQ8ACZYMgk7
Xbp32jbcS92Ung/oJPu7Z7PVF3dHA5jruX6Nsq/SUL/NDPb2fuTYAkVUglyi1mTl
93UiDJZAy4IcfpMnSarkwQRlfuNzKO3F6c0PS3ZTQHJQR8cwsJKeBjuMXDobe9bO
zOkTZjzlDq5jQL5eMc216xdFtCGwOdQUbxX2jxqSJh24joCwMSymSeJ0c9/nr/Lc
KtIgCFDKQV6nmEzArbEeaI6Gl7h5RMUK2E5GdlRVpFB2fjdWrWdopEE0RiYH3TRD
pX/ZCH9iM3GS2moGi4nZR8Hx8fpkjyx4vJoBLGkJ8na2kgxwtk/EwyqOGH0i/WsN
fbhpzH+5YrVP/oBjqWZt8i/czJvbnuG34w7cX32iQHhn0tDjE3fXMazvng5Lec9o
KZNKSbrBJGCUXJnOqYB7bwLC9Nn1B1fUKiyR8anaX7OgIVqXwf3gYWXxjO5IpJSH
HwDQoCXoCksiaMROjqlmLLAU22+i2oyrRTZmiCbA20xULbdWnaekPtVBgeWsahSK
t3/0J9dscIlrA1VC87jo
=MKaj
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--

