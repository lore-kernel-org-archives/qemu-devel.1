Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED0C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC6C2467B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC6C2467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HSX-0002Rl-PB
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j7HRj-0001ua-If
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j7HRh-0001gc-3M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:35:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:24295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j7HRg-0001aL-To
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:35:13 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9AD5C747E01;
 Thu, 27 Feb 2020 12:35:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8312B747DF7; Thu, 27 Feb 2020 12:35:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 81F49747DF5;
 Thu, 27 Feb 2020 12:35:08 +0100 (CET)
Date: Thu, 27 Feb 2020 12:35:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <ec3861e40717ef1ccfba29671e4dd42356e63cf1.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2002271233220.21840@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
 <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
 <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
 <alpine.BSF.2.22.395.2002251515290.22173@zero.eik.bme.hu>
 <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com> 
 <alpine.BSF.2.22.395.2002261109290.39786@zero.eik.bme.hu>
 <e7758063db7312ab052e595a508f0baa70d454dc.camel@bt.com>
 <ec3861e40717ef1ccfba29671e4dd42356e63cf1.camel@bt.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
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
Cc: mark.cave-ayland@ilande.co.uk, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020, jasper.lowell@bt.com wrote:
>> I'll submit a RFC V2 patch with a proposed fix.
>
> This will have to wait.
>
> Recent commits have caused Solaris 10 to error out of booting much
> earlier than previously.

Can you bisect which commit broke it? Is it the same that caused slowness 
for arm and ppc? For that one there are patches that should fix it on the 
list.

Regards,
BALATON Zoltan


