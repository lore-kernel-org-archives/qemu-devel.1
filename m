Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B187BC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 08:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6EB20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 08:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMhvOYy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6EB20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwih5-0000M9-N7
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 03:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwiaw-0007jm-Ts
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 03:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwiat-0002k8-MW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 03:21:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwiat-0002at-Ft
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 03:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580286062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuSwD6YBnWzdUgeZ6HPHqgMevZkQbJax0wFKRL6Zcaw=;
 b=BMhvOYy+LNO+jsIvHwUDers05es01p2jnTix0dIItSwP0vcnwOZHij1tn6M0Eo+cT8EjUe
 E2yDQH5EsgoqLrjT0XLAQW2PPI9KULcsSJ05PLawhbZPOkvY7wzTGZxYqDk1BJ7t5aqta/
 1az+hd1h3tct3zdL818axCLCdLW79so=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-J7vffYPYNG6xn1qe-BtQvg-1; Wed, 29 Jan 2020 03:20:57 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so9733482wrw.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 00:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4a1a1Ti0csN3h6WR4sxshVL5b/XKqg1dCzE3pBWPkJA=;
 b=R3DaGkNu8XWdtJhro3FRsDSyd6VfUm1Kkq4jThKEO+A2B9/p3jj9mR+7zBHg8xR8iz
 OfOwaEeq7NIO5HzH0gh3t1hmgSByM+TTwp4GX0T5zD07n1SIVQ/57xETBBlW2+CwaPzP
 gD3JLjC7jlRCy1Zi7bU4Qh9t9HwWPN3LPI5UyWDaXEG3i60xBsFgmVaE8g+9dIWbQAAv
 PCct+ftb3RT1t8z9sY1LgGK9/WciTEFu00vdkN2DdWCGUu13kcvOBXEhGeMtjMfOw5z5
 xXScnHAquaVG9jFGk8Fqco+RG9ux+QNZpvcFqZ8oMKTD/kFoidODyuY+F/VR4PYlNmW2
 oI+Q==
X-Gm-Message-State: APjAAAXRY18XiFo3ryUaNSra0hVbvY6zSPfBgLacqdTcTkuLpDUpl6tj
 v25a4g1UbFrWBwn6+ZlBCIycwplq/E0Z5561l7FJMv8AZXqxnevoVqz7zKcVDK6pjhUah4VG519
 9Pn/RORHO5geVrDQ=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr9619052wmh.164.1580286055918; 
 Wed, 29 Jan 2020 00:20:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhYzBQbKTJKnPM6gPA5E1Q7cFAM/jtms09ykgaiH6c0pY6McHOCEFwQoeldgTOqqBNqfbqLQ==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr9619022wmh.164.1580286055600; 
 Wed, 29 Jan 2020 00:20:55 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id g2sm1821888wrw.76.2020.01.29.00.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 00:20:54 -0800 (PST)
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com> <874kwfg2qh.fsf@linaro.org>
 <CAP+75-U0XZe31+QSv7t3oDwmy9fPxgQ7U165w=HU0UN_h2Jc5Q@mail.gmail.com>
 <266be40c-6f5c-ad76-d326-bb174ebf047f@redhat.com>
 <411567d3-2a32-eaf8-7689-3649aad4267c@redhat.com>
 <6b298da8-8694-35ba-7822-d8de86487674@redhat.com>
 <a621498f-c9aa-5cd0-671f-f4e07c95aaa7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <93e3d049-4f02-92e6-9f7f-8f1a883a8ad0@redhat.com>
Date: Wed, 29 Jan 2020 09:20:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a621498f-c9aa-5cd0-671f-f4e07c95aaa7@redhat.com>
Content-Language: en-US
X-MC-Unique: J7vffYPYNG6xn1qe-BtQvg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 8:34 AM, Thomas Huth wrote:
> On 29/01/2020 08.27, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/29/20 8:20 AM, Thomas Huth wrote:
>>> On 28/01/2020 14.33, Wainer dos Santos Moschetta wrote:
>>>>
>>>> On 1/28/20 11:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On Tue, Jan 28, 2020 at 1:55 PM Alex Benn=C3=A9e <alex.bennee@linaro.=
org>
>>>>> wrote:
>>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>>> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>> The NAME variable can be used to describe nicely a job (see [*]).
>>>>>>>> As we currently have 32 jobs, use it. This helps for quickly
>>>>>>>> finding a particular job.
>>>>>>>>
>>>>>>>>  =C2=A0=C2=A0=C2=A0 before: https://travis-ci.org/qemu/qemu/builds=
/639887646
>>>>>>>>  =C2=A0=C2=A0=C2=A0 after: https://travis-ci.org/philmd/qemu/build=
s/641795043
>>>>>>> Very good idea, correlating a job in the GUI to an entry in the yml
>>>>>>> file
>>>>>>> was really a pain, so far.
>>>>>>>
>>>>>>>> [*]
>>>>>>>> https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs=
-within-matrices
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>>>>> ---
>>>>>>>>  =C2=A0=C2=A0 .travis.yml | 101
>>>>>>>> ++++++++++++++++++++++++++++++++++------------------
>>>>>>>>  =C2=A0=C2=A0 1 file changed, 67 insertions(+), 34 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>>>>> index 6c1038a0f1..d68e35a2c5 100644
>>>>>>>> --- a/.travis.yml
>>>>>>>> +++ b/.travis.yml
>>>>>>>> @@ -94,24 +94,28 @@ after_script:
>>>>>>>>
>>>>>>>>  =C2=A0=C2=A0 matrix:
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 include:
>>>>>>>> -=C2=A0=C2=A0=C2=A0 - env:
>>>>>>>> +=C2=A0=C2=A0=C2=A0 - name: "[x86] GCC static (user)"
>>>>>>> Could you please drop the [x86] and other architectures from the
>>>>>>> names?
>>>>>>> Travis already lists the build architecture in the job status
>>>>>>> page, so
>>>>>>> this information is redundant.
>>>>>> Hmm for me the Travis page mis-renders the architecture (on
>>>>>> firefox) so
>>>>>> I do find the arch in the text fairly handy.
>>>>> This might be a font problem, I can't see the architecture on neither
>>>>> Firefox nor Chrome:
>>>>>
>>>>> https://pasteboard.co/IS3O358.png
>>>>
>>>>
>>>> It is the partially hidden column between the job number and the pengu=
in
>>>> (or apple if MacOS).
>>>>
>>>> Funny, I can see the arch on Philippe's dashboard
>>>> (https://travis-ci.org/philmd/qemu) but it disappears on my own
>>>> (https://travis-ci.org/wainersm/qemu).
>>>
>>> I've never had problems here, for me the column shows up correctly
>>> everywhere. It looks like this:
>>>
>>>  =C2=A0 http://people.redhat.com/~thuth/travis.png
>>
>> OK now I understand better your comment :)
>>
>>>
>>>> Anyway, most of the jobs run on x86_64. So perhaps mark only the non-x=
86
>>>> ones?
>>>
>>> Sounds like a good compromise to me!
>>
>> I'd rather use one style, rather ARCH explicit on all, or not used at al=
l.
>=20
> Then I'd vote to drop it (if I've got a vote here at all ;-)), hoping
> that Travis fixes their HTML for that column, soon...

Fine.

I opened issue https://github.com/travis-ci/travis-ci/issues/10503 which=20
got closed, then I got lost in their forum. I'll simply hope instead.


