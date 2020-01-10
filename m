Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA8C33CA4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0C4205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra/8oVos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0C4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq0xI-00077K-JC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 15:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iq0wU-0006ak-SD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iq0wT-00068P-G8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:31:38 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:42075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iq0wP-0005o6-LL; Fri, 10 Jan 2020 15:31:33 -0500
Received: by mail-qv1-xf44.google.com with SMTP id dc14so1360686qvb.9;
 Fri, 10 Jan 2020 12:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eGXCRTGnFL6fJsIyIFnWxZoErJiBbTfeTCFeN/GBl+I=;
 b=Ra/8oVosrlfE8zeLDGPnLPfBJEbx+KYtzdgEwKfluOCI0bWPam3BiHMq8dn+MK0QQs
 q1y1NwyzhMjp7xFyZ+EcsuZRzabMH+nvYIJrrIuMd0KiwWRi3tdOrvq7KfU/BKhyaqrE
 WXxJZhF9hBwvvVrDqwc5odLwTJuQvokNPbVV28FLOy3YZ5o+hyZaIW0d0hO1jvnVDRaE
 5uh8u+eKPhbIXkXSBMVw3657cqBkmtKN8zk+/SM6Yq0pTv7ARwQF697EOGeXrjT02aZe
 yuVjDzw4kZLM6sQakz56DXuw+TlaKhnMr95/YXEt5c3IULBZhhMgFKsk9/unJ4JRWUmo
 IkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eGXCRTGnFL6fJsIyIFnWxZoErJiBbTfeTCFeN/GBl+I=;
 b=q90rScE2Hi28zb1trpxXSpmAIonucv6FzyjVuzsyI8dIW9BnaL7zfceeGlK/VDQ7BX
 wTVkv2a0z5pmTCKZCFVELhB2tktkAZWxsj4WYNnNLv/JS+jcnJ2WmEyHeEb3CyJZE9DP
 yEjE7rM++F2ujmqzrL+4RGXYa6k8FmB+V18J3Qp7DyGyPES+m/AlPrQXN/DIV//mEe06
 3F8IWLXVjhsbqb2kWMpfFR4P4o+gYbm4qS3djcwnf2jvLvAVKA4t4E5nfWiiURpsDrE5
 bSxaAvhnAnzUF4lKcn/l2IUlEcbUCoiEH6Gzjt54+3PjMjDDEm2ezIq429k87j9TdG/P
 JUUA==
X-Gm-Message-State: APjAAAXunQ7MzSd8yrWPVImaGJxTqmE1CuUl0PPaw8CLke6xcm5TxF16
 674Pzi1WG8Vv83fhsx/Ipr4=
X-Google-Smtp-Source: APXvYqxgioCBpSJitlqGj/1nG+qdppuowdM+kcCwvZIMHwsCOC7eoZ3C38IXWKfefJvzaTnVjtYeIA==
X-Received: by 2002:a05:6214:1428:: with SMTP id
 o8mr475631qvx.87.1578688292253; 
 Fri, 10 Jan 2020 12:31:32 -0800 (PST)
Received: from ?IPv6:2804:431:c7c7:541e:7a5e:37ad:989b:4530?
 ([2804:431:c7c7:541e:7a5e:37ad:989b:4530])
 by smtp.gmail.com with ESMTPSA id g53sm1563679qtk.76.2020.01.10.12.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 12:31:31 -0800 (PST)
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <15cc13a7-4061-b4e8-fc0a-c0c8386cf969@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <ac804a97-6494-fa73-8cff-1dc861b4b2cf@gmail.com>
Date: Fri, 10 Jan 2020 17:31:24 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <15cc13a7-4061-b4e8-fc0a-c0c8386cf969@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/10/20 4:05 PM, Eric Blake wrote:
> On 1/6/20 12:23 PM, Daniel Henrique Barboza wrote:
>> Hello,
>>
>> This is the type of cleanup I've contributed to Libvirt
>> during the last year. Figured QEMU also deserves the same
>> care.
>>
>> The idea here is remove unneeded labels. By 'unneeded' I
>> mean labels that does nothing but a 'return' call. One
>> common case is something like this:
>>
>> if ()
>>      goto cleanup;
>> [...]
>>   cleanup:
>>      return 0;
>>
>> This code can be simplified to:
>>
>> if ()
>>      return 0;
>>
>>
> 
> How much of this work is done manually, and how much via Coccinelle?


I'm still getting along with Coccinelle. I'm able to do simple matches but
couldn't make it work to match this scenario. I didn't invest too much
time on it though.


> 
> 
>>   qga/commands-win32.c          | 17 ++++---
>>   target/mips/mips-semi.c       | 15 +++---
>>   target/unicore32/softmmu.c    | 23 +++-------
>>   util/aio-posix.c              |  3 +-
>>   util/module.c                 | 11 ++---
> 
> Hmm, no change to scripts/coccinelle, so presumably all manual :(

I used pcregrep:

$ pcregrep --exclude-dir=build --exclude-dir=docs --exclude-dir=scripts -r -n -M ':\n*\s*return' . > clean_labels

(note: there was a lot more of --exclude-dir in the original command, unfortunately I
didn't record it)

Then I filtered in the output file the cases where the regexp matched "switch"
labels and any other false positives like strings in comments. It's not manual
inspection, but it was crude indeed.



> 
> If we have a Coccinelle script that performs this transformation, we are more likely to be able to catch all places in the tree that would benefit (rather than relying on grep calls or other manual inspection), and more importantly, we can repeat the effort periodically to fix future additions that don't comply with the preferred style as well as backport the patch by rerunning the Coccinelle script with less worry of changed context.  Automated cleanups are always going to be easier to swallow (even if the diffstat is larger) than manual ad hoc cleanups.

I am not aware of how QEMU handles Coccinelle, if it is imposed via
./scripts/checkpatch.pl or something that it is ran from time to time to
suggest changes. But if it's desirable, I can see if I can cook a Coccinelle
script (or anything a bit more sophisticated than what I did)  to flag these
cases I attempted to handle with this series.


Thanks,


DHB


> 

