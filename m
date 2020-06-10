Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2476DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD722074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Tw3ij2b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD722074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisyR-0002J3-2W
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisuW-0003xU-Fy
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:04:24 -0400
Received: from ozlabs.org ([203.11.71.1]:54195)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisuV-0006qp-7N
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:04:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZfB6d0kz9sSS; Wed, 10 Jun 2020 15:04:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591765458;
 bh=qPUiaH9w2H1CGLrtL01FsBPRRImwRJC54PtlVwsph2s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tw3ij2b4FyJCjx4Gj/+xG5pGbjTmfv29Bqq4YOBM2viLQHpSe4P/hsXeg14bEpV/h
 9RsBL1Pd9Tqr05fxMf9Kl9GswGIWv4fU+tRtv+naLy73geS/lgBUAlP/tXcJFKi+Np
 E9+HXBveHHZLPB3NXEDtA5pOFz8bnzeXsMbjQxHk=
Date: Wed, 10 Jun 2020 15:02:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 0/2] Makefile: libfdt: build only the strict necessary
Message-ID: <20200610050249.GK494336@umbus.fritz.box>
References: <20200518160319.18861-1-cfontana@suse.de>
 <1f70e2fb-a1f4-29af-c9e6-38b178fa26ca@suse.de>
 <9f1d9711-c87d-f554-2718-f69b3babbf54@redhat.com>
 <20200608095200.GC494336@umbus.fritz.box>
 <39261b0b-e256-0e47-3394-1a3c7838f650@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="opg8F0UgoHELSI+9"
Content-Disposition: inline
In-Reply-To: <39261b0b-e256-0e47-3394-1a3c7838f650@suse.de>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 00:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 David Gibson <dgibson@redhat.com>, Alex Bennee <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--opg8F0UgoHELSI+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2020 at 01:14:31PM +0200, Claudio Fontana wrote:
> On 6/8/20 11:52 AM, David Gibson wrote:
> > On Sun, Jun 07, 2020 at 08:53:52AM +0200, Thomas Huth wrote:
> >>  Hi David,
> >>
> >> could you maybe take this through your ppc tree?
> >=20
> > Sounds reasonable, but this version doesn't seem to apply any more.
>=20
> Hi David,
>=20
> which problem are you experiencing?

Urgh, now I'm not sure what happened.  I seemed to get conflicts in
the Makefile, but now I seem to have them committed ok to my tree
after all.  I think I was just confused.

Anyway, they should be in ppc-for-5.1 now.

> I have applied the series to latest master without encountering problems =
and pushed to:
>=20
> https://github.com/hw-claudio/qemu.git "v5-Makefile-build-necessary"
>=20
> Thanks,
>=20
> Claudio
>=20
> >=20
> >>
> >>  Thanks,
> >>   Thomas
> >>
> >>
> >> On 01/06/2020 13.28, Claudio Fontana wrote:
> >>> Hello all,
> >>>
> >>> is this queued somewhere?
> >>>
> >>> Thanks,
> >>>
> >>> Claudio
> >>>
> >>> On 5/18/20 6:03 PM, Claudio Fontana wrote:
> >>>> v4 -> v5:
> >>>>
> >>>> * include the dtc submodule update commit in the 1/2 patch
> >>>>
> >>>> v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU y=
et)
> >>>>
> >>>> * changed the approach to leverage new upstream dtc Makefile,
> >>>>   needs dtc submodule update to include upstream dtc commit
> >>>>   85e5d839847af54efab170f2b1331b2a6421e647.
> >>>>
> >>>> * LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
> >>>>   not used anymore.
> >>>>
> >>>> * LIBFDT_lib: need to avoid building libfdt.so at least for now, so =
pass as
> >>>>   empty to avoid building the .so. This is to avoid breaking existing
> >>>>   trees with objects already compiled without -fPIC.
> >>>>
> >>>> * clean: no need to make dtc clean target, every artifact is capture=
d by
> >>>>   global clean rule
> >>>>
> >>>> v2 -> v3:
> >>>>
> >>>> * changed into a 2 patch series; in the second patch we remove the o=
ld
> >>>>   compatibility gunks that were meant for removal some time after 4.=
1.
> >>>>
> >>>> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
> >>>>   existing working trees forward and backward compatible across the =
change.
> >>>>
> >>>> v1 -> v2:
> >>>>
> >>>> * fix error generated when running UNCHECKED_GOALS without prior con=
figure,
> >>>>   for example during make docker-image-fedora. Without configure, DS=
OSUF is
> >>>>   empty, and the module pattern rule in rules.mak that uses this var=
iable
> >>>>   can match too much; provide a default in the Makefile to avoid it.
> >>>>
> >>>> * only attempt to build the archive when there is a non-empty list o=
f objects.
> >>>>   This could be done in general for the %.a: pattern in rules.mak, b=
ut maybe
> >>>>   there are valid reasons to build an empty .a?
> >>>>
> >>>> * removed some intermediate variables that did not add much value
> >>>>   (LIBFDT_srcdir, LIBFDT_archive)
> >>>>
> >>>> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src=
 subdir),
> >>>> and with docker-image-fedora, docker-test-debug@fedora that failed b=
efore.
> >>>>
> >>>> Claudio Fontana (2):
> >>>>   Makefile: libfdt: build only the strict necessary
> >>>>   Makefile: remove old compatibility gunks
> >>>>
> >>>>  Makefile  | 32 ++++++++++++++++----------------
> >>>>  configure |  6 +-----
> >>>>  rules.mak |  2 ++
> >>>>  3 files changed, 19 insertions(+), 21 deletions(-)
> >>>>
> >>>
> >>>
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--opg8F0UgoHELSI+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gaXYACgkQbDjKyiDZ
s5K/Bg/+L8hyoINx7W8HH0vbiQO5UDBCvnkGKjL7l9l5fQN3goIs7tg4O9xZqkYC
jLkyNt3MqXrQa6Rl5LmL/kKXUnjqgl/9RKeE/IoBrQ8SEdfka+gTLlah2kggXUsd
P0GvwhmO1WynVMnoz2yuAtCUa5qQ9IFmZTuNCo9ZxzGXLggZaictxyF+0P5M0w49
wEZJvm34dUkr9jomndQFmRO6HG3Dt5AWDymYAcuPn1Gg/ZagQOFEJ7hb4bweGMKe
nw5jUlJ0kLjZzdLG1txJpjffR2jd77nq2IKD/pBwk+9Vul8l+Wp/3zgDhadeOhRW
d8NTYPAE4x72G7iIuewMcQ5FNKybsaOkka/Obw6NBP+N2iYayeQDw3FNuz6c3Vfc
zkkFxtMc9SUSh4ihzmvD2+vooQLZBS8ajzzwOAG7twlp2X3h1rhHU/JvZXY97Pas
9T9tALTlKdItYMRsuvVr5RBStlssKm5ZSBYtJVWQTIMjp2YCQ4A6twJhwhMRAbZ7
9LWuhv0pX7YksO5odkf21Gih97Ea4896rQJ7ErgWY6vXXsBmdSXHNNH4fWJmoWwR
NejHcFBvRPYtaADxwmU/UM501FogR472gIFISlVgk2Gr2AN09b0/h3U+TzgJwS4G
4eVcpnp+OX0YJ/mRqrp8YiKyA+ZcuusLo7oGUJw3wBl6Q7vfuwI=
=2Cx7
-----END PGP SIGNATURE-----

--opg8F0UgoHELSI+9--

