Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A3FC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5043120825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5043120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40115 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNsVU-0000a7-JC
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:19:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNsUQ-0000AH-Ux
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNsUP-0002Sd-Tq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:18:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNsUP-0002Rp-FP
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:18:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so1918262wmj.1
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 22:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2mlt/Nivd3xg9klZHlZRU3nWz1AmHiwwGK9asAfsNt4=;
	b=pL0OCffWV9VRsXSJoPwgTeoNOJCBFRqqTV/B3Ib1T972WuFZHv2mHayzk565nNP6W+
	N755PAv3TXQzV4LzhequnqHKuzIgGuy/OFvUZVIXV/YzVkafXAPg9QEplO1umWTHNBVf
	UVC/Q8Uat+pPTbFpqL7MBzJQrp5nCu7Zm2GQlEpCqNTKA/N6CHRK93tb/AltO16KTBQZ
	CftnTOFR08wO2BthTu+mUPhdv7JMkHdOgusaErE0Ez0bo4GG5mWCpKRnWPbbw+8YlJXT
	6OwKMfkL5BwF60qzIhNrwoTv92hr2b5us2D3Sp5+rgp1Y8jGT6pVe0K0+AN4QQ8Xs+jq
	mcFw==
X-Gm-Message-State: APjAAAWAr+81RoXge6CjhF64CQWHKLCsLphOgtwTwSeMBuJv298WH2xp
	SR5B+j+Ym8mxSI1dxkzx5di7aw==
X-Google-Smtp-Source: APXvYqx/s5bDjem9mEveup+pW+6Z3c2v17yAYtU/thLwPu5LLs82P9pxtYFdotum4nMrkdyJ886gug==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr20101337wma.71.1557206284418; 
	Mon, 06 May 2019 22:18:04 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	t16sm8233388wrw.56.2019.05.06.22.18.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 22:18:03 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190312234541.2887-1-philmd@redhat.com>
	<d5d84efd-ef8c-4e0d-d48a-6996d91832e7@redhat.com>
	<20190506214155.GI28722@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4202015a-d86f-a626-e87c-57fb328ae64a@redhat.com>
Date: Tue, 7 May 2019 07:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506214155.GI28722@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Acceptance Tests: Test the
 Raspberry Pi 2 board
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 11:41 PM, Eduardo Habkost wrote:
> On Sat, May 04, 2019 at 01:52:51PM +0200, Philippe Mathieu-Daudé wrote:
>> On 3/13/19 12:45 AM, Philippe Mathieu-Daudé wrote:
>>> Add the raspi2 to the list of boards tested by the
>>> boot_linux_console Avocado test.
>>>
>>> Based on "Acceptance Tests: target architecture support" v5:
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04111.html
>>> Based-on: <20190312171824.5134-1-crosa@redhat.com>
>>>
>>> Philippe Mathieu-Daudé (2):
>>>   BootLinuxConsoleTest: Let extract_from_deb handle various compressions
>>>   Boot Linux Console Test: add a test for the Raspberry Pi 2
>>>
>>>  tests/acceptance/boot_linux_console.py | 34 ++++++++++++++++++++++++--
>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> I was hoping this series would be included in "Acceptance Tests: target
>> architecture support" by Eduardo (removing the 'print' debug line) but I
>> just realized I forgot to Cc him :S
> 
> Problem solved: queued on python-next (after removing the print
> statement from patch 2/2).  :)

Thanks a lot!

