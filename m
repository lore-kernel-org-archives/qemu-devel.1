Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C95C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161B72067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161B72067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXuL-0005ws-3H
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIWyo-0007Lj-Pc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIWyn-0002WM-13
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:51:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIWym-0002Vx-PT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:51:36 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6943981F11
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:51:35 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m6so1678517wmf.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gVOtKl9J7olP42CQP9x0iok46JyvCU/v0eXCza95U/c=;
 b=Ew45hewee7zUTu47i4DQ4wBk4lvhgjNcSbbeFcPzuN09nc3ududqT2A9+QLFGJ0Mig
 PmzW8iC6hukwi+5bB019f5bNaS6JnPWkhLH6mqLDszyWs9iTuKM2JsY/qcttm3zlI0gz
 6mqP58I157Z57nMMRXaNWmcTYrknqxlyn8gUUVwugd+neF/98OLkWZdBtMA3LettOEDs
 y9qOg0w6pa6IjBAg8qSwouEbZOAphUI/QbfDnc+G+14+4M8EiKI1rR9fp+uGRxmmxahh
 VNR89/YiLNL/04Trw3MNkJNZ7N65zwi2VPspvHO4Bo2upg4Omojny1jT+EIn9ls7gm+j
 5SDQ==
X-Gm-Message-State: APjAAAXK2mVgSphLGrUp3xQqUL8dKaQRjmJ5x/IqY1OpnJcDwouby8Au
 F2K8zWpOvNlCgGF2dWO2HH7OY9uliQYcYxtYnX1TWdMewHvFRJpGKUPl1wY4VVUnIyS/Kab6/xk
 Tc60Bl0jiI7Ef/Mw=
X-Received: by 2002:a5d:624f:: with SMTP id m15mr7536233wrv.59.1570708294211; 
 Thu, 10 Oct 2019 04:51:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUGFteuB1vZhvTyVNV2sZI654mAUmg6lHX+XWIy7ESeDmAjC/MQw6mQ6Fcprz2D9DorAdMuA==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr7536216wrv.59.1570708294009; 
 Thu, 10 Oct 2019 04:51:34 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id l11sm6809727wmh.34.2019.10.10.04.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:51:33 -0700 (PDT)
Subject: Re: [PATCH 4/5] travis.yml: Fix the ccache lines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-5-thuth@redhat.com>
 <910285f7-d470-cf0b-85b2-a2264cf23ea3@redhat.com>
 <1ab2f569-a256-9627-0725-e54f52ce8c81@redhat.com>
 <815ae506-7dec-52c4-0401-d48fb884b3e0@redhat.com>
 <753cf697-d360-ed37-6834-443596672a72@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bcf56ed9-f182-3036-b61c-4f4b3029c0f6@redhat.com>
Date: Thu, 10 Oct 2019 13:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <753cf697-d360-ed37-6834-443596672a72@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 1:29 PM, Thomas Huth wrote:
> On 10/10/2019 13.16, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/10/19 11:38 AM, Thomas Huth wrote:
>>> On 09/10/2019 21.04, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 10/9/19 7:07 PM, Thomas Huth wrote:
>>>>> The "command -v ccache && ccache ..." likely were supposed to test
>>>>> the availability of ccache before running the program. But this
>>>>> shell construct causes Travis to abort if ccache is not available.
>>>>
>>>> Oops.
>>>>
>>>> Why can't you install ccache if these are Ubuntu systems?
>>>> It is even more wanted if the arm64 machine are slow...
>>>
>>> I just tried to add "ccache" to the list of packages that should be
>>> installed, but I don't see a difference in the runtime.
>>>
>>> First run with ccache enabled:
>>>
>>>  =C2=A0 https://travis-ci.com/huth/qemu/jobs/244117945
>>>
>>> Second run where I'd expect a speedup:
>>>
>>>  =C2=A0 https://travis-ci.com/huth/qemu/jobs/244124599
>>>
>>> The statistics at the end say that it had only 1 cache hit. Any ideas
>>> what might be wrong here?
>>
>> Looking there and your following commit
>> (https://github.com/huth/qemu/commit/eaf80e7851) I see you already
>> figured this out :)
>=20
> No, that was just a try, but it did not change anything:
>=20
>   https://travis-ci.com/huth/qemu/jobs/244137697#L5813

Oh I checked the x86 build then...

https://travis-ci.com/huth/qemu/jobs/244137696#L11299

> But I also noticed that in the arm64 builds, the cache information is
> missing:
>=20
>   https://travis-ci.com/huth/qemu/jobs/244137697#L1844
>=20
> ... so I assume that ccache support needs to be supported in the image
> that is provided by Travis, and you can not simply install it
> afterwards. So this is likely just a quirk that hopefully will be fixed
> by Travis later (arm64 is still marked as "alpha" there if I've got tha=
t
> right).

Ah, you might be correct.

If so, your job is now ready to use the feature once they enable it :)

