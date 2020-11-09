Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570A32074F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDRjhO2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570A32074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8x8-0002xy-5c
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kc8v9-0001iS-Dw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kc8v7-0000na-89
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604935042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Hw8bHhYVEjHbDd7A9BxKPiLcj/7xFL+ZeyxKAyLexI=;
 b=HDRjhO2hlHert5YuFHxNld1qi5ViPK38Nywx1mDD4bfNOnGqwcMH+wHmb4VrCvejSF0zAj
 0tNcANoLA0dajHHMeZ6LLlkkto4I6OyRx5+kq11q5LJzmmwNhO9bqI+0zQTtGjl1u29EVo
 laXP0Wix28WbfgSgHp125eYAWyO1WPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-_ZELLAtmOd21zGPNXPT97g-1; Mon, 09 Nov 2020 10:17:18 -0500
X-MC-Unique: _ZELLAtmOd21zGPNXPT97g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68FEC809DF1;
 Mon,  9 Nov 2020 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F56F1002C1D;
 Mon,  9 Nov 2020 15:17:02 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:17:01 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 1/4] Jobs based on custom runners: documentation and
 configuration placeholder
Message-ID: <20201109151701.GA3874327@localhost.localdomain>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-2-crosa@redhat.com>
 <0cafdc10-b979-5a47-516b-24a51663ff6b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0cafdc10-b979-5a47-516b-24a51663ff6b@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 08:45:18AM +0200, Thomas Huth wrote:
> On 19/10/2020 03.50, Cleber Rosa wrote:
> > As described in the included documentation, the "custom runner" jobs
> > extend the GitLab CI jobs already in place.
> >=20
> > Those jobs are intended to run on hardware and/or Operating Systems
> > not provided by GitLab's shared runners.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/custom-runners.yml | 14 +++++++++
> >  .gitlab-ci.yml                  |  1 +
> >  docs/devel/ci.rst               | 54 +++++++++++++++++++++++++++++++++
> >  docs/devel/index.rst            |  1 +
> >  4 files changed, 70 insertions(+)
> >  create mode 100644 .gitlab-ci.d/custom-runners.yml
> >  create mode 100644 docs/devel/ci.rst
> >=20
> > diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runn=
ers.yml
> > new file mode 100644
> > index 0000000000..3004da2bda
> > --- /dev/null
> > +++ b/.gitlab-ci.d/custom-runners.yml
> > @@ -0,0 +1,14 @@
> > +# The CI jobs defined here require GitLab runners installed and
> > +# registered on machines that match their operating system names,
> > +# versions and architectures.  This is in contrast to the other CI
> > +# jobs that are intended to run on GitLab's "shared" runners.
> > +
> > +# Different than the default approach on "shared" runners, based on
> > +# containers, the custom runners have no such *requirement*, as those
> > +# jobs should be capable of running on operating systems with no
> > +# compatible container implementation, or no support from
> > +# gitlab-runner.  To avoid problems that gitlab-runner can cause while
> > +# reusing the GIT repository, let's enable the recursive submodule
> > +# strategy.
> > +variables:
> > +  GIT_SUBMODULE_STRATEGY: recursive
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 8ffd415ca5..b33c433fd7 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -18,6 +18,7 @@ include:
> >    - local: '/.gitlab-ci.d/opensbi.yml'
> >    - local: '/.gitlab-ci.d/containers.yml'
> >    - local: '/.gitlab-ci.d/crossbuilds.yml'
> > +  - local: '/.gitlab-ci.d/custom-runners.yml'
> > =20
> >  .native_build_job_template: &native_build_job_definition
> >    stage: build
> > diff --git a/docs/devel/ci.rst b/docs/devel/ci.rst
> > new file mode 100644
> > index 0000000000..41a4bbddad
> > --- /dev/null
> > +++ b/docs/devel/ci.rst
> > @@ -0,0 +1,54 @@
> > +=3D=3D
> > +CI
> > +=3D=3D
> > +
> > +QEMU has configurations enabled for a number of different CI services.
> > +The most up to date information about them and their status can be
> > +found at::
> > +
> > +   https://wiki.qemu.org/Testing/CI
> > +
> > +Jobs on Custom Runners
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Besides the jobs run under the various CI systems listed before, there
> > +are a number additional jobs that will run before an actual merge.
> > +These use the same GitLab CI's service/framework already used for all
> > +other GitLab based CI jobs, but rely on additional systems, not the
> > +ones provided by GitLab as "shared runners".
> > +
> > +The architecture of GitLab's CI service allows different machines to
> > +be set up with GitLab's "agent", called gitlab-runner, which will take
> > +care of running jobs created by events such as a push to a branch.
> > +Here, the combination of a machine, properly configured with GitLab's
> > +gitlab-runner, is called a "custom runner" here.
>=20
> Nit: Remove one of the two "here" in the above sentence.
>=20
> > +The GitLab CI jobs definition for the custom runners are located under=
::
> > +
> > +  .gitlab-ci.d/custom-runners.yml
> > +
> > +Current Jobs
> > +------------
> > +
> > +The current CI jobs based on custom runners have the primary goal of
> > +catching and preventing regressions on a wider number of host systems
> > +than the ones provided by GitLab's shared runners.
> > +
> > +Also, the mechanics of reliability, capacity and overall maintanance
>=20
> s/maintanance/maintenance/
>

