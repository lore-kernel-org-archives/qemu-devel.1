Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BAFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B65223B0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hasLz+jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B65223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Kj-0007U6-Uc
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iX69P-0001Oh-CB
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iX69N-0001Rv-G6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:14:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iX69N-0001Rf-BU
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574180084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCVlw6uXB0vdxN6J2BW+eK4Z7aJD5bBNaRlCvQbZyfA=;
 b=hasLz+jWPAJIZx3wrMS7JQPazFXL8Ezjld79zb5IL2QZhtk775DFmNYAEypigx+mUGPjnt
 XLRJSkLsKSylbrFQPRSR2JBlSh6BxxfrZrOWzBiF3iNUxLOF7FYVSaPRP6RjkgUgzWury/
 lNfldLEw3scAhzrjLPIQWdTLg4E2wzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-Icz_iihdP9W6Rxay7sAxVQ-1; Tue, 19 Nov 2019 11:14:42 -0500
X-MC-Unique: Icz_iihdP9W6Rxay7sAxVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB7ED593A8;
 Tue, 19 Nov 2019 16:14:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ADC9605A7;
 Tue, 19 Nov 2019 16:14:35 +0000 (UTC)
Date: Tue, 19 Nov 2019 16:14:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Exclude paths from checkpatch (was: Re: [PATCH] Add minimal
 Hexagon target)
Message-ID: <20191119161434.GB229732@stefanha-x1.localdomain>
References: <157412709300.27250.5531224491109755641@37313f22b938>
 <7851e556-a5f2-9059-faf7-3d2a4e32958c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7851e556-a5f2-9059-faf7-3d2a4e32958c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu, Max Filippov <jcmvbkbc@gmail.com>,
 tsimpson@quicinc.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 09:51:00AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/19/19 2:31 AM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/1574121497-2433-1-git-send-email-=
tsimpson@quicinc.com/
> >=20
> >=20
> >=20
> > Hi,
> >=20
> > This series seems to have some coding style problems. See output below =
for
> > more information:
> >=20
> > Subject: [PATCH] Add minimal Hexagon target - First in a series of patc=
hes - linux-user changes + linux-user/hexagon + skeleton of target/hexagon =
- Files in target/hexagon/imported are from another project and therefore d=
o not conform to qemu coding standards
> > Type: series
> > Message-id: 1574121497-2433-1-git-send-email-tsimpson@quicinc.com
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > Switched to a new branch 'test'
> > 7744509 Add minimal Hexagon target - First in a series of patches - lin=
ux-user changes + linux-user/hexagon + skeleton of target/hexagon - Files i=
n target/hexagon/imported are from another project and therefore do not con=
form to qemu coding standards
> >=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
> > #38:
> > new file mode 100644
> >=20
> > ERROR: do not use C99 // comments
> > #1922: FILE: target/hexagon/imported/iss_ver_registers.h:80:
> > +// New interrupts, keep old defines for the time being
>=20
> I tried this quick way to filter some file/directory out of checkpatch.pl=
,
> and it works nicely:
>=20
> $ cat .git/hooks/pre-commit
> #!/bin/bash
> exec git diff --cached -- ':(top)' $(test -e .checkpatchignore && sed -ne
> '/^\(#.*\|$\)/ ! s/.*/:(exclude)\0/p' < .checkpatchignore) |
> scripts/checkpatch.pl --no-signoff -q -
>=20
> $ cat .checkpatchignore
> # A line starting with # serves as a comment.
> # A blank line matches no files, so it can serve as a separator for
> readability.
> include/standard-headers
> target/xtensa/core-*
> target/hexagon/imported
>=20
> Would this be acceptable to reduce patchew false positives?
>=20
> git exclude pathspec trick from:
> https://stackoverflow.com/questions/39931781/git-diff-stat-exclude-certai=
n-files/39937070#39937070

Seems useful so that patchew/checkpatch output remains high-quality.

An alternative to the git exclude pathspec trick is to build
.checkpatchignore into the checkpatch.pl script so that regular
invocations also use .checkpatchignore.

Stefan

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3UFOoACgkQnKSrs4Gr
c8gMVwf/aOxnOmSyW5Wg506AplotYZV8Ek4oV7p0SkKahpVsK2GCMDoCn2cv4ZsQ
R+kNPM4NJq6WfhLJAwD+vHQWlgc4foaP2+O/8NteZT/FcB3zJ/WGErkZms1o3Y3X
HJxa9JZUiThtLVoX9k+4DM9cI+FCR2d+Q+UW7oQJq/V4Q0QPTYUTixNiIqRPQzJH
sYkZWTzacyevf8a0THbFzB3WDwky+gcSzHEXeZ8W2WZpUPviDBh6Lp2P7ag1D+3H
/zIJovl5nVL3AVrrIbxJDuv4aWrEfEUSAG6dnj7f+kg7om8JnNxfrnUN6raemOih
T6mtIgtIHKF2MhBF4srgHttHoIyPbg==
=+Y0u
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--


