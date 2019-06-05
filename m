Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F58C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D8D2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="HSBbnfe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D8D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXaw-0008V2-Vq
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:12:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYXZB-0007SJ-2M
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYXZA-0001AU-0A
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:11:05 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:53384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1hYXZ8-0000ld-Mq
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.uni-paderborn.de; s=20170601;
	h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g13SMHpLF2ukBpYf9747dCTiSOcThrdT7VUIQ1chP9E=;
	b=HSBbnfe3996crJu2TYL528Tovh
	It9JFoAsclUTkUOges2MtxFqc9t11epFGqoUkJ4EAM9p3RE/rxNfRzm7UbLft9S7iJaGreBsJruZc
	ypZIfTZoW7M1XQuzS9F4bEOh7QB53VS7aCqkwmGg1X+BiM+xhi15NtNwiAGuet6sHyrg=; 
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <1b2d4995-8a9c-887e-6b8a-f0c6936fbb91@mail.uni-paderborn.de>
Date: Wed, 5 Jun 2019 17:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605061126.10244-1-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
	Antispam-Data: 2019.6.5.150316, AntiVirus-Engine: 5.63.0,
	AntiVirus-Data: 2019.6.4.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
Subject: Re: [Qemu-devel] [PATCH 0/5] tricore: adding new instructions and
 fixing issues
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
Cc: David Brenken <david.brenken@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Guys,

On 6/5/19 8:11 AM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
>
> Hello everyone,
>
> in the scope of this patchset we added implementations for the following
> instructions for the target TriCore:
>
> QSEED, FTOIZ, UTOF

first of all thanks for these patches. QSEED.F was one instruction that 
was bugging me for some time and I didn't dare to do the grind figuring 
out how it works in all details.

I left some comments in the patch emails but in general I think the 
patches are nearly good to go. I created some scripts [1] to generate 
random tricore asm programs that I run against tsim. This has been very 
useful in catching bugs in the PSW calculation. You might want to run 
them as well :)


Cheers,
Bastian

[1] https://github.com/bkoppelmann/tricore-qemu-tests


