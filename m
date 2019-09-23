Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF99C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E0620673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E0620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPrX-0006tP-Lq
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCPmn-0002tD-C8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCPml-00053S-HC
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:57:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCPml-00052r-9I
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:57:55 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 559D385536
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:57:54 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k9so6851548wmb.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iuQTdp3TwtC7k0GQknt2aeaofEuvtPqWcCjlrbrVe+M=;
 b=D07HgUM6MY1MFhTbYS8cD5REImXbqqzXk8iUGXI2TCdY4s5Y7hnvTIh5Um/uKgri+R
 Knp3mKRU7OUJXhu+cnk7NBy/7s5/CLZxXk6qID9y5RF80oVbACuVnJpX4QrUbcqdtSy6
 iZKMI3BMp5Sod70sDLm7sXceKJpYoSO58MJKRHmQ0/0S6WV3Og3WtkKjj89mzCkXJgM4
 ZwZk5oy/DUwiEMvvtz8rrzuvYHlFGNBFO75Y5IN5jWvYvva0wm7lAZONJqlzQwGcGCTA
 HB6GwqV380OhR5JKIzkd5M6VDC1mAMHYmBAt9kv3yywZI2eNFVF9zd0AZoqL89KzGnzd
 GqRQ==
X-Gm-Message-State: APjAAAWxPJi4GaDsyTngORNSuutceaIvxab8I2pJEraQet8afM5gg1gz
 BheRbQiQsW14hMx/jITl5ElFUddA1zOmMZMMym3Cs/DVT5vt9CzhvzOf0eQMHETnGPshESHoLjq
 rRMTXcpIhHbXRdVs=
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr22320904wrq.214.1569250672880; 
 Mon, 23 Sep 2019 07:57:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwdMSFBIbYEacK5mCqKpOdLY5cIiaep/1v1gM2DJ9eiq6c3UNYt7oe2kPriPURWn83VLCrppQ==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr22320893wrq.214.1569250672648; 
 Mon, 23 Sep 2019 07:57:52 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q22sm9485829wmj.5.2019.09.23.07.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 07:57:52 -0700 (PDT)
Subject: Re: [PATCH] docker: move tests from python2 to python3
To: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
References: <20190920200049.27216-1-jsnow@redhat.com>
 <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3f8e132a-26d1-e33c-04e0-72464e6b8500@redhat.com>
Date: Mon, 23 Sep 2019 16:57:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 4:50 PM, Cleber Rosa wrote:
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

John remove this image at the end of the series.
I suggested him to reorder and remove it before this patch.

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

