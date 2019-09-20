Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA76BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF99207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF99207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKHl-0000Ci-A8
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBK4Q-0004cB-24
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBK4H-00080N-5M
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBK4G-0007zI-S2
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:39:29 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 599E44E8AC
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 14:39:27 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z205so1312900wmb.7
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KgT/0xNiHgslGSKiR4P2gJwTgfH4vL4peLE4zubl4yU=;
 b=gYYu7wJ+/emKB0INicB+pJRdqS+5v6EpivWCbPqf8pmk/A/Kr3+UhQgN3WWMIMUvZ2
 cbgMZfPVwmCq7PswuE8F8LzcV9h+IwbYyy/liB5BZC6Hwm4IMvSuRTEMHMUS242l8wBt
 NwtF88bST4rHH0t+JQw2maVZoPUa+D4udmKpKmWI2emuglPa8MvqEMITdQmp7GgRjy9G
 UB38m6VhCdbO1XpwW8EGysZNxqHBusctf6RyeWa8e3rhXwZ/lQgq3AY2Te2iQuoBXt7k
 zBRO1jmL1+3KccfuKJbSnQWMUlEM+1PlVbYwtjJiHeLNsyVvLhW+NeDHrD2lBbHLruZF
 Gbgg==
X-Gm-Message-State: APjAAAW6TGEXh0Mo48GshTm/lx8Ef8ZeuNjBEQ5T7NW2NX/3BSqQqLyW
 CzdvHKZjl23UvmomUC5WG/XA6rkwZcdfjigT0AModwWpD+3K/EOzC9di3dBLEXBOQs37IigZkwG
 JGYmD7sNxb/GsBN8=
X-Received: by 2002:adf:cc8a:: with SMTP id p10mr4578905wrj.321.1568990366135; 
 Fri, 20 Sep 2019 07:39:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwHUsUBJwNrDiW0lH5ijzw9AgxVabyvNhKo6Qxm3DdcoGgyGrNxaWnGqCr7gLyt89nQdQDIg==
X-Received: by 2002:adf:cc8a:: with SMTP id p10mr4578892wrj.321.1568990365927; 
 Fri, 20 Sep 2019 07:39:25 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id 189sm3485614wma.6.2019.09.20.07.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 07:39:25 -0700 (PDT)
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190920141248.12887-1-philmd@redhat.com>
 <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
 <f817b9a4-272e-c4c0-a4c4-5b5ebd7fd917@redhat.com>
 <CAFEAcA9KAc4viUy1X6f=f9Xm=_+H_JDJh1+USOHyPG76v5f_jw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a4c4f869-710d-930d-54f3-d43882cbb869@redhat.com>
Date: Fri, 20 Sep 2019 16:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KAc4viUy1X6f=f9Xm=_+H_JDJh1+USOHyPG76v5f_jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 4:35 PM, Peter Maydell wrote:
> On Fri, 20 Sep 2019 at 15:29, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> On 9/20/19 4:19 PM, Peter Maydell wrote:
>>> On Fri, 20 Sep 2019 at 15:12, Philippe Mathieu-Daud=C3=A9 <philmd@red=
hat.com> wrote:
>>>>
>>>> Now that the unassigned_access CPU hooks have been removed,
>>>> the unassigned_mem_read/write functions are only used for
>>>> debugging purpose.
>>>> Simplify by converting them to in-place trace events.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>> Based-on: <20190920125008.13604-1-peter.maydell@linaro.org>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04668.html
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03705.html
>>>>
>>>> I first wrote:
>>>>
>>>>   These functions are declared using the CPUReadMemoryFunc/
>>>>   CPUWriteMemoryFunc prototypes. Since it is confusing to
>>>>   have such prototype only use for debugging, convert them
>>>>   to in-place trace events.
>>>>
>>>> But it doesn't provide helpful information and is rather confusing.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> @@ -1437,7 +1418,8 @@ MemTxResult memory_region_dispatch_read(Memory=
Region *mr,
>>>>      MemTxResult r;
>>>>
>>>>      if (!memory_region_access_valid(mr, addr, size, false, attrs)) =
{
>>>> -        *pval =3D unassigned_mem_read(mr, addr, size);
>>>> +        trace_memory_region_invalid_read(size, addr);
>>>> +        *pval =3D 0; /* FIXME now this value shouldn't be accessed =
in guest */
>>>
>>> This FIXME comment is not entirely correct.
>>>
>>> Unassigned memory will RAZ/WI and the 0 will be seen by:
>>>  * guest CPUs which don't implement a do_transaction_failed hook
>>>    (or which have a hook that doesn't always raise an exception)
>>
>> OK, I thought targets always had to implement do_transaction_failed.
>=20
> No, and in fact most don't (only 8 out of 21 architectures have the hoo=
k).
> In some cases that might be that nobody's got around to it; in other
> cases if the RAZ/WI default and no guest CPU exception is what you want=
,
> there's no real need to write a hook function.

OK!

>>>> diff --git a/trace-events b/trace-events
>>>> index 823a4ae64e..83dbeb4b46 100644
>>>> --- a/trace-events
>>>> +++ b/trace-events
>>>> @@ -62,6 +62,8 @@ memory_region_tb_read(int cpu_index, uint64_t addr=
, uint64_t value, unsigned siz
>>>>  memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value=
, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>>>>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t add=
r, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x=
%"PRIx64" size %u"
>>>>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t ad=
dr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0=
x%"PRIx64" size %u"
>>>> +memory_region_invalid_read(unsigned size, uint64_t addr) "invalid r=
ead size %u addr 0x%"PRIx64
>>>> +memory_region_invalid_write(unsigned size, uint64_t addr, int fmt_w=
idth, uint64_t value) "invalid write size %u addr 0x%"PRIx64" value 0x%0*=
"PRIx64
>>>
>>> Do all our trace backends support format strings which use the
>>> "dynamic format width specified via '*'" syntax ?
>>
>> I thought I read a comment about it between Eric/Stefan but I can't fi=
nd
>> it, maybe I dreamed it. (Cc'ed Eric).
>=20
> If my grep is correct we currently use the syntax already in
> gt64120_read, gt64120_write, pflash_io_read, pflash_io_write,
> pflash_data_read and pflash_data_write trace events.

If you use 'git blame' you'll notice I added all of them, so better
let's get a proper confirmation from Stefan :)

I plan to use them more, I find them helpful to directly see the access
size looking at the value width.

Regards,

Phil.

