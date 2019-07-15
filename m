Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E175C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAF2206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAF2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn4hY-00049N-3U
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 13:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn4hG-0003AN-Hl
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn4hF-0007MR-CR
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:23:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hn4hF-0007M3-5l
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:23:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so17988044wrr.4
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 10:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HlX1nMNKAimFNMM8/+DERRCYxmb3wwDsucgdxSGKQ4g=;
 b=ohQkIoBqc7ziP96nKhOrt2CwzGoTFViOpwjBFH4LxbNM8aCS9Pa/E5hl0bUjldBwVE
 bSmc41r3JNSuOdGxbNsA5ir02n2earRfUM3CU1Op+p/kjpToFn9on77aDvzXB+oFPsZZ
 3hv2vo8ux32RR/bQ24bK/GxuGrcccx9FXLHeZRfwGcSYJtFW1nH7pYluThNL6mM+o68w
 zBUo64797OPOESDRLDBUVyvDH3zlCFLYqG+TRub0aOBHZmD6qgudb5TXNHly3bEvngs2
 iujky6o2Df7n8Fog/ZHmNnA7W7VORgl/9N1TbUwd0Ftp8CTYj68hBDyTY+gzwAxXmhwn
 vWqw==
X-Gm-Message-State: APjAAAWC4eD7QQDa4ar1Gr1j85H5d8/GVb1KnPb23YGSeTc44euaz3R7
 N/goVpm9R0JGLKgCZMdTKzU0wQ==
X-Google-Smtp-Source: APXvYqwVu/R001oDzRvRDWcDSCw2bwbBgCxFZZ0I6A1SMwOd8NFvDncdTXzjpe7Y45d7PWCImuEz5w==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr30322837wrw.169.1563211408188; 
 Mon, 15 Jul 2019 10:23:28 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id d10sm11753944wrx.34.2019.07.15.10.23.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 10:23:27 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190713163558.13204-1-philmd@redhat.com>
 <20190713163558.13204-2-philmd@redhat.com> <87lfwzv0iw.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <160560a4-a5bd-1d0d-f580-19f47c3c4d3e@redhat.com>
Date: Mon, 15 Jul 2019 19:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87lfwzv0iw.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/3] tests/docker: Install Sphinx in the
 Debian images
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
Cc: Fam Zheng <fam@euphon.net>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/19 4:24 PM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Since commit 5f71eac06e the Sphinx tool is required
>> to build the rST documentation.
>>
>> This fixes:
>>
>>  $ ./configure --enable-docs
>>
>>  ERROR: User requested feature docs
>>         configure was not able to find it.
>>         Install texinfo, Perl/perl-podlators and python-sphinx
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/docker/dockerfiles/debian-sid.docker          | 1 +
>>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 3 ++-
> 
> These two are probably overkill - sid and xtensa are used for building
> test cases.

Fair.

> 
>>  tests/docker/dockerfiles/debian10.docker            | 1 +
> 
> Again used as a base for docker-cross targets - it can't build QEMU on
> it's own but I guess makes sense to include it here.

Yeah, we might use it as base image later.

> 
>>  tests/docker/dockerfiles/debian9-mxe.docker         | 1 +
> 
> debian9-mxe is derived from  qemu:debian9 so

No idea why I missed that :)

> 
>>  tests/docker/dockerfiles/debian9.docker             | 1 +
> 
> We only really need this one.
> 
>>  5 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
>> index 676941cb32..9d65c15916 100644
>> --- a/tests/docker/dockerfiles/debian-sid.docker
>> +++ b/tests/docker/dockerfiles/debian-sid.docker
>> @@ -38,4 +38,5 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>          pkg-config \
>>          psmisc \
>>          python \
>> +        python3-sphinx \
>>          texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
>> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
>> index afd2ab9163..3022940e64 100644
>> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
>> @@ -18,7 +18,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>          flex \
>>          gettext \
>>          git \
>> -        python-minimal
>> +        python-minimal \
>> +        python3-sphinx
>>
>>  ENV CPU_LIST csp dc232b dc233c
>>  ENV TOOLCHAIN_RELEASE 2018.02
>> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
>> index aeeb151b52..cf57d8218f 100644
>> --- a/tests/docker/dockerfiles/debian10.docker
>> +++ b/tests/docker/dockerfiles/debian10.docker
>> @@ -27,5 +27,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>          pkg-config \
>>          psmisc \
>>          python \
>> +        python3-sphinx \
>>          texinfo \
>>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
>> diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
>> index 5bc8a6d5c3..497c198731 100644
>> --- a/tests/docker/dockerfiles/debian9-mxe.docker
>> +++ b/tests/docker/dockerfiles/debian9-mxe.docker
>> @@ -17,6 +17,7 @@ RUN apt-get update
>>  RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>      apt-get install -y --no-install-recommends \
>>          libpython2.7-stdlib \
>> +        python3-sphinx \
>>          $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
>>
>>  ENV PATH $PATH:/usr/lib/mxe/usr/bin/
>> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
>> index 5f23a35404..52c589a7d6 100644
>> --- a/tests/docker/dockerfiles/debian9.docker
>> +++ b/tests/docker/dockerfiles/debian9.docker
>> @@ -27,5 +27,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>          pkg-config \
>>          psmisc \
>>          python \
>> +        python3-sphinx \
>>          texinfo \
>>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
> 
> 
> --
> Alex Bennée
> 

