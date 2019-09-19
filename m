Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AEEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054CE20644
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054CE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzqX-00089Y-Oc
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAznc-0005vc-7w
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAzna-0007Br-6y
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAznZ-0007Au-Um
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:00:54 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF688796FF
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 17:00:52 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r21so1905174wme.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PNhoJ2bi0DzHGZLCyE+58JDcigW3fph7J2zFvGmhtro=;
 b=n/UfMpxuEQ4rOEIEVGC2yP85W4iVGs8HhjbgMuTAsYfVW2E/xZSyD6cbGPmJD/R7Bf
 ZV47kR2yiPDNWNXOLjbN7UyOWPxcqg8pkxLrxDyR/qB3p3sGaLdTnjy020+3Mis8R1wi
 vpa4j1br/VJJ3j0EjxxgV7pE7TIG6dHstbCTFpTrd/I9JwhydbWwa0m33RyQUgKwMYNF
 w7Y8j/weCWIdmoZmny1Q/8YncEqJceJls/d6gOPp1KgqOgGpIEvdXfyj6DWxdfB0NWF3
 db0Qnod7iT+zawoiddn3Dc1BTjO9o9SCLOPKtqSj+XJEahhu0F0FZ+YXJCo4AGkoMvg4
 r3Uw==
X-Gm-Message-State: APjAAAVfGKlG9KX9OsKzUYiqIlk6vxNy1AnkdhEw+zQOjGrXkxnXqwYL
 G7ZDuyxgrSWR00wIn3armyXBb0OPzx1pENKm/Pe7hHOab0ojSRxDNUSB0jF1YlAd1maMa+dkEup
 BcvH4OuBnwjMXRrQ=
X-Received: by 2002:adf:e591:: with SMTP id l17mr8267508wrm.199.1568912451179; 
 Thu, 19 Sep 2019 10:00:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwN6KLiNRBdq6TboyiY2TRxrlr9HnFnvhM0algC6aAax2lb84wMr4HKljiyHaUuPhzsT8Sm8Q==
X-Received: by 2002:adf:e591:: with SMTP id l17mr8267498wrm.199.1568912450969; 
 Thu, 19 Sep 2019 10:00:50 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id d193sm9942589wmd.0.2019.09.19.10.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 10:00:50 -0700 (PDT)
Subject: Re: Problems with MIPS Malta SSH tests in make check-acceptance
To: Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20190918071654.GK2440@umbus.fritz.box>
 <20190919011452.GA23168@localhost.localdomain>
 <20190919165632.GA5821@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8bc26c85-253e-ff20-c3e0-1ecdb56d60c0@redhat.com>
