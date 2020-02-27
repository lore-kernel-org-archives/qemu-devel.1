Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F06AC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBD624692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBD624692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HmD-00023h-Ei
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j7Hkt-0008Du-ME
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j7Hkr-0001XF-W0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:55:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:59653)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j7Hkq-0001Li-8Z; Thu, 27 Feb 2020 06:55:00 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A28737475F6;
 Thu, 27 Feb 2020 12:54:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 844137461AE; Thu, 27 Feb 2020 12:54:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 82B5874569F;
 Thu, 27 Feb 2020 12:54:58 +0100 (CET)
Date: Thu, 27 Feb 2020 12:54:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <CAL1e-=iK1NEOr=ZRBm9XtJw7Mn_23w1ra74e3yDGbfKPVTA9zw@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002271248380.21840@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
 <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
 <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
 <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
 <2126C4B4-B0F2-4B0F-ADEC-211466989E36@gmail.com>
 <CAL1e-=iK1NEOr=ZRBm9XtJw7Mn_23w1ra74e3yDGbfKPVTA9zw@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Dino Papararo <skizzato73@msn.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020, Aleksandar Markovic wrote:
> I totally disagree with your using the term "hardfloat feature enabled" in
> this context, speaking about this particulat patch. This may be just
> wishful thinking. The right wording would be "hardfloat feature hacked", or
> "hardfloat feature fooled".
>
> The patch itself has the wrong, intentionally misleading and confusing
> title from the outset. It should be something like  "target/ppc: Cheat
> hardfloat feature into beleiving that inexact flag is always set"

May I point out that the patch is RFC, meaning it's not meant to be merged 
only to test it and provide feedback. Also the limitations were stated in 
the commit message. There's no other easy way that I know to test if 
hardfloat would work with PPC than forcing inexact bit to have it run with 
hardfloat most of the time. Once it's tested what regression this would 
cause (other than the expected inexact bit) then we can see if there are 
any other problem with hardfloat and PPC or only this bit. Then we can 
either change it to only not clear inexact bit like it's done on other 
archs or do something else as even not clearing sticky inexact bit would 
break the non-sticky counterpart PPC has. Breakage would be limited to the 
non-sticky version and discussion was about if even that's unacceptable.

Regards,
BALATON Zoltan

