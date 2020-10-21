Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A3C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF578206DD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF578206DD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBGM-0007Zs-99
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kVBFQ-0006xa-KD; Wed, 21 Oct 2020 06:21:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:49553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kVBFN-00059V-6v; Wed, 21 Oct 2020 06:21:35 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C0F8374760E;
 Wed, 21 Oct 2020 12:21:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9043A74760D; Wed, 21 Oct 2020 12:21:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8E5F8747604;
 Wed, 21 Oct 2020 12:21:18 +0200 (CEST)
Date: Wed, 21 Oct 2020 12:21:18 +0200 (CEST)
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
In-Reply-To: <87v9f4qmoh.fsf@dusky.pond.sub.org>
Message-ID: <805d309c-b8c6-e166-a5ce-7872df9452a@eik.bme.hu>
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
 <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
 <20201012065436.GB71119@yekko.fritz.box>
 <9f7e4847-801d-dcd3-b876-bf2d276251@eik.bme.hu>
 <6e587154-4bc5-c44c-0c85-b46e0dddd3aa@amsat.org>
 <87k0vm1wny.fsf@dusky.pond.sub.org>
 <24bcd4-fde2-22a2-d3f4-cd42d9ee13c6@eik.bme.hu>
 <87d01e48pa.fsf@dusky.pond.sub.org>
 <9968e60e-99fd-3777-62ca-57decb716886@ilande.co.uk>
 <877drl1n2x.fsf@dusky.pond.sub.org>
 <8f27b2b4-1937-305e-af22-2378d1fb3a8@eik.bme.hu>
 <87v9f4qmoh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 BALATON Zoltan via <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Wed, 21 Oct 2020, Markus Armbruster wrote:
> BALATON Zoltan via <qemu-devel@nongnu.org> writes:
>> On Tue, 20 Oct 2020, Markus Armbruster wrote:
>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>>
>>>> One thing I have thought about is being able to mark a link property
>>>> as mandatory so if a value hasn't been set before realize then you
>>>
>>> A non-null value, I presume.
>>
>> Do you mean something like distinguish between NULL and INVALID_VALUE
>> where setting the latter as initial value means property is mandatory?
>
> I doubt "somebody must have set some value (which could be null)" is
> useful here.  I believe Mark was thinking about "somebody must have
> connected the link (i.e. set a non-null value)".

This is all theoretical, as in this case we have no_user anyway so the 
problem can only happen through programmer error but if an object has 
several properties some of which can be NULL while others are mandatory 
how do you tell which one is mandataory? That's what I thouhgt having 
initial value some INVALID_VALUE could be used to say these are mandatory 
while those properties that are initially NULL don't need to have a valie. 
That way your generic check can work, otherwise it will need another way 
to describe mandatory properties which is additional complexity and more 
boilerplate or will make every link property mandatory which may not 
always work. Anyway, I was just trying to understand your suggestion and 
since we concluded that we don't really need it for this case we can just 
say "YAGNI" as I've learned from you and leave it at that.

Regards,
BALATON Zoltan

