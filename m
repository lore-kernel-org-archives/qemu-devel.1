Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5866C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9732067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSREflzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9732067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSNa-00017Q-MG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1jtSMc-0000Ec-TJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:57:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1jtSMY-00046j-Cg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594285021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omc8HnRCdjr/8CsoWpfSoADz5w9mvWzEfy8ZyLYS5ss=;
 b=jSREflzwYUY0LIABpJ/lCENUV95h3OUSKGknfwmjeQ+tpDZvtDT87GXuQrz3L8Kc9FVT+E
 r2VshSYWiO5Yc5C6y2mvv+R0KRroPVMblD3DH6IS6uSmC8rPKJvH0kakB0vkrjMDMxXeKS
 90vfowcuPgdvB374RtodYRallERvU3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-t88pXWBRMuOYYUxkw3DkJA-1; Thu, 09 Jul 2020 04:55:13 -0400
X-MC-Unique: t88pXWBRMuOYYUxkw3DkJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A58388C79A;
 Thu,  9 Jul 2020 08:55:12 +0000 (UTC)
Received: from nautilus.usersys.redhat.com (unknown [10.40.193.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E79457F8B7;
 Thu,  9 Jul 2020 08:55:09 +0000 (UTC)
Date: Thu, 9 Jul 2020 10:55:07 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200709085507.GA536480@nautilus.usersys.redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709024657.2500558-3-crosa@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eskultet@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eskultet@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> This is a mapping of Peter's "remake-merge-builds" and
> "pull-buildtest" scripts, gone through some updates, adding some build
> option and removing others.
>
> The jobs currently cover the machines that the QEMU project owns, and that
> are setup and ready to run jobs:
>
>  - Ubuntu 18.04 on S390x
>  - Ubuntu 20.04 on aarch64
>
> During the development of this set of jobs, the GitLab CI was tested
> with many other architectures, including ppc64, s390x and aarch64,
> along with the other OSs (not included here):
>
>  - Fedora 30
>  - FreeBSD 12.1
>
> More information can be found in the documentation itself.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
>  .gitlab-ci.yml                         |   1 +
>  docs/devel/testing.rst                 | 147 +++++++++++++++++
>  scripts/ci/setup/build-environment.yml | 217 +++++++++++++++++++++++++
>  scripts/ci/setup/gitlab-runner.yml     |  72 ++++++++
>  scripts/ci/setup/inventory             |   2 +
>  scripts/ci/setup/vars.yml              |  13 ++
>  7 files changed, 598 insertions(+)
>  create mode 100644 .gitlab-ci.d/gating.yml
>  create mode 100644 scripts/ci/setup/build-environment.yml
>  create mode 100644 scripts/ci/setup/gitlab-runner.yml
>  create mode 100644 scripts/ci/setup/inventory
>  create mode 100644 scripts/ci/setup/vars.yml
>
> diff --git a/.gitlab-ci.d/gating.yml b/.gitlab-ci.d/gating.yml
> new file mode 100644
> index 0000000000..5562df5708
> --- /dev/null
> +++ b/.gitlab-ci.d/gating.yml
> @@ -0,0 +1,146 @@
> +variables:
> +  GIT_SUBMODULE_STRATEGY: recursive
> +
> +# All ubuntu-18.04 jobs should run successfully in an environment
> +# setup by the scripts/ci/setup/build-environment.yml task
> +# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
> +ubuntu-18.04-s390x-all-linux-static:
> + tags:
> + - ubuntu_18.04
> + - s390x
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+bug/1838763
> + # --disable-glusterfs is needed because there's no static version of those libs in distro supplied packages
> + - ./configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
> + - make --output-sync -j`nproc`
> + - make --output-sync -j`nproc` check V=1
> + - make --output-sync -j`nproc` check-tcg V=1

I know this patch doesn't introduce a FreeBSD job, but later in the patch it's
clear you'd want to introduce them at some point, so:
'nproc' doesn't exist on FreeBSD, but `getconf _NPROCESSORS_ONLN` does, so you
may want to use it right from the start.

...

> +
> +CI
> +==
> +
> +QEMU has configurations enabled for a number of different CI services.
> +The most update information about them and their status can be found

s/update/up to date/

> +at::
> +
> +   https://wiki.qemu.org/Testing/CI
> +
> +Gating CI
> +----------
> +
> +A Pull Requests will only to be merged if they successfully go through

s/A /
s/to be/be/

> +a different set of CI jobs.  GitLab's CI is the service/framework used

s/a different set/different sets/       (I may be wrong with this one)

...

> +
> +gitlab-runner setup and registration
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The gitlab-runner agent needs to be installed on each machine that
> +will run jobs.  The association between a machine and a GitLab project
> +happens with a registration token.  To find the registration token for
> +your repository/project, navigate on GitLab's web UI to:
> +
> + * Settings (the gears like icon), then
> + * CI/CD, then
> + * Runners, and click on the "Expand" button, then
> + * Under "Set up a specific Runner manually", look for the value under
> +   "Use the following registration token during setup"
> +
> +Edit the ``scripts/ci/setup/vars.yml`` file, setting the
> +``gitlab_runner_registration_token`` variable to the value obtained
> +earlier.
> +
> +.. note:: gitlab-runner is not available from the standard location
> +          for all OS and architectures combinations.  For some systems,
> +          a custom build may be necessary.  Some builds are avaiable
> +          at https://cleber.fedorapeople.org/gitlab-runner/ and this
> +          URI may be used as a value on ``vars.yml``
> +
> +To run the playbook, execute::
> +
> +  cd scripts/ci/setup
> +  ansible-playbook -i inventory gitlab-runner.yml
> +
> +.. note:: there are currently limitations to gitlab-runner itself when
> +          setting up a service under FreeBSD systems.  You will need to
> +          perform steps 4 to 10 manually, as described at
> +          https://docs.gitlab.com/runner/install/freebsd.html

What kinds of limitations? Is it architecture constrained maybe? I'm asking
because we have all of the steps covered by an Ansible playbook, so I kinda got
triggered by the word "manually". Also, the document only mentions 9 steps
overall.

Regards,
Erik


