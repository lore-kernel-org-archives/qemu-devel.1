Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD764C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4313320675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4313320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOn6j-0006lp-9j
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:45:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOn5t-0006BQ-T6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOn5r-0001gj-Px
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:44:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOn5r-0001fn-KB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:44:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so1791217wrl.6
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nJ43tWRJUig84Sd0mCgeFZJeBtBNiVK/1hXUaueswrU=;
	b=T51850AbXupOD1YOM6BFZJe3feVvUevuVc8pEKjAq/9pEBC6VU5iLn1RaGQ2oDCy81
	4aiNqtKhugRpic/d9CVunmbcwLgLLFHq0ywlhFrp2Z8BuJFrMstiZEjBl5RHYkZhOlsw
	sQ45kncCX3uJeqGc1pyWfcIiUWcNHS0pBaXGprQa71S055dP1dy7VkdbODqOFZFVCZnQ
	pbync9Q7kVmaKZV01BYiVWxu5wfI35iSqEfm8q8dBwvdVPI9qx7axHLvLCfT0fJSGJuA
	UqDconuYjQghqs5vO+d/vUfc7XhPSa5HzksjhxmSQnlwEf7qRHbOa8mIGZfXDu3aqPXu
	b9PQ==
X-Gm-Message-State: APjAAAXdKK5ugJnHKIezr1Qy8AtrjUueBVIKV7rJX1QdZLos/JcmR9Bi
	Tml3hg/2BQAY8KgS5jOg4i7nsw==
X-Google-Smtp-Source: APXvYqyGX6kIchkY6+8r4PndqxsYqOHAHvLn1QCe8eXWhbBV+A/AX0jIeQYsLaP2lPG3K/xlOLaV1A==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr4011683wrq.23.1557423869787; 
	Thu, 09 May 2019 10:44:29 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id g5sm4970571wrh.44.2019.05.09.10.44.28
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 10:44:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20190507134521.31044-1-thuth@redhat.com>
	<CAFEAcA-j+wQXjPW+puxk=foi2T8O=MzXHtxdWJ6E5P7o89WQSg@mail.gmail.com>
	<c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
	<CAFEAcA8RoJ-ZSsn3Lhzj5hd3oYOE7Uxy8MvUUWrzhNfBmD=AWQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d9562f50-ad54-7a96-a2fc-7e5a3dfe0723@redhat.com>
Date: Thu, 9 May 2019 19:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RoJ-ZSsn3Lhzj5hd3oYOE7Uxy8MvUUWrzhNfBmD=AWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL v2 00/28] Kconfig for Arm machines
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Paolo

On 5/9/19 6:54 PM, Peter Maydell wrote:
> On Wed, 8 May 2019 at 16:33, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 08/05/2019 17.09, Peter Maydell wrote:
>>> On Tue, 7 May 2019 at 14:45, Thomas Huth <thuth@redhat.com> wrote:
>>>> ----------------------------------------------------------------
>>>> Kconfig settings for the Arm machines
>>>> (v2: Fix the dependency of q35 to AHCI_ICH9 in the second patch)
>>>> ----------------------------------------------------------------
>>>
>>> Hi -- this is still failing in the build test where I 'make clean'
>>
>> Very weird. What is running before the "make clean"? Could you provide
>> me with the content of i386-softmmu/config-devices.mak please?
> 
> Nothing runs before make clean -- my scripts effectively just do
> a git merge, then make clean, then make, then make check.
> 
> http://people.linaro.org/~peter.maydell/config-devices.mak
> is the i386-softmmu/config-devices.mak
> (it does not include AHCI_ICH9).
> 
> I notice that "make clean" does not delete config-devices.mak,
> and "make" doesn't cause anything to update it, either.
> 
> Further, if I "touch hw/i386/Kconfig" and then run make, nothing
> is rebuilt at all, so something seems to be wrong with our
> makefile dependencies somewhere.

Good finding.

> 
> It's kind of weird that it only shows up with the from-clean
> build and not with the incrementals, though.
> 
> thanks
> -- PMM
> 

