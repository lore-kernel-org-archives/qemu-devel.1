Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BDCC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150D3206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFUuDDcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150D3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHCv-0006T0-Ku
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idFUY-0003Nm-Kc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idFUV-0002gK-BI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:26:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57080
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idFUT-0002er-Iz
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575645956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjJ+ajwqZ4Cxr9teSaFNXWWcrifhGgbgofFu9El4614=;
 b=fFUuDDcz6WJaXQoFx3ZPIz9neEZz4NKJqzvnHm51keG5bzFuoaA07Ad6fjEiePrFChXTmR
 K6h81DGXOCIVIveMxctdYcofmhtXBMBVFHH0rLA64P5qvOFF5WhgCESSyz30+eD8QHE021
 H78mr5Q1IGppY0UHGRLwWKn1I429hso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-0IOYAMkuO0uZzlXb8bTzfQ-1; Fri, 06 Dec 2019 10:25:51 -0500
X-MC-Unique: 0IOYAMkuO0uZzlXb8bTzfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A716E107B7F7;
 Fri,  6 Dec 2019 15:25:50 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69C5A6B8EA;
 Fri,  6 Dec 2019 15:25:45 +0000 (UTC)
Date: Fri, 6 Dec 2019 10:25:43 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] Fix for m68k/q800 acceptance test for QEMU 4.2-rc
Message-ID: <20191206152543.GA20588@dhcp-17-72.bos.redhat.com>
References: <20191206150844.20124-1-crosa@redhat.com>
 <CAFEAcA8ekevaZnwOg5bwJmkFkDFaC_qkrLLESLbSJs=L80viHA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ekevaZnwOg5bwJmkFkDFaC_qkrLLESLbSJs=L80viHA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 03:12:31PM +0000, Peter Maydell wrote:
> On Fri, 6 Dec 2019 at 15:09, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9=
278e:
> >
> >   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
> >
> > for you to fetch changes up to 820649aa00ee343a0d473ad1002c59c70ba8c158=
:
> >
> >   tests/boot_linux_console: Fetch assets from Debian snapshot archives =
(2019-12-06 09:48:35 -0500)
> >
> > ----------------------------------------------------------------
> > Fix for m68k/q800 acceptance test (Philippe Mathieu-Daud=E9)
>=20
> Any pullreq after about rc2 needs to clearly say
> what it's fixing and why it's justifiable for it to
> go in rather than waiting for the next release.
> Otherwise you get the default response:
>   nope, not at this point in the release cycle.
>=20
> thanks
> -- PMM
>=20

Hi Peter,

This is fixing the URL from which a kernel package is fetched from,
updating it to an archival (thus stable) location.  The current
location is transient, and Debian removes packages from those
locations after a given amount of time.  Without this patch, the test
is never going to be executed.  The package itself is unchanged, as
can be seen from the verification hash that was not changed.

While this is far from critical, the main benefit of having this in
4.2, as opposed to in the next cycle, is to not "ship" a broken test
in a release.  It would also help downstream packages running such
tests.

And sorry for not giving the complete explanation before.

Thanks,
- Cleber.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qcvQACgkQZX6NM6Xy
CfPuzBAAqcwwEz36lXTPuRDG1XhXAajqdm5lzDhAfZp+adaDUvlkdFLAE1P4vawG
nmmXfz6R7Cw1FRUgVAlnLRNOgqNBCq6foypzJB/deeXPViKFU5DJiAIINk2B8qxI
ePnf81O8fOmHh9UzliP0/h7U47BhPhknb6W8JtNq3CcZe30ijokT6a31PWYLAEPd
QoW4Hu87nsV7Xxis79/3Rt3rdtuCa+sVJF1OcU9l9tDMGqMEGpl9IzvBvEHgLlXG
LflZ3MPRZFjHeMOzCAtAP7GJs1a9RuLafwdkiV00f3z4GHiDzK5l3Q5i6A20HPbx
znz+Q1msCmFJoPqY74DT5q2bYJ26tXFPr+Myrs5N2oO1M4jzYEr6VGMwmUDUop2R
hbR5yWdCnT8afgNmnGzO7o14GNPw2+tm5eOcfTzBIa5IjI4WRnPbC/c/jLOhWRHN
LYjoGK6I9r8sU4kTUzAPLMHmn5fuRtnmULDsA4km/R7lOOnnWj+4LncAyhEoQNpu
kFRjLqWMei74cIxW9mHTLy2I1YnyhMnN/yt5Wr0A3aT6YNCZeSRUJ0Fi8ZlM5zKE
0jY4ROQ1Xo20ELeaaGebTnk167F9GFDCFPb9KrXgrnH8TBYqoBIl/35Ki2f7C7XY
fgYy8b8zdg7yrpMXuNvxgV/TSdYj4Dq/WHpyBspLWtrbgw4T8OQ=
=HRQQ
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--


