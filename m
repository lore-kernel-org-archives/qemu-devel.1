Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B423C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0165320575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQLWfo49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0165320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqWR-0002MW-K1
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jDp0p-0001KH-Mi
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jDp0n-0006oC-8c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:38:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jDp0n-0006Zt-38
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362307;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWvomnxaUXY+4089nhzBiG0Xxg7JaSqP2Yu8nO1j6zw=;
 b=VQLWfo49OW+gWvTmtN2mBxVJEq6bfhbIQO93it2w4upOSCrB6PzKapmhcG+dqrUFljaa/D
 vXZEMGCyaMA2cIDjx7zy4XPIQcekhiz5e98wOYfoUgqOsbsYluAjCpUhymWkjGAr6E2jfJ
 zMYVmHl8ZxSgCAjTZvHcqXpu+Sd3ZtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-vVM6EV70PS20qbNWbXejww-1; Mon, 16 Mar 2020 08:38:18 -0400
X-MC-Unique: vVM6EV70PS20qbNWbXejww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E30AE13F8;
 Mon, 16 Mar 2020 12:38:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0EF291D7D;
 Mon, 16 Mar 2020 12:38:10 +0000 (UTC)
Date: Mon, 16 Mar 2020 12:38:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200316123807.GG1528804@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200312193616.438922-1-crosa@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
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

On Thu, Mar 12, 2020 at 03:36:11PM -0400, Cleber Rosa wrote:
> The idea about a public facing Gating CI for QEMU was lastly
> summarized in an RFC[1].  Since then, it was decided that a
> simpler version should be attempted first.
>=20
> Changes from the RFC patches[2] accompanying the RFC document:
>=20
> - Moved gating job definitions to .gitlab-ci-gating.yml
> - Added info on "--disable-libssh" build option requirement
>   (https://bugs.launchpad.net/qemu/+bug/1838763) to Ubuntu 18.04 jobs
> - Added info on "--disable-glusterfs" build option requirement
>   (there's no static version of those libs in distro supplied
>   packages) to one
> - Dropped ubuntu-18.04.3-x86_64-notools job definition, because it
>   doesn't fall into the general scope of gating job described by PMM
>   (and it did not run any test)
> - Added w32 and w64 cross builds based on Fedora 30
> - Added a FreeBSD based job that builds all targets and runs `make
>   check`
> - Added "-j`nproc`" and "-j`sysctl -n hw.ncpu`" options to make as a
>   simple but effective way of speeding up the builds and tests by
>   using a number of make jobs matching the number of CPUs
> - Because the Ansible playbooks reference the content on Dockerfiles,
>   some fixes to some Dockerfiles caught in the process were included
> - New patch with script to check or wait on a pipeline execution
>=20
> [1] - https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00231.html
> [2] - https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00154.html
>=20
> Cleber Rosa (5):
>   tests/docker: add CentOS 8 Dockerfile
>   tests/docker: make "buildah bud" output similar to "docker build"
>   GitLab CI: avoid calling before_scripts on unintended jobs
>   GitLab Gating CI: introduce pipeline-status contrib script
>   GitLab Gating CI: initial set of jobs, documentation and scripts
>=20
>  .gitlab-ci-gating.yml                         | 111 ++++++++++
>  .gitlab-ci.yml                                |  32 ++-
>  contrib/ci/orgs/qemu/build-environment.yml    | 208 ++++++++++++++++++
>  contrib/ci/orgs/qemu/gitlab-runner.yml        |  65 ++++++
>  contrib/ci/orgs/qemu/inventory                |   2 +
>  contrib/ci/orgs/qemu/vars.yml                 |  13 ++
>  contrib/ci/scripts/gitlab-pipeline-status     | 148 +++++++++++++

FYI, the contrib/ directory is generally a place for arbitrary / adhoc
but interesting user contributed files/sources that are not officially
supported deliverables of the project.

IOW, this is not a good home for the official CI scripts.

We already have a .gitlab-ci.d/ directory that looks like it would
be good for this.  Or if that's not suitable, then scripts/ci/ is
a second choice.

>  docs/devel/testing.rst                        | 142 ++++++++++++
>  tests/docker/dockerfiles/centos8.docker       |  32 +++
>  .../dockerfiles/debian-win32-cross.docker     |   2 +-
>  10 files changed, 751 insertions(+), 4 deletions(-)
>  create mode 100644 .gitlab-ci-gating.yml
>  create mode 100644 contrib/ci/orgs/qemu/build-environment.yml
>  create mode 100644 contrib/ci/orgs/qemu/gitlab-runner.yml
>  create mode 100644 contrib/ci/orgs/qemu/inventory
>  create mode 100644 contrib/ci/orgs/qemu/vars.yml
>  create mode 100755 contrib/ci/scripts/gitlab-pipeline-status
>  create mode 100644 tests/docker/dockerfiles/centos8.docker

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


