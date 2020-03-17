Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9646AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6603620724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDvoRnRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6603620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGDm-0002AE-Ht
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jEGCk-0001aC-Jz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jEGCi-00020a-RE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:40:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jEGCi-0001tw-Kt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584466835;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnBPtUaJCGGtJ4lKcPDEpfNhp0XHJPZwaqndPCQC69c=;
 b=jDvoRnRgJgBteHOdYCACM6EeS7lUMdvPX61jvQ9GiYD5xgQmlEtUl10YR177qbNClarO9/
 E/Vn93SpZNDs7Tsk4uACpcWGPxf+Wr3huWdWWCPJjjto41EuVO9WFulmIig4gFvO0OlZw9
 bLVOf/CiVoJejSaSQ568I/st9Vetjck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-9nSqv7ejO96r0NRUNK2kiA-1; Tue, 17 Mar 2020 13:40:32 -0400
X-MC-Unique: 9nSqv7ejO96r0NRUNK2kiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4070B8010C7;
 Tue, 17 Mar 2020 17:40:29 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F7EF10027A3;
 Tue, 17 Mar 2020 17:40:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 06/15] configure: Enable test and libs for zstd
In-Reply-To: <CAFEAcA86cH=XEg5aW8rg1vp9j3Ug=Gozk0m4hYZ-fiQ38J35aw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 17 Mar 2020 17:09:51 +0000")
References: <20200228092420.103757-1-quintela@redhat.com>
 <20200228092420.103757-7-quintela@redhat.com>
 <CAFEAcA86cH=XEg5aW8rg1vp9j3Ug=Gozk0m4hYZ-fiQ38J35aw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 17 Mar 2020 18:40:23 +0100
Message-ID: <8736a6lw1k.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 28 Feb 2020 at 09:28, Juan Quintela <quintela@redhat.com> wrote:
>>
>> Add it to several build systems to make testing good.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  .gitlab-ci.yml                                |  1 +
>>  .travis.yml                                   |  1 +
>>  configure                                     | 30 +++++++++++++++++++
>>  tests/docker/dockerfiles/centos7.docker       |  3 +-
>>  .../dockerfiles/fedora-i386-cross.docker      |  3 +-
>>  tests/docker/dockerfiles/fedora.docker        |  3 +-
>>  tests/docker/dockerfiles/ubuntu.docker        |  1 +
>>  tests/docker/dockerfiles/ubuntu1804.docker    |  1 +
>>  tests/vm/fedora                               |  5 +++-
>>  tests/vm/freebsd                              |  3 ++
>>  tests/vm/netbsd                               |  3 ++
>>  tests/vm/openbsd                              |  3 ++
>>  12 files changed, 53 insertions(+), 4 deletions(-)
>
> Hi; this patch changes some .docker files, but it has
> put the new line at the bottom of each package list,
> rather than at the correct point in the alphabetical
> order that the lists are in, for these 3 fedora/centos ones:

ok.

I mill send a patch for that.

Sorry, Juan.


>
>> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dock=
erfiles/centos7.docker
>> index 562d65be9e..cdd72de7eb 100644
>> --- a/tests/docker/dockerfiles/centos7.docker
>> +++ b/tests/docker/dockerfiles/centos7.docker
>> @@ -33,6 +33,7 @@ ENV PACKAGES \
>>      tar \
>>      vte-devel \
>>      xen-devel \
>> -    zlib-devel
>> +    zlib-devel \
>> +    libzstd-devel
>>  RUN yum install -y $PACKAGES
>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>> diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/d=
ocker/dockerfiles/fedora-i386-cross.docker
>> index 9106cf9ebe..cd16cd1bfa 100644
>> --- a/tests/docker/dockerfiles/fedora-i386-cross.docker
>> +++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
>> @@ -7,7 +7,8 @@ ENV PACKAGES \
>>      gnutls-devel.i686 \
>>      nettle-devel.i686 \
>>      pixman-devel.i686 \
>> -    zlib-devel.i686
>> +    zlib-devel.i686 \
>> +    libzstd-devel.i686
>>
>>  RUN dnf install -y $PACKAGES
>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docke=
rfiles/fedora.docker
>> index 987a3c170a..a6522228c0 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -92,7 +92,8 @@ ENV PACKAGES \
>>      vte291-devel \
>>      which \
>>      xen-devel \
>> -    zlib-devel
>> +    zlib-devel \
>> +    libzstd-devel
>>  ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
>>
>>  RUN dnf install -y $PACKAGES
>
> The ubuntu ones are OK though:
>
>> diff --git a/tests/docker/dockerfiles/ubuntu.docker
>> b/tests/docker/dockerfiles/ubuntu.docker
>> index 4177f33691..b6c7b41ddd 100644
>> --- a/tests/docker/dockerfiles/ubuntu.docker
>> +++ b/tests/docker/dockerfiles/ubuntu.docker
>> @@ -58,6 +58,7 @@ ENV PACKAGES flex bison \
>>      libvdeplug-dev \
>>      libvte-2.91-dev \
>>      libxen-dev \
>> +    libzstd-dev \
>>      make \
>>      python3-yaml \
>>      python3-sphinx \
>> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker
>> b/tests/docker/dockerfiles/ubuntu1804.docker
>> index 0766f94cf4..1efedeef99 100644
>> --- a/tests/docker/dockerfiles/ubuntu1804.docker
>> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
>> @@ -44,6 +44,7 @@ ENV PACKAGES flex bison \
>>      libvdeplug-dev \
>>      libvte-2.91-dev \
>>      libxen-dev \
>> +    libzstd-dev \
>>      make \
>>      python3-yaml \
>>      python3-sphinx \
>
>
> Could somebody send a patch that fixes up the ordering,
> please?
>
> thanks
> -- PMM


