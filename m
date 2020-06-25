Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4FF20775
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUbzUzmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4FF20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUMn-0002eV-46
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1joUGA-0001Bg-7o
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:57:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1joUG7-0005nf-IH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593100669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yHZYru1HRN3hSsXroTWy8Yr+dsJ9Xb5/fy92Lg0Uo4=;
 b=DUbzUzmfjr6MKQq3NPIHIZzr2JuWaBJXFH//mx0TZBh447L74/0SBwu8I319GC+9CPdU6t
 PqmlPkFgNqJC03W1wSRR5mgS7Ap8TdzplAVipe27JWr1/bJhWnmC4j9Ap3Ho36afVxayGA
 LUy1v1ikgR+fDQ1EmGIjAr8ocbkDKKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-3Uf8hHlOO2aTc8B9ST51ug-1; Thu, 25 Jun 2020 11:57:45 -0400
X-MC-Unique: 3Uf8hHlOO2aTc8B9ST51ug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADD89800C60;
 Thu, 25 Jun 2020 15:57:44 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-16.ams2.redhat.com
 [10.36.115.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81F0A1001B07;
 Thu, 25 Jun 2020 15:57:40 +0000 (UTC)
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
 <b9da6d29-0615-d96d-5fb7-ba4dc2d5f3d8@redhat.com>
 <20200625095041.GD1009994@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ad2d15bc-81ed-c7e3-092b-77dfd2da62ef@redhat.com>
Date: Thu, 25 Jun 2020 17:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200625095041.GD1009994@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/25/20 11:50, Daniel P. Berrangé wrote:
> On Thu, Jun 25, 2020 at 11:35:54AM +0200, Thomas Huth wrote:
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
>>>   .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
>>>   .gitlab-ci.yml              |   3 +
>>>   2 files changed, 251 insertions(+)
>>>   create mode 100644 .gitlab-ci.d/containers.yml
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
>>
>> I can see this in the output:
>>
>> WARNING! Using --password via the CLI is insecure. Use --password-stdin.
>>
>> I have to admit that I have only little knowledge about docker ... but could
>> there be an issue here? Should this be done in a different way?
> 
> In general the warning is correct, because other users on the same
> host can see the process CLI args, and thus the password is susceptible
> to snooping.
> 
> In this case, however, it is a non-issue. This is running inside a docker
> container already which has a PID namespace. Thus the only things that
> can see our password on the CLI are things inside our own container
> which already all have the env variable, and processes running in host
> OS context which are only things GitLab admins control. So there's no
> data leakage to anyone who doesn't already have access to the password
> 
> This particular docker login command is the documented solution:
> 
>   https://docs.gitlab.com/ee/ci/docker/using_docker_build.html

(

Purely theoretically, we could use a "here string":

docker [...] --password-stdin <<< "$CI_REGISTRY_PASSWORD"

The password is then not exposed on any process's command line; it's a
(bash) shell redirection. (It's not in POSIX.)

)

Thanks
Laszlo


