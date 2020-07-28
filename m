Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE8C433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15EC206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7S71KnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15EC206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RtI-0002FF-4u
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0Rsi-0001gS-Qw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:51:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0Rsg-0006Mn-1M
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595951464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3OstRRYDCC3FpVTZrPgfoUnGbjnBJHZrmvNGoXXGCfs=;
 b=b7S71KnTPUgfvsnNJFfub6HZ0ICpO6VCZ7NxllLeGyNznSu1KTewYUzquLMarCQ+M/9i8p
 U0Gx+IrtIJqLTqC1NGVul3rYIeQ5ckO6Iq6EOFK0sYWBTC9egcfXfyryveAYE/41w9tVZc
 j89MlYKt6My6DhcvYAGkYrc6CGPAZVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-leXKc1C_OwWikOs5-w4sBQ-1; Tue, 28 Jul 2020 11:50:59 -0400
X-MC-Unique: leXKc1C_OwWikOs5-w4sBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 484BF100AA26;
 Tue, 28 Jul 2020 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-202.rdu2.redhat.com
 [10.10.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5381E76216;
 Tue, 28 Jul 2020 15:50:54 +0000 (UTC)
Date: Tue, 28 Jul 2020 11:50:52 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
Message-ID: <20200728155052.GA389264@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 03:48:38PM +0100, Peter Maydell wrote:
> On Mon, 20 Jul 2020 at 18:22, Cleber Rosa <crosa@redhat.com> wrote:
> > Sure.  It's important that PATCH 2/2 in this series is included in a
> > branch that you need to push to the "staging" branch on the
> > https://gitlab.com/qemu-project/qemu repo (it could be just that one
> > patch).  Then, you can run:
> >
> >   ./scripts/ci/gitlab-pipeline-status --verbose -w
> >
> > And that should be it.  You can drop '--verbose' if you just want the
> > final outcome as the result.
>=20
> I tried this (local branch named "staging", pushed to gitlab
> remote "staging" branch), but it said:
>=20
> e104462:bionic:qemu$ ./scripts/ci/gitlab-pipeline-status --verbose -w
> ERROR: No pipeline found
> failure
>

Hi Peter,

I think this may just have been a timing issue.  GitLab usually does
take a few seconds after it receives a branch push to create a
pipeline.  Let me know if you'd like to see this within the script, or
if you'd rather put a sleep between your push and the
"gitlab-pipeline-status" execution.

> It does seem to have kicked off the pipeline on gitlab though:
> https://gitlab.com/qemu-project/qemu/-/pipelines/171671136/builds

There's already new content on the staging branch, but supposing my local
staging branch contained commit 6e7c2dcb50907aa6be0cbc37f81801d2fa67f7b4
(https://gitlab.com/qemu-project/qemu/-/commit/6e7c2dcb50907aa6be0cbc37f818=
01d2fa67f7b4),
the command you ran:

  ./scripts/ci/gitlab-pipeline-status --verbose -w

Should have behaved as this (output from my machine):

  /scripts/ci/gitlab-pipeline-status --verbose -w -c 6e7c2dcb50907aa6be0cbc=
37f81801d2fa67f7b4
  running...

> OTOH I can't see anything on that web page that suggests that
> it's submitting jobs to the s390 or aarch64 boxes -- is it
> intended to?
>

All the jobs for that pipeline have been created as expected, for
instance:

   https://gitlab.com/qemu-project/qemu/-/jobs/659874849

But given the recent changes to the GitLab YAML adding other phases,
it's waiting for the previous phases.

The jobs introduced with this patch are in the test phase because they
do builds and tests.  But IIRC there's a way to tell jobs to avoid
being blocked by previous phases.  I'll look into that.

Until then, I hope to see the job results soon from the s390 and aarch64
boxes.

Thanks,
- Cleber.

> thanks
> -- PMM
>=20

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8gSVoACgkQZX6NM6Xy
CfNX3A//Vbm5s2Gat9nujq3MsBbwjvr+QahGEy4I+uF2PuPRR19L/kyl13sCtAHH
32Qz7kzl0waissOM82MCR4viMvl8r2NNnF2daciNeKP+dJGHhFKBTzJcMhWbB3Vf
Onkb2qIll5GBPhhcY8YMLs606u0vUbtLqBSmqDCig/XN6Slmfcow/TjEukUap47c
Zv5p3+V7qXBPdAEwL8vyNJKhRCDC+sXMTTDaTOb6+7Kn4eqXDCGstPs413lSUOxm
VZeslAZO94a+juge1W6tfFNt7ZhZoc+B23CiVhWD1Lb5qG6vFxvYFNTC5tzxrN8a
gAu4MhZD+qWShMIfYLgUf+47effJX7ylEciVp6u4c9oQPrOne8Fw6QDouLlStGZG
Kttd0xDNZ5i/daMGmYytsnEHnPc3toUre/4gY6xgE0MDNxmV2i7zHWDHS2aSind0
fB/kzBPSECD9ETEQqm+HUHhf2oFOaSN5fs5ogzeIbC1FDHgQ+/fw5PU9Pe1y/4gv
+e0G3FEMr/UE8roUTB+XM1Fj0FAMfulfTfHyiUaKyk4BFqjBlKXi/zkmaUrjZemL
Y6JWd6FyUbJujqayFUGhTn7ylYpOzQQOO6cNZp1Jwz1qYUKT/DbA4KDXtaiklPY0
Z9aQHP8Gvu4vxw2mZ+HMPVFfliH9Z0LrD7pmy8MiShLJijQ78VI=
=Q/gI
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


