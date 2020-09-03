Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF0C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC2820678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSIxG2Bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC2820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxA1-0001du-P0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDwX8-0005Dr-1q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:12:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDwX5-0000pM-As
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599167553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/yqg3EGjPSxhZ66yF+Xt2cnRLlNWNBZ9VXNiLPX8+2c=;
 b=QSIxG2Bxvvd3ulDI0al58l2GjlwIcIUe12ZDm5/8n69hyh3cvV3WAAkJl9HHwZLw4fjaXb
 3mLFQ1HhtrwD3gRsdk5dVJaOj8qfsUatcfLodYpxNWRBZM/9VeOFl+ekPWxRfcCg7Uwv9e
 zN+W0NsogkPtw78jVi0KwpRdbZ9k4fY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-P6UazNAHMyiKuh4ECaiZ9w-1; Thu, 03 Sep 2020 17:12:17 -0400
X-MC-Unique: P6UazNAHMyiKuh4ECaiZ9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD520100746C;
 Thu,  3 Sep 2020 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D55B12D07D;
 Thu,  3 Sep 2020 21:12:12 +0000 (UTC)
Date: Thu, 3 Sep 2020 17:12:11 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200903211211.GC55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709085507.GA536480@nautilus.usersys.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709085507.GA536480@nautilus.usersys.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 10:55:07AM +0200, Erik Skultety wrote:
> On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > This is a mapping of Peter's "remake-merge-builds" and
> > "pull-buildtest" scripts, gone through some updates, adding some build
> > option and removing others.
> >
> > The jobs currently cover the machines that the QEMU project owns, and t=
hat
> > are setup and ready to run jobs:
> >
> >  - Ubuntu 18.04 on S390x
> >  - Ubuntu 20.04 on aarch64
> >
> > During the development of this set of jobs, the GitLab CI was tested
> > with many other architectures, including ppc64, s390x and aarch64,
> > along with the other OSs (not included here):
> >
> >  - Fedora 30
> >  - FreeBSD 12.1
> >
> > More information can be found in the documentation itself.
> >
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
> >  .gitlab-ci.yml                         |   1 +
> >  docs/devel/testing.rst                 | 147 +++++++++++++++++
> >  scripts/ci/setup/build-environment.yml | 217 +++++++++++++++++++++++++
> >  scripts/ci/setup/gitlab-runner.yml     |  72 ++++++++
> >  scripts/ci/setup/inventory             |   2 +
> >  scripts/ci/setup/vars.yml              |  13 ++
> >  7 files changed, 598 insertions(+)
> >  create mode 100644 .gitlab-ci.d/gating.yml
> >  create mode 100644 scripts/ci/setup/build-environment.yml
> >  create mode 100644 scripts/ci/setup/gitlab-runner.yml
> >  create mode 100644 scripts/ci/setup/inventory
> >  create mode 100644 scripts/ci/setup/vars.yml
> >
> > diff --git a/.gitlab-ci.d/gating.yml b/.gitlab-ci.d/gating.yml
> > new file mode 100644
> > index 0000000000..5562df5708
> > --- /dev/null
> > +++ b/.gitlab-ci.d/gating.yml
> > @@ -0,0 +1,146 @@
> > +variables:
> > +  GIT_SUBMODULE_STRATEGY: recursive
> > +
> > +# All ubuntu-18.04 jobs should run successfully in an environment
> > +# setup by the scripts/ci/setup/build-environment.yml task
> > +# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
> > +ubuntu-18.04-s390x-all-linux-static:
> > + tags:
> > + - ubuntu_18.04
> > + - s390x
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > + script:
> > + # --disable-libssh is needed because of https://bugs.launchpad.net/qe=
mu/+bug/1838763
> > + # --disable-glusterfs is needed because there's no static version of =
those libs in distro supplied packages
> > + - ./configure --enable-debug --static --disable-system --disable-glus=
terfs --disable-libssh
> > + - make --output-sync -j`nproc`
> > + - make --output-sync -j`nproc` check V=3D1
> > + - make --output-sync -j`nproc` check-tcg V=3D1
>=20
> I know this patch doesn't introduce a FreeBSD job, but later in the patch=
 it's
> clear you'd want to introduce them at some point, so:
> 'nproc' doesn't exist on FreeBSD, but `getconf _NPROCESSORS_ONLN` does, s=
o you
> may want to use it right from the start.
>=20
> ...
>

Sure, thanks for the info.

> > +
> > +CI
> > +=3D=3D
> > +
> > +QEMU has configurations enabled for a number of different CI services.
> > +The most update information about them and their status can be found
>=20
> s/update/up to date/
>

