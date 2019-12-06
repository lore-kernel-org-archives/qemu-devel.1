Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6309FC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C00124659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8vZ/jcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C00124659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGoo-0003Vr-MD
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idFo9-0001Dd-Em
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idFo3-0006Mk-AL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:46:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idFo2-0006Ji-SX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575647169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s+QCmtAoSbsFXhh9jznWklrSekDd1K+v+KfUa846Fs0=;
 b=Y8vZ/jcA+wyaVFEtcMYwnmWfxrMcndY3Acx1U+yS6Bk+zMBcTZY65TCzuJwl7qNKo1vo2k
 ovlxR7FhjCDuE1tB7SSARop3VNK/oa6LtJh32g571cDdSnQ6dNcJdZMWs/Lm6HChDDgxym
 iWgHHy4GvOz/d72GSCyzkTyWIUWVokU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-9LOT38v1NhagqXniTcypxQ-1; Fri, 06 Dec 2019 10:46:06 -0500
X-MC-Unique: 9LOT38v1NhagqXniTcypxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 964FB800D5B;
 Fri,  6 Dec 2019 15:46:05 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E17A95C1C3;
 Fri,  6 Dec 2019 15:45:59 +0000 (UTC)
Date: Fri, 6 Dec 2019 10:45:58 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] Fix for m68k/q800 acceptance test for QEMU 4.2-rc
Message-ID: <20191206154558.GA23522@dhcp-17-72.bos.redhat.com>
References: <20191206150844.20124-1-crosa@redhat.com>
 <CAFEAcA8ekevaZnwOg5bwJmkFkDFaC_qkrLLESLbSJs=L80viHA@mail.gmail.com>
 <20191206152543.GA20588@dhcp-17-72.bos.redhat.com>
 <CAFEAcA_SmR_QnrSzDGpsckh_hatNthVbx_0Z9=qM3BQSwVyhKg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_SmR_QnrSzDGpsckh_hatNthVbx_0Z9=qM3BQSwVyhKg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Beraldo Leal <bleal@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 03:37:19PM +0000, Peter Maydell wrote:
> On Fri, 6 Dec 2019 at 15:25, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > On Fri, Dec 06, 2019 at 03:12:31PM +0000, Peter Maydell wrote:
> > > On Fri, 6 Dec 2019 at 15:09, Cleber Rosa <crosa@redhat.com> wrote:
> > > >
> > > > ----------------------------------------------------------------
> > > > Fix for m68k/q800 acceptance test (Philippe Mathieu-Daud=E9)
> > >
> > > Any pullreq after about rc2 needs to clearly say
> > > what it's fixing and why it's justifiable for it to
> > > go in rather than waiting for the next release.
> > > Otherwise you get the default response:
> > >   nope, not at this point in the release cycle.
>=20
> > This is fixing the URL from which a kernel package is fetched from,
> > updating it to an archival (thus stable) location.  The current
> > location is transient, and Debian removes packages from those
> > locations after a given amount of time.  Without this patch, the test
> > is never going to be executed.  The package itself is unchanged, as
> > can be seen from the verification hash that was not changed.
> >
> > While this is far from critical, the main benefit of having this in
> > 4.2, as opposed to in the next cycle, is to not "ship" a broken test
> > in a release.  It would also help downstream packages running such
> > tests.
>=20
> Thanks for the explanation. If at the moment the test is simply
> being skipped (ie it is not actually failing) then I would
> prefer to delay this to 5.0. Otherwise we'll start running
> the test and may find that it is actually failing in some
> of our CI or test environments. That wouldn't be a problem
> a bit earlier in the release cycle, but given we've already
> had rc4 and rc5 is going to have the minimum number of
> absolutely critical fixes in it I think I'd prefer not to
> take that risk.
>=20
> thanks
> -- PMM
>=20

Yes, this is a very fair point.

Thanks,
- Cleber.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qd7MACgkQZX6NM6Xy
CfNOrg/+PewR8O3yK3f4aMS1KPPJwRKY0jTPgrWY7LamNKndZj2Dvxjwqa023/bH
n2HCk8S0yGoBnAJZP2sHuqtGwdkhikUr/UHBj5GgJ5Aq1Larz52kEV+RALTogzeY
PrX7+nSyahNMkf+xbs9gVblUMirxhRwsBVXyUeCR0gJhSu1g+wQEWy0Uba3752ho
b7V42h2f+QPCINpds74bNidBDOdXk7+UZ/3TJojPbGbWo7XlYRAoYHhX2S8re1C5
AJknah8MpYfync8QCQ5hXlxQItvJC8B9y3gHyepAIgsG/3TIW0PMQ7EK6vMKBn67
uYB4V7dFz1hDedIzylgaIWp+/MRJ/CztumviPv2BKbWUX1TsPZ+PXLXM61qMU0SA
CgzXoDmKZbZDiHOAMGLj9G+qlbm2w1G7shrU9sTawymb/cZ5aRFLpt0YhGaNcEyB
za1HyEUhicJGmX8yQ4VsAQ01IA4cQxfercNk8Hqa97fY++sSPgZKBhDyXwHtM91q
ZM7rePR1v9Xcok+9zkFPZ5xgY3GPVjfPJLu38oJ4ZaBC/Wfkp/yhHYamOb3CnsL1
Z972RiQZZ9A+dtvVeUF8TZ4b56iYpBd4A4c56fg9vryldkHFpbTVkbLfxRsEsrOM
FRVCztMwH+7S2y0kYdih/HO3I9NNHslu2vL1dSzIpkyJPkMX8kw=
=jmGr
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


