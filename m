Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45B3C433FE
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929F4207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayeKPQqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929F4207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SZ6-0000he-TB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0SYN-0008TL-Sh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:34:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60401
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k0SYL-0004Mr-NX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595954048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JTCm+9QsvT5Iju6ogfiqWiOVMKlu0Z1i5zH9R4+aG1g=;
 b=ayeKPQqsXjWeq0Hlokyc1pGw9CX6oEmqGY/dGnu+bA1sHji3MxD8ZkHTpYihtmUQwYyP5I
 RrDjOakfj7d5B0h0ZaHnQsYKrZ1l5nSuO3cfNBHyeEjImtg132j2UhenWfger31V5VpyuN
 LZ/RiYl+HuRU7drsbYmBdzLNf0lCFvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-QZ9b8thCO8eYR-FqCNeiag-1; Tue, 28 Jul 2020 12:34:04 -0400
X-MC-Unique: QZ9b8thCO8eYR-FqCNeiag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EE7310059A7;
 Tue, 28 Jul 2020 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-202.rdu2.redhat.com
 [10.10.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B6F71901;
 Tue, 28 Jul 2020 16:33:59 +0000 (UTC)
Date: Tue, 28 Jul 2020 12:33:57 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
Message-ID: <20200728163357.GB393320@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
 <20200728155052.GA389264@localhost.localdomain>
 <CAFEAcA99fVFKwc6ju1w=2FRn9_UNhroGLRfZm+2hq_qMK-eNKA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99fVFKwc6ju1w=2FRn9_UNhroGLRfZm+2hq_qMK-eNKA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 05:08:50PM +0100, Peter Maydell wrote:
> On Tue, 28 Jul 2020 at 16:51, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 03:48:38PM +0100, Peter Maydell wrote:
> > > On Mon, 20 Jul 2020 at 18:22, Cleber Rosa <crosa@redhat.com> wrote:
> > > > Sure.  It's important that PATCH 2/2 in this series is included in =
a
> > > > branch that you need to push to the "staging" branch on the
> > > > https://gitlab.com/qemu-project/qemu repo (it could be just that on=
e
> > > > patch).  Then, you can run:
> > > >
> > > >   ./scripts/ci/gitlab-pipeline-status --verbose -w
> > > >
> > > > And that should be it.  You can drop '--verbose' if you just want t=
he
> > > > final outcome as the result.
> > >
> > > I tried this (local branch named "staging", pushed to gitlab
> > > remote "staging" branch), but it said:
> > >
> > > e104462:bionic:qemu$ ./scripts/ci/gitlab-pipeline-status --verbose -w
> > > ERROR: No pipeline found
> > > failure
> > >
> >
> > Hi Peter,
> >
> > I think this may just have been a timing issue.  GitLab usually does
> > take a few seconds after it receives a branch push to create a
> > pipeline.  Let me know if you'd like to see this within the script, or
> > if you'd rather put a sleep between your push and the
> > "gitlab-pipeline-status" execution.
>=20
> Ah, right. I ran the command again and it does (eventually)
> print "running...". I think the ideal behaviour would be for
> the script to have some kind of "waiting for pipeline to start..."
> phase where it sits and polls for the pipeline to appear,
> with a pretty long timeout (minutes?).
>

Fair enough.  I'll send a patch to change the script behavior.

> > > It does seem to have kicked off the pipeline on gitlab though:
> > > https://gitlab.com/qemu-project/qemu/-/pipelines/171671136/builds
> >
> > There's already new content on the staging branch, but supposing my loc=
al
> > staging branch contained commit 6e7c2dcb50907aa6be0cbc37f81801d2fa67f7b=
4
> > (https://gitlab.com/qemu-project/qemu/-/commit/6e7c2dcb50907aa6be0cbc37=
f81801d2fa67f7b4),
> > the command you ran:
> >
> >   ./scripts/ci/gitlab-pipeline-status --verbose -w
> >
> > Should have behaved as this (output from my machine):
> >
> >   /scripts/ci/gitlab-pipeline-status --verbose -w -c 6e7c2dcb50907aa6be=
0cbc37f81801d2fa67f7b4
> >   running...
> >
> > > OTOH I can't see anything on that web page that suggests that
> > > it's submitting jobs to the s390 or aarch64 boxes -- is it
> > > intended to?
> > >
> >
> > All the jobs for that pipeline have been created as expected, for
> > instance:
> >
> >    https://gitlab.com/qemu-project/qemu/-/jobs/659874849
> >
> > But given the recent changes to the GitLab YAML adding other phases,
> > it's waiting for the previous phases.
>=20
> The page now says "This job has been skipped"...
>

I saw that, and I was very disappointed... I double checked the
machines, the runners status, tag names and they all seem to be OK.

So, I think the reason for the skip (there's an open issue on GitLab
itself about not communicating to users the reason) is that GitLab
does a late evaluation of the job condition.  For those jobs the
condition is:

   rules:
   - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'

Which by the time the job was evaluated it was no longer true (there
was new content on the staging branch).  There are multiple ways to
solve the problem, including (and in my order of preference):

 1. using '$CI_COMMIT_BRANCH' instead of '$CI_COMMIT_REF_NAME', given
    that the pushed branch name should be kept stable even if the content
    (thus reference name) changes

 2. not changing anything if you believe that under normal
    circunstances one pipeline for the staging will be running at a
    time.

I'll prepare a new version with #1, unless you have a strong feeling
against it.

- Cleber.

> thanks
> -- PMM
>=20

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8gU3IACgkQZX6NM6Xy
CfP3uw/+KVCW+TIbulWqbc45HmBhwxUCI+4QAFCRxWA/hEDiXIoaNOJAVSK6s8Sm
oADlS4UbDJpktofjAU1l4AbFLcBMJjQx3zRwtN/RXH40OJ+kJsGv/aYQVap3Rnw5
HFsj1YnVpTIFMCyj+pvZW6s7MIo5uEbwiVlP7fAWVsWIXk14fVKXLIuJgVqm+tKx
31w5gowh5t32HI1NOn4sX1tnQOSlk5nhNGiqNTuHEDTmumjznBWdMOFWJ5griYTw
gGhm28WbiSSyfTApx+ZPrE7ehhQc7xyHwdpqLMXHtsR67oFjWNrhCMapA6ONqdRe
6Sgy7XPV+qKuRaksGERBmPoE07Vrxh0z8WrrYGbwSdrtEPk5DMaTuPq8W+5xd9ui
TfCybuo9y4Ki9m3No9toVHj0A7AHyvvtwdm+V4a8cCZlvZxFVwJXZL2oTquvPBiF
lIg+KqEZNs4CHm/2vPBgGSeDJxGA41+DXJ6RUkOyHUYVbTia2Hi/mVjfnqP1ewwr
rYFlqttcdqLAI3T+y2quEot9u3N2rl9JpA/b5mKWjYX9xTuL3AulhCbQWv5mdOiJ
XehmcrCFGrel65bxKDQN76W791HNDmLpVtr0wAJNtT6tgdysobFjI/ixt3wyKXqe
DsXRUig6O5HogcgBJQ3TnMmsAf6uPORTp10YPItYcnsLaotDLlo=
=cGdF
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--


