Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D805AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1B2207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1B2207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKHA-0007pW-AH
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBJur-00050y-Mc
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBJuq-00049I-9G
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:29:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBJuq-00048w-0x
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:29:44 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 096CF8553A
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 14:29:43 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w8so2383326wrm.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SvZCT0xaafGJcy/Pc8bRAYUL8MzX4QU/dwa9I2jPlcE=;
 b=gYwf3mymOppdIJC0srx72EnHlJBbJufNEYUFxXrnJOAI3pCfuHiX+t13JKzYjtBqUH
 Zm7NQX0jPo2DIGCeB493/Z3FKeLbW/FAKxlGZBJj+sVwYZFSWCnTsfRFYGj0zY1SByKq
 LTi1mC/bTge0G5hnkW2rJMQL3fitkpBoG2slWJlenz/T3xoFj9YLa9YTly6/tkYQ4jzu
 HXZUyxtkq+KtxHfND7RvQokl8sRF7GnzPIus6shiU//wFnP3yKceoDf+u/ZblYpGTOGI
 epShUaBx+WYadmgrTLoKCRZ5/pq3lmL4niyGATYaxOUWcpVhya3KXzDiSBHdiTGcZckX
 fyUg==
X-Gm-Message-State: APjAAAWpAG6Q2A/1wsGjUUEI4KvnwmRpa7STUP085Xa5Hd+vNh1P93W4
 cP8+Tubcr0hqKl1DIYOtbsOB4NkpbnpOIgpBiqTU2Us92rtQsWbSa8KzRJpKx5uB+wgvsGNaQub
 2E8lO+J3CYyKpt3M=
X-Received: by 2002:adf:f151:: with SMTP id y17mr11885678wro.244.1568989781820; 
 Fri, 20 Sep 2019 07:29:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwweLkxd8GUotyjFMkOJ7wAPrTP5LUirojeyndMa1uReBcFepmemsB+VO9G5jkMl6gSXhgzcg==
X-Received: by 2002:adf:f151:: with SMTP id y17mr11885667wro.244.1568989781631; 
 Fri, 20 Sep 2019 07:29:41 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id y14sm3273411wrd.84.2019.09.20.07.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 07:29:41 -0700 (PDT)
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20190920141248.12887-1-philmd@redhat.com>
 <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f817b9a4-272e-c4c0-a4c4-5b5ebd7fd917@redhat.com>
Date: Fri, 20 Sep 2019 16:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
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
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 4:19 PM, Peter Maydell wrote:
> On Fri, 20 Sep 2019 at 15:12, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> Now that the unassigned_access CPU hooks have been removed,
>> the unassigned_mem_read/write functions are only used for
>> debugging purpose.
>> Simplify by converting them to in-place trace events.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Based-on: <20190920125008.13604-1-peter.maydell@linaro.org>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04668.html
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03705.html
>>
>> I first wrote:
>>
>>   These functions are declared using the CPUReadMemoryFunc/
>>   CPUWriteMemoryFunc prototypes. Since it is confusing to
>>   have such prototype only use for debugging, convert them
>>   to in-place trace events.
>>
>> But it doesn't provide helpful information and is rather confusing.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> @@ -1437,7 +1418,8 @@ MemTxResult memory_region_dispatch_read(MemoryRe=
gion *mr,
>>      MemTxResult r;
>>
>>      if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
>> -        *pval =3D unassigned_mem_read(mr, addr, size);
>> +        trace_memory_region_invalid_read(size, addr);
>> +        *pval =3D 0; /* FIXME now this value shouldn't be accessed in=
 guest */
>=20
> This FIXME comment is not entirely correct.
>=20
> Unassigned memory will RAZ/WI and the 0 will be seen by:
>  * guest CPUs which don't implement a do_transaction_failed hook
>    (or which have a hook that doesn't always raise an exception)

OK, I thought targets always had to implement do_transaction_failed.

>  * other transaction masters, such as DMA controllers, if they
>    choose to ignore the MemTxResult (or use an API that doesn't
>    expose the MemTxResult)

Didn't think about this one. OK.

I'll replace my FIXME by your 2 comments to make it clear.

>> diff --git a/trace-events b/trace-events
>> index 823a4ae64e..83dbeb4b46 100644
>> --- a/trace-events
>> +++ b/trace-events
>> @@ -62,6 +62,8 @@ memory_region_tb_read(int cpu_index, uint64_t addr, =
uint64_t value, unsigned siz
>>  memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, =
unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr,=
 uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"=
PRIx64" size %u"
>>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr=
, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%=
"PRIx64" size %u"
>> +memory_region_invalid_read(unsigned size, uint64_t addr) "invalid rea=
d size %u addr 0x%"PRIx64
>> +memory_region_invalid_write(unsigned size, uint64_t addr, int fmt_wid=
th, uint64_t value) "invalid write size %u addr 0x%"PRIx64" value 0x%0*"P=
RIx64
>=20
> Do all our trace backends support format strings which use the
> "dynamic format width specified via '*'" syntax ?

I thought I read a comment about it between Eric/Stefan but I can't find
it, maybe I dreamed it. (Cc'ed Eric).

Regards,

Phil.