Good catch!

> > +at::
> > +
> > +   https://wiki.qemu.org/Testing/CI
> > +
> > +Gating CI
> > +----------
> > +
> > +A Pull Requests will only to be merged if they successfully go through
>=20
> s/A /
> s/to be/be/
>=20
> > +a different set of CI jobs.  GitLab's CI is the service/framework used
>=20
> s/a different set/different sets/       (I may be wrong with this one)
>=20
> ...

I think you're right.  But, to keep it simpler, I'm using:

"Pull Requests will only be merged if they successfully go through
different CI jobs."

>=20
> > +
> > +gitlab-runner setup and registration
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The gitlab-runner agent needs to be installed on each machine that
> > +will run jobs.  The association between a machine and a GitLab project
> > +happens with a registration token.  To find the registration token for
> > +your repository/project, navigate on GitLab's web UI to:
> > +
> > + * Settings (the gears like icon), then
> > + * CI/CD, then
> > + * Runners, and click on the "Expand" button, then
> > + * Under "Set up a specific Runner manually", look for the value under
> > +   "Use the following registration token during setup"
> > +
> > +Edit the ``scripts/ci/setup/vars.yml`` file, setting the
> > +``gitlab_runner_registration_token`` variable to the value obtained
> > +earlier.
> > +
> > +.. note:: gitlab-runner is not available from the standard location
> > +          for all OS and architectures combinations.  For some systems=
,
> > +          a custom build may be necessary.  Some builds are avaiable
> > +          at https://cleber.fedorapeople.org/gitlab-runner/ and this
> > +          URI may be used as a value on ``vars.yml``
> > +
> > +To run the playbook, execute::
> > +
> > +  cd scripts/ci/setup
> > +  ansible-playbook -i inventory gitlab-runner.yml
> > +
> > +.. note:: there are currently limitations to gitlab-runner itself when
> > +          setting up a service under FreeBSD systems.  You will need t=
o
> > +          perform steps 4 to 10 manually, as described at
> > +          https://docs.gitlab.com/runner/install/freebsd.html
>=20
> What kinds of limitations? Is it architecture constrained maybe? I'm aski=
ng
> because we have all of the steps covered by an Ansible playbook, so I kin=
da got
> triggered by the word "manually". Also, the document only mentions 9 step=
s
> overall.
>

FreeBSD's "service management" (systemd/sys-v like) is not covered by
the GO library[1] used on gitlab-runner.  It's not ideal, and the
second best solution would be to script the equivalent handling within
the playbook, but I remember trying and finding some inconsistencies.
Then, I had to give it up and defer to whenever a FreeBSD job is
actually added.

> Regards,
> Erik

[1] - https://github.com/ayufan/golang-kardianos-service

Thanks for the review, I'll be sending a v3 shortly.
- Cleber.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9RXCgACgkQZX6NM6Xy
CfNlIxAAovcpwJFZchHGJ4ZQLaUq1a49SE2nW/y1iUYQAsrLEyV9pN9E9ApX7ARE
+SyuqsFHvLczbBD6vj6aa0XpYJ4j9pbxqYeNOtqOUdQW1Gt73BH+Ort1YoePlP3T
/V27b1vEctNu7Yg5UaDXVjqXV4B982FbDaj6ZAkGsUgW4nZw+GSb4i92aK+dBzpG
+mdF6rKkj7+8+Vc938GGa9aXdT1fxX0Tr/3mSjonVwm7t/y0WdOEjbh98dzQ9vxI
42VAszj7sedhyCMWH5QYi/FGV/T2rZt1RJejKfYiXyQNJsCZUrtdu838wMZBvxqe
T90WuuuKYEmKJmcTEcJLVnxRMcCpzqJ7PIMnf11YEh0ZUvrOvOA7H0vfVIiuoQfh
P7jGAiimHy7frHIgaY/jIfdOpdgw0B4+RTNlihAJ8DslErfhDolXdd0yui2IHLWJ
5tvB8xfrPl3jtFDh0L00/CepT2f7RGFrsM6BId5hwDWES6TwQKnU2JGhqz7dOOkn
nLFbTsw19wQjw6+7a6MllIxj0rdWtktLg5GDQ2mxjV3FVFv1pj7R7A+7ZazXGBz1
mj58LfnRnXYtq6FZ+390rxNr487725ygNfBGAL1EhAQAaq0+HOf+AQ4/Gp+e2eIa
5Kgz6wh17Sc4BdIWWSu7f1W+TLKUKzoQzAsSiwgKtVJRy2Uhgtc=
=xW2X
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--


