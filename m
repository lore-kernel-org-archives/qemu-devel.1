Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1ADC433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A664420748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7uoxruu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A664420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvEM-00057H-Fm
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtvDL-0004Fm-C4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:45:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtvDH-0008Fn-I9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594395921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=F+4Xyk4MNefNGQ2BcIq91VLQea/AHI/7gAXPVV3J3uE=;
 b=S7uoxruuVJxQmWyoGo42sn2vbX/HUssG7YuveDMKgVe3Zt08RPtEFlpy4URTJebtdVXM+F
 GI9WAgmIZ3eJPFGhtdTPUuoPXpEEwe8NLaCi5NWNYCzn80TCxzfPhC0hqiJV5oEY4Jyo+p
 yJ2tZ9x1N7MeHvneNJHJkEWZq7ZaiyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-QuZG9FCKOHikvwxq6jwSEQ-1; Fri, 10 Jul 2020 11:45:19 -0400
X-MC-Unique: QuZG9FCKOHikvwxq6jwSEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9E2B800D5C;
 Fri, 10 Jul 2020 15:45:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E78257EFA6;
 Fri, 10 Jul 2020 15:45:05 +0000 (UTC)
Subject: Re: [PULL 00/32] AVR port
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
 <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
 <47ca6b92-cedb-a6c4-754b-b7cd5da597e7@redhat.com>
 <CAFEAcA_wBT+Yfsn+DFZkcRxYWKmF04U2JHNVz5mNuXabeDcN5g@mail.gmail.com>
 <544208da-9dad-5fab-ab43-b2537a1f2f90@amsat.org>
 <d2dd51b4-2f10-a33a-66be-6357c52d8564@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f3796a46-1fb1-e70b-a08f-93ddec443184@redhat.com>
Date: Fri, 10 Jul 2020 17:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d2dd51b4-2f10-a33a-66be-6357c52d8564@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 17.32, Philippe Mathieu-Daudé wrote:
> On 7/10/20 5:17 PM, Philippe Mathieu-Daudé wrote:
>> On 7/10/20 5:12 PM, Peter Maydell wrote:
>>> On Fri, 10 Jul 2020 at 16:03, Thomas Huth <thuth@redhat.com> wrote:
>>>> Endianess bug ... this should fix it:
>>>>
>>>> diff --git a/target/avr/helper.c b/target/avr/helper.c
>>>> --- a/target/avr/helper.c
>>>> +++ b/target/avr/helper.c
>>>> @@ -337,6 +337,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data,
>>>> uint32_t addr)
>>>>          helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
>>>>      } else {
>>>>          /* memory */
>>>> -        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
>>>> +        uint8_t data8 = data;
>>>> +        cpu_physical_memory_write(OFFSET_DATA + addr, &data8, 1);
>>>>      }
>>>
>>> Or equivalently
>>>   address_space_stb(&address_space_memory, data, MEMTXATTRS_UNSPECIFIED, NULL);
>>>
>>> (better choices of address space may be available, but this is
>>> the exact-same-behaviour one).
>>
>> Ah, this is my stashed fix:
>>
>> -- >8 --
>> @@ -320,8 +320,10 @@ target_ulong helper_fullrd(CPUAVRState *env,
>> uint32_t addr)
>>   *  this function implements ST instruction when there is a posibility
>> to write
>>   *  into a CPU register
>>   */
>> -void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
>> +void helper_fullwr(CPUAVRState *env, uint32_t data32, uint32_t addr)
>>  {
>> +    uint8_t data = data32;
>> +    assert(data == data32);
>> +
>>      env->fullacc = false;
>>
>> ---
>>
>> 3 ways to do the same :) The assert is probably superfluous.
>>
>> I don't like the fact that env->r[addr] (which is u8) is silently casted
>> from u32.
> 
> I'll squash Peter suggested fix:
[...]
> @@ -305,13 +308,14 @@ target_ulong helper_fullrd(CPUAVRState *env,
> uint32_t addr)
> 
>      if (addr < NUMBER_OF_CPU_REGISTERS) {
>          /* CPU registers */
> -        data = env->r[addr];
> +        data = cpu_to_le32(env->r[addr]);

That part looks wrong?

 Thomas


