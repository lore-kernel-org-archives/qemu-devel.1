Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889512133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRdXQ8mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889512133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrWG-0004Nh-OO
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:28:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTrVF-0003pb-79
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTrVE-0005rg-0l
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:27:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTrVD-0005qO-OC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:27:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id t5so6610527wmh.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Eo1IrSr/sQK+ukghAYSg/L2iUJxn36i0iKSrcYiLDX0=;
	b=pRdXQ8mXS+1rsFO/uJ2PVljXQ1xiSCI2L6rEjmVBaLqQyfINVPzN69WdDAmtPexVWH
	MvqElv2huWmzN7T61Q2U9Ymxh/vpk6Iu5tcjdogy/ZosdSudd9OT7OHnmm3LhE7Es+VQ
	BEsnBbUnina0WZD9uVJlVc+3ZOiyq+tNv4AqGsPVrlw9zmUGqGertxxky3xozS+AziAX
	rKF/lnhnXXAqNk87Q7n1W/0ibUZ19HA2q2hGzxLxbP3lWNbw9zsX33aTfuQjYobAjLiJ
	E/RKHHBwiPp/wVrkyAPhyuVDh8lt0Sx8s2RWsUoQml3lRvgl2SWdYoUisM5hFNInbu3c
	wE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=Eo1IrSr/sQK+ukghAYSg/L2iUJxn36i0iKSrcYiLDX0=;
	b=chn7SOypy1O/nB423oYUeK/IX5Asl07OLPAjN9hcyGdxjqmCsIy2UZhH0GmsLe1JZ7
	8ALVboxn1aJWG4kMr+VMT9aPJda6GpIzySSg0Ffw99UNQU3wbW21RB/j0Naz1UvzMNSr
	Oj1bPMUjDrjKSLvxNdEomM+9LBaSLEjbwJBp7NDRRkEgM763EtG4PcqW1GwS9V19wIVN
	3elDJLe88Ylx1XxMd2+VyxeGErlM0DGFmp3EE2LsRH0Ll0QIBPJE843ZWFR02Eyw4z48
	uUaeIB5EApGPEFhdxxu6RsZ3QlOLIWvjEeHZ6bjVOh7kY73uBtMLvyp0SfTHpkS4NPif
	RFLg==
X-Gm-Message-State: APjAAAW3XEraprtnGPJFQFsMUs2dFTJEoq5FroiZLh5W22abSiFMbwaV
	yapbLk9eQdbbim4CpQBq9DY=
X-Google-Smtp-Source: APXvYqy5PaDuHmK5IU9Oqr8L3pE0YKZCsUZ05c36jdJkDSQjB0w5H9DWX0RAit52Y/zM/LQpSYcbGA==
X-Received: by 2002:a1c:a80b:: with SMTP id r11mr13451322wme.77.1558632457838; 
	Thu, 23 May 2019 10:27:37 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id d72sm184217wmd.12.2019.05.23.10.27.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 10:27:36 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Cleber Rosa <crosa@redhat.com>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<CAL1e-=iW2honEgNfrsFoA0tU1wMq0mw5LuoRbWVmRDBMA22ELA@mail.gmail.com>
	<1094559891.24356881.1558619101528.JavaMail.zimbra@redhat.com>
	<CAL1e-=ikyNrfwBR_UW8wwCNHQjLWxhcfrTdde54OP4phkdvqHA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <b4252e21-a82c-2e1b-7a3f-ed13cb3fba36@amsat.org>
Date: Thu, 23 May 2019 19:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ikyNrfwBR_UW8wwCNHQjLWxhcfrTdde54OP4phkdvqHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 7:11 PM, Aleksandar Markovic wrote:
> On May 23, 2019 3:45 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
>>> From: "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
>>> On May 22, 2019 11:46 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
>>>>> From: "Eduardo Habkost" <ehabkost@redhat.com>
>>>>>
>>>>> Until we actually have a mechanism to exclude the test case on
>>>>> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
>>>>> please don't merge patch 4/4 yet or it will break travis-ci.
>>>>>
>>>>> Cleber, Wainer, is it already possible to make "avocado run" skip
>>>>> tests tagged with "slow"?
>>>>>
>>>>
>>>> The mechanism exists, but we haven't tagged any test so far as slow.
>>>>
>>>
>>> Cleber,
>>>
>>> For the test from patch 4/4, there is no dilemma - it should be in the
>>> “slow” group, as Philippe envisioned and said, so that it is not
> humpered
>>> with stricter requirements for “fast” (default) group. Could you
> explain us
>>> how to do it, so that we can hopefully finally proceed?
>>>
>>
>> Hi Aleksandar,
>>
>> The point is that there's no "group" definition at this point.  This is
> the
>> core of the discussion.
>>
>> I think we're close to converging to something simple and effective.
> Please
>> let us know what you think of the proposals given.
>>
>> Thanks!
>> - Cleber.
>>
> 
> Cleber, hi.
> 
> Thanks for responding.
> 
> My views are very similar to Philippe's, but I will provide you with more
> details of our (mips) perspective.
> 
> As far as black/whitelist issues that is a moot point for us - we only want
> to be able to have a way to tag a test within the test itself (so, without
> updating some common files, external lists,etc.)
> 
> In general, we would like to have a test environment where we would be able
> to test what WE deem suitable for us, without feeling that we bother you or
> anybody else, or that we are bothered by others.
> 
> Let me give you a little extreme example: Let's say we want a complex test
> that downloads components from let's say fifty internet location, executes
> zillion test cases, and last two days. I wouldn't like anybody to ask me
> “Why would you that?” or tell me “You can't do this.” or say “No, we did
> not anticipate such tests, patch rejected.” I (we, people from mips) should
> be able to define what I (we) need.

Maybe we can use subdirectory like we do for the TCG tests (Aleksandar
maintains tests/tcg/mips/). We should try to keep contribution upstream,
so good idea/pattern can be reused by others.

What I'd like to have with those tests is, at least:

1/ we don't need to run all the tests (but there is a set of 'quick'
tests we can run on daily basis)

2/ maintainers can run their default tests easily (using a combination
of Avocado tags)

3/ if a developer working on the PCI subsystem has to modify the MIPS
subsystem (for example), he should be able to run the MIPS tests before
sending his series.

> Having such test would be a big deal for me, not only that I could run it
> manually or automatically every weekend, but I could ask submitters of
> critical changes: “Did you run this test that we have in Avocado dir?”,
> without specifying test details, procedures, etc. All this is a BIG deal
> for me.
> 
> On the other hand, I agree that certain group of tests (envisioned for
> daily or so Travis CI) should have some stricter limitations and structure.
> But right now I feel humpered by it, and this is counterproductive.
> 
> So, we want freedom, responsibility and ownersheep of our tests. Please
> give us the opportunity to get down on business and start writing tests and
> start testing.
> 
> Yours,
> Aleksandar

