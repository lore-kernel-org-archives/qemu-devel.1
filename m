Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F86CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C00C206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C00C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYoY-0001tE-Ix
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIYjG-0005L4-FG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIYjF-0006bI-3a
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:43:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIYjE-0006aa-Qx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:43:41 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B18293CA03
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 13:43:39 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id g67so1797960wmg.4
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 06:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q2fRCbwTFySOnCK3JiOVij95RQS5p6saSe3jyZO1Srw=;
 b=cFKw2dsBjmQ9BGQeZZ4HoDkw5Kn/ZJhlJ0+by4mWqjOidoZ4rDOwF96JiDZYipoNbW
 t47v78GV3VcJv8T3N/FiR9btYpx5groSDOhwhW4axZc8HDiRO+eIXwi5eFiA9EAuPaNY
 bHsqm7EVPCC1WSno2iKjyYpukt09FEOoSWxwKD3dKCeK63gIdbh2m34b02IN3F7okSwD
 IbKEvaPatLvQ6g1waZ1/SGPoNOakvTJGkvg57BsTf0Y+W5xQsjQMddkrMoLuSvPR9xU8
 VkYqTUYP5oKDX0qKsFd7QXICXYEeTi0gsZISVqr8ClVvUjC91pevivpGW9GxEAE3NRqk
 bKfA==
X-Gm-Message-State: APjAAAXlMiRIZWAVRg0/HGm3owwnO6Y6MMkSV81axWWD9KZUkg2ff273
 5oqKUoimFGBzamdx8gq/bhqcxFIdSQkuyjQyzZTTveby/KoBLBu7ymrt7mCP8IJhkyGL6fLtERc
 s5eANEBKfBYzAzWY=
X-Received: by 2002:a5d:4302:: with SMTP id h2mr9061145wrq.35.1570715018463;
 Thu, 10 Oct 2019 06:43:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyphqiezS7CZW6yRExGo180HhTTpCFevCRLPdLi2ZJPPkNkEcZR2YJj+f93dTSnIj8ARzaUaA==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr9061100wrq.35.1570715018125;
 Thu, 10 Oct 2019 06:43:38 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id s10sm9456944wmf.48.2019.10.10.06.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 06:43:37 -0700 (PDT)
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
 <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
 <20191008214907.GA28137@localhost.localdomain>
 <CAFEAcA9DzeObmtsc2VJmw=1yruANZ6ajY2SG0cAPdehkeRN3wA@mail.gmail.com>
 <20191009190743.GA6019@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d2011e56-8c5f-9f57-04eb-16581866fd48@redhat.com>
Date: Thu, 10 Oct 2019 15:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009190743.GA6019@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Evgeny Voevodin <e.voevodin@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Sven Schnelle <svens@stackframe.org>,
 Helge Deller <deller@gmx.de>, Markus Armbruster <armbru@redhat.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Maksim Kozlov <m.kozlov@samsung.com>, Guenter Roeck <linux@roeck-us.net>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Basse?= <contact@fredericb.info>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 9:07 PM, Cleber Rosa wrote:
> On Wed, Oct 09, 2019 at 02:38:02PM +0100, Peter Maydell wrote:
>> On Tue, 8 Oct 2019 at 22:49, Cleber Rosa <crosa@redhat.com> wrote:
>>> On Mon, Oct 07, 2019 at 05:28:49PM +0100, Peter Maydell wrote:
 >>>
 >>>> Do our other acceptance tests download random third-party
 >>>> (ie "not a well-known distro") binaries for the tests ?
 >>>> It seems a bit hazardous for reproducability and trustability
 >>>> reasons...
[...]
>>> I find it hard to judge precisely how much of a third-party some of
>>> these are.  I remember Philippe mentioning that one of them, I guess
>>> the images used on linux_ssh_mips_malta.py, were "as official as it
>>> gets" (my words, from my often misleading memory).
>>>
>>> Reproducibility is definitely an issue, in the sense given that some
>>> of these can indeed go away, but as long as they're available the hash
>>> recorded in the test should guarantee that we're running the same
>>> images.

So this thread is a follow up on:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg546430.html

For Open Source software I can understand we want to be able to rebuild 
them, and should provide a link about how to rebuild.

I don't want to rebuild images myself, I want to focus on testing QEMU. 
I tried once to build a MIPSsim kernel and it was a total nightmare:
https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04071.html
(Thomas Huth eventually succeeded using buildroot).

>>> Do you think we should do something different here?
>>
>> I'm not sure, which is why I asked whether this new test
>> was in line with what we've done previously. Since these
>> are just test cases and we don't redistribute them to
>> other people there's less of a traceability/reproducibility
>> worry, and if we check hashes on download that cuts off
>> a lot of "fail to notice if the image changes for some
>> reason" possible problems.
> 
> Yep, because I have no clue how to do improve on this (redistributing
> the binaries is definitely not on the improvement side, and neither
> is not testing some machine types), the current approach seems good.

QEMU machines are not restricted to running Linux or other Open Source 
software. It seems important to be able to test for regressions with 
closed-source code too, because it usually has been well tested on real 
hardware.

I just posted a firmware test:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg651012.html

I could find it stored compressed and uuencoded on the Wayback Machine.
Since I don't want to abuse from this amazing service, and other script 
to decode/uncompress it, I stored it on a new repository with its SHA-1
(the default hash used by Avocado):
https://github.com/philmd/qemu-testing-blob/tree/master/hppa/hp9000/712

Is this acceptable? Incorrect?

Regarding Avocado tests, maybe we can simply add a "untrusted" or 
"closedsource" tag, so people willing to test untrusted binaries could 
still run the tests using 'avocado --tag untrusted_software', and we 
could skip these tests by default.

I am very interested because I already experimented with:

- AIX on PReP/40p
- some RTOS on Canon PowerShot A1100
- VxWorks on MIPS and SPARC
- closed-source bootloader for Raspi3/4

Regards,

Phil.

