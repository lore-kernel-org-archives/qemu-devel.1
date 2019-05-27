Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0FEC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5F9206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtkyvqMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5F9206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47501 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVI0U-0000Jl-7F
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 11:57:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1hVHze-0008RN-0z
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1hVHzd-0002B0-1r
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:56:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hVHzc-0002AZ-TQ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:56:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id s11so9782083pfm.12
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=d6VSBFNBtAbJpYlBgVyHpiunnCtg5nq2DJVgA1pCtMA=;
	b=jtkyvqMqsBJBDfI+8Vyo9jx8Zu56SQR9OU96Wf8gn9qcqPL0dhirCkWpHS9Q4LJoTf
	FnH8J7xFslp71OCeVd9OTKi8nuockChFDcyvMwY+XFnuRkpQxiIqaHPUQmH8Ntgxre28
	x4Oec5b+wAAR8zX6mcArnvX7vfKrhwnrSaPsJ3bCJKlEq18rF5RLNbXP6gPlyeiDXYrB
	VXYyXqsv57vT/jHgAOa1epzDJ68BPcIOjp2CM5usrOM5vvJTAnOVKdBPIDxGYWmmC3tW
	YZ7KnYA5eI2kVA2HU2NDd+Pv9KQKc/YaSYmKqYaBcHrPovVeZ+NBUd8MBdkq5ABBuPSH
	0u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=d6VSBFNBtAbJpYlBgVyHpiunnCtg5nq2DJVgA1pCtMA=;
	b=IbeuR6w8FKTt1iUJRzsgYmO8svYSvPoKmf070RthsKLPAERRHv0sm91DOhcwQocx+6
	aRNJQyIO9XbXsZdUpdYi2MQcSQ0f3QPmxnEZ5qBTVUwcZG64HFKlzMZxjjlET529wQ2j
	6qau2NvmDVxLWvN0w6AFxyoqfeu9ZSXH3n5oQOH3RvW4loN4jylMSmQRAMufS9f2Tf6m
	ihzJ5gY0OXr5gutFmmo4qxAEcaRE45gzel3KFw1/7tEB4RI83BC+zEccKcbh+WhMYPY5
	VFscXVfEPjA6FhS5qbZAZY/bvWRkEBexf4SURy2l4jaBMbRgk+/3fMLv5UbKph0WwSVx
	vzxw==
X-Gm-Message-State: APjAAAVXj9lfgxJeKEFcGseKDYZ6PEa5K0s2FGIumS/HjcrHaWx40gX1
	fhkPYvUjST4nZvLXi/Yv86g=
X-Google-Smtp-Source: APXvYqwcAY5U9y/EHrI4RzsmJwHSIzREkHux5n+Pnh+rJpV8l5dRNU8u/Pmwj5d1E4tkhpXhbdMBcw==
X-Received: by 2002:a17:90a:b393:: with SMTP id
	e19mr32693682pjr.91.1558972615422; 
	Mon, 27 May 2019 08:56:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
	by smtp.gmail.com with ESMTPSA id
	q70sm19541411pja.31.2019.05.27.08.56.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 08:56:54 -0700 (PDT)
To: Tony Lindgren <tony@atomide.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
	<20190527063250.GI5447@atomide.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
Date: Mon, 27 May 2019 08:56:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527063250.GI5447@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

On 5/26/19 11:32 PM, Tony Lindgren wrote:
> Hi,
> 
> * Philippe Mathieu-Daudé <philmd@redhat.com> [190523 12:01]:
>> What I use as reference for testing ARM boards [*] is the work of
>> Guenter Roeck:
>> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/run-qemu-arm.sh
> 
> I think Guenter also has v2.3.50-local-linaro branch in his
> github repo that has support for few extra boards like Beagleboard.
> Not sure what's the current branch to use though.
> 
I'd be happy to use a different (supported) branch, but the Linaro branch
was the only one I could find that supports those boards. Unfortunately,
qemu changed so much since 2.3 that it is all but impossible to merge
the code into mainline qemu without spending a lot of effort on it.

Guenter

