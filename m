Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF7720702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT6kwN4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF7720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRu6-0000uK-In
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joRt7-0007dl-4n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:25:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joRt5-0003wa-8j
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593091554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJpXSiesTW9zTVHXNgyA52eO8xwUgZy+MH4RQUpIT5k=;
 b=XT6kwN4YrPGuiDKbRKboJ8Q/DQ0/HfW1Zrij7XQ/rP4dyQULU+nNs1drfKHDYxQi24QG7p
 eSExkNoqtRh3qmz6E10Nq+wKaqLWtWjxwLlL9tnQ2qKdJjf6TwEqd38RKVl55i8Ygg/+8h
 rOZTuEn2p/v455+5qgllTVfhyp3MCDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-hcGb9vWoN8GhIPClYubiUg-1; Thu, 25 Jun 2020 09:25:50 -0400
X-MC-Unique: hcGb9vWoN8GhIPClYubiUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550B01009458;
 Thu, 25 Jun 2020 13:25:33 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF41FC14C5;
 Thu, 25 Jun 2020 13:25:21 +0000 (UTC)
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
 <745e1e86-3042-7b7c-89c7-81eb9a8f7905@redhat.com>
 <20200625102457.GG1009994@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <acfb1a3a-e18d-dc4e-e28a-35201bafad86@redhat.com>
Date: Thu, 25 Jun 2020 15:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200625102457.GG1009994@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/2020 12.24, Daniel P. Berrangé wrote:
> On Thu, Jun 25, 2020 at 12:14:33PM +0200, Thomas Huth wrote:
>> On 22/06/2020 17.33, Daniel P. Berrangé wrote:
>>> We have a number of container images in tests/docker/dockerfiles
>>> that are intended to provide well defined environments for doing
>>> test builds. We want our CI system to use these containers too.
>>>
>>> This introduces builds of all of them as the first stage in the
>>> CI, so that the built containers are available for later build
>>> jobs. The containers are setup to use the GitLab container
>>> registry as the cache, so we only pay the penalty of the full
>>> build when the dockerfiles change. The main qemu-project/qemu
>>> repo is used as a second cache, so that users forking QEMU will
>>> see a fast turnaround time on their CI jobs.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
>>>    .gitlab-ci.yml              |   3 +
>>>    2 files changed, 251 insertions(+)
>>>    create mode 100644 .gitlab-ci.d/containers.yml
>>>
>>> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
>>> new file mode 100644
>>> index 0000000000..ea1edbb196
>>> --- /dev/null
>>> +++ b/.gitlab-ci.d/containers.yml
>>> @@ -0,0 +1,248 @@
>>> +
>>> +
>>> +.container_job_template: &container_job_definition
>>> +  image: docker:stable
>>> +  stage: containers
>>> +  services:
>>> +    - docker:dind
>>> +  before_script:
>>> +    - export TAG="$CI_REGISTRY_IMAGE/ci-$NAME:latest"
>>> +    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/ci-$NAME:latest"
>>> +    - docker info
>>> +    - docker login registry.gitlab.com -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
>>> +  script:
>>> +    - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
>>> +    - sed -i -e "s,FROM qemu:,FROM $CI_REGISTRY_IMAGE/ci-," tests/docker/dockerfiles/$NAME.docker
>>> +    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
>>> +    - docker push "$TAG"
>>> +  after_script:
>>> +    - docker logout
>>
>> .gitlab-ci.d/edk2.yml uses a "changes" rule to only run the pipeline if
>> something really has been changed. Could you use something similar here?
>> E.g.:
>>
>> rules:
>>   - changes:
>>     - .gitlab-ci.d/containers.yml
>>     - tests/docker/*
>>     - tests/docker/dockerfiles/*
>>
>> ?
> 
> If the OS distro base image changes, we'll never pick it up with that
> kind of filtering.  For the main gitlab.com/qemu-project/qemu  you
> could configure a nightly/weekly/whatever job to force rebuild on a
> periodic basis to pick up base image changes.  The downside of this
> is that any users who fork qemu won't have that periodic job and so
> will be testing their work against potentially outdated content.
> 
> Having said all that, I'm not 100% convinced I'm actually picking
> up changed base images right now anyway, given our use of caching.
> 
> It is possible that I would need todo an explict "docker pull" of
> the base image to force it to trigger a refresh othrewise I have
> a feeling we're always cached.

But currently, each of the container stages currently takes > 2 minutes, 
even with the cached containers. I had a quick look, and it takes 7 
minutes 'till the "build" stage begins. So all the advantages of not 
having to do "yum/apt-get install" in the build containers anymore seem 
to be crushed by the time that the three container stages take now?

  Thomas


