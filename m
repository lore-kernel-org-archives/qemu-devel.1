Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586462098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586462098B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpzc-0006aP-Cd
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUpx2-0004t7-GR; Tue, 20 Oct 2020 07:37:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:22254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUpx0-0002pZ-KR; Tue, 20 Oct 2020 07:37:11 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 49022747609;
 Tue, 20 Oct 2020 13:37:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1F876747608; Tue, 20 Oct 2020 13:37:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1E306747604;
 Tue, 20 Oct 2020 13:37:07 +0200 (CEST)
Date: Tue, 20 Oct 2020 13:37:07 +0200 (CEST)
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
In-Reply-To: <877drl1n2x.fsf@dusky.pond.sub.org>
Message-ID: <8f27b2b4-1937-305e-af22-2378d1fb3a8@eik.bme.hu>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:29:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

On Tue, 20 Oct 2020, Markus Armbruster wrote:
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>
>> One thing I have thought about is being able to mark a link property
>> as mandatory so if a value hasn't been set before realize then you
>
> A non-null value, I presume.

Do you mean something like distinguish between NULL and INVALID_VALUE 
where setting the latter as initial value means property is mandatory?

>> receive a fatal error. This would be for cases like this where 2
>> internal devices are connected together without any formal interface,
>> i.e. in cases where -device wouldn't work anyway.
>
> Moves the check from code one step closer to data: from the realize
> method to the object_property_add_link() call.
>
> I like doing things in data, because data is easier to reason about than
> code.

Except when object initialisation is scattered around in boiler plate code 
as in QEMU where it may not be obvious why a realize method fails due to 
something set/documented in a class_init method elsewhere, whereas an 
assert in the realize method is quite self evident and would document the 
same requirements.

Regards.
BALATON Zoltan

