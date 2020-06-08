Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EF0206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bZWIYQaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EF0206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEUc-0000bb-TO
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jiES8-0006TA-4r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:52:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44877 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jiES5-00045y-Iv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:52:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49gT7G5pWyz9sRR; Mon,  8 Jun 2020 19:52:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591609930;
 bh=3nftKjTSlR6yZLalgH0AP5LAfLkOWB0e+gKJpPTMjwI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bZWIYQaPiNTpUl0mmDFKfUJxvf4N6kbg3/pwKtLlbkWhlELKdde7bQ/7XEhhhDiPF
 ZlHb5Ly41otFxY7mmzjd05khBfRSxLdjtQv9nh4j736GOH5xdWIGRKq9Z3YbF6l07g
 XKdPgXhDa53viKzqqXKLdC8XSGmipxwW1f7lToyw=
Date: Mon, 8 Jun 2020 19:52:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 0/2] Makefile: libfdt: build only the strict necessary
Message-ID: <20200608095200.GC494336@umbus.fritz.box>
References: <20200518160319.18861-1-cfontana@suse.de>
 <1f70e2fb-a1f4-29af-c9e6-38b178fa26ca@suse.de>
 <9f1d9711-c87d-f554-2718-f69b3babbf54@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <9f1d9711-c87d-f554-2718-f69b3babbf54@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 Philippe Mathieu-Daude <philmd@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 David Gibson <dgibson@redhat.com>, Alex Bennee <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 08:53:52AM +0200, Thomas Huth wrote:
>  Hi David,
>=20
> could you maybe take this through your ppc tree?

Sounds reasonable, but this version doesn't seem to apply any more.

>=20
>  Thanks,
>   Thomas
>=20
>=20
> On 01/06/2020 13.28, Claudio Fontana wrote:
> > Hello all,
> >=20
> > is this queued somewhere?
> >=20
> > Thanks,
> >=20
> > Claudio
> >=20
> > On 5/18/20 6:03 PM, Claudio Fontana wrote:
> >> v4 -> v5:
> >>
> >> * include the dtc submodule update commit in the 1/2 patch
> >>
> >> v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU yet)
> >>
> >> * changed the approach to leverage new upstream dtc Makefile,
> >>   needs dtc submodule update to include upstream dtc commit
> >>   85e5d839847af54efab170f2b1331b2a6421e647.
> >>
> >> * LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
> >>   not used anymore.
> >>
> >> * LIBFDT_lib: need to avoid building libfdt.so at least for now, so pa=
ss as
> >>   empty to avoid building the .so. This is to avoid breaking existing
> >>   trees with objects already compiled without -fPIC.
> >>
> >> * clean: no need to make dtc clean target, every artifact is captured =
by
> >>   global clean rule
> >>
> >> v2 -> v3:
> >>
> >> * changed into a 2 patch series; in the second patch we remove the old
> >>   compatibility gunks that were meant for removal some time after 4.1.
> >>
> >> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
> >>   existing working trees forward and backward compatible across the ch=
ange.
> >>
> >> v1 -> v2:
> >>
> >> * fix error generated when running UNCHECKED_GOALS without prior confi=
gure,
> >>   for example during make docker-image-fedora. Without configure, DSOS=
UF is
> >>   empty, and the module pattern rule in rules.mak that uses this varia=
ble
> >>   can match too much; provide a default in the Makefile to avoid it.
> >>
> >> * only attempt to build the archive when there is a non-empty list of =
objects.
> >>   This could be done in general for the %.a: pattern in rules.mak, but=
 maybe
> >>   there are valid reasons to build an empty .a?
> >>
> >> * removed some intermediate variables that did not add much value
> >>   (LIBFDT_srcdir, LIBFDT_archive)
> >>
> >> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src s=
ubdir),
> >> and with docker-image-fedora, docker-test-debug@fedora that failed bef=
ore.
> >>
> >> Claudio Fontana (2):
> >>   Makefile: libfdt: build only the strict necessary
> >>   Makefile: remove old compatibility gunks
> >>
> >>  Makefile  | 32 ++++++++++++++++----------------
> >>  configure |  6 +-----
> >>  rules.mak |  2 ++
> >>  3 files changed, 19 insertions(+), 21 deletions(-)
> >>
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7eCj0ACgkQbDjKyiDZ
s5JUmRAAuVA0C3Yz4eDm5Vpxmer/FK+SgCE2mwNQOkS30m0VZCEWwg2dgBRW/AG7
7yZntaMW0+6COOZ94xommRqg8X28muJGmZ0bt5dqZoJc499iUIeLNObidZYsyPKV
vh+uElv0EKN9xLctPyGDq4kRuBB2T2bXKgkUHqaanE2IKppFSK1dmhqaVLUpME0B
YicWeU9QVC4xtmAXIlzSTK16P7HoDqAgDcI+U1kRW8Z8jqPWgtdXbQ7LDudeNcA+
Rq5Vd9+xRWnOD0wsbAzcC3iLJRamoR/9xuLJ5iht384JWd/3w7jWVxoqEav5sRw+
hjz9DDzLuRqPkhhG3R7sRqyJRBHoBwHHqb/cAd6JWeIv8p4Ga0cprueosqBHJ2Al
KoC0choBvE+QGejT0DxJX33/UhWbQrt7BnvN8F1/8u/BQ0hYTf+wCAwMaoDOR14Q
EPzDK6iAXz/HWesL+FNy/Y5F7XEKHIHcM8BIkaSxpt9xAEjjp8Gtj9cYeRa7fZ1B
ZpLibXcmPo7N8A9rJtJ5YO4GSOYaOQ8l3fIPyj3MH8Q5YT21li2+jxWJvMVTRNSv
bwnUcBwM9QqeMBBOov7evTz1z9To2q4KJm/94SK8qDoOL7lPb1Babi1dsythyolm
93E79ufL97kHZdRNF3RvuomFMzwfFZHtVE2SLdgcWt4FJFrHxXs=
=6dIy
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--

