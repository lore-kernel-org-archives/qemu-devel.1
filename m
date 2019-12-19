Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B632BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819932176D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWottMKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819932176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjeV-0003fT-Ml
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihjdd-0002kY-Q5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihjdb-0002O6-IX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:25:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihjda-0002Mi-Up
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576715154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzqDzRfFCR1o3Y9Ndmz5oBeJ1T0sEEHyyL2/A5Iu3hw=;
 b=BWottMKGGypShOfs+fjXm4Rll9M/2DFkTw8Wso2YkTd8mEEQDwNhUqWpgkh5LXTuDCA3O5
 uHneJ1Mynu1wYGcPsRF2gy7St2JVa1+O2TmufKGN4jNXxzjipg+rYMS4H2o7Ncry16vYo/
 5AZYk2wtRQniDIGT1NiwyckVTpGAfOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-B9jN7OdQPQ6vL_7uUk59zA-1; Wed, 18 Dec 2019 19:25:51 -0500
X-MC-Unique: B9jN7OdQPQ6vL_7uUk59zA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0741801E6D;
 Thu, 19 Dec 2019 00:25:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28D5F26E43;
 Thu, 19 Dec 2019 00:25:42 +0000 (UTC)
Date: Wed, 18 Dec 2019 19:25:39 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 1/4] Acceptance tests: introduce BLD_DIR, SRC_DIR and
 LNK_DIR
Message-ID: <20191219002539.GA29918@localhost.localdomain>
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-2-crosa@redhat.com>
 <3362e435-73be-f5c3-a672-6208f2bacd95@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3362e435-73be-f5c3-a672-6208f2bacd95@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 01:02:39AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 12/19/19 12:24 AM, Cleber Rosa wrote:
> > Some tests may benefit from using resources from a build directory.
> > This introduces three variables that can help tests find resources in
> > those directories.
> >=20
> > First, a BLD_DIR is assumed to exist, given that the primary form of
> > running the acceptance tests is from a build directory (which may or
> > may not be the same as the source tree, that is, the SRC_DIR).
>=20
> Can we name this BUILD_DIR?
>

Yes, of course.

> This would be more in line with the other buildsys files (configure/make)=
.
>

That's a good point.

> > If the directory containing the acceptance tests happens to be a link
> > to a directory (kept as LNK_DIR), it's assumed to it points to the
> > source tree (SRC_DIR), which is the behavior defined on the QEMU
> > Makefiles.  If the directory containing the acceptance tests is not a
> > link, then a in-tree build is assumed, and the BLD_DIR and SRC_DIR are
> > the same and LNK_DIR is set None.
>=20
> Similarly, can we name this CURRENT_DIR instead of LNK_DIR?
>

Yes, or maybe even drop it?  TBH, I can only see use cases for build
and source dirs.  So, I assume you'd propose SRC_DIR would be
SOURCE_DIR?

Cheers,
- Cleber.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl36w4EACgkQZX6NM6Xy
CfO0+hAAuR0Hog/pBJ7nPKMp1iGWS9SdIGMWx2LGWi/fLQmdxmjaI8yYtZqf0hu1
Mr4wKmAzDyVXByZFhLvs6mVrv7y3rqVZDbdKK9yswaleausVqL6bkTgjnFnAXEkT
QZKUY1NpdSUeBePCp6eOItGtDGg/Ef0a/1vCPNdl+mX0z+VFgnwu4af2X79gHaYd
uOPuGbcS9DvitjJNrw0F6CnJPObCeWI9E/k6cBKBtT7tSqEOBa3ty2dl+HAMJNDt
iCDu3SeCSdLYYdqGhifEsHQLlECv4DQh0yWYjOprPMkSEA6A9PQY5oHpjewcr+Bn
xtvFScgqD0eRDQ3XV3xVdZsAsiFND0AIF15Z81UA/rhTjCp7jn00sdzKagVCRcWa
IfCuuaeQr2Cwnvnc3HTgoFbcAuZFxckdYUUbKR8fNtZj1BDe0ylr5qzxb5qbMBEF
XL742xW9SpRem6iGBh59D7V+c2wj4sSjvOMYoBUtszXKCTo7U99iy2kf3WEXaPV0
gyco9M4OL+M3Qw5IJE+7VPaxLK7aZTzXJAJw0fAFzBKdkNSUwdj4JIwH71qG5aPu
Pzyx2yWctdJHfEeGi4gYlckWfm9t5S0gyDnNqPp1HqYs9H9q/At7E2VhoXLRW9hI
TZ9KSHP/hdLaIY4BrXT7KuBNcPQ6PDPGnDEhaozUeWfwe0lwB/I=
=FSmf
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


