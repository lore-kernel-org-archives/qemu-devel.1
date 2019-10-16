Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD8FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D5820854
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D5820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmVq-0003Qj-BC
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKmNC-00041S-7F
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKmN9-00067y-9D
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKmN8-00067W-Vq
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:03 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5ED281DF1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 16:42:01 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r21so1210133wme.5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rn/NawSjrmNE4yneEf16tatrqHBeU4j8bvVjf+OJcAc=;
 b=DWsTh4ZvcBFxAVKoSu6HwivxzmN/HCJoJf7yFir8AM2JCXlR+9oo5ojb4HCy1Rw2Ej
 P2kMXCga7bMkWdRQRXKGAEcMXcBjH+RvIOpyUxQYCwsgar1JrFdm+6L4LJvNas1YQ3f3
 1x6XmTyWr8Beul7M8X0LqlpzG8y+ymTntEh77JAKsAfakuR2ZzI70P5lR8s4vEccm2KV
 VhvOqLaMDKHgINImEqQyeUxB4Z0MoDbuXD1X3ByO3zWsLiBDUqrlujJwh78uq1o+uKcU
 o1Rm7ZDPUooC+NBAUwARXvbt9AQ/WxaIH6N0bi7NiMyn8ulCIyB1bLqIj5dIkG8cPQlH
 8JBw==
X-Gm-Message-State: APjAAAWyJwytg6inS0uE0ifvO3j6KeqbsohoZEbUc089HWULbgdg67rA
 duT/BN9B0sLgxqSsrr7ucXOlS3NcZOKxuoNqKE3iHEUTwDGGGrJrQY8XB5tFm7cG24f2C27Mr7u
 7mI2ZuiMO1O5ufPU=
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr4002792wmj.161.1571244120549; 
 Wed, 16 Oct 2019 09:42:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCkzYTievdOg4Tjg87+BhQ8KZzL757a999AGE7QfSfPumSh1l3/ziAYZsN/q4mUNFDwMkXAQ==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr4002767wmj.161.1571244120294; 
 Wed, 16 Oct 2019 09:42:00 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id v11sm2990320wml.30.2019.10.16.09.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 09:41:59 -0700 (PDT)
Subject: Re: [SeaBIOS] Re: [PATCH v7 7/8] bootdevice: FW_CFG interface for
 LCHS values
To: Sam Eiderman <sameid@google.com>, John Snow <jsnow@redhat.com>
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
 <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
 <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
 <CAFr6bUnsxhqBqHgRdw3dtv0rEvfCVn0oM4XD8Vb1xv_UGKvepg@mail.gmail.com>
 <CAFr6bUm53A+gBVBRr00XKDkt=GiJ5QSOEEXPFfuUJ2PcLeG04w@mail.gmail.com>
 <bf6ff260-f8ca-a593-dd3e-e78fa0551101@redhat.com>
 <eb3cc776-b8d9-f8da-269a-2fc0f8c21662@redhat.com>
 <CAFr6bUkQZP7ks4odRBpKGOSrzwe2VWSD47JGBUx-DuwBVNOmiA@mail.gmail.com>
 <5a5f7f62-bc3c-f260-933f-2605d3c67b36@redhat.com>
 <CAFr6bUmKr4_9Jn=6rGAF162pNMMsnUFSQ6OHuBKNaW59sEzPJQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <597b8df4-f55a-2685-6798-53fbacc6ba2a@redhat.com>
Date: Wed, 16 Oct 2019 18:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFr6bUmKr4_9Jn=6rGAF162pNMMsnUFSQ6OHuBKNaW59sEzPJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, kraxel@redhat.com,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 5:19 PM, Sam Eiderman wrote:
> Sure!
> 
> Philippe withdrew his R-b on 7/8, as I explained 7/8 is fine (only
> need to remove a bad comment) the problem was in the tests 8/8 -
> should I include the original R/b?

I withdrew it because John was preparing his pull request, and I needed 
more time to review this again. But then Laszlo was quicker and figured 
out the problem is in the other patch, so please keep my original R-b.

Thanks to all 3 of you :)

> I guess all other 1-6 are fine to add R/b...
> 
> On Wed, Oct 16, 2019 at 6:07 PM John Snow <jsnow@redhat.com> wrote:
>>
>>
>>
>> On 10/16/19 10:55 AM, Sam Eiderman wrote:
>>> Thanks for the detailed comment Laszlo,
>>>
>>> Indeed my e-mail has changed and I only received replies to the
>>> commits where I added this new mail in the S-o-b section, should of
>>> added in all of them.
>>>
>>> So as you said it, the problem was actually in using qfw_cfg_get_u32
>>> which assumes the value is encoded LE and has an additional
>>> le32_to_cpu, should have used qfw_cfg_get directly like
>>> qfw_cfg_get_file does.
>>>
>>> Regarding qfw_cfg_get_file - I wrote this code when this function did
>>> not exist yet, I think it was added 6 months ago. In any case, I will
>>> use it instead.
>>>
>>> Thanks for this.
>>>
>>> I will resubmit this entire commit series:
>>> * I will only change code in the last commit (tests)
>>> * I will remove a comment which is now not true anymore
>>> * I will add my new email in S-o-b
>>>
>>> Sam
>>>
>>
>> Philippe gave me a verbal tut-tut for not including his review tags in
>> my last pull request; when you re-spin could you be so kind as to
>> include any that still apply?
>>
>> --js

