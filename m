Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058CC2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lufFVoPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058CC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWwLn-00041I-UN
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kWwKt-0003RO-E3; Mon, 26 Oct 2020 02:50:31 -0400
Received: from ozlabs.org ([203.11.71.1]:55665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kWwKq-0000q8-Ui; Mon, 26 Oct 2020 02:50:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CKQSj2PJJz9sTL; Mon, 26 Oct 2020 17:50:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603695013;
 bh=TbqVDzI6j2hZea3x1TPf+SYQIEAZcI0AWGvle7aOl8Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lufFVoPZeIuLLZQMjfV1Kbz0W0jibIvLQJSmH5ZtXxypokJKHBg5cn0e9rDJvBWHT
 RW4Ifd7zU4uwYWhgEjbrtfj1tZ5zfDzoR+VTzisAkXZeptnLhmzc+SHtE5UbdSxDKY
 /A7gHIO92zFe3MiqeWeGU84GLc4LwnjWWgA4yNjw=
Date: Mon, 26 Oct 2020 16:44:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/5] spapr: Error handling fixes and cleanups (round 3)
Message-ID: <20201026054408.GA4671@yekko.fritz.box>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <20201022041142.GG1821515@yekko.fritz.box>
 <20201025111340.48e2a40c@bahia.lan>
 <20201025223306.0ca3ee0a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20201025223306.0ca3ee0a@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:50:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2020 at 10:33:06PM +0100, Greg Kurz wrote:
> On Sun, 25 Oct 2020 11:13:40 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Thu, 22 Oct 2020 15:11:42 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Mon, Oct 19, 2020 at 10:47:52AM +0200, Greg Kurz wrote:
> > > > Hi,
> > > >=20
> > > > This is a followup to a previous cleanup for the sPAPR code:
> > > >=20
> > > > https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04860.html
> > > >=20
> > > > The last two patches had to be dropped because they were wrongly as=
suming
> > > > that object_property_get_uint() returning zero meant failure. This =
led to
> > > > a discussion in which arose a consensus that most of the time (not =
to say
> > > > always) object property getters should never fail actually, ie. fai=
lure
> > > > is very likely the result of a programming error and QEMU should ab=
ort.
> > > >=20
> > > > This series aims at demonstrating a revelant case I've found while =
auditing
> > > > object property getters (this is patch 4 that I've isolated from a =
huge
> > > > 50-patch series I haven't dared to post yet). The sPAPR memory hotp=
lug code
> > > > is tailored to support either regular PC DIMMs or NVDIMMs, which in=
herit
> > > > from PC DIMMs. They expect to get some properties from the DIMM obj=
ect,
> > > > which happens to be set by default at the PC DIMM class level. It t=
hus
> > > > doesn't make sense to pass an error object and propagate it when ge=
tting
> > > > them since this would lure the user into thinking they did somethin=
g wrong.
> > > >=20
> > > > Some preliminary cleanup is done on the way, especially dropping an=
 unused
> > > > @errp argument of pc_dimm_plug(). This affects several platforms ot=
her than
> > > > sPAPR but I guess the patch is trivial enough to go through David's=
 tree
> > > > if it gets acks from the relevant maintainers.
> > >=20
> > > Since this series mostly affects ppc, I've applied it to ppc-for-5.2.
> > >=20
> > > It would be nice to have an acked-by from Igor or Michael for the
> > > first patch, though.
> > >=20
> >=20
> > David,
> >=20
> > Igor sent a R-b for patches 1 and 4. He also suggested to call
> > spapr_drc_attach() at pre-plug time. I'll look into this, so maybe
> > you can drop patch 5 from ppc-for-5.2 (or the entire series at
> > your convenience).
> >=20
>=20
> It seems that spapr_drc_attach() cannot be called at pre-plug time
> actually because there is no way to call spapr_drc_detach() if
> the device fails to realize. I think you there's nothing else to do
> for this series than adding Igor's r-b to patches 1 and 4.

Ok.  In fact I'd already added Igor's r-b, just hadn't pushed out my
latest tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+WYiYACgkQbDjKyiDZ
s5LAkQ/8CBKngxYlI+UGrKDzzvPSl+cOS2yRR7q15CEs6zTHMhaHQ69dz1neoRtE
vu7z15nyKuZg7pAv8qeMI1z6jtwjIHDGghji4SyaoicWBWRrbvk9vvXNYRQLl31j
M8syPHuIdv7Zf1g9q10ZAqMz1mbzjzOGuFK6CC11m6jdKITBtb6s3DIZ7hCWP/2/
5g4leS+QsiyS/2HXhWpupMz9HnX0o1O2vG47tBgwg+QgccWW6XoriDqZQwD2IDqL
a0a/22PELRrXPxFFWpQcy9Wb494XDmWeeS1JspXA4BqKwmpZgpVOaNEwbQPyeyp+
vTx6r8jvZ8Dkyf1tZvPwNa6LSdr6DpfxH+Xu+vSM0lpRD4LLwk6ulvyLVcET3EwJ
q84Xe7FVQYxw4IyOgSwbz/uARFyx8rpm/p0OUAwU9YRBpIc2ZH62vYF5rGJjzHxD
CVBwClNHpaOeseQSifgA5y9BwbEiKrfoGiJVhogc42y8zJ0XHfFQ+JpaLGl9qZ11
njJTW9e4ctXR2LSKfXs/WLGMtea/uJG45bBLcuMxkeIDV0NCJd/YC4w6SP8UJkhr
GpQxUiuaJKJM5sdwnnYSc6foncEgmcIjIMsd3cT6cyTCtYdcNg+2UNcsaHxYkjA5
tEve6fdh/ck6IOvqq87galUCA0uQ/csWl5EFX3ghB9srR4nqq7I=
=N07k
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

