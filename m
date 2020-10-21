Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC2C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E082075B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtpHHi5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E082075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV7tg-0005b6-6E
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 02:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kV7sT-000555-Oy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 02:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kV7sN-0003fo-1S
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 02:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603262732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0VKAOqrWDbrr3k+RwZq2lSANabLsU26erHXBVUt8jg=;
 b=EtpHHi5n1CpfIYaNa3FWtpRPhddr57Aq5kD61oRoHGCF9xyYLyiSmg7W15d9vzwC8kvBqh
 MUKvTVLC/Li/H/yhFZTTdlji2WUZb+C/jSZncLtmNoIJvpr6RpbiRXutm2DoMc74ZDDy8G
 S79q7fMklMRyfQeqNayYJH9DFTYSPQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-Hg8o4253M_SBdGD-UWqWlQ-1; Wed, 21 Oct 2020 02:45:29 -0400
X-MC-Unique: Hg8o4253M_SBdGD-UWqWlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC45787507C;
 Wed, 21 Oct 2020 06:45:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-165.ams2.redhat.com [10.36.112.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE6BD6EF44;
 Wed, 21 Oct 2020 06:45:19 +0000 (UTC)
Subject: Re: [PATCH v4 1/4] Jobs based on custom runners: documentation and
 configuration placeholder
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-2-crosa@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0cafdc10-b979-5a47-516b-24a51663ff6b@redhat.com>
Date: Wed, 21 Oct 2020 08:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019015003.1527746-2-crosa@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 03.50, Cleber Rosa wrote:
> As described in the included documentation, the "custom runner" jobs
> extend the GitLab CI jobs already in place.
> 
> Those jobs are intended to run on hardware and/or Operating Systems
> not provided by GitLab's shared runners.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/custom-runners.yml | 14 +++++++++
>  .gitlab-ci.yml                  |  1 +
>  docs/devel/ci.rst               | 54 +++++++++++++++++++++++++++++++++
>  docs/devel/index.rst            |  1 +
>  4 files changed, 70 insertions(+)
>  create mode 100644 .gitlab-ci.d/custom-runners.yml
>  create mode 100644 docs/devel/ci.rst
> 
> diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
> new file mode 100644
> index 0000000000..3004da2bda
> --- /dev/null
> +++ b/.gitlab-ci.d/custom-runners.yml
> @@ -0,0 +1,14 @@
> +# The CI jobs defined here require GitLab runners installed and
> +# registered on machines that match their operating system names,
> +# versions and architectures.  This is in contrast to the other CI
> +# jobs that are intended to run on GitLab's "shared" runners.
> +
> +# Different than the default approach on "shared" runners, based on
> +# containers, the custom runners have no such *requirement*, as those
> +# jobs should be capable of running on operating systems with no
> +# compatible container implementation, or no support from
> +# gitlab-runner.  To avoid problems that gitlab-runner can cause while
> +# reusing the GIT repository, let's enable the recursive submodule
> +# strategy.
> +variables:
> +  GIT_SUBMODULE_STRATEGY: recursive
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 8ffd415ca5..b33c433fd7 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -18,6 +18,7 @@ include:
>    - local: '/.gitlab-ci.d/opensbi.yml'
>    - local: '/.gitlab-ci.d/containers.yml'
>    - local: '/.gitlab-ci.d/crossbuilds.yml'
> +  - local: '/.gitlab-ci.d/custom-runners.yml'
>  
>  .native_build_job_template: &native_build_job_definition
>    stage: build
> diff --git a/docs/devel/ci.rst b/docs/devel/ci.rst
> new file mode 100644
> index 0000000000..41a4bbddad
> --- /dev/null
> +++ b/docs/devel/ci.rst
> @@ -0,0 +1,54 @@
> +==
> +CI
> +==
> +
> +QEMU has configurations enabled for a number of different CI services.
> +The most up to date information about them and their status can be
> +found at::
> +
> +   https://wiki.qemu.org/Testing/CI
> +
> +Jobs on Custom Runners
> +======================
> +
> +Besides the jobs run under the various CI systems listed before, there
> +are a number additional jobs that will run before an actual merge.
> +These use the same GitLab CI's service/framework already used for all
> +other GitLab based CI jobs, but rely on additional systems, not the
> +ones provided by GitLab as "shared runners".
> +
> +The architecture of GitLab's CI service allows different machines to
> +be set up with GitLab's "agent", called gitlab-runner, which will take
> +care of running jobs created by events such as a push to a branch.
> +Here, the combination of a machine, properly configured with GitLab's
> +gitlab-runner, is called a "custom runner" here.

Nit: Remove one of the two "here" in the above sentence.

> +The GitLab CI jobs definition for the custom runners are located under::
> +
> +  .gitlab-ci.d/custom-runners.yml
> +
> +Current Jobs
> +------------
> +
> +The current CI jobs based on custom runners have the primary goal of
> +catching and preventing regressions on a wider number of host systems
> +than the ones provided by GitLab's shared runners.
> +
> +Also, the mechanics of reliability, capacity and overall maintanance

s/maintanance/maintenance/

> +of the machines provided by the QEMU project itself for those jobs
> +will be evaluated.

I'm not sure what this sentence is really good for... of course new stuff
has to prove its usefulness first, but that's always the case and does not
need to be mentioned in the documentation, I think? ... maybe that sentence
is better something for the patch description instead of (hopefully)
long-lasting documentation here?

> +Future Plans and Jobs
> +---------------------
> +
> +Once the CI Jobs based on custom runners have been proved mature with
> +the initial set of jobs run on machines from the QEMU project, other
> +members in the community should be able provide their own machine
> +configuration documentation/scripts, and accompanying job definitions.
> +
> +As a general rule, those newly added contributed jobs should run as
> +"non-gating", until their reliability is verified.
> +
> +The precise minimum requirements and exact rules for machine
> +configuration documentation/scripts, and the success rate of jobs are
> +still to be defined.
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 77baae5c77..2fdd36e751 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -21,6 +21,7 @@ Contents:
>     atomics
>     stable-process
>     testing
> +   ci
>     qtest
>     decodetree
>     secure-coding-practices
> 

 Thomas


