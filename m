Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 15:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBE12074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 15:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBE12074A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kToax-0005kM-Ff
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 11:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kToZr-0004x9-MT; Sat, 17 Oct 2020 11:57:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:12717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kToZp-0007fx-CK; Sat, 17 Oct 2020 11:57:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 511FA747622;
 Sat, 17 Oct 2020 17:56:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CD8A1746331; Sat, 17 Oct 2020 17:56:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB9E8745953;
 Sat, 17 Oct 2020 17:56:57 +0200 (CEST)
Date: Sat, 17 Oct 2020 17:56:57 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v8 0/5] Mac Old World ROM experiment (ppc/mac_* clean
 ups and loading binary ROM)
In-Reply-To: <f614564a-e3e1-fc68-7f88-5983f5d41575@ilande.co.uk>
Message-ID: <6d125f2-c936-cfa2-f180-42b8ad9ca522@eik.bme.hu>
References: <cover.1602805637.git.balaton@eik.bme.hu>
 <005ed95d-65ee-ab36-c068-e96a773ef8ed@ilande.co.uk>
 <f26e685a-4e93-c8a5-622f-5b12c71b8ac@eik.bme.hu>
 <f614564a-e3e1-fc68-7f88-5983f5d41575@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 11:56:58
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Sat, 17 Oct 2020, Mark Cave-Ayland wrote:
> On 16/10/2020 13:19, BALATON Zoltan via wrote:
>> On Fri, 16 Oct 2020, Mark Cave-Ayland wrote:
>>> On 16/10/2020 00:47, BALATON Zoltan via wrote:
>>>> This is the cut down version of the earlier series omitting unfinished
>>>> patches that I plan to rework later and rebased to Mark's qemu-macppc
>>>> branch. Compared to v7 the only change is the cast to (target_ulong)
>>>> from (uint32_t) as requested by Mark in patch 1.
>>> 
>>> FWIW the reason for suggesting the cast to target_ulong is so that the 
>>> same code works for both qemu-system-ppc and qemu-system-ppc64. For 
>>> qemu-system-ppc that should correctly drop the sign extension from 32-bit, 
>>> whilst still allowing someone to load a 64-bit ELF into qemu-system-ppc64 
>>> if requested.
>>> 
>>> Can you confirm that the sign extension behaviour is still correct for 
>>> both qemu-system-ppc and qemu-system-ppc64? If so I'm happy to give it a 
>>> R-B tag.
>> 
>> I've tried it now again with both ppc and ppc64: both OpenBIOS and a G3 
>> beige ROM can be loaded with qemu-system-ppc but qemu-system-ppc64 fails 
>> with OpenBIOS when casting to target_ulong (i think because target_ulong is 
>> 64 bit there but g3beige is still 32 bit but I haven't throughly debugged 
>> it). But everything works with my original uint32_t cast, so ditch it and 
>> use my original version. Should I resubmit or you can fix up? (I think I 
>> wait until it's clear if this will be taken by David or you and send a 
>> fixed version cc-ing David if this is decided to go through the PPC queue.)
>
> Hmmm yes I see that qemu-system-ppc64 fails because target_ulong will always 
> represent a 64-bit quantity, even if you request a 32-bit CPU. Rather than 
> add some CPU-specific code let's keep the uint32_t cast for now as I would 
> hope it is unlikely someone would load an ELF in high memory, and perhaps the 
> sign-extended address bug will get fixed later.
>
> With the cast reverted to uint32_t then for patches 1 and 2:
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> If you can send a v9 with the cast fixed I'll apply this to my qemu-macppc 
> branch right away.

You could've really just edit the single cast in patch 1 before applying 
to change the it back but I've resent the changed patch 1 as v9 also 
adding your R-b for your convenience. Other patches are unchanged so you 
can take the v8 for those, I haven't resent those, let me know if you want 
the whole series but this is really getting much more work that it should 
be for such a simple change. (There is no cast in patch 2 as I've already 
stated several times.)

Regards,
BALATON Zoltan

