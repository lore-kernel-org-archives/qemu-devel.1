Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD3CC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 17:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF76F20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 17:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF76F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCS0x-0006Yw-Rw
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 13:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iCS05-00068s-3l
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 13:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iCS02-0008M8-C2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 13:19:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iCS02-0008LT-2w
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 13:19:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC68C300DA6E;
 Mon, 23 Sep 2019 17:19:44 +0000 (UTC)
Received: from [10.18.17.231] (dhcp-17-231.bos.redhat.com [10.18.17.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 042FA60C80;
 Mon, 23 Sep 2019 17:19:41 +0000 (UTC)
Subject: Re: [PATCH] docker: move tests from python2 to python3
To: Cleber Rosa <crosa@redhat.com>
References: <20190920200049.27216-1-jsnow@redhat.com>
 <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6ac39e69-4982-dc35-d853-fedbb1c12e1a@redhat.com>
Date: Mon, 23 Sep 2019 13:19:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 23 Sep 2019 17:19:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/23/19 10:50 AM, Cleber Rosa wrote:
> On Fri, Sep 20, 2019 at 04:00:49PM -0400, John Snow wrote:
>> As part of the push to drop python2 support, replace any explicit python2
>> dependencies with python3 versions.
>>
>> For centos, python2 still exists as an implicit dependency, but by adding
>> python3 we will be able to build even if the configure script begins to
>> require python 3.5+.
>>
>> Tested with centos7, fedora, ubuntu, ubuntu1804, and debian 9 (amd64).
>> Tested under a custom configure script that requires Python 3.5+.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/docker/dockerfiles/centos7.docker             | 2 +-
>>  tests/docker/dockerfiles/debian-ports.docker        | 2 +-
>>  tests/docker/dockerfiles/debian-sid.docker          | 2 +-
>>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 +-
>>  tests/docker/dockerfiles/debian10.docker            | 2 +-
>>  tests/docker/dockerfiles/debian8.docker             | 3 +--
>>  tests/docker/dockerfiles/debian9.docker             | 2 +-
>>  tests/docker/dockerfiles/ubuntu.docker              | 2 +-
>>  tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
>>  9 files changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
>> index e0b9d7dbe9..953637065c 100644
>> --- a/tests/docker/dockerfiles/centos7.docker
>> +++ b/tests/docker/dockerfiles/centos7.docker
>> @@ -25,6 +25,7 @@ ENV PACKAGES \
>>      nettle-devel \
>>      perl-Test-Harness \
>>      pixman-devel \
>> +    python3 \
> 
> Good, this gives us Python 3.6 (currently seeing package version
> 3.6.8-10.el7).
> 
>>      SDL-devel \
>>      spice-glib-devel \
>>      spice-server-devel \
>> @@ -34,4 +35,3 @@ ENV PACKAGES \
>>      zlib-devel
>>  RUN yum install -y $PACKAGES
>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>> -
>> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/dockerfiles/debian-ports.docker
>> index 61bc3f2993..f1ea8d3bd1 100644
>> --- a/tests/docker/dockerfiles/debian-ports.docker
>> +++ b/tests/docker/dockerfiles/debian-ports.docker
>> @@ -31,6 +31,6 @@ RUN apt-get update && \
>>          git \
>>          pkg-config \
>>          psmisc \
>> -        python \
>> +        python3 \
> 
> On my testing, Python 3.7.4-4 gets installed here at this time.
> 
> I wonder if this "unstable" distro can/will give us Python 3.8 in the
> near future and the consequences of that...  assuming that's a feature
> for now.
> 

I think it's effectively the point of using debian-sid, I'm not sure how
debian-ports differs.

I've encouraged Philippe to submit a testable target that uses the
debian-sid base so we can keep the partial image -- otherwise I want to
delete it as we can't build against it currently with the tools as they
exist in-tree.

>>          texinfo \
>>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
>> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
>> index 2a1bcc33b2..dcb8e83715 100644
>> --- a/tests/docker/dockerfiles/debian-sid.docker
>> +++ b/tests/docker/dockerfiles/debian-sid.docker
>> @@ -31,5 +31,5 @@ RUN apt update && \
>>          git \
>>          pkg-config \
>>          psmisc \
>> -        python \
>> +        python3 \
> 
> Python 3.7.4-2 gets installed here.
> 
>>          texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
>> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
>> index b9c2e2e531..e6f93f65ee 100644
>> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
>> @@ -18,7 +18,7 @@ RUN apt-get update && \
>>          flex \
>>          gettext \
>>          git \
>> -        python-minimal
>> +        python3-minimal
> 
> I'm getting Python 3.5.3-1+deb9u1 here, so it LGTM.
> 

Oh, that's actually a bit of a problem. I tested on 3.5+, but I think
some people want 3.6+.

I don't know much about Debian, but we either need to guarantee 3.6+ or
backtrack our plans to 3.5+.

>>  
>>  ENV CPU_LIST csp dc232b dc233c
>>  ENV TOOLCHAIN_RELEASE 2018.02
>> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
>> index 30a78813f2..dad498b52e 100644
>> --- a/tests/docker/dockerfiles/debian10.docker
>> +++ b/tests/docker/dockerfiles/debian10.docker
>> @@ -26,7 +26,7 @@ RUN apt update && \
>>          git \
>>          pkg-config \
>>          psmisc \
>> -        python \
>> +        python3 \
> 
> Python 3.7.3-2 gets installed here on my testing.
> 
>>          python3-sphinx \
>>          texinfo \
>>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
>> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
>> index 1212a85c35..be67023826 100644
>> --- a/tests/docker/dockerfiles/debian8.docker
>> +++ b/tests/docker/dockerfiles/debian8.docker
>> @@ -30,5 +30,4 @@ RUN apt update && \
>>          git \
>>          gnupg \
>>          pkg-config \
>> -        python-minimal
>> -
>> +        python3-minimal
> 
> This results in the Python package version 3.4.2-1+deb8u7 being
> installed, so it's *NOT* enough for the 3.5+ requirements.
> 
> I suppose it'd be time to retire those distros instead of updating
> them?
> 

Yup, we're dropping it, as you've seen in the other series.

>> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
>> index b36f1d4ed8..8cbd742bb5 100644
>> --- a/tests/docker/dockerfiles/debian9.docker
>> +++ b/tests/docker/dockerfiles/debian9.docker
>> @@ -26,7 +26,7 @@ RUN apt update && \
>>          git \
>>          pkg-config \
>>          psmisc \
>> -        python \
>> +        python3 \
> 
> Python 3.5.3-1+deb9u1 here, meeting the requirement.
> 

Tch, okay.

>>          python3-sphinx \
>>          texinfo \
>>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
>> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
>> index a4f601395c..f486492224 100644
>> --- a/tests/docker/dockerfiles/ubuntu.docker
>> +++ b/tests/docker/dockerfiles/ubuntu.docker
>> @@ -60,7 +60,7 @@ ENV PACKAGES flex bison \
>>      libvte-2.91-dev \
>>      libxen-dev \
>>      make \
>> -    python-yaml \
>> +    python3-yaml \
> 
> Python 3.7.3-2ubuntu0.1 gets installed here, meeting the requirement.
> 
>>      python3-sphinx \
>>      sparse \
>>      texinfo \
>> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
>> index 883f9bcf31..3cc4f492c4 100644
>> --- a/tests/docker/dockerfiles/ubuntu1804.docker
>> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
>> @@ -47,7 +47,7 @@ ENV PACKAGES flex bison \
>>      libvte-2.91-dev \
>>      libxen-dev \
>>      make \
>> -    python-yaml \
>> +    python3-yaml \
> 
> Not related to this patch, but the lack of an explicit python3 package
> line gets to me. :)
> 
> Anyway, this ends up pulling Python 3.6.7-1~18.04, so LGTM.
> 
>>      python3-sphinx \
>>      sparse \
>>      texinfo \
>> -- 
>> 2.21.0
>>
>>
> 
> The only issue I see here is what action to take with regards to
> debian8.docker.
> 
> - Cleber.
> 

Thanks for the review!

