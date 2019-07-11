Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A1C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 07:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0B121019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 07:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0B121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlToo-0005cZ-6I
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 03:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlToK-0005CN-Bs
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 03:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlToJ-0007Un-7x
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 03:48:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlToJ-0007T4-0s
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 03:48:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so6332390wmd.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 00:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A3Etdi5nPKQWgNN3kQA4KRfVFUZLkNVqiDdxffRi8mE=;
 b=PKK6YiFHNvfhPPJNOM8QJQuuThMj4aZgto9agDkoCBpKZpRUUUlEbRAxsRKRjeInbz
 1RquM2H7wIoDgmYlI9udBIvwkSJgmWwO0hNnwjFjo42FFRFDxOzOk2k+RtUNG3/Z9QU7
 Sgp1BkSlTYSpj99l1AuN3YK0PNqhmQgjK0bGSeQ+a774sS5wsS+fSFN74GwnkQ5GcZiw
 wkhHgJwaN6UTQ6nKVLbt49atogFS7ow93IuXmiZzX5cuKsYiZnHtt43hfjM4cexGTpBd
 rZRIp34NDFS7KpSheFNEpfuyrz1qmMf+P0/SXHXaAWQKvqh4KGHKr5LRTMZp65Vae4mw
 +VWQ==
X-Gm-Message-State: APjAAAW2cuMC+H6gfSH1SzQSR7D8d/orFYJZdMOGb9JKYy53YfwX6UDy
 GdQwwMbxIzoxPPOCCKDOY9OWDA==
X-Google-Smtp-Source: APXvYqy24a4SjsGvHKMFPcgttVoejFlHdzdXqYKnP6bbcAHv84uvtxrb2v9DkJecvuXaw35WuNjrAw==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr2557786wms.8.1562831289381;
 Thu, 11 Jul 2019 00:48:09 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id h8sm4274600wmf.12.2019.07.11.00.48.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 00:48:08 -0700 (PDT)
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190710220153.GA10826@roeck-us.net>
 <20190711010742.GA810@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dc31e591-3b22-8626-10b2-48597f56ee0a@redhat.com>
Date: Thu, 11 Jul 2019 09:48:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711010742.GA810@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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

Hi Guenter,

Cc'ing Markus/Dan/Alex

On 7/11/19 3:07 AM, Guenter Roeck wrote:
> On Wed, Jul 10, 2019 at 03:01:53PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> when trying to run "make -j30 install" from a clean tree on v4.1.0-rc0, I get
>> _lots_ of undefined symbol errors.
>>
>> If I run "make -j30" followed by "make -j30 install", make succeeds, but then
>> I get linker errors such as the following when running "make -j30 install".

Seems similar to this report:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01860.html

>>
>> /usr/bin/ld: final link failed: File truncated
>> /usr/bin/ld: BFD (GNU Binutils for Ubuntu) 2.26.1 internal error,
>> 	aborting at ../../bfd/merge.c:905 in _bfd_merged_section_offset

This seems new, what is your host?

"File truncated" reminds me out-of-space issues.

FWIW sometimes I'm having some weird issue when calling "make
check-tcg". Docker is used to build target binaries, but apparently it
tries to compile some host object instead and fails, but I don't reach
the linking.
Just to clear this out, do you see any docker started?

>>
>> Running "make -j30" followed by "make install" succeeds.
>>
> 
> Correction: This doesn't always work either. Sometimes I still get a linker
> error. If that happens, another round of "make; make install" succeeds.
> 
> Guenter
> 
>> This looks like "make install" may have bad dependencies. Has anyone else
>> experienced this problem ?
>>
>> Thanks,
>> Guenter
> 

