Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F3C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5FF206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bJvAQGyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5FF206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZp9S-0004Vm-T6
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 01:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZp8V-0003bt-Ru
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:13:23 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZp8S-0003Az-QK
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:13:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49PD1w6LWyz9sTM; Sat, 16 May 2020 15:13:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589605988;
 bh=rNdsvVirbxTfhLiS9ilMyZgBa9OoLgV7psO7BF6qshM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bJvAQGySLnk9bMuNMxX1TZlZqL2XVzN5oeS6I2yR8LvRa4uG2jUNEUuVpqJTSQwXO
 hySmpWx8JXRF4wLkZkc9hegWU0EZTr/bH6HGtZ6t6Od02X3WJRWblUfjSybA1fmUIR
 WyoPqF7po5HabcXwyXOkdRAUyCmkGIjP/b5Yd7Fk=
Date: Fri, 15 May 2020 23:36:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 0/2] Makefile: libfdt: build only the strict necessary
Message-ID: <20200515133616.GH2183@umbus.fritz.box>
References: <20200514193811.6798-1-cfontana@suse.de>
 <be9d37e8-ea14-c42d-b8e6-405840e75b45@redhat.com>
 <37d6358a-2a3c-22d3-c998-fc7ff5255231@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k9EanI4qvbxMqdC7"
Content-Disposition: inline
In-Reply-To: <37d6358a-2a3c-22d3-c998-fc7ff5255231@suse.de>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Alex Bennee <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k9EanI4qvbxMqdC7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 09:56:25AM +0200, Claudio Fontana wrote:
> On 5/15/20 9:50 AM, Philippe Mathieu-Daud=E9 wrote:
> > Hi Claudio,
> >=20
> > On 5/14/20 9:38 PM, Claudio Fontana wrote:
> >> v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU yet)
> >>
> >> * changed the approach to leverage new upstream dtc Makefile,
> >>    needs dtc submodule update to include upstream dtc commit
> >>    85e5d839847af54efab170f2b1331b2a6421e647.
> >=20
> > I don't have this commit locally:
> >=20
> > fatal: bad object 85e5d839847af54efab170f2b1331b2a6421e647
> >=20
> > My remote is https://git.qemu.org/git/dtc.git, might it be de-synchroni=
zed?
>=20
> Hi Philippe, maybe that commit is not in the qemu dtc.git yet, only in Da=
vid's tree at:
>=20
> https://github.com/dgibson/dtc.git

Oops, I forgot to push it to the master tree at
git://git.kernel.org/pub/scm/utils/dtc/dtc.git

Done now.  The qemu.org mirror should update within a day or so.

> >> * LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
> >>    not used anymore.
> >=20
> > Why not include the submodule update in the first patch?
>=20
> Right, I am not sure how git.qemu.org/git/dtc.git is updated?
>=20
> I guess once it is, I should include the submodule update.
>=20
> Thanks!
>=20
> Claudio
>=20
> >=20
> >>
> >> * LIBFDT_lib: need to avoid building libfdt.so at least for now, so pa=
ss as
> >>    empty to avoid building the .so. This is to avoid breaking existing
> >>    trees with objects already compiled without -fPIC.
> >>
> >> * clean: no need to make dtc clean target, every artifact is captured =
by
> >>    global clean rule
> >>
> >> v2 -> v3:
> >>
> >> * changed into a 2 patch series; in the second patch we remove the old
> >>    compatibility gunks that were meant for removal some time after 4.1.
> >>
> >> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
> >>    existing working trees forward and backward compatible across the c=
hange.
> >>
> >> v1 -> v2:
> >>
> >> * fix error generated when running UNCHECKED_GOALS without prior confi=
gure,
> >>    for example during make docker-image-fedora. Without configure, DSO=
SUF is
> >>    empty, and the module pattern rule in rules.mak that uses this vari=
able
> >>    can match too much; provide a default in the Makefile to avoid it.
> >>
> >> * only attempt to build the archive when there is a non-empty list of =
objects.
> >>    This could be done in general for the %.a: pattern in rules.mak, bu=
t maybe
> >>    there are valid reasons to build an empty .a?
> >>
> >> * removed some intermediate variables that did not add much value
> >>    (LIBFDT_srcdir, LIBFDT_archive)
> >>
> >> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src s=
ubdir),
> >> and with docker-image-fedora, docker-test-debug@fedora that failed bef=
ore.
> >>
> >> Claudio Fontana (2):
> >>    Makefile: libfdt: build only the strict necessary
> >>    Makefile: remove old compatibility gunks
> >>
> >>   Makefile  | 32 ++++++++++++++++----------------
> >>   configure |  6 +-----
> >>   rules.mak |  2 ++
> >>   3 files changed, 19 insertions(+), 21 deletions(-)
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k9EanI4qvbxMqdC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6+mswACgkQbDjKyiDZ
s5JFnw//Qs2TjD5FimoL4+3cY5hinoJclqDVRTlH4ag2KuSj3Uvk5z+ntiBh3Mt1
rbtEWKxj239+biqaSlcGJ8UeUZYWBAZa92pyoWc0y+ajW2HTQ6q+7Ag2iPSMFmkx
l8c68xa5vTfU3Kw41pj+jxnWjXnkC/kHdZgaorwe7HsVlL2GMI9RXemfLL8qj6kM
xzHy03PqmydAnTo3TavblZP6nCia96XsBmjJUy92/cKqKImzXj0YtGZMDyE6Fhfx
SNoKqvrNd7Zd+kjad7gnhqfnASpVa0cXmtJbCxni5Jzdh495GZ49Xl4wFXnO1skP
+1tSmH9lpK7xWBD1xG0i9PHHy7WtXrpYo4DYR5QkuY3FeSrJSS48cCaPyoI7Mn3Z
tqpmUnPXXCWIqehNnhK/msEbK+AS7JmjkFgnzySfn5v//P8nyQ9AslVYsj3ee4hI
j3brVUmXipCDBx5Ugu5B5ElZisCIMd6/rjK18iLzBtK6atcRGuIubYiMchB3oClI
zJvWYrG0NJVChgSEXitC9RiaJwf9gLjnANhj0VSStDC8SXlgMxPRELosXH3K82FY
bJtbSl8xCvANTGkIvXiLEsuNmdALh4vzHntnU/TVo+a1KkAvTW1X81ZNPWum4d9j
4j3k8NGjiruxdicSgZryC6tJ9tVWaF1BC6kd0mCIxhZMoTtjsd0=
=M4ui
-----END PGP SIGNATURE-----

--k9EanI4qvbxMqdC7--

