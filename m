Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FABC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE4C2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE4C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFz0i-0002z3-7x
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:38:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFyyg-0001ce-3R
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFyyf-00064Z-2W
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hFyye-00064C-Qm
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so19728083wmk.4
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 03:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ifqdwrAThYfGn8IUoYywJOyZXzG7ITczfE0kygCkwTA=;
	b=Z9ZiklBSsU3PD/DJthzJ0KJFhVac8sFWwnMgfAwcFYFzujKEqkPrI2ULwhUMJ3gGJI
	dOAcQYrKoyJb0sYRqD6zBERUvGShtPlYBD+azEA72+4APtQTk+oUS+z6/5K9pNVfxvMt
	H7Tg2sE+go8Vk5eKUoFhwr4Di/s+7QOpu1SXZcAcMXZcUSw58ZnWlVZwQom78XYx37ja
	haQf64YCOOXvMKmYNEhxDxh0CUplQusjsN/wGNQmmn5WY0bW7t5WhmZTKvzkNbnuKEbi
	SNKXfMkrDlJIn2Shua0YkwZDXcGnn50WXWQuFDs13FXybJ53F7oVliuM/qLQMRUqO9iy
	gXkw==
X-Gm-Message-State: APjAAAW6rnDrIc9iSgYhsv8CkzeqpimsFQGxqggwR9jI7SMCSVkTuKGB
	hDNOGLxCNZgyCUsa+DqV5IIQlaeuyns=
X-Google-Smtp-Source: APXvYqwGCAIC5bmCeGpWJMCwcD9wrR7rrdRXDNL2OzOMJ8CrieZm5T/yCnWGUNJwjugNi0s0hF1osQ==
X-Received: by 2002:a1c:b782:: with SMTP id h124mr21878939wmf.5.1555324599787; 
	Mon, 15 Apr 2019 03:36:39 -0700 (PDT)
Received: from [10.115.78.87] ([46.31.59.59]) by smtp.gmail.com with ESMTPSA id
	h2sm69810287wro.11.2019.04.15.03.36.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 03:36:39 -0700 (PDT)
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
	<29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
	<CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
	<4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5665d408-512e-2ad4-aa4e-481287fc39e7@redhat.com>
Date: Mon, 15 Apr 2019 12:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
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
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415103636.MMd5bG-UT33XXe247wgToAGK32pMDc8LwVoMqqaxBm4@z>

On 4/14/19 11:24 PM, Hervé Poussineau wrote:
> Le 14/04/2019 à 20:53, Artyom Tarasenko a écrit :
>> On Sun, Apr 14, 2019 at 7:01 PM Hervé Poussineau
>> <hpoussin@reactos.org> wrote:
>>>
>>> Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
>>>> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
>>>>
>>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>>> ---
>>>>    hw/isa/i82378.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>>>> index a5d67bc..546c928 100644
>>>> --- a/hw/isa/i82378.c
>>>> +++ b/hw/isa/i82378.c
>>>> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error
>>>> **errp)
>>>>        isa = isa_create_simple(isabus, "i82374");
>>>>
>>>>        /* timer */
>>>> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
>>>> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
>>>> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
>>>> +    qdev_init_nofail(DEVICE(isa));
>>>
>>> I am not sure the base_year should be hardcoded in i82378. I can
>>> assume other machines with a i82378 can have another base_year.
>>
>> I doubt it to be honest. How would it work in the hardware? Is there a
>> pin which would switch a year?
>> I do believe the different i823xx may have the different base years
>> though.

There is no RTC on the i82378, this should be moved to the board code
and set the date there. Do you want me to send this patch?

Regards,

Phil.

