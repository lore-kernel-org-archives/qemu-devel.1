Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B909C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA9B2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA9B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYY5v-0008Ip-R7
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:44:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYY4H-0007FQ-W5
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYY0d-0005u2-CA
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:39:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYY0Y-0005hu-9X
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:39:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so19974917wrm.8
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 08:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=W3KUJRvQLWBZz5OsKlhD8eGlR1Mj5g1achVcHTjSt1o=;
	b=bI4jA0rOpMs3i3CoUXuURp4Y0KVGEpMzww8jtpwmg1x0JmQy+AbZmoA0gF7bu3Uc+f
	IkjnJj641Yzc844qbkqAT9oXmbMQsekJ2zsdU+PFRMDh0u73qKsOVPhxNcCeGKP3fhs9
	g0DtHLYd7geLA8CiZWN+UxW3wimcYQZzdDE6tJY3b4SPiW1U474DYGUaiGdXgdeo32Z2
	38UQV4cbvxc0R+QzjMVdbdcTpDCtXMfZCE6waGbm+hPQsl6XdzM3N94Y+k5RBY37JS5V
	7SLR2pJjeUoHBVnilAm8b5WRhuC26yw4e8bUO9CkpMTg+iMvxR7JZhduvn45hgd9BMgg
	DGtw==
X-Gm-Message-State: APjAAAV6zfxdu1zW4pghkjDAlwJ23MqSQ2pu25GNAYC1k0doYYuEMaD0
	ns+HoTkSURCq1YuJAaXRe63LXw==
X-Google-Smtp-Source: APXvYqykVWg98lciFOv5olMOxDxNz1gATirL1eL7s4myZYwwmbNAia+V1wcOqgZmqyG/POCdJd9yRg==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr16684462wrw.349.1559749160335;
	Wed, 05 Jun 2019 08:39:20 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	s8sm36563248wra.55.2019.06.05.08.39.17
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 08:39:19 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
	<20190523234011.583-4-marcandre.lureau@redhat.com>
	<e0cf3112-62f6-aaff-0821-f472297dbb93@redhat.com>
	<CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
	<20190605151008.GE8956@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d565ab4b-c64b-b15b-e648-a40ad0a64135@redhat.com>
Date: Wed, 5 Jun 2019 17:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605151008.GE8956@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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

On 6/5/19 5:10 PM, Daniel P. Berrangé wrote:
> On Fri, May 24, 2019 at 01:17:17PM +0200, Marc-André Lureau wrote:
>> Hi
>>
>> On Fri, May 24, 2019 at 9:41 AM Philippe Mathieu-Daudé
>> <philmd@redhat.com> wrote:
>>>
>>> On 5/24/19 1:40 AM, Marc-André Lureau wrote:
>>>> Released last month.
>>>>
>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>  tests/docker/dockerfiles/fedora.docker | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>>>> index 69d4a7f5d7..1496b68ba1 100644
>>>> --- a/tests/docker/dockerfiles/fedora.docker
>>>> +++ b/tests/docker/dockerfiles/fedora.docker
>>>> @@ -1,4 +1,4 @@
>>>> -FROM fedora:29
>>>> +FROM fedora:30
>>>
>>> Hmm this patch is pending for review:
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00819.html
>>
>> Oh I missed that. Maybe we should use "latest" to avoid bumping the
>> version every 6 months.
>>
>> fwiw we have different versions:
>>
>> tests/docker/dockerfiles/fedora-cris-cross.docker:FROM fedora:latest
>> tests/docker/dockerfiles/fedora-i386-cross.docker:FROM fedora:29
>> tests/docker/dockerfiles/fedora.docker:FROM fedora:29
>>
>> In 62559b916 "tests: update Fedora i386 cross image to Fedora 29", Daniel said:
>>
>>     Using the "latest" tag is not a good idea because this changes what
>>     release it points to every 6 months. Together with caching of docker
>>     builds this can cause confusion where CI has cached & built with Fedora
>>     N, while a developer tries to reproduce a CI problem with Fedora N + 1,
>>     or vica-verca.
>>
>> But at the same time, Daniel bumped f28 to f29 in commit 19a9978db1.
>>
>> It's confusing, do we need some stability or follow the latest?
> 
> The problem is introduced by local caching. "latest" may point to "29"
> today, but the CI system had cached content meaining its use of "latest"
> still resolved to "28".
> 
> Using "29" meant both CI & developers saw the same image, even when
> caching is used.

Should we invert the default NOCACHE value?

See commits c1958e9d & 6fe3ae3f:

commit c1958e9d54c8de85ceda7c96b302b75a2f67b4e1
Author: Fam Zheng <famz@redhat.com>
Date:   Fri Nov 3 21:12:29 2017 +0800

    docker: Improved image checksum

    When a base image locally defined by QEMU, such as in the debian images,
    is updated, the dockerfile checksum mechanism in docker.py still skips
    updating the derived image, because it only looks at the literal content
    of the dockerfile, without considering changes to the base image.

    For example we have a recent fix e58c1f9b35e81 that fixed
    debian-win64-cross by updating its base image, debian8-mxe, but due to
    above "feature" of docker.py the image in question is automatically NOT
    rebuilt unless you add NOCACHE=1. It is noticed on Shippable:

    https://app.shippable.com/github/qemu/qemu/runs/541/2/console

    because after the fix is merged, the error still occurs, and the log
    shows the container image is, as explained above, not updated.

    This is because at the time docker.py was written, there wasn't any
    dependencies between QEMU's docker images.

    Now improve this to preprocess any "FROM qemu:*" directives in the
    dockerfiles while doing checksum, and inline the base image's dockerfile
    content, recursively. This ensures any changes on the depended _QEMU_
    images are taken into account.

    This means for external images that we expect to retrieve from docker
    registries, we still do it as before. It is not perfect, because
    registry images can get updated too. Technically we could substitute the
    image name with its hex ID as obtained with $(docker images $IMAGE
    --format="{{.Id}}"), but --format is not supported by RHEL 7, so leave
    it for now.

commit 6fe3ae3f194a675a3b73b6beab3ed5dd35db3be3
Author: Alex Bennée <alex.bennee@linaro.org>
Date:   Tue Jul 25 14:34:23 2017 +0100

    docker: docker.py make --no-cache skip checksum test

    If you invoke with NOCACHE=1 we pass --no-cache in the argv to
    docker.py but may still not force a rebuild if the dockerfile checksum
    hasn't changed. By testing for its presence we can force builds
    without having to manually remove the docker image.

