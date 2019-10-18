Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D952E21D80
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D952E21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMqZ-0004TM-SD
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLMpT-0003ho-4n
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLMpQ-0005hz-Hs
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLMpQ-0005he-9R
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:37:40 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D98896FAC7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:37:38 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k2so2183755wrn.7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 00:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zsJd4msP7SaBaAFREn6mkmJ3plHwLUOcVv3JLvkWe7o=;
 b=R5zHQH64K8cjrYUqTo+RpJSv+/kxzQcZ05dWutKtr7cImyV4KCxglmjzVWoiZhCNNE
 l6wi/9ivKnZWuiWhlICdwIh1sywokyfM9nQhm2bmJPt6p7Aong7TDRHuIqvsF4UKkTwL
 EcuKtdB3E7XMOMsnmiSMZk90ZuSmGa5D1Xyevx1rM3LIj0puGfYA9M1jjJr06oUD95VQ
 zqdCZeqxx3CyiCQ+OUimz9rl78lFTXU8O9FJsjKMBT63vMeT3mTwHOclfFNfX2e2kjHW
 L7deZ9dwVu92kMQx7pK8taFr2VOLQiZcLyyzpxOPe0+Bi7RpXzZiZ4oSGmBayZZrVr1v
 Xolg==
X-Gm-Message-State: APjAAAWGI8thQwjNdjRI4J6IMenuuYNOW5OgNNZttJirzC359geG3EBp
 U/tsGfvDDOxSRvSEXXAmctbmUzbVgGu86iodkJ8IZK3xTE3EfBw1p+D2kRurnkF0/acXMABmyI3
 HdC/1n0DF5mr+jUo=
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr6060944wmc.11.1571384257343; 
 Fri, 18 Oct 2019 00:37:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7wt52dYM9IO+FF8oJysYUDRZ55YfMIeMZhWOHabXbYh+kABRAhQhnJCLR/6RfpzNN3XcPCQ==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr6060930wmc.11.1571384257093; 
 Fri, 18 Oct 2019 00:37:37 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id o4sm7278656wre.91.2019.10.18.00.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 00:37:36 -0700 (PDT)
Subject: Re: [PATCH] hw/s390x: Emit a warning if user tried to enable USB
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20191017142123.1236-1-thuth@redhat.com>
 <20191017163402.43437191.cohuck@redhat.com>
 <2e689f2b-9bed-e40e-c761-6f38efaae635@redhat.com>
 <181d44b3-3333-91a3-0003-d312e8ab4805@redhat.com>
 <620c3bfe-2163-6bb4-cdc9-689dcd74dcac@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <10b2dcc2-adea-6ffb-009b-ee23d3041ecc@redhat.com>
Date: Fri, 18 Oct 2019 09:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <620c3bfe-2163-6bb4-cdc9-689dcd74dcac@redhat.com>
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 8:35 AM, Thomas Huth wrote:
> On 17/10/2019 20.18, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/17/19 4:40 PM, Thomas Huth wrote:
>>> On 17/10/2019 16.34, Cornelia Huck wrote:
>>>> On Thu, 17 Oct 2019 16:21:23 +0200
>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>>> There is no USB on s390x, so running qemu-system-s390x with
>>>>> "-machine ...,usb=3Don" is certainly wrong. Emit a warning to make
>>>>> the users aware of their misconfiguration.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  =C2=A0 After a year or two, we could finally turn this into a hard=
 error,
>>>>>  =C2=A0 but I think we should give the users some time to fix their=
 command
>>>>>  =C2=A0 lines first, so I'm initially only emitting a warning here.
>>>>>
>>>>>  =C2=A0 hw/s390x/s390-virtio-ccw.c | 4 ++++
>>>>>  =C2=A0 1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.=
c
>>>>> index d3edeef0ad..af8c4c0daf 100644
>>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>>> @@ -243,6 +243,10 @@ static void ccw_init(MachineState *machine)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtualCssBus *css_bus;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 if (machine->usb) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("This machi=
ne does not support USB");
>>>>
>>>> I'm wondering if this is the only machine type not supporting usb...
>>>> if not, how are others handling it?
>>>
>>> I think most machines are silently ignoring it, like we did on s390x
>>> until now, too.
>>>
>>>> The usb parsing code in machine.c does not care if usb is even
>>>> configured (CONFIG_USB).
>>>
>>> machine.c is common code, so you can not use CONFIG_USB there.
>>
>> We already have:
>>
>> bool target_words_bigendian(void)
>> {
>> #if defined(TARGET_WORDS_BIGENDIAN)
>>  =C2=A0=C2=A0=C2=A0 return true;
>> #else
>>  =C2=A0=C2=A0=C2=A0 return false;
>> #endif
>> }
>=20
> ... and kvm_available() and xen_available() ...
>=20
>> diff --git a/hw/usb/machine.c b/hw/usb/machine.c
>> new file mode 100644
>> index 0000000000..5381928479
>> --- /dev/null
>> +++ b/hw/usb/machine.c
>> @@ -0,0 +1,12 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/boards.h"
>> +#include "config-devices.h"
>> +
>> +bool machine_has_usb(void)
>> +{
>> +#if defined(CONFIG_USB)
>> +=C2=A0=C2=A0=C2=A0 return true;
>> +#else
>> +=C2=A0=C2=A0=C2=A0 return false;
>> +#endif
>> +}
>=20
> I think I'd rather call it usb_available() (like the other _available()
> functions) and put it into arch_init.c (and rename that file to arch.c
> or target.c or something like that).

Yes, clever names :)

