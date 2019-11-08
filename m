Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE1FC6197
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAE0215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAE0215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTCET-0007bV-G8
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 16:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iTCDX-00071A-Jg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iTCDV-0007ZO-Rc
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:54:54 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:34531)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iTCDV-0007BH-Lq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:54:53 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 97D927456F2;
 Fri,  8 Nov 2019 22:54:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7B1517456ED; Fri,  8 Nov 2019 22:54:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 783F174568D;
 Fri,  8 Nov 2019 22:54:38 +0100 (CET)
Date: Fri, 8 Nov 2019 22:54:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: Looking for issues/features for my first contribution
In-Reply-To: <CAL1e-=iCJntxh3r05kJgKnARV=EsREL9rMKG6JZSTi-QGY9mZg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.99999.352.1911082238100.43546@zero.eik.bme.hu>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
 <CAL1e-=iCJntxh3r05kJgKnARV=EsREL9rMKG6JZSTi-QGY9mZg@mail.gmail.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Rajath Shashidhara <rajaths@cs.utexas.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Fri, 8 Nov 2019, Aleksandar Markovic wrote:
>> [c] DS3231 also has programmable square-wave output + 32 KHz output pin.
>> M41T80 chip also supports this feature. However, qemu does not support
>> emulation of these features [2]. Do I take the same approach ?
>
> Hi, Rajath.
>
> I would rather have you amend M41T80, if there is a missing functionality.
>
> cc-in Zoltan the creator of M41T80 emulation, for his opinion.

The missing functionality (such as alarm timer, if I remember correctly) 
could be added, but I did not bother to fully implement it because the 
clients I was interested in only used the RTC part, so current 
implementation is sufficient for that. Not sure if anything would use the 
missing features but it would be nice to fully implement the chip.

I'm not sure what you plan to use DS3231 for but if clients only use part 
of the functions then maybe implementing those first might be enough but 
if you have time to correctly implement everything then that's probably 
even better.

If you or someone else is still looking for a relatively easy device to 
implement I have this:

https://osdn.net/projects/qmiga/wiki/SubprojectMac99I2C

The difficulty in that is that it has no docs but only open source drivers 
to figure out how it works but if someone likes a challenge it may improve 
mac99 emulation.

Regards,
BALATON Zoltan

