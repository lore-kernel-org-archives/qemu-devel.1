Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D536C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165B9208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165B9208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVI7E-0003uD-5B
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:04:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVI5u-0003CY-Dd
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVI5t-0006FH-A6
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:03:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVI5t-0006Ds-4S
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:03:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so17341207wrx.0
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 09:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2TYRQV/8vy5n7AkTEmZf5fs246F6UHHh7ITNZBQ2EdM=;
	b=URwTKdoGYn8gjHlCO2+bAOheADCFa6x8Qa5+uwmgS5k4nDUciUA8+OQ+QyBKgz3S6x
	DDdPS/yDzr/Uzt/zgqHYOjx8DFGSmZhx/blEYIUM5KU3BXjwttoRWFv69KR5+fM2/kYn
	IMleMGd2EAYKypRzK7U5WqVvNWwxe1xbJMRa6uobU8K8/M/7Z/mqAgOXGn3NmnWk89T1
	INUf8c/noMWnkt/ghDFxepsmZJP5PSZEackWymL/+C30L0OZu1/IHCZbgl14/QtxSRLu
	upsdjSErSPawf7zZdGJLuZqDCUUFD5VfZ75p0a1E6D7cU2cwjkKePiNvzWNZnGhst77N
	sHoQ==
X-Gm-Message-State: APjAAAWl2BJwQsUVBgQxwETgO3d+RN/RpAI7pNf7utxAjLs8HFq5Eipy
	5OEQO7XL8FL0ubFe+J3h6zwXXg==
X-Google-Smtp-Source: APXvYqwT2b/6FC4cJVZGNdWcdbbsNERf/3B12TaNX+gUgYXRWPEXC9eJwz0FLxEkCRuK1jUYHdIfoQ==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr19005476wrt.150.1558973003585; 
	Mon, 27 May 2019 09:03:23 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	a128sm12214045wma.23.2019.05.27.09.03.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 09:03:22 -0700 (PDT)
To: Guenter Roeck <linux@roeck-us.net>, Tony Lindgren <tony@atomide.com>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
	<20190527063250.GI5447@atomide.com>
	<5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <55b06c4c-5963-d4ef-4dcf-b222786bfd52@redhat.com>
Date: Mon, 27 May 2019 18:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] Running linux on qemu omap
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>, linux-omap@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/19 5:56 PM, Guenter Roeck wrote:
> On 5/26/19 11:32 PM, Tony Lindgren wrote:
>> Hi,
>>
>> * Philippe Mathieu-Daudé <philmd@redhat.com> [190523 12:01]:
>>> What I use as reference for testing ARM boards [*] is the work of
>>> Guenter Roeck:
>>> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/run-qemu-arm.sh
>>>
>>
>> I think Guenter also has v2.3.50-local-linaro branch in his
>> github repo that has support for few extra boards like Beagleboard.
>> Not sure what's the current branch to use though.
>>
> I'd be happy to use a different (supported) branch, but the Linaro branch
> was the only one I could find that supports those boards. Unfortunately,
> qemu changed so much since 2.3 that it is all but impossible to merge
> the code into mainline qemu without spending a lot of effort on it.

Peter commented on that here:
https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg00137.html

"This is not a trivial job (my estimate was that it would be a couple
of months work to get the complete set sorted out and upstreamed ..."

