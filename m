Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6643FC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4181C20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36791 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVe63-00032Q-1N
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 11:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVe4z-0002jE-Ms
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVe4y-0007T9-HH
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:31:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVe4y-0007RM-AW
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:31:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id h1so6591146wro.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 08:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5fK69IQ3n21KzCsanDIlwzCWkeml1LRvlCq8wtL3tg0=;
	b=hVE18L6ai9Ew4afAhZm/p/3Dg5XoLV/6AKWCjO0NcV0bLRyqsS7B2gpguANCzsexoU
	uN8ksyiL7a8o7TBd7qB6Q+wDUlOrmPKZM267qJM4oohdLLTQ3q/td8mnyauxRMvt3Gdm
	6wZAGYpxYe5+RoEyo57KgHsSYToA9YvG5GEJj6elJZ9jWYFQbaVAPbo9PvxxDq2k9usC
	638aG02QNEBpaTvhplB3J7cB+nJYLPMoQLl1Tv+T/uPpWxgRQiSl7clFpvaHwzJ03lAB
	s2BXz8xUNt/J5yQ0/nHRmnbzILPHFISakjmm8omxD2XDVZBJu+XXQR30GttmXFa6WxcZ
	B2cg==
X-Gm-Message-State: APjAAAVGVLgyRVeju08lMtxwUF6k6XdH6aizaZ9WMyK/hk0qsL2Vboby
	zDOStMKVYvGmB6tWvubCyWxALg==
X-Google-Smtp-Source: APXvYqyrfsPBU81K31ZDyRKRhiTOCWrVHqbgU00n+kpKUYBKHYo5AQolwaXC5jgCfcTaoHcbm9TFUw==
X-Received: by 2002:adf:ec04:: with SMTP id x4mr684523wrn.342.1559057515077;
	Tue, 28 May 2019 08:31:55 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	k63sm3290114wmf.35.2019.05.28.08.31.54
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 08:31:54 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
	<20190523234011.583-4-marcandre.lureau@redhat.com>
	<e0cf3112-62f6-aaff-0821-f472297dbb93@redhat.com>
	<CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d37d58ef-ef3a-5294-779d-6cef0153f0e4@redhat.com>
Date: Tue, 28 May 2019 17:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 3/4] docker: update fedora to f30
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 1:17 PM, Marc-André Lureau wrote:
> Hi
> 
> On Fri, May 24, 2019 at 9:41 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> On 5/24/19 1:40 AM, Marc-André Lureau wrote:
>>> Released last month.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  tests/docker/dockerfiles/fedora.docker | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>>> index 69d4a7f5d7..1496b68ba1 100644
>>> --- a/tests/docker/dockerfiles/fedora.docker
>>> +++ b/tests/docker/dockerfiles/fedora.docker
>>> @@ -1,4 +1,4 @@
>>> -FROM fedora:29
>>> +FROM fedora:30
>>
>> Hmm this patch is pending for review:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00819.html
> 
> Oh I missed that. Maybe we should use "latest" to avoid bumping the
> version every 6 months.
> 
> fwiw we have different versions:
> 
> tests/docker/dockerfiles/fedora-cris-cross.docker:FROM fedora:latest
> tests/docker/dockerfiles/fedora-i386-cross.docker:FROM fedora:29
> tests/docker/dockerfiles/fedora.docker:FROM fedora:29
> 
> In 62559b916 "tests: update Fedora i386 cross image to Fedora 29", Daniel said:
> 
>     Using the "latest" tag is not a good idea because this changes what
>     release it points to every 6 months. Together with caching of docker
>     builds this can cause confusion where CI has cached & built with Fedora
>     N, while a developer tries to reproduce a CI problem with Fedora N + 1,
>     or vica-verca.
> 
> But at the same time, Daniel bumped f28 to f29 in commit 19a9978db1.
> 
> It's confusing, do we need some stability or follow the latest?

Tracking a stable release helps to handle new compiler warnings when
bisecting.

See also:

commit 5b9b49d7bd3e0da13e8f6d58578443a11817f56e
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Jan 12 12:11:43 2018 +0100

    docker: change Fedora base image to fedora:27

    Using "fedora:latest" makes behavior different depending on when you
    actually pulled the image from the docker repository.  In my case,
    the supposedly "latest" image was a Fedora 25 download from 8 months
    ago, and the new "test-debug" test was failing.

    Use "27" to improve reproducibility and make it clear when the image
    is obsolete.

Why we don't add a new file when a new version get released?
See: https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03868.html

