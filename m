Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33994C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0263D20665
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0263D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcji0-0005o7-1H
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 00:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcjhK-0005HP-4O
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcjhI-0000AH-DA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:56:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcjhI-00008m-51
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:56:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so3583838wmd.1
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 21:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XEuSVIiKp5ZDIQnYr1zZzvPLWP0SR6EhhPmoQrCO1nk=;
 b=OhlesWro4fBk2ipB3oeVieGtV4ufjyQy8vE4qMazQezKlXqTncySozr/T6Jd8fQldp
 +XxxCyCNcS6G93HGejmYdFbuoQ1dA71MXtgrWFTdvWWzoYf+qLmJO2BvivBBwac5fhAq
 ixEDnY9Z+d73paKZvfsuMjJj8ixJqJ4PtkxsDtUWm8CVzyiToljN5r1z7j+//tsYv6Ma
 1MfpRA2g5O9T0aiRoojdnRHPfc7Z9IFps9Dh7aAcKMvsogErD50gAJ+1qGvnq0Qi3JVc
 xQWCp8OSX87wa6b1F6tl0oRjzG0ehxpEa9m98Xa/Wus3zxbIxBpIQfWmIP22nJvzr+Z5
 PCQQ==
X-Gm-Message-State: APjAAAX02f0h0/fmW3XCPox98tuNeU97nZULNRGePqeEQ3hERCPDHGEP
 g0ZiNZks1ghmU4LBybqV0xFH2w==
X-Google-Smtp-Source: APXvYqxFOnj/+p5MjuLydrk0NkKZVArxvz6839v+1OtF9GKoaqTPk9FjgASkdwJS+X6JKMcrYzFnng==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr16525347wmk.55.1560747405109; 
 Sun, 16 Jun 2019 21:56:45 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id q15sm7614884wrr.19.2019.06.16.21.56.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 21:56:44 -0700 (PDT)
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20190613050937.124903-1-aik@ozlabs.ru>
 <35361394-42ba-dcf0-6fe2-5a0a538d1440@redhat.com>
 <d20e26db-7157-d9bd-c707-d7f4443396c0@ozlabs.ru>
 <20190614093306.GG10957@stefanha-x1.localdomain>
 <33c70ea6-08d7-d4ba-210b-328ea275cfe5@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fa361ec0-c734-567a-d617-6613b6e89f78@redhat.com>
Date: Mon, 17 Jun 2019 06:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <33c70ea6-08d7-d4ba-210b-328ea275cfe5@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 3:25 AM, Alexey Kardashevskiy wrote:
> On 14/06/2019 19:33, Stefan Hajnoczi wrote:
>> On Fri, Jun 14, 2019 at 10:13:04AM +1000, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 13/06/2019 23:08, Philippe Mathieu-Daudé wrote:
>>>> Hi Alexey,
>>>>
>>>> On 6/13/19 7:09 AM, Alexey Kardashevskiy wrote:
>>>>> This adds a trace point which prints every loaded image. This includes
>>>>> bios/firmware/kernel/initradmdisk/pcirom.
>>>>>
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>> ---
>>>>>
>>>>> The example for a pseries guest:
>>>>>
>>>>> loader_write_rom slof.bin: @0x0 size=0xe22e0 ROM=0
>>>>> loader_write_rom phdr #0: /home/aik/t/vml4120le: @0x400000 size=0x13df000 ROM=0
>>>>> loader_write_rom /home/aik/t/le.cpio: @0x1ad0000 size=0x9463a00 ROM=0
>>>>
>>>> I find the "ROM=0" part confuse, maybe you can change to "ROM:false".
>>>
>>> How? I mean I can do that in the code as rom->isrom?"true":"false" and
>>> make trace point accept "%s" but it is quite ugly and others seem to
>>> just use %d for bool.
>>
>> Yes, %d is the convention for bool.  Perhaps you can name it "is_rom"
>> instead of "ROM".  That way the name communicates that this is a boolean
>> value.
> 
> It is quite obvious though that it is boolean even as "ROM" (what else
> can that be realistically?) and there does not seem to be a convention
> about xxx:N vs is_xxx:N. And personally I find longer lines worse for
> limited width screens (I run multiple qemus in tiled tmux). Whose tree
> is this going to? Let's ask that person :)

Personally I find 'is_rom' clearer. I read 2 addresses, then my first
reaction was to parse it as another address. But it is also true we now
enforce traced hex values with '0x' prefix, so your 'ROM' is unlikely an
address. Tiled tmux is an acceptable argument. Anyway you already got my
R-b.

Tree: the PPC tree is likely to get it merged quicker than the MISC tree.

Regards,

Phil.

