Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1216C31E47
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15BC20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="RkojnDNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15BC20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb1ot-0006PF-0Z
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 07:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hb1o2-00060L-S8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hb1o1-0005Vp-SH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:52:42 -0400
Received: from nylar.uni-paderborn.de ([131.234.189.18]:56882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1hb1o1-0005Uj-5v
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fvyks6l203BtIWer/hofmPjurNQEhJPQ6YPPjQ5sMls=; b=RkojnDNsBpDQdMF7g59xXHTmqK
 cgXMeUKwjajYDKMy92uIOL69m/LOjpNpoPCDiK3k7H1zfhsBhNYQ3coknqJl4F7DQ5SOvv34wNICz
 ucvKuTWdVLK6n22Jjlj0liLvjO5ZUyXOxEApTksrabskG2oqMkqKh/OzqdwMGaZG1WyQ=;
To: "Brenken, David (EFS-GH2)" <david.brenken@efs-auto.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Brenken <david.brenken@efs-auto.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
 <20190605061126.10244-4-david.brenken@efs-auto.org>
 <ffb4ba2c-318e-6b08-c206-a90b000074d2@mail.uni-paderborn.de>
 <34F764F04E859040BBA6C4FF41AB17D93B2DA4@AUDIINSX0410.audi.vwg>
 <8e4f29db-fb2d-4053-2483-a2d92466ce35@linaro.org>
 <34F764F04E859040BBA6C4FF41AB17D93B4A3D@AUDIINSX0410.audi.vwg>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <1dc1af82-88cf-5840-dfad-ff0a75e3dcec@mail.uni-paderborn.de>
Date: Wed, 12 Jun 2019 13:52:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <34F764F04E859040BBA6C4FF41AB17D93B4A3D@AUDIINSX0410.audi.vwg>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.6.12.114216, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.6.4.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.18
Subject: Re: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
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
Cc: "Biermanski, Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>, "Hofstetter,
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Konopik,
 Andreas \(EFS-GH2\)" <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 6/12/19 7:48 AM, Brenken, David (EFS-GH2) wrote:
> Thank you for your hint.
> Would anyone mind, if keep my insert implementation anyway?
> If I compare the pseudo code of the instruction manual to the insert implementation it looks nearly the same whereas it seems kind of difficult to directly map the pseudo code of the instruction manual to the general deposit instruction.

I think deposit is better, as tcg can emit the native deposit 
instruction of the host processor (which it does for x86). gen_insert() 
on the other hand needs 8 tcg ops.

Regarding the pseudo code, take a look at tcg/README. You'll see that 
the semantics of insert and deposit are the same. Thus, I think Richards 
fix is better.

Cheers,

Bastian


