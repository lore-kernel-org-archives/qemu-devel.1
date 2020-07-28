Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8AC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5AA20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7kGCalQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5AA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SQ0-0005vY-CF
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0SPM-0005SR-B8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:24:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0SPK-0002z2-GG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595953489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tzu2hqlv8ZLOejNibr2oners+zkv7j80I9Ffe4IazBA=;
 b=Y7kGCalQSDtMt/X01xwX+suWVwGSJmwQk+uL9WtS94+80k9omfAKOGqGkxzQLvZLVR9rY2
 aFRnlxsAomAsL8WBUeDUNh8NFOkcUy6eDfjidXt1BXy58cDgIoDTwXaBSAAJuInE2VlgKa
 aSGPnHt19q0RQcrALQY5s2LVOw5uHHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-a6FsBwWJNCSo8bupC-ap7A-1; Tue, 28 Jul 2020 12:24:37 -0400
X-MC-Unique: a6FsBwWJNCSo8bupC-ap7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCC2880183C;
 Tue, 28 Jul 2020 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-202.rdu2.redhat.com
 [10.10.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1BFA19C4F;
 Tue, 28 Jul 2020 16:24:32 +0000 (UTC)
Date: Tue, 28 Jul 2020 12:24:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
Message-ID: <20200728162431.GA393320@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
 <20200728145134.GB3443476@redhat.com>
 <20200728161306.GB389264@localhost.localdomain>
 <20200728161517.GD3443476@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200728161517.GD3443476@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
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

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 05:15:17PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jul 28, 2020 at 12:13:06PM -0400, Cleber Rosa wrote:
> > On Tue, Jul 28, 2020 at 03:51:34PM +0100, Daniel P. Berrang=E9 wrote:
> > > On Tue, Jul 28, 2020 at 03:48:38PM +0100, Peter Maydell wrote:
> > > > On Mon, 20 Jul 2020 at 18:22, Cleber Rosa <crosa@redhat.com> wrote:
> > > > > Sure.  It's important that PATCH 2/2 in this series is included i=
n a
> > > > > branch that you need to push to the "staging" branch on the
> > > > > https://gitlab.com/qemu-project/qemu repo (it could be just that =
one
> > > > > patch).  Then, you can run:
> > > > >
> > > > >   ./scripts/ci/gitlab-pipeline-status --verbose -w
> > > > >
> > > > > And that should be it.  You can drop '--verbose' if you just want=
 the
> > > > > final outcome as the result.
> > > >=20
> > > > I tried this (local branch named "staging", pushed to gitlab
> > > > remote "staging" branch), but it said:
> > > >=20
> > > > e104462:bionic:qemu$ ./scripts/ci/gitlab-pipeline-status --verbose =
-w
> > > > ERROR: No pipeline found
> > > > failure
> > > >=20
> > > > It does seem to have kicked off the pipeline on gitlab though:
> > > > https://gitlab.com/qemu-project/qemu/-/pipelines/171671136/builds
> > > > OTOH I can't see anything on that web page that suggests that
> > > > it's submitting jobs to the s390 or aarch64 boxes -- is it
> > > > intended to?
> > >=20
> > > It looks like those jobs are all in the "test" stage of the pipeline,=
 so
> > > it is waiting for the earlier stages to complete before running the j=
obs.
> > >
> >=20
> > Hi Daniel,
> >=20
> > Right.  IIUC the criteria for putting jobs in the test stage at the
> > moment is "if they include running tests (in addition to builds) they
> > should be in test".  Looking at that from this perspective, they're in
> > the right place.
> >=20
> > But, these jobs don't depend on anything else, including container
> > builds, so there's no reason to have them wait for so long to run.
> > The solution may be to rename the first stage (containers) to something
> > more generic (and unfortunately less descriptive) so that all of them
> > will run concurrently and earlier.
>=20
> Just add 'needs: []'  to any jobs that don't depend on earlier jobs.
>

Great, thanks!

Long version: I remember something like this was possible (which I
mentioned in the other reply), but the documentation about stages
(https://docs.gitlab.com/ee/ci/yaml/#stages) made me loose hope when
writing this reply.  Thanks again!

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

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8gUTwACgkQZX6NM6Xy
CfMAXw//e7ia2j5zxzzpJB7wjFUeobIaqogrNSidsY2o4v02q7CE+gms2NL5pwJJ
WrDZVMolAV0vETbUQhXYGZFjCwOp0zniHtDtF/Uwdy56EIW6XYmVYKMcRuEQ3ZeY
dZPanUDzVmAQFmSojO5WKMp1GbaJk4xiwt42zOYRjg35+E4In7ToH8mJbdONpilP
auP0hQq41p9bgvkM0krC3AvODW9bK0bUjN6o3Nt9ocoRc8ZYfJB4+N5Qrjqxm7Px
HHHuHCA/O3aUhM6N4+na6AB6rzgKsltpj9NzICSkdoCV/ulTnZRfVvjxc2mn6dnU
uVBvkAhg/jkxEUet2fQHL/7FBB+HLZw+3i8Zkt6VUP8VC594jR9JASzpRTF8sP0U
bra2zFNi3EZk3/7N/hz7HgZt3CCePn0nm6bFWuaGsTXez5GsPSCdu9Upjs0KKGDB
OZY1oHrToHWhpoCvUQdGti3GnG7VzMAVXr/EhI2TSK/Kwoi4swDojB1Wl+BHkc50
eW+eBkXGp5u8NbJ64ao/CxuJ9KKZH4srHrcLWpPdR92G8cl26qiR+2s1sOMY5HI6
MG7LUf0dGYDLdM8iha6MGYa9WIODVwMk87dYQjHvuQbxifkeuNO5Wc/0CaHfYcw3
IpS0RhMwz5Fxxrl4XQhPJFq1YRLafw9kXTrn2or3jgQyLBVB94M=
=OY5W
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--


