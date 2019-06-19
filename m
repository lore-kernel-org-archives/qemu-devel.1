Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566BC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230CE2147A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="G8kLZIAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230CE2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdZf7-00061f-8G
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 08:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hdZeU-0005Vj-ST
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hdZeT-0007FT-Kb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:25:22 -0400
Received: from spheron.uni-paderborn.de ([131.234.189.16]:42200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1hdZeR-0007BR-R5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fLJQhaA3jUc11luD6AGlyutoSsHvtFNFB/INNC4au9E=; b=G8kLZIAAs8UxbEHnFF86/W2WXY
 H6+Z5e4C4cHrNOdnzbP3u2UXakg57X4v1B2uzH1ZwZ8ggphS+Cp+vm1nO0kjQ57PnE00FlZi+CyU0
 npZXJH6vtju1z9qgiKPgjgH/73C9WekvBvevthVS4gO0KAewcSSbjzl6xiPLDmAKaVfA=;
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
 <20190619075643.10048-5-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <cd1adeb4-6006-fcc8-4301-0604623f3991@mail.uni-paderborn.de>
Date: Wed, 19 Jun 2019 14:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619075643.10048-5-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.6.19.121817, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.6.18.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.16
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tricore: add QSEED instruction
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
Cc: Andreas Konopik <andreas.konopik@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 Lars Biermanski <lars.biermanski@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6/19/19 9:56 AM, David Brenken wrote:
> +
> +        result = 0;
> +        result = deposit32(result, 31, 1, new_S);
> +        result = deposit32(result, 23, 8, new_E);
> +        result = deposit32(result, 15, 8, new_M);
> +    }
> +
> +    if (float32_is_any_nan(arg1) || result == float32_sqrt_nan) {


You need float32_is_signaling_nan, since only signaling nan raises the 
invalid flag.


> +        env->FPU_FI = 1;

env->FPU_FI = 1 << 31;

See f_update_psw_flags(). FPU_FI  and PSW_V are the same and we defined 
bit 31 as the V bit for optimization purposes.

Cheers,

Bastian


