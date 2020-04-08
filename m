Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D245C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0A220747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="wQMoaWiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0A220747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7eA-0001Oj-Rp
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1jM7bA-0008GC-PS
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1jM7b9-0005yr-N9
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:06:20 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:42038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1jM7b5-0005oU-BB; Wed, 08 Apr 2020 06:06:15 -0400
Received: from [192.168.1.12] (lfbn-gre-1-344-171.w90-112.abo.wanadoo.fr
 [90.112.62.171])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 950B296EF0;
 Wed,  8 Apr 2020 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1586340372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nyR2oWPAYjjoaK8JAIKLS4NWzG69MYCwGOPrLLhRGk=;
 b=wQMoaWiDUn1xIQyWfSNc72ls8KWKXHNY/fA/pHhaRcUlAWIhZskaOrJyzbn/9YPfpZbW0d
 BSY3QmGmFesEIrYbser5aviAdBdXJj5z5YzPuJLpYnG3kN/8z5kdKZLlGsub9zB9WmRVpg
 /P1piKgLoRea64d/SkUoRn3qW/V0n+0=
Subject: Re: [PATCH v9 5/9] docs/clocks: add device's clock documentation
To: Markus Armbruster <armbru@redhat.com>
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
 <20200406135251.157596-6-damien.hedde@greensocs.com>
 <87pncjzxwc.fsf@dusky.pond.sub.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <f5556e5f-ee75-10cb-53f3-b249de8a5147@greensocs.com>
Date: Wed, 8 Apr 2020 12:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87pncjzxwc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1586340372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nyR2oWPAYjjoaK8JAIKLS4NWzG69MYCwGOPrLLhRGk=;
 b=ETNnm7aRrIsp1HhK1Wl/Z54wrwLnnfeKtKeBqIgiknSIcIZ1k/g3/mKyj5/RrFPo12DhOl
 iJPfpixkpTgLpQKjWnzIzA8YEjRkRcR7AyPrZYb33Zc+/Rq08T8LhlPGKPcGy+F2jcB2BE
 s8O+AM2PaY2jUe4OasaX8rIFPgoR8gs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1586340372; a=rsa-sha256; cv=none;
 b=fMYiC06BLS8w1tl5dt6t6SvlJe7g+12fvoRi39ppnyHQvO+fTVt3QibTaqQ06+Vx02w5C5
 k18o1QT3bzkNI1QTq0Wbltorrxk/+KkERTmqS+T71gEpAtmvVYLSDCGsWEZo8oymwLnVOK
 e2L85yoNUvI9CtsK+FVSef+tC+uFATU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/7/20 7:07 AM, Markus Armbruster wrote:
> Damien Hedde <damien.hedde@greensocs.com> writes:
> 
>> Add the documentation about the clock inputs and outputs in devices.
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> ---
>> v9:
>>  + fix a few typos (Alistair)
>>
>> v8:
>>  + fix list indentation
>>  + reduce title size
>>
>> v7:
>>  + update ClockIn/Out types
>>  + switch to rst format
>> ---
>>  docs/devel/clocks.rst | 360 ++++++++++++++++++++++++++++++++++++++++++
>>  docs/devel/index.rst  |   1 +
>>  2 files changed, 361 insertions(+)
>>  create mode 100644 docs/devel/clocks.rst
>>
>> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
>> new file mode 100644
>> index 0000000000..ead9f55561
>> --- /dev/null
>> +++ b/docs/devel/clocks.rst
>> @@ -0,0 +1,360 @@
>> +Modeling a clock tree in QEMU
>> +=============================
>> +
>> +What are clocks
>> +---------------
>> +
>> +Clocks are QOM objects developed for the purpose of modeling the
>> +distribution of clocks in QEMU.
>> +
>> +They allow us to model the clock distribution of a platform and detect
>> +configuration errors in the clock tree such as badly configured PLL, clock
>> +source selection or disabled clock.
>> +
>> +The object is *Clock* and its QOM name is ``CLOCK``.
> 
> PATCH 1 has
> 
>     #define TYPE_CLOCK "clock"
> 
> Ignorant question: how is this related to *Clock* and ``CLOCK``?
> 
> [...]
> 

Hi Markus,


*Clock* refer to the C type
> typedef struct Clock Clock;

I think I've put ``CLOCK`` in uppercase because, in practical, we only
use the upper case macro.
> #define TYPE_CLOCK "clock"
> #define CLOCK(obj) OBJECT_CHECK(Clock, (obj), TYPE_CLOCK)

I'm not sure what is the right terminology here. Maybe I can replace by
the following:

> The QOM name of a clock is ``"clock"`` (or the macro ``TYPE_CLOCK``).
The C type object is *Clock*.

Thanks,
Damien


