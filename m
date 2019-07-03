Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20645C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE6A21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE6A21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibnC-000471-6Y
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56671)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hib8w-00016G-CG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hib8k-0000UC-5y
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:01:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hib8Z-0008To-LX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:01:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id b2so594334wrx.11
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 02:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SGe7susGi1OXjP+I2Z+yKcn0I9rskIm4uZtR3zrrv2U=;
 b=qIOF6vELKovgr0KeI6yHko4RPRB7HbQCNgU3/0dJxpc59kIAEkOs7NCirBSwnq1hvv
 Q4D+zev6oIYHy3/pgDgjN1eXXi3JLIX1kx0TqOc59ytiAHgJ8crGcj6Gnigf/otDHGGp
 gQU1H+JQGk5I9T6vXKBLsCzF4yTMy5hbYFnl23uYYI71YLtM6hiweb1ozxK/vpYac11o
 zTFoXKIrGs03twsdNfXdEnc7Xne3do5NRGavn/Bsj5jBpWvTq39cJxBXmmY0osatg9c5
 hmsDt/FKmrHMX0v0BBHEo6JMQAcNNEQ3ksEQUU3crtDDFLuTHbGssqsHzaN+C2YASo7b
 TjHQ==
X-Gm-Message-State: APjAAAVHfnQuKxk+prlJxD7DbB1J2GTsiyNsOnaLYZ7TOeEKmVRMM63t
 fAHmPrEegO2lQHYfoU1Bd6H9tg==
X-Google-Smtp-Source: APXvYqx4jee0ulTfHQIlGao0rbVo5z4V+Rwq06EltZ+H1mOF81dVyvcvAN6pWzHF8e4gcW9bopInyA==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr27993316wrs.77.1562144467723; 
 Wed, 03 Jul 2019 02:01:07 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id b2sm1857433wrp.72.2019.07.03.02.01.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 02:01:07 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <156208710846.15457.11521609447031896814@c4a48874b076>
 <3321812b-d7c9-d69d-a0af-8bb1da04e057@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b568ec34-231e-1328-c62e-8931fd3fa03c@redhat.com>
Date: Wed, 3 Jul 2019 11:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3321812b-d7c9-d69d-a0af-8bb1da04e057@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, amit@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 8:05 PM, Laurent Vivier wrote:
> Le 02/07/2019 à 19:05, no-reply@patchew.org a écrit :
>> Patchew URL: https://patchew.org/QEMU/20190702123713.14396-1-laurent@vivier.eu/
> ...
>> PASS 2 qmp-test /x86_64/qmp/oob
>> PASS 3 qmp-test /x86_64/qmp/preconfig
>> PASS 4 qmp-test /x86_64/qmp/missing-any-arg
>> ---
>> PASS 5 device-introspect-test /x86_64/device/introspect/abstract-interfaces
>>
>> =================================================================
>> ==10595==ERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 32 byte(s) in 1 object(s) allocated from:
>>     #0 0x55b80fde5b1e in calloc (/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64+0x19f4b1e)
> 
> I don't see how this series can introduce a memory leak... all changes
> are trivial and there is no memory allocation added.
> 
> So I guess it's a false positive. Any idea?

Unrelated to your series, this commit:

commit c82c7336de58876862e6b4dccbda29e9240fd388
Author: BALATON Zoltan <balaton@eik.bme.hu>
Date:   Thu Jun 20 12:55:23 2019 +0200

    ati-vga: Implement DDC and EDID info from monitor

added a call to bitbang_i2c_init() which has some leak.
It was here since 3cd035d863 "GPIO I2C rework" introduced 'Fri Nov 20
23:37:15 2009', but since then the device-introspect test never run a
machine using this device.

Peter sent a fix for this earlier this morning:
"hw/i2c/bitbang_i2c: Use in-place rather than malloc'd
bitbang_i2c_interface struct"

>> ---
>>
>> SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).
>> /tmp/qemu-test/src/tests/libqtest.c:137: kill_qemu() tried to terminate QEMU process but encountered exit status 1
>> ERROR - too few tests run (expected 6, got 5)
>> make: *** [/tmp/qemu-test/src/tests/Makefile.include:894: check-qtest-x86_64] Error 1
>> make: *** Waiting for unfinished jobs....
>> Traceback (most recent call last):
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20190702123713.14396-1-laurent@vivier.eu/testing.asan/?type=message.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
>>
> 
> 

