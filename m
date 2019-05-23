Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5592070D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5592070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTkC7-00048z-5J
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 05:39:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTkBL-0003pc-5p
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTkBJ-0003R3-N2
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:38:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTkBJ-0003Qc-Cs
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:38:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so1594123wrn.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 02:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HzKe0VhfNL4llBZ3W4blN1UunpXuzs6goV8BEs0gpFc=;
	b=cg0a9z282S9SzifamBVh7dWgsWFpXSnfAUwAUx2NBnh5BkpL9D+1z3celyIQalypst
	z/4fXDVyzJGY7+OIBWLO/vKKeph6sppH/G297XaP9ZBLB1Q8c2ZTv0Mm4She0FKuhTkN
	3RfqiPlv6xgCT47bUwWB+27HXFecUtYQCWZl9YBqIDpv5A3mxHTvSfYjMCb5EoCwxAI0
	Hipxq+1z1sSHMQu0+txX1ED2oWxXnZAgzlDArDV57wZPi1qCA05YmHpdeVurL+eVwIXJ
	g7e440kbhKFS7b6P/WjSDc4PFY96fPjk5Rozxqjr2kTxtnyDbKDBwzyC6XPvu5v/kw1Z
	wdFQ==
X-Gm-Message-State: APjAAAWzyvWZ9KJDlnI1dny45/kYFiEtrMr/52AlIvIVvxSxDRmzC+KO
	BBVRZ42/3ZGmVK5JuHms5F1bqQ==
X-Google-Smtp-Source: APXvYqy9QMDOcp0bu3yfy2AxOORF8e7cac4MFbI64T4USjDorZbwpJI1cRBRmqCgfOqTAFpbGUM8Ig==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr425545wrn.133.1558604316207; 
	Thu, 23 May 2019 02:38:36 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	s10sm23738110wrt.66.2019.05.23.02.38.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 02:38:35 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<20190522230705.GB10764@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7a046f76-c892-a796-e7d0-b0eda92075d9@redhat.com>
Date: Thu, 23 May 2019 11:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522230705.GB10764@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 1:07 AM, Eduardo Habkost wrote:
> On Wed, May 22, 2019 at 05:46:06PM -0400, Cleber Rosa wrote:
>> ----- Original Message -----
>>> From: "Eduardo Habkost" <ehabkost@redhat.com>
>>> On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> It was a rainy week-end here, so I invested it to automatize some
>>>> of my MIPS tests.
>>>>
>>>> The BootLinuxSshTest is not Global warming friendly, it is not
>>>> meant to run on a CI system but rather on a workstation previous
>>>> to post a pull request.
>>>> It can surely be improved, but it is a good starting point.
>>>
>>> Until we actually have a mechanism to exclude the test case on
>>> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
>>> please don't merge patch 4/4 yet or it will break travis-ci.
>>>
>>> Cleber, Wainer, is it already possible to make "avocado run" skip
>>> tests tagged with "slow"?
>>>
>>
>> The mechanism exists, but we haven't tagged any test so far as slow.
>>
>> Should we define/document a criteria for a test to be slow?  Given
>> that this is highly subjective, we have to think of:
>>
>>  * Will we consider the average or maximum run time (the timeout
>>    definition)?
>>  
>>  * For a single test, what is "slow"? Some rough numbers from Travis
>>    CI[1] to help us with guidelines:
>>    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS (6.04 s)
>>    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS (2.91 s)
>>    - linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16:  PASS (18.14 s)
>>    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)
> 
> I don't think we need to overthink this.  Whatever objective
> criteria we choose, I'm sure we'll have to adapt them later due
> to real world problems.
> 
> e.g.: is 396 seconds too slow?  I don't know, it depends: does it
> break Travis and other CI systems often because of timeouts?  If
> yes, then we should probably tag it as slow.
> 
> If having subjective criteria is really a problem (I don't think
> it is), then we can call the tag "skip_travis", and stop worrying
> about defining what exactly is "slow".

I'd go with a simpler "tags:travis-ci" whitelisting any job expecting to
run smoothly there.

Then we can add "slow" tests without having to worry about blacklisting
for Travis CI.
Also, Other CI can set different timeouts.

I'd like maintainers to add as many tests as they want to upstream, so
these tests can eventually run by anyone, then each maintainer is free
to select which particular set he wants to run as default.

>>  * Do we want to set a maximum job timeout?  This way we can skip
>>    tests after a given amount of time has passed.  Currently we interrupt
>>    the test running when the job timeout is reached, but it's possible
>>    to add a option so that no new tests will be started, but currently
>>    running ones will be waited on.
> 
> I'm not sure I understand the suggestion to skip tests.  If we
> skip tests after a timeout, how would we differentiate a test
> being expectedly slow from a QEMU hang?
> 

