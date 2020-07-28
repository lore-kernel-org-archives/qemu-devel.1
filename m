Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D457C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570E42065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brVqQlBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570E42065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SF0-0006AN-M9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0SED-0005Wh-Hd
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:13:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0SEB-0001Bq-46
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595952798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y9xT0+55b0OkRnElrNLpqdkIdMFe0Ad9Ow/aHgz+X3k=;
 b=brVqQlBPXqywSAV04jWa+eT8OBq7Yy2bB0K0llqMGcvr+1tWDfc9TeEGSESSIupY+A2a9R
 Te5Lm/Z+ZjSoNYu9SnzKvMaFMITxGmxGuFegP6uGbO7386QDRQ2mqhSeCzQXEvFrosPANT
 AlYcPtkIX6xvNS/8WPQd3ekx6tqTRB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-GLSBh0v2PzKfmXsoL8ngVg-1; Tue, 28 Jul 2020 12:13:15 -0400
X-MC-Unique: GLSBh0v2PzKfmXsoL8ngVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2719419067E3;
 Tue, 28 Jul 2020 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-202.rdu2.redhat.com
 [10.10.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CA3D71908;
 Tue, 28 Jul 2020 16:13:08 +0000 (UTC)
Date: Tue, 28 Jul 2020 12:13:06 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
Message-ID: <20200728161306.GB389264@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
 <20200728145134.GB3443476@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200728145134.GB3443476@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 03:51:34PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jul 28, 2020 at 03:48:38PM +0100, Peter Maydell wrote:
> > On Mon, 20 Jul 2020 at 18:22, Cleber Rosa <crosa@redhat.com> wrote:
> > > Sure.  It's important that PATCH 2/2 in this series is included in a
> > > branch that you need to push to the "staging" branch on the
> > > https://gitlab.com/qemu-project/qemu repo (it could be just that one
> > > patch).  Then, you can run:
> > >
> > >   ./scripts/ci/gitlab-pipeline-status --verbose -w
> > >
> > > And that should be it.  You can drop '--verbose' if you just want the
> > > final outcome as the result.
> >=20
> > I tried this (local branch named "staging", pushed to gitlab
> > remote "staging" branch), but it said:
> >=20
> > e104462:bionic:qemu$ ./scripts/ci/gitlab-pipeline-status --verbose -w
> > ERROR: No pipeline found
> > failure
> >=20
> > It does seem to have kicked off the pipeline on gitlab though:
> > https://gitlab.com/qemu-project/qemu/-/pipelines/171671136/builds
> > OTOH I can't see anything on that web page that suggests that
> > it's submitting jobs to the s390 or aarch64 boxes -- is it
> > intended to?
>=20
> It looks like those jobs are all in the "test" stage of the pipeline, so
> it is waiting for the earlier stages to complete before running the jobs.
>

Hi Daniel,

Right.  IIUC the criteria for putting jobs in the test stage at the
moment is "if they include running tests (in addition to builds) they
should be in test".  Looking at that from this perspective, they're in
the right place.

But, these jobs don't depend on anything else, including container
builds, so there's no reason to have them wait for so long to run.
The solution may be to rename the first stage (containers) to something
more generic (and unfortunately less descriptive) so that all of them
will run concurrently and earlier.

Thoughts?
- Cleber.

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8gTpAACgkQZX6NM6Xy
CfMhuA//cARkxf2TJ0T+lnmi68ReHSxpvkeEApGV7U7dQAiac6yt9AeQynQFHMeb
JoH3+/NHmEWfemAdsORy0Dgt/D8wWnIxNNn/7Leap7XjN/ppuOIcOaXslVslKu0I
MOPU/bOFrmGQA5VL06bzTbUfszc67uw/Q5ugztUmBP3ENOnn2y+f9wbLgmUuStiU
z0UG5iMOeocE4DMq8DZyeyxBijOT55exRGA3naJVgM4wxol6kjmMeK4uLYbu7LJM
LacQAgGVB9ayIaocFH5A1pAA5XJk83bgtwM7oee0z5iuB+GS848ZbCNmNPOfO0uM
ilVFMLgoXl1OzjkwFLt/Z8anHlj3qR6KZTeF+dz6ZHUxK1F1iul01BO1oNIUrGyK
9aenUKS/nnHijHIJsoD+8Y9XqWuA7sELwZFnXzQPPLrN0bjd/tosnuUsRWsWbJdy
9/xUDGtx4jtJUNC3ZOoBWeeuwASnHRWHFzXad9IUCnS24+tycOY/KVwWd9MHvQRF
s8O/KW6Op2X7HmoBduysvnWACaFo+pKWdVc1/YFGaIdftgBZ9uhQ/Ow2aaVtSgPN
qM9lGQ7H8js3JdlrCz/+mxgwPEiNfXiL2WeSVo4RXgRBTtX02RwQpedGVLluAfVl
5xn2hJrtqOyCtS+z+QNQBpYZ8073wjHpfIbc7ruri5hxeo5OCLs=
=AsMr
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--


