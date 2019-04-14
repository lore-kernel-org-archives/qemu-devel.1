Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46586C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 21:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B482084D
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 21:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="kqkQwT6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B482084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41067 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFmdG-0002vr-W5
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 17:25:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFmcS-0002Wb-2H
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 17:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFmcR-0002gJ-1i
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 17:24:56 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:37400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1hFmcN-0002cd-8v; Sun, 14 Apr 2019 17:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
	; s=25047;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RDvgx9PuevACiM2bZVjLzGf9COZAuhoZrbtXVB1k+II=;
	b=kqkQwT6NyPNYi9i9YVeD8B3PNZ
	l82ol/Y1SR8u9pbiPTgnSkhMPhqMKADpOX5/QmU8D3jXmZ/ofsgTlzUmXgxSVbpCr5fD2YoDO/kW7
	2AXtOBjeNZYsykM6oK54S5eEB0g3goDK6Wk+4kP4sVeWKHthm0DqA6NAaQhfD9qB9FDI=; 
Received: from rob92-5-82-227-227-196.fbx.proxad.net ([82.227.227.196]
	helo=[192.168.0.35]) by iserv.reactos.org with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <hpoussin@reactos.org>)
	id 1hFmcJ-00044h-QG; Sun, 14 Apr 2019 21:24:47 +0000
To: Artyom Tarasenko <atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
	<29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
	<CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
Date: Sun, 14 Apr 2019 23:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
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
Message-ID: <20190414212443.0jGDPtL1t53Bq4Kq3QadXNq6OaPlzyDd11XpacKOyJs@z>

Le 14/04/2019 à 20:53, Artyom Tarasenko a écrit :
> On Sun, Apr 14, 2019 at 7:01 PM Hervé Poussineau <hpoussin@reactos.org> wrote:
>>
>> Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
>>> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
>>>
>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>> ---
>>>    hw/isa/i82378.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>>> index a5d67bc..546c928 100644
>>> --- a/hw/isa/i82378.c
>>> +++ b/hw/isa/i82378.c
>>> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>>        isa = isa_create_simple(isabus, "i82374");
>>>
>>>        /* timer */
>>> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
>>> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
>>> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
>>> +    qdev_init_nofail(DEVICE(isa));
>>
>> I am not sure the base_year should be hardcoded in i82378. I can assume other machines with a i82378 can have another base_year.
> 
> I doubt it to be honest. How would it work in the hardware? Is there a
> pin which would switch a year?
> I do believe the different i823xx may have the different base years though.

OK, I don't really know. So, your patch looks fine.

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

> 
>> Maybe you can you add a base_year property to i82378, and forward it to mc146818 with object_property_add_alias?
>> Then, change 40p machine to set it to 1900, without changing it for prep machine.
> 
> Were you not going to drop the -M prep ? Because I sort of dropped the
> support for it in OFW.
> I had a branch were I added some registers to -M prep  enough that it
> would be able to turn itself out as a PowerStack II Utah,
> but then again I couldn't find any advantage of having two PReP machines.
> AFAIK, the only OS which can run on Powerstack, but not on 40p is Motorola AIX.
> But since we can have IBM AIX, I don't see why would we want to keep -M prep.

I really want to drop support for prep. But, as long as prep is in code base, we shouldn't regress it too much.

> 
> On the other hand, if you plan to revive it, I'll think about adding
> the support for it to OFW.
> PowerStack had a Cirrus VGA which we already have.
> 
>>>    }
>>>
>>>    static void i82378_init(Object *obj)
>>>
>>
>> Hervé
> 
> 
> 