Oopsie... thanks.

> > +of the machines provided by the QEMU project itself for those jobs
> > +will be evaluated.
>=20
> I'm not sure what this sentence is really good for... of course new stuff
> has to prove its usefulness first, but that's always the case and does no=
t
> need to be mentioned in the documentation, I think? ... maybe that senten=
ce
> is better something for the patch description instead of (hopefully)
> long-lasting documentation here?
>

I think the statement attempts to set the tone here, and answer a
question that I've seen more than once...  It certainly feels a bit
out of place here, but I also think the commit message would be too
transient and almost invisible.  I expect a lot will change in the CI
and in its docs, so I don't think this exact sentence will be too long
lasting.

Let me know if that convinces you it deserves to be in the docs, if not
I'll gladly moved it to the commit message.

Thanks!
- Cleber

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+pXWsACgkQZX6NM6Xy
CfPMCBAAs6CGTilUw/hI3uHmx5jsS7VbQVpZtz3Yu2b3LvIlssgtWdlec2S5/dMz
CqsMxTSbtYa/HH3VUFs0OVFDqEIN/i2R5jQDu1eraKv12YOX82uqWl8GQBBiA1iQ
SnR54bRGXohLgIYCzohajO+tvDIYnhMlGisS9R/v7Tere9Vb/cEQEub4/aaCh7cl
T2pXQqmMFfjUePHkkN555Aq58tSP4yK2uRwAL5noe5nUyrWlA7WCL2yvawpL7r1m
apKhOXWMYXhLoVQ+YnHyEVF9pkSS3ZWkGmUq0TpggtH4CvMT7v0XJIlcgHngoDIX
MoIuOEr+w4U+e1cXtHm1gvFwHrmcyyB8Tjjhods8DRxyaft9lqhyeq6RR+tlG6HS
rJeS/u88teHD7Jwzd+NrEBjNuwdTkHEtoVKAcr6THJnPaULAyrYJqojvL0BQCAZD
tOvlYG9Ku+BcnUvaN7eeqWr/sswADVAg9wnhqgkGP+XDU8oAHA1tAV9gs3gfXSb2
9Eeb0CCb4M+G8NfdtiORNADpvEW8vZg2GTpx3Ikxjh3Mncq0NYZ4eDS9hPzS90xx
rY+/l3q9e/UcF+Bg2naCuLn15aQ2fV186hGRoG0VoR6ry0WvUO32VYYDeoiZLDrf
l8wL/W01UElg/FJTRzdJ+s9d7pbQ/cKTSiRNfIApmiKZkbD3oBc=
=fRK2
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


