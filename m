Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A3C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A11920867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A11920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJwm-0003QC-JD
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iGJvx-0002za-OC
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iGJvv-0008VV-8O
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:31:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iGJvv-0008VG-2I
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:31:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86BAA898113;
 Fri,  4 Oct 2019 09:31:29 +0000 (UTC)
Received: from localhost (unknown [10.36.118.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50FC65D9E1;
 Fri,  4 Oct 2019 09:31:26 +0000 (UTC)
Date: Fri, 4 Oct 2019 10:31:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: more automated/public CI for QEMU pullreqs
Message-ID: <20191004093124.GH505@stefanha-x1.localdomain>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822104957.GE20491@stefanha-x1.localdomain>
 <CAFEAcA_FLN=bpBr4RriqAOS9e2v2bkv2Wnqwm9Rwcm4oX2PteQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_FLN=bpBr4RriqAOS9e2v2bkv2Wnqwm9Rwcm4oX2PteQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 04 Oct 2019 09:31:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 01:53:16PM +0100, Peter Maydell wrote:
> On Thu, 22 Aug 2019 at 11:50, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > Thanks for writing up this summary!  The requirements and possible
> > solutions are now clear.
> >
> > We need someone willing to set up and maintain the CI.
> >
> > One-off tasks:
> >
> > 1. Create CI runners that offer similar cross-architecture coverage to
> >    Peter's current setup.  qemu.org has some x86, ppc, and s390 server
> >    resources available.  I'm not sure about ARM and other architectures.
> >
> > 2. Write CI configuration to run Peter's "make && make check && make
> >    check-tcg && linux-user-test".
> >
> > 3. Document the CI on wiki.qemu.org.
> >
> > Ongoing responsibilities:
> >
> > 1. Triage failures that the qemu.git maintainer thinks are related to CI
> >    runners.
> >
> > 2. Keep the CI up-to-date and runners online.
> >
> > Any volunteers?
>=20
> I see this call for volunteers didn't attract any offers :-/
>=20
> Thread consensus seems to be toward using gitlab CI -- assuming
> we can hand-build the gitlab runner for the architectures
> we need without having to block on gitlab fixing their weird
> "build for all architectures at once" packaging ?

Let's tackle the issue of CI at KVM Forum.  The main issue is to get
people.

I will talk to colleagues beforehand to see if anyone is available for
this role.

Stefan

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2XEWwACgkQnKSrs4Gr
c8hpbQf+Oqo7JOa9OzTvt7h0TSSt5r8IwhnT/G50J4KkBjo85Ct9hnytCnprFXV2
K/YMlnlE/vKfvPBSeB2VdGeWEdGQ8XpVtykFuA62TTX2sUbTpEWxhUzJdrPlB6YB
yxw3/UYEWxEDl8R9+lNlLfTukGJgsytZK0m9pGK87zsBoEuLmd4dWYlYItyzfY6t
GnHINvRc+tncd+d+dgPo0p96YhdBF4g6Jt3zxNeHPDYOWE7Bv5+7fT7BlOORwoNz
z1RkM2WD7glcDSHZfWU+GZaakxfryecQNeaq0sCuLageoruTpzNIyUR+gfHZje64
FW7ZOG4/6cohl3T+uBa0Y4ecaq832A==
=FERy
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--

