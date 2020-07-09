Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741D4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F60F206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vkz388VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F60F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTqL-00059E-Fg
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtTpG-00046S-S4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:30:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22445
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtTpD-0008Px-NZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290643;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I35Pwx7CbfuzSwzuLDUS5USxCDWOYJ7+Z44uPLx4BGA=;
 b=Vkz388VRsR+ERpllPt5D5K6C7CXRcSVEBCYd/8nFsYZQBZnPh3Z/spERPtr+g+sNEtcMQG
 p8hqXhLAIqjJeFH/a1GVk9guQKPFl+7RdBi8T92iQy5MwSKfhp8CBE57bwj2N6PuUIRj4S
 rB4hcTICHSIQLwNAseRqqJyF0w6XxHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-kOLTMEAUPbKleJ2hnjEeLw-1; Thu, 09 Jul 2020 06:30:39 -0400
X-MC-Unique: kOLTMEAUPbKleJ2hnjEeLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8890F1081;
 Thu,  9 Jul 2020 10:30:38 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F97010013C2;
 Thu,  9 Jul 2020 10:30:32 +0000 (UTC)
Date: Thu, 9 Jul 2020 11:30:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200709103029.GK3753300@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709024657.2500558-3-crosa@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
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

AFAIK, the jobs in this file just augment what is already defined
in the main .gitlab-ci.yml. Also since we're providing setup info
for other people to configure custom runners, these jobs are usable
for non-gating CI scenarios too.

IOW, the jobs in this file happen to be usable for gating, but they
are not the only gating jobs, and can be used for non-gating reasons.

This is a complicated way of saying that gating.yml is not a desirable
filename, so I'd suggest splitting it in two and having these files
named based on what their contents is, rather than their use case:

   .gitlab-ci.d/runners-s390x.yml
   .gitlab-ci.d/runners-aarch64.yml

The existing jobs in .gitlab-ci.yml could possibly be moved into
a .gitlab-ci.d/runners-shared.yml file for consistency.

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

I think I'd make it more flexible in particular to allow multiple
branches. For example I have multiple subsystems and have separate
branches for each.

This could be as simple as allowing a regex prefix

  - if: '$CI_COMMIT_REF_NAME =~ /^staging/'




> diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
> new file mode 100644
> index 0000000000..89b35386c7
> --- /dev/null
> +++ b/scripts/ci/setup/build-environment.yml
> @@ -0,0 +1,217 @@
> +---
> +- name: Installation of basic packages to build QEMU
> +  hosts: all
> +  vars_files:
> +    - vars.yml
> +  tasks:
> +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> +      apt:
> +        update_cache: yes
> +        # This matches the packages on tests/docker/Dockerfiles/ubuntu1804.docker

I'd be inclined to actually use docker on the custom runners.

eg. instead of having separate physical machines or VMs for each
(distro, arch) pair, have a single host distro for the arch. Then
use docker to provide the build environment against each distro.

IOW, a RHEL-8 aarch64 host, running docker for ubuntu18.04, fedora30
etc.

That way we don't end up duplicating all these packages, and instead
can use  tests/docker/Dockerfiles/ubuntu1804.docker.  This ensures
that if a user needs to reproduce a build failure on their own local
aarch64 machine, they can run docker and get the exact same build
architecture.

It also has the benefit that we don't need to worry about how to
setup gitlab runners for every distro we care about. We only need to
do gitlab runner for the standard host distro, which spawns a pristine
throwaway docker env.

I appreciate this is a big change from what you've done in this patch
though, so don't consider this comment a blocker for initial merge.
I think we should do this as the long term strategy though. Essentially
for Linux builds, everything should always be container based.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


