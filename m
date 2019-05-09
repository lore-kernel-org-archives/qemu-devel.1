Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6DEC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D799221479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D799221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51339 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfRJ-0000IE-5j
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:34:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfPh-0007mu-T8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfPg-0005KZ-BP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:32:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOfPg-0005Jp-4n
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:32:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so1981291wra.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 02:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QwH74LETBaF+UY2LT9XQQKL1D1uQjZEUPv8hnsq76J8=;
	b=eE9LJTSR/b910ZrvUKLgHzVc4u8kL0I1NiNcZgBDLqqrohlIFCGCew9/TcKzaOSEnP
	OCw1TEPo6ooLYwIJgQDHIT3wwsDYBZ5bPCQ4BGtevldPb/EFhMrXExTpEe/MkdRbltCx
	OgX5gJaS8gTOfrxIu/Pz7aSlFX9jrxray1rwFQCPRgLydDCU9N4TtDJ4Sw1nOXGIEzbU
	Epx1kSXBuhp23G0keuGCSR+UnOBJizUCu93FNBHqQ2WBv2ReTOsEd0RZJhCp7HqxA7Hd
	/cgjEkey9zu92x5PPIVbYEaNrjgwFkHSqwUS2g+qtjFWygTKBnkgCueYUbslTHaSHSDf
	1/EA==
X-Gm-Message-State: APjAAAU8rVZV90KFUBX7uvCUW8rrjLBUcEWn3/sH6bvXppH7ZBAPwIBS
	QCHigav3kCmnLjliIhY0naYPCHcPKiw=
X-Google-Smtp-Source: APXvYqwH3ArKrpQ6T1ubZMh8A9knAavpnnj7tTr9F7WF59HmyObQUFCaRhPSv4DcLe8GGryJlsnF6A==
X-Received: by 2002:a5d:5282:: with SMTP id c2mr2259891wrv.88.1557394346192;
	Thu, 09 May 2019 02:32:26 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id f6sm2029940wro.12.2019.05.09.02.32.25
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 02:32:25 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190507134521.31044-1-thuth@redhat.com>
	<CAFEAcA-j+wQXjPW+puxk=foi2T8O=MzXHtxdWJ6E5P7o89WQSg@mail.gmail.com>
	<c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
	<b93b1eb4-d2ff-67cd-a293-5ceb4db9b957@redhat.com>
	<CAP+75-XRZ22uhxfLF6uOpjDtKOf_EDC8uGgbu=DgYw-kcBSAGQ@mail.gmail.com>
	<20a27c22-cd1a-f5a8-9e36-db171c4ae19e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f8186f0c-2852-956b-5a01-e42ec6c90d7f@redhat.com>
Date: Thu, 9 May 2019 11:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20a27c22-cd1a-f5a8-9e36-db171c4ae19e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
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
Cc: qemu-arm <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 7:34 AM, Thomas Huth wrote:
> On 08/05/2019 18.45, Philippe Mathieu-Daudé wrote:
>> [clicked ctrl+enter too fast]
>>
>> On Wed, May 8, 2019 at 6:43 PM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>> On 5/8/19 5:33 PM, Thomas Huth wrote:
>>>> On 08/05/2019 17.09, Peter Maydell wrote:
>>>>> On Tue, 7 May 2019 at 14:45, Thomas Huth <thuth@redhat.com> wrote:
>>>>>>
>>>>>>  Hi Peter,
>>>>>>
>>>>>> the following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>>>>>>
>>>>>>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-07
>>>>>>
>>>>>> for you to fetch changes up to 69f879e9fefab9aaf24893fe4ce23e07756d703c:
>>>>>>
>>>>>>   hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-07 15:01:47 +0200)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Kconfig settings for the Arm machines
>>>>>> (v2: Fix the dependency of q35 to AHCI_ICH9 in the second patch)
>>>>>> ----------------------------------------------------------------
>>>>>
>>>>> Hi -- this is still failing in the build test where I 'make clean'
>>>>
>>>> Very weird. What is running before the "make clean"? Could you provide
>>>> me with the content of i386-softmmu/config-devices.mak please?
>>>
>>> It worked for me after running 'git fetch --tags', maybe because Thomas
>>> used the same tag?
>>
>> Maybe because Thomas used the same tag you are still trying the
>> previous version?
> 
> I did not use the same tag. v1 had pull-request-2019-05-05 while v2 has
> pull-request-2019-05-07. So this can not be the reason.

Oh, I might have mixed up because I ran "git fetch" -> no change,
because tags are not fetched by default. "pull-request-2019-05-07" is
what I tested, with/without running "make clean". I can not reproduce
the error Peter is having.

