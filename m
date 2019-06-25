Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CFFC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56A8215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="ZfFTp0wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56A8215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiKO-0006Gn-1S
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hfiIN-0004r0-Ml
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hfiIL-0002Zh-Do
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:03:23 -0400
Received: from nylar.uni-paderborn.de ([131.234.189.18]:43100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1hfiIL-0002WF-0d
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cFJETV/mxauTwpTp54YJBJFhXV1PdQj+At0U+P2lT3g=; b=ZfFTp0wAmChKRS49tVJx9rLsQX
 qadzxV/H0BibbnVcgZKdwBRyZ5V8oBINeuILHrhIit5yc7BGffg91QY0+v8zb3fSFJmM+yufu9mXE
 m+Vw5aVkWeSvAUrwlXgtgUCfBtfgaUMbNHjTyUjwZzula1JXIGvOd/F95FYcPEO5QGts=;
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
References: <20190624070339.4408-1-david.brenken@efs-auto.org>
 <20190624070339.4408-6-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <56ede725-c2ac-8180-d3cb-2579e1fca44b@mail.uni-paderborn.de>
Date: Tue, 25 Jun 2019 12:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624070339.4408-6-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.6.25.95716, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.6.18.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.18
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tricore: add QSEED instruction
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
Cc: Lars Biermanski <lars.biermanski@efs-auto.de>,
 Andreas Konopik <andreas.konopik@fau.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6/24/19 9:03 AM, David Brenken wrote:
> +
> +        result = 0;
> +        result = deposit32(result, 31, 1, new_S);
> +        result = deposit32(result, 23, 8, new_E);
> +        result = deposit32(result, 15, 8, new_M);
> +    }
> +
> +    if (float32_is_signaling_nan(arg1) || result == float32_sqrt_nan) {

float32_is_signaling_nan needs fp_status as an argument. I'll fix it for you this time, but please check if each patch builds before submitting them. Otherwise: Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian


