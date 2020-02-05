Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC0C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7457B20674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZG/14ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7457B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izPWI-0002x1-KW
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 13:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izPVY-00024r-3G
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izPVX-0008Ap-1Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:34:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izPVT-00082c-Pb; Wed, 05 Feb 2020 13:34:35 -0500
Received: by mail-pf1-x442.google.com with SMTP id i6so1657140pfc.1;
 Wed, 05 Feb 2020 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=U9k6gslZubazUtZyUDKePl3+kVZUq7ywnE3xDBg3sqc=;
 b=hZG/14lyL9U7tz3jLbYSlRAUU0u51lwFwpsiaH7/8gKaxhoJfkN2tOYEk80MIlGZjX
 GGLDHXSeXwjG817+46HrCQ461/f92CT8Fls7pyOxQ93AHfW2lhYPvq1Wij3bOgxQsy3O
 IhqujIHIgmPhnOr5odLxpYlIJEtyqQfXW/1trPZ1w2jQy9rerwU9Z0+KaMqCAOra+x7f
 FRpmHPVOichpjaLmkcqL6/luQFdSUBdnU4wzFN8lBz+4b5mcWLOll+AhumsmlZpQcyBu
 9D0cXFfLMCtv6vdjMTfk1jDyEMa84082PS60b9zzT23lXK4GWdu7F59jTDUyCwLvJg5H
 Up9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=U9k6gslZubazUtZyUDKePl3+kVZUq7ywnE3xDBg3sqc=;
 b=aqYWoyYzSw2OabTMlaa9i9fpqAWCj0Gj9GgB6zsILWXiiYFtnyKBUGXVfuEJMomGCt
 T5i6wooSffxpsFvwx7e0AGnKPKIRTbUUe7uSRNSZebl9WNuVVIGqg25I5/hvK3x3C5Hg
 gdDli98IRZMQtj0jItydpgRvePJPMKTaHZeafq4gD5/rY9Hr5QDRW5JYCrJGG6SGpBvH
 rswBkns7tZ4NXnk8N367T9jE+NqU7QCBtqZY2Yuvid8yHBYDqo4SddJ/c7YopHTrPsgu
 0ipsZBs2HxLmONGA/vMCvBIICUEmc1Gitf5rl2I9RWO1f9W0brK2CAxF/BdPyyN7mrsj
 9nrQ==
X-Gm-Message-State: APjAAAXjaEsdUGwWI4Ad7XNsbASZ0XVbGDbrbkI/4rWxoLQ6bXdUFU1W
 0mjTBecnHKcawiXyQZ3sPOI=
X-Google-Smtp-Source: APXvYqymKuohMOwf6UHxUKdbGmHJWgokSRF+tGDKWUEu7qNYbuu9vboZvPHVGCosubA0UvX1kAN0Kw==
X-Received: by 2002:a63:78b:: with SMTP id 133mr37098735pgh.379.1580927674512; 
 Wed, 05 Feb 2020 10:34:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id c15sm194369pfo.137.2020.02.05.10.34.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Feb 2020 10:34:33 -0800 (PST)
Date: Wed, 5 Feb 2020 10:34:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/3] m25p80: Convert to support tracing
Message-ID: <20200205183432.GA10650@roeck-us.net>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <615518c7-f4c8-7c08-9096-bcf5f583eeb1@kaod.org>
 <20200205163520.GE25403@roeck-us.net>
 <a4ee58d2-0642-b4f4-2756-84d9f08b08a9@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ee58d2-0642-b4f4-2756-84d9f08b08a9@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 06:10:44PM +0100, Cédric Le Goater wrote:
> On 2/5/20 5:35 PM, Guenter Roeck wrote:
> > On Wed, Feb 05, 2020 at 11:05:04AM +0100, Cédric Le Goater wrote:
> >> On 2/3/20 7:09 PM, Guenter Roeck wrote:
> >>> While at it, add some trace messages to help debug problems
> >>> seen when running the latest Linux kernel.
> >>
> >> In case you resend, It would be nice to printout a flash id in the tracing
> >> else I have a patch for it on top of yours. It helped me track a squashfs
> >> corruption on the Aspeed witherspoon-bmc machine which we were after since
> >> 2017 or so. It seems to be a kernel bug.
> >>
> > 
> > I'll send a new version to split patch 2. Not sure I understand what you mean
> > with the above. If you send me your patch I'll be happy to merge it into mine,
> > otherwise we can just keep it as follow-ip patch.
> 
> Here is the idea : 
> 
>   https://github.com/legoater/qemu/commit/a07727e9cfc8447ea18249ff68a561f7e8883584
> 

Ah, that. I had thought about doing that, but I found displaying the pointer
a bit clumsy. It looks like there isn't really anything else available that
would provide a flash index, and I agree that it would be useful, so I'll
add it for all traces.

Thanks,
Guenter

