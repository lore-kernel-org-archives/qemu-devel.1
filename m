Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49373C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101702071C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g38d71OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101702071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqkQ-0007le-HG
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jDp8w-00041P-0h
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jDp8t-0001E5-KK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:46:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jDp8r-00010j-19
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LedGvwVFV70/OCrlbpdNTPHCHCZb7VaL5RYKtID9BDQ=;
 b=g38d71OKgCdmvRrDGjaEqnIzH8UIlxPdIEaqIQcRJov0+q3LqUu1gBnbirPltjbeGxEeyv
 I1YVFu7hoIDpDdWdbr02AftQx50lCE8prIGAYZ24RNjNj9dOqbku0a++WHJdjA/hvR/Uks
 3ev/OI1NbVlIApaijvkXC76MGRM0Og4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-dikehZeANL21kArRJ-HJfA-1; Mon, 16 Mar 2020 08:46:46 -0400
X-MC-Unique: dikehZeANL21kArRJ-HJfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7830E8C5D80;
 Mon, 16 Mar 2020 12:46:45 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BE9F60BEE;
 Mon, 16 Mar 2020 12:46:45 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5785818095FF;
 Mon, 16 Mar 2020 12:46:45 +0000 (UTC)
Date: Mon, 16 Mar 2020 08:46:45 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?utf-8?Q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Message-ID: <1856958202.1343884.1584362805031.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200316123807.GG1528804@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200316123807.GG1528804@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
MIME-Version: 1.0
X-Originating-IP: [10.10.127.103, 10.4.195.30]
Thread-Topic: QEMU Gating CI
Thread-Index: kj07lMl0uXN/GvPl7TMsMSS1XnYfJw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Erik Skultety <eskultet@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> To: "Cleber Rosa" <crosa@redhat.com>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>, "Peter Maydell" <peter.m=
aydell@linaro.org>, qemu-devel@nongnu.org, "Fam
> Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>, "Eduardo Habko=
st" <ehabkost@redhat.com>, "Erik Skultety"
> <eskultet@redhat.com>, "Wainer Moschetta" <wmoschet@redhat.com>, "Wainer =
dos Santos Moschetta"
> <wainersm@redhat.com>, "Willian Rampazzo" <wrampazz@redhat.com>, "Philipp=
e Mathieu-Daud=C3=A9" <philmd@redhat.com>,
> "Beraldo Leal" <bleal@redhat.com>
> Sent: Monday, March 16, 2020 8:38:07 AM
> Subject: Re: [PATCH 0/5] QEMU Gating CI
>=20
> On Thu, Mar 12, 2020 at 03:36:11PM -0400, Cleber Rosa wrote:
> > The idea about a public facing Gating CI for QEMU was lastly
> > summarized in an RFC[1].  Since then, it was decided that a
> > simpler version should be attempted first.
> >=20
> > Changes from the RFC patches[2] accompanying the RFC document:
> >=20
> > - Moved gating job definitions to .gitlab-ci-gating.yml
> > - Added info on "--disable-libssh" build option requirement
> >   (https://bugs.launchpad.net/qemu/+bug/1838763) to Ubuntu 18.04 jobs
> > - Added info on "--disable-glusterfs" build option requirement
> >   (there's no static version of those libs in distro supplied
> >   packages) to one
> > - Dropped ubuntu-18.04.3-x86_64-notools job definition, because it
> >   doesn't fall into the general scope of gating job described by PMM
> >   (and it did not run any test)
> > - Added w32 and w64 cross builds based on Fedora 30
> > - Added a FreeBSD based job that builds all targets and runs `make
> >   check`
> > - Added "-j`nproc`" and "-j`sysctl -n hw.ncpu`" options to make as a
> >   simple but effective way of speeding up the builds and tests by
> >   using a number of make jobs matching the number of CPUs
> > - Because the Ansible playbooks reference the content on Dockerfiles,
> >   some fixes to some Dockerfiles caught in the process were included
> > - New patch with script to check or wait on a pipeline execution
> >=20
> > [1] - https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00231.ht=
ml
> > [2] - https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00154.ht=
ml
> >=20
> > Cleber Rosa (5):
> >   tests/docker: add CentOS 8 Dockerfile
> >   tests/docker: make "buildah bud" output similar to "docker build"
> >   GitLab CI: avoid calling before_scripts on unintended jobs
> >   GitLab Gating CI: introduce pipeline-status contrib script
> >   GitLab Gating CI: initial set of jobs, documentation and scripts
> >=20
> >  .gitlab-ci-gating.yml                         | 111 ++++++++++
> >  .gitlab-ci.yml                                |  32 ++-
> >  contrib/ci/orgs/qemu/build-environment.yml    | 208 ++++++++++++++++++
> >  contrib/ci/orgs/qemu/gitlab-runner.yml        |  65 ++++++
> >  contrib/ci/orgs/qemu/inventory                |   2 +
> >  contrib/ci/orgs/qemu/vars.yml                 |  13 ++
> >  contrib/ci/scripts/gitlab-pipeline-status     | 148 +++++++++++++
>=20
> FYI, the contrib/ directory is generally a place for arbitrary / adhoc
> but interesting user contributed files/sources that are not officially
> supported deliverables of the project.
>=20
> IOW, this is not a good home for the official CI scripts.
>=20

Good point, reason is that I wasn't/ain't sure this script is going
to be "official" and really that useful.  I'm happy to move it
somewhere else though.

> We already have a .gitlab-ci.d/ directory that looks like it would
> be good for this.  Or if that's not suitable, then scripts/ci/ is
> a second choice.
>=20

Ack.

Thanks!
- Cleber.

> >  docs/devel/testing.rst                        | 142 ++++++++++++
> >  tests/docker/dockerfiles/centos8.docker       |  32 +++
> >  .../dockerfiles/debian-win32-cross.docker     |   2 +-
> >  10 files changed, 751 insertions(+), 4 deletions(-)
> >  create mode 100644 .gitlab-ci-gating.yml
> >  create mode 100644 contrib/ci/orgs/qemu/build-environment.yml
> >  create mode 100644 contrib/ci/orgs/qemu/gitlab-runner.yml
> >  create mode 100644 contrib/ci/orgs/qemu/inventory
> >  create mode 100644 contrib/ci/orgs/qemu/vars.yml
> >  create mode 100755 contrib/ci/scripts/gitlab-pipeline-status
> >  create mode 100644 tests/docker/dockerfiles/centos8.docker
>=20
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge
> |:|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om
> |:|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge
> |:|
>=20


