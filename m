Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95804C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3DF21537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk49O9cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3DF21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZDp-0001SX-Jw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hlZCi-0000L2-Iu
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hlZCg-0007kb-KH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:33:43 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hlZCg-0007jr-ET
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:33:42 -0400
Received: by mail-pl1-x644.google.com with SMTP id b7so3052232pls.6
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rYkDYN4ij96vK8jKlgewO3DDystLZkDCBhV99uXfH8o=;
 b=Qk49O9cKqaQWg540JyJRlBBK0VBQZ/T0AjU8m0ZnkzC1VCkSMgLyCBz4CSZ2gvUXd9
 Ho+nJ2CdsHqmBXJS45WVCPcduRxZ2C+QnOThVd+5X3WWxU0maI6G75mImZq+oOvVxPaH
 Ul/4HcrnxTvtWK77GQcfzcc69VKiGMFQ/tad3g6xe8AXFvC5dLm9Kujf/IfjcY185oG/
 yrWsn1TEwbIoIiS5cHSwYNECSawX2bP4XYS8TmE2JPX1dHWd1thct3JErhb/j3p5ylVS
 SCPEFbe68LgdoZtyrLcaZZy2ya+gZHi9nWK0N42qd84iNucMvznp05oi0ulMj+E/9g8e
 3fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rYkDYN4ij96vK8jKlgewO3DDystLZkDCBhV99uXfH8o=;
 b=CXVoWkL4ZoNG2R4DGrq/QH6qpsAAIgBycd1tpVmS/JfpALaSNUFpdFmzqYslaasMFC
 Q6tJdV9RI7dCUYBn8xeMOdug+ZSe3lSt+le+ht5quLTG+DdqFWIkxjPsTesxvxuAYB7l
 rqvklPMUjqBbZh911lX8XcnPpWfASC+6JrbHZnmS+wf9hXf7K6bI0EdqTW7ZNTPXUDSo
 pJrZ8dCKJePG592GeHXAnb9bOa+MK7FKJGQW6HJm8YXc8jX7UcdbUB+uig4P86Y/+oCQ
 MK5MmEcK9HbJXHtm14OAxmmghSOmEI8L+99ew2vB8vr2cvNC2IpcqYoUR0D5mZkCx1hn
 MUJw==
X-Gm-Message-State: APjAAAWBKn1cTouc9c1qaN/hRvwVFxL+eX56X/FeIXSmpir8w09zHcDE
 kLgrZ/kgfihdauxX117Admg=
X-Google-Smtp-Source: APXvYqzJ7TdBVw+24866eeeS0Ag0XW+bw20skumAp3uMxtLl3mTUP+e2B4YoO3/9ZD02nk4fezuIhw==
X-Received: by 2002:a17:902:b702:: with SMTP id
 d2mr4857940pls.259.1562852021441; 
 Thu, 11 Jul 2019 06:33:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 s15sm5484141pfd.183.2019.07.11.06.33.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 06:33:40 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190710220153.GA10826@roeck-us.net>
 <20190711010742.GA810@roeck-us.net>
 <dc31e591-3b22-8626-10b2-48597f56ee0a@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <11bd13d0-e5c0-76fc-2f75-e01588a9103b@roeck-us.net>
Date: Thu, 11 Jul 2019 06:33:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <dc31e591-3b22-8626-10b2-48597f56ee0a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] Problems building and installing qemu v4.1.0-rc1
 in single step
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 7/11/19 12:48 AM, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> Cc'ing Markus/Dan/Alex
> 
> On 7/11/19 3:07 AM, Guenter Roeck wrote:
>> On Wed, Jul 10, 2019 at 03:01:53PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> when trying to run "make -j30 install" from a clean tree on v4.1.0-rc0, I get
>>> _lots_ of undefined symbol errors.
>>>
>>> If I run "make -j30" followed by "make -j30 install", make succeeds, but then
>>> I get linker errors such as the following when running "make -j30 install".
> 
> Seems similar to this report:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01860.html
> 
Yes, that looks like the same problem.

Reverting the following commits fixes the problem for me.

8d358a5 Makefile: Fix "make clean" in "unconfigured" source directory
	(possibly for context to be able to revert the next patch)
1338a4b Makefile: Reuse all's recursion machinery for clean and install

>>>
>>> /usr/bin/ld: final link failed: File truncated
>>> /usr/bin/ld: BFD (GNU Binutils for Ubuntu) 2.26.1 internal error,
>>> 	aborting at ../../bfd/merge.c:905 in _bfd_merged_section_offset
> 
> This seems new, what is your host?
> 
> "File truncated" reminds me out-of-space issues.
> 
No, the affected file is really truncated (or empty). The file system has
some 200+ GB of free space on an NVME drive. The error message above is
a side effect. Host is Ubuntu 16.01 running gcc 7.4 with binutils 2.26.1;
CPU is Ryzen 2700X.

For sure, the internal linker error is a binutils problem, but that should
not distract from the real issue.

> FWIW sometimes I'm having some weird issue when calling "make
> check-tcg". Docker is used to build target binaries, but apparently it
> tries to compile some host object instead and fails, but I don't reach
> the linking.
> Just to clear this out, do you see any docker started?
> 

No, there is nothing virtual involved. Also, again, the problem is only seen
with "make -j X".

Guenter

>>>
>>> Running "make -j30" followed by "make install" succeeds.
>>>
>>
>> Correction: This doesn't always work either. Sometimes I still get a linker
>> error. If that happens, another round of "make; make install" succeeds.
>>
>> Guenter
>>
>>> This looks like "make install" may have bad dependencies. Has anyone else
>>> experienced this problem ?
>>>
>>> Thanks,
>>> Guenter
>>
> 


