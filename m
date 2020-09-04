Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52CAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7864220716
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjrxDRsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7864220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDzLZ-0004ce-H5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 20:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDzKk-00044l-28
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:12:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDzKh-0005Hg-FQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599178318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YlXVbqjWIdwcOfLn7GxZ4m9DFMvg1Dn+6qUoNJ63FlE=;
 b=gjrxDRspBpFJr3PmaneJ4NeXe0QDjpi8oXC+VwjLYoIJQlL+NGueqQzGX/FLvuT8bVdObL
 lsaqPpLnYjumibunaDnnlSuZurTYDyjszyBbLg8IrMyYvriJetpWZKFlD4U04jDad49swD
 c4iN0+tvAcTRrMHtRW2mjjAi6COUSv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-WsWhbjYIPTS_fXGodYG_7A-1; Thu, 03 Sep 2020 20:11:46 -0400
X-MC-Unique: WsWhbjYIPTS_fXGodYG_7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A592018B9ED1;
 Fri,  4 Sep 2020 00:11:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BDEE5D9CC;
 Fri,  4 Sep 2020 00:11:41 +0000 (UTC)
Date: Thu, 3 Sep 2020 20:11:39 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904001139.GE55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709103029.GK3753300@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709103029.GK3753300@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 20:11:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 11:30:29AM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > This is a mapping of Peter's "remake-merge-builds" and
> > "pull-buildtest" scripts, gone through some updates, adding some build
> > option and removing others.
> >=20
> > The jobs currently cover the machines that the QEMU project owns, and t=
hat
> > are setup and ready to run jobs:
> >=20
> >  - Ubuntu 18.04 on S390x
> >  - Ubuntu 20.04 on aarch64
> >=20
> > During the development of this set of jobs, the GitLab CI was tested
> > with many other architectures, including ppc64, s390x and aarch64,
> > along with the other OSs (not included here):
> >=20
> >  - Fedora 30
> >  - FreeBSD 12.1
> >=20
> > More information can be found in the documentation itself.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
>=20
> AFAIK, the jobs in this file just augment what is already defined
> in the main .gitlab-ci.yml. Also since we're providing setup info
> for other people to configure custom runners, these jobs are usable
> for non-gating CI scenarios too.
>

If you mean that they introduced new jobs, you're right.

> IOW, the jobs in this file happen to be usable for gating, but they
> are not the only gating jobs, and can be used for non-gating reasons.
>

Right, I do not doubt these jobs may be useful to other people and on
scenarios other than "before merging a patch series".

> This is a complicated way of saying that gating.yml is not a desirable
> filename, so I'd suggest splitting it in two and having these files
> named based on what their contents is, rather than their use case:
>=20
>    .gitlab-ci.d/runners-s390x.yml
>    .gitlab-ci.d/runners-aarch64.yml
>=20
> The existing jobs in .gitlab-ci.yml could possibly be moved into
> a .gitlab-ci.d/runners-shared.yml file for consistency.
>

Do you imply that every gitlab CI job should be a gating job?  And
that the same jobs should be used when other people with their own
forks?  I find this problematic because:

* It would trigger pipelines with jobs that, unless every user has the
  same runners configured, would have unfulfilled jobs that don't have
  a matching hardware.

* It dilutes the idea that those jobs are inherently different with
  regards to the management of their infrastructure.

* It destroys the notion of layered testing, for whatever people find
  that worth it, where a faster turnaround could/would be possible
  with fewer jobs for every push, and many more jobs before a merge.

Finally, I find the split by runner architecture you suggested
problematic because different organizations may have jobs for the same
architecture.  I believe that files for different organizations may be
a better organization instead.  Entries in the MAINTAINERS are one
example where the grouping by architecture may not be optimal.

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
> >=20
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
>=20
> I think I'd make it more flexible in particular to allow multiple
> branches. For example I have multiple subsystems and have separate
> branches for each.
>=20
> This could be as simple as allowing a regex prefix
>=20
>   - if: '$CI_COMMIT_REF_NAME =3D~ /^staging/'
>=20
>=20
>=20
>=20
> > diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/=
build-environment.yml
> > new file mode 100644
> > index 0000000000..89b35386c7
> > --- /dev/null
> > +++ b/scripts/ci/setup/build-environment.yml
> > @@ -0,0 +1,217 @@
> > +---
> > +- name: Installation of basic packages to build QEMU
> > +  hosts: all
> > +  vars_files:
> > +    - vars.yml
> > +  tasks:
> > +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> > +      apt:
> > +        update_cache: yes
> > +        # This matches the packages on tests/docker/Dockerfiles/ubuntu=
1804.docker
>=20
> I'd be inclined to actually use docker on the custom runners.
>=20
> eg. instead of having separate physical machines or VMs for each
> (distro, arch) pair, have a single host distro for the arch. Then
> use docker to provide the build environment against each distro.
>=20
> IOW, a RHEL-8 aarch64 host, running docker for ubuntu18.04, fedora30
> etc.
>

