Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD23C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A658206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="r/rjT14+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A658206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idI65-0002T4-C2
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1idGM0-0007uZ-Cp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1idGLz-0006Yq-2c
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:21:16 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:44274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1idGLv-0006LC-EQ; Fri, 06 Dec 2019 11:21:11 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id B401C96EF0;
 Fri,  6 Dec 2019 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575649269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8c+iJWFGPAiZo9jyfQbNY0kXYYSglGYK/9W4fXx3aw=;
 b=r/rjT14+vBaGM9Jyt10ruvVkwDTpFJZmmNZYEMVR79pBFBFipB47pHs9bIKJFUD6jy0/vP
 y89v4rJ0ghvzbUjOrf9L0/REKpfARpEYm5isva6Hethq8Dx1tnl2tcz3qsFl+/I9uSjGnN
 Srfk9Vaq4n5iWWlZqPOq/9hHnkRv8+k=
Subject: Re: [PATCH v5 09/13] docs/devel/reset.txt: add doc about Resettable
 interface
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-10-damien.hedde@greensocs.com>
 <CAFEAcA_4x+EvDS8Lc0xyPE1GHRh4+7dvJ6sxMPXZjkrZ_CgrHw@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <82ff568e-2828-f055-af3e-43e748127fd2@greensocs.com>
Date: Fri, 6 Dec 2019 17:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4x+EvDS8Lc0xyPE1GHRh4+7dvJ6sxMPXZjkrZ_CgrHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575649269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8c+iJWFGPAiZo9jyfQbNY0kXYYSglGYK/9W4fXx3aw=;
 b=DtV9BBUDi5HAWhHGhslm/XNInRy71liL5TTsKD9NRCmqb2CB0w3fd5GptvXqAywhJJjR2M
 Q/vgQyI4QxSYo0cgbvrD2RjE+U4EXZK2HgviS1NAiawUUCT9FmmOj0D5ENIC78b/+OcsA7
 hE5BA0hpu3Sza77WxwCvoK8fCWK4oHY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575649269; a=rsa-sha256; cv=none;
 b=ZDIdtvKGXiPY69R/9y4+7NXRhIzaRs0nQ698DAPBxrVWWasaav/o77lITX/YGJIMmz3zH0
 VZ0ZyZosJYjU7wDNnFii1p6Bo5pg4o8eBRKrYPnxUh8N66Sc449vmL5H3J2uvBY7/OboGx
 WRvPb2cAwLbFUhvJ5PzMDW9p1LNLjKI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/29/19 8:00 PM, Peter Maydell wrote:
> On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> 
> Subject line still says ".txt".
> 
>> ---
>>
>> +Polling the reset state
>> +.......................
>> +
>> +Resettable interface provides the ``resettable_is_in_reset()`` function.
>> +This function returns true if the object parameter is currently under reset.
>> +
>> +An object is under reset from the beginning of the *init* phase to the end of
>> +the *exit* phase. During all three phases, the function will return that the
>> +object is in reset.
>> +
>> +This function may be used if behavior has to be adapted when receiving external
>> +interaction while in reset state. Note that until migration of the reset state
>> +is supported, an object should not be left in reset. So apart from being
>> +currently executing one of a reset phase, the only cases when this
>> +function should return true is if an external interaction is made during *hold*
>> +or *exit* phase of another object in the same reset group.
> 
> This paragraph feels a bit unclear to me but I'm not sure how to improve it.
> 

If I add an example like this is it better ?

This function may be used if the object behavior has to be adapted
while in reset state. For example if a device has an irq input,
it will probably need to ignore it while in reset; then it can for
example check the reset state at the beginning of the irq callback.

Note that until migration of the reset state is supported, an object
should not be left in reset. So apart from being currently executing
one of the reset phases, the only cases when this function will return
true is if an external interaction (like changing an io) is made during
*hold* or *exit* phase of another object in the same reset group.

--
Damien