Date: Thu, 19 Sep 2019 19:00:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919165632.GA5821@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 6:56 PM, Cleber Rosa wrote:
> On Wed, Sep 18, 2019 at 09:14:58PM -0400, Cleber Rosa wrote:
>> On Wed, Sep 18, 2019 at 05:16:54PM +1000, David Gibson wrote:
>>> Hi,
>>>
>>> I'm finding make check-acceptance is currently useless for me as a
>>> pre-pull test, because a bunch of the tests are not at all reliable.
>>> There are a bunch which I'm still investigating, but for now I'm
>>> looking at the MIPS Malta SSH tests.
>>>
>>> There seem to be at least two problems here.  First, the test includes
>>> a download of a pretty big guest disk image.  This can easily exhaust
>>> the 2m30 timeout on its own.
>>>
>>
>> You're correct that successes and failures on those tests depend
>> largely on bandwith.  On a shared environment I used for tests
>> the download of those images take roughly 400 seconds, resulting
>> in failures.  On my own machine, around 60, and the tests pass.
>>
>> There's a conceptual and conflicting problem in that the environment
>> for tests to run should be prepared beforehand.  The conflicting
>> solutions can be:
>>
>>  * extensive bootstrapping of the test execution environment, such
>>    as the installation of guests from ISOs or installation trees, or
>>    the download of "default" images wether the tests will use it or
>>    not (this is what Avocado-VT does/requires)
>>
>>  * keeping test assets in the tree (Avocado allows this if you have
>>    a your_test.py.data/ directory), but it's not practical for large
>>    files or files that can't or shouldn't be redistributed
>>
>>> Even without the timeout, it makes the test really slow, even on
>>> repeated runs.  Is there some way we can make the image download part
>>> of "building" the tests rather than actually running the testsuite, so
>>> that a) the test themselves go faster and b) we don't include the
>>> download in the test timeout - obviously the download speed is hugely
>>> dependent on factors that aren't really related to what we're testing
>>> here.
>>>
>>
>> On Avocado version 72.0 we attempted to minimize the isse by
>> implementing a "vmimage" command.  So, if you expect to use Fedora 30
>> aarch64 images, you could run before your tests:
>>
>>  $ avocado vmimage get --distro fedora --distro-version 30 --arch aarch64
>>
>> And to list the images on your cache:
>>
>>  $ avocado vmimage list
>>
>> Unfortunately, this test doesn't use the vmimage API.  Actually that
>> is fine because not all test assets map nicely to the vmimage goal,
>> and should keep using the more generic (and lower level) fetch_asset().
>>
>> We're now working on various "asset fetcher" improvements that should
>> allow us to check/cache all assets before a test is executed.  Also,
>> we're adding a mode in which the "fetch_asset()" API will default to
>> cancel (aka SKIP) a test if the asset could not be downloaded.
>>
>> If you're interested in the card we're using to track that new feature:
>>
>>   https://trello.com/c/T3SC1sZs/1521-implement-fetch-assets-command-line-parameter
>>
>> Another possibility that we've prototyped, and we'll be working on
>> further, is to make a specific part of the "test" code execution
>> (really a pre-test phase) to be executed without a timeout and even be
>> tried a number of times before bailing out and skipping the test.
>>
>>> In the meantime, I tried hacking it by just increasing the timeout to
>>> 10m.  That got several of the tests working for me, but one still
>>> failed.  Specifically 'LinuxSSH.test_mips_malta32eb_kernel3_2_0' still
>>> timed out for me, but now after booting the guest, rather than during
>>> the image download.  Looking at the avocado log file I'm seeing a
>>> bunch of soft lockup messages from the guest console, AFAICT.  So it
>>> looks like we have a real bug here, which I suspect has been
>>> overlooked precisely because the download problems mean this test
>>> isn't reliable.
>>>
>>
>> I've schedulled a 100 executions of `make check-acceptance` builds, with
>> the linux_ssh_mips_malta.py tests having a 1500 seconds timeout.  The
>> very first execution already brought interesting results:
>>
>>  ...
>>  (15/39) /home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta32eb_kernel3_2_0: PASS (198.38 s)
>>  (16/39) /home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64el_kernel3_2_0: FAIL: Failure message found in console: Oops (22.83 s)
>>
>> I'll let you know about my full results.  This should also serve as a
>> starting point to a discussion about the reliability of other tests,
>> as you mentioned before.
> 
> Out of the 100 executions on a ppc64le host, the results that contain
> failures and errors:
> 
> 15-/home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta32eb_kernel3_2_0
>   - PASS: 92
>   - INTERRUPTED: 4
>   - FAIL: 4
> 16-/home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64el_kernel3_2_0
>   - PASS: 95
>   - FAIL: 5
> 
> FAIL means that self.fail() was called, which means 'Oops' was found
> in the console.  INTERRUPTED here means that the test timeout kicked
> in, and I can back David's statements about soft lockups.
> 
> Let me know if anyone wants access to the full logs/results.

Can you check if the FAIL case are this bug please?

https://bugs.launchpad.net/qemu/+bug/1833661

Thanks,

Phil.

