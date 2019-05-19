Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E63FC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 15:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2C721872
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 15:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2C721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSNSf-0006Bn-V0
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 11:10:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSNRv-0005pd-LH
	for qemu-devel@nongnu.org; Sun, 19 May 2019 11:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSNRu-0002Jx-QW
	for qemu-devel@nongnu.org; Sun, 19 May 2019 11:10:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSNRt-0002GW-NY
	for qemu-devel@nongnu.org; Sun, 19 May 2019 11:10:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so9242425wmh.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 08:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7b8CQXWajrtm344ENpCeCmT8/bIELv4xFVwmGy0aIAY=;
	b=Tkq2e+LXHTsNts5YdfvJGHC7SPzOJPt9MJt8nbj3tqOx3zhJ3kJwLhxV0INVotrCEN
	TNqHwRevJdQg+EE15NQLdC7Xe/u3t3V+89WornIqY01XQ29Anq0CXu8EawTGR/z7pdzV
	yTiDMuWLwkQanP0aX+LVHwFzVxfx0Bei1mBkXudaTLjhPoWIRlO5ig3nK4aLSaYvItHq
	abw1mNH+4/qxZzzyHwEIck2c6XR1zgo9IFBj6t1z0cKygtTxbSk2NipbrQEwzREa04ar
	54zr8OsF+jnzQ2XWVc2LSd+VWkH99PFjrDXV+87A2Q1D7kN+W93eRfM+MTG5/Jj01W1k
	42Mg==
X-Gm-Message-State: APjAAAU7mwZ0F9+qFSAYWh7M0kmsBmyKvy1TpOc7Cqc8ieGW0vYhBz4t
	Z6ClOsITYQFd0/sDk7LriYZXcA==
X-Google-Smtp-Source: APXvYqzy9vVfbzj4YF02cahFWf1MtYTvKudb+nKY+OwVkiGODW7Y2Vx4tA3Yla1699rRBG0Evk3Qrg==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr9009769wma.65.1558278604266; 
	Sun, 19 May 2019 08:10:04 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id p8sm3193887wro.0.2019.05.19.08.10.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 08:10:03 -0700 (PDT)
To: Jakub Jermar <jakub.jermar@kernkonzept.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<bb25cbee-9265-260a-681d-d7d390c007ee@kernkonzept.com>
	<BN6PR2201MB125130243EB8B0ED9AE36848C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<034a6cb7-7fb6-e59c-007b-4f8610db37a8@kernkonzept.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <86981e47-5630-4a79-be84-b4843ec7182f@redhat.com>
Date: Sun, 19 May 2019 17:10:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <034a6cb7-7fb6-e59c-007b-4f8610db37a8@kernkonzept.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/19 4:46 PM, Jakub Jermar wrote:
> On 5/19/19 2:00 PM, Aleksandar Markovic wrote:
>>>>
>>>>   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
>>>
>>> This was rather a problem with failing non-executable page tests in
>>> L4Re, not HelenOS. Even though I tested HelenOS for regressions.
>>
>> OK, Jakub, what would be your suggestion for a high-level description
>> of this message for end users (it is definitely a change that affects end
>> user)? Something like" Improved PAGE_EXEC flag handling"?
> 
> It makes sure that referenced pages are not automatically marked
> executable by QEMU (despite the XI bit).
> 
> As a user-visible change, this might unbreak some tests that attempt to
> execute data. Note that this fix does not affect pages that are not
> referenced prior to being executed - those have worked fine.
> 
> Otherwise for normal code that does not attempt to execute data, things
> should not change at all.

Yes.

> 
> Cheers,
> Jakub
> 
>> Thanks,
>> Aleksandar

Thanks Aleksandar for preparing this pull request!

Phil.