I've come across so many caveats and corner cases that having the
lowest common denominator proved to be the smart and sane thing to do.
For instance, building on the example you gave, running a RHEL 8
aarch64 host is a NO GO Today because RHEL 8 doesn't ship with docker
and the gitlab runner needs to be taught to talk to, say, Podman.

gitlab-runner-helper images for different architectures, used to
prepare the docker images before running jobs, also proved to be a
challenge.

Finally, it's going to be very important for some organizations to
run tests outside of container environments.  For instance, Red Hat
needs to run QEMU+KVM tests on bare metal and on VMs, in addition
to containers.

> That way we don't end up duplicating all these packages, and instead
> can use  tests/docker/Dockerfiles/ubuntu1804.docker.  This ensures
> that if a user needs to reproduce a build failure on their own local
> aarch64 machine, they can run docker and get the exact same build
> architecture.
>

Like I explained before, containers-only won't cut it.  So, we need
tooling that is environment agnostic.  So far, ansible playbooks seem
to be a reasonable solution.  But duplicating information bothers me
as much as it seems to bother you, so we need to engage in common
tooling that is capable of generating those container environments,
but not be limited to it.  One example of a tool that seems to be
a good candidate is "Libvirt's" lcitool.

> It also has the benefit that we don't need to worry about how to
> setup gitlab runners for every distro we care about. We only need to
> do gitlab runner for the standard host distro, which spawns a pristine
> throwaway docker env.
>=20
> I appreciate this is a big change from what you've done in this patch
> though, so don't consider this comment a blocker for initial merge.
> I think we should do this as the long term strategy though. Essentially
> for Linux builds, everything should always be container based.
>

Thanks for taking the time to give this feedback, and for making me
check again the premises that led to the proposal of this design.

Hopefully, this will be an improvement over the current state of
"pre-merge" testing, and at the same time can be the first step
towards a scenario that has more of the characteristics you pointed
out.

Best!
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

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9RhjkACgkQZX6NM6Xy
CfO+vxAAoCrkpwa+z1TMXrMhLs7La3qJ8wYdQFEKrrVK8+BcdJ5nvudHDYtZCABo
dSO93zkhuzglSxswSwtCE4FbgXTKenZwfSnFN42RR0prjHv6P/XTLxDY9S3/zTK9
t+p6htjxOutTqPQIF+ugVGBwR7qWqvueoKMQ4rdPxcAVUHpUh4CDiNTB2tC1otV9
DolZzrZxnPk4yrE30eK0WgH4zTRVhXzp7DHlKXy3o16HdYxLbYBqkcbx1XGA1wqh
XR/QGAKUe2yKTgKgtWDt2rAFey8khQaIFBwYWETyQjzS6K9P2hZKf98CCNqnzrXF
twbQyOzXDHQ7f8PPD2/HeLSLeVIKUwXKzrEhaAyCJR9F1WDVC1BVvYwFJXmntYv8
X4wd7yPUBtMymiolaO8/zsXtSXOmArbztSLG+2lhmn+V9Fdmp0OBTXsuWXUG7F80
kyZiAGEexDrCVLmfWwyFGjA98RpFlVtttZU9iZdQ4hRt1YDL6/9Koo5zo44pDGGl
vvzl+CizE4e/Ie6EFcw7AJW1uUtY5YHc3t+XMhX2OTluEocgeudcYHD0H/csFacK
NkcWifB7wqopNYtSIAE0niiFwwmmbygUTTI6pOtsKMKPOvDnhBq5+SpV/MyCI3NY
Rmo5c1QwEzKZMOQf3y5s6MLhwOTw2b/hCZ0jhrt8cY0+Xv5U5cI=
=c4dm
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--


