Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBB02077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2GP0uxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBB02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiZ9-0005GF-P7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuhMG-0008K2-D7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuhMC-0003sj-KP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:37:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21218
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuhMC-0003sI-GZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579804651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wYETtubdMkhSXWZ61HdTf21VDFypri2RTf9txI0mFw=;
 b=X2GP0uxpXZHpSByhV8jh7oIKsBaiazECmSRDS4EkXmuL8emLIOkbSTCnkFM1sa+F7tlaKq
 w+hciehnHWe8Z2k99JL4bfpVkHzYP1jmyOYKZa6tQ5au8s0TQf91dccuSnltFi5SwFyd45
 u+dRBhUUmxh03ZDsEXiUlc8q+dbWXag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-TGCj0jxqN0WpCSGUd334dA-1; Thu, 23 Jan 2020 13:37:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so2364833wrw.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rUqhRHPuwgmjAQhU/HcCDGSPjQxYNYnQ4sksW2u9Lo8=;
 b=e6knvbEmtxnWwNll3OUNnjyejWcWfU/HfXXCKuI2Nu3ShsCsfBc9D1V4o5UbfDzWTs
 DLTKIixLVVRUNUidmNzoSJ03HLnuQO3kBeflnyf7dTUMJ+H7MiK4ODYT8mA6Op/B1YPs
 U9/cZOTUpUhX2sBLOIBDRvrC1kpSE+/J2WisnZqN6s5xWt08Z2MaAe8UKxuCxjP1LGT8
 3j9b76jxeArN4m5GPxAgSPNeGgMoSjGzbxgS8ElN1MqYWr1DWkbPcbWM0dWsg7nperY8
 u0iQKORSQxrQ2DR1UhSp9apuymf5mF/tnpWEQ+RjHFXdNHXUP2BZhOE030VJ+EY0R3vx
 Rsgg==
X-Gm-Message-State: APjAAAULXCDQLKmTEiplUODazBxbtqWBQtQRbbJTEiZ/QSjkbSM46p6F
 j3k5gof7WPB20XFck5qFkAq9kM+3oM0/95kO7JkDGw0gi30dvUcgBnTxhM/ZYKfPi2qBBcVfwnw
 VkcubDEMbwVZcYz4=
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr19974739wrk.53.1579804648380; 
 Thu, 23 Jan 2020 10:37:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbiFsYjaqyesMA2cDrF2yKRX8Ux58Virl4iyo3H6PAlPFFHAgHwBHF2abGKcUQ4wt/pgtHBQ==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr19974714wrk.53.1579804648103; 
 Thu, 23 Jan 2020 10:37:28 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x7sm3981468wrq.41.2020.01.23.10.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 10:37:27 -0800 (PST)
Subject: Re: [PATCH] tests/boot-serial-test: Allow the HPPA machine to shudown
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200123003603.11610-1-f4bug@amsat.org>
 <15bada61-7e0c-bb4d-a91e-2cdfd42161e1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bcba70e2-9702-c080-1025-ad22fd344801@redhat.com>
Date: Thu, 23 Jan 2020 19:37:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <15bada61-7e0c-bb4d-a91e-2cdfd42161e1@linaro.org>
Content-Language: en-US
X-MC-Unique: TGCj0jxqN0WpCSGUd334dA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 4:27 AM, Richard Henderson wrote:
> On 1/22/20 2:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> The boot-serial test uses SeaBIOS on HPPA, and expects to read the
>> "SeaBIOS wants SYSTEM HALT" string, see [*]:
>>
>>   122 void __VISIBLE __noreturn hlt(void)
>>   123 {
>>   124     if (pdc_debug)
>>   125         printf("HALT initiated from %p\n",  __builtin_return_addre=
ss(0));
>>   126     printf("SeaBIOS wants SYSTEM HALT.\n\n");
>>   127     asm volatile("\t.word 0xfffdead0": : :"memory");
>>   128     while (1);
>>   129 }
>>
>> A 'SYSTEM HALT' would really halts the CPU, but SeaBIOS implements
>> it as an infinite loop.
>=20
> Well, SeaBIOS implements it as the magic QEMU halt instruction,
>=20
> # These are artificial instructions used by QEMU firmware.
> # They are allocated from the unassigned instruction space.
> halt            1111 1111 1111 1101 1110 1010 1101 0000
> reset           1111 1111 1111 1101 1110 1010 1101 0001
>=20
> followed by an infinite loop, probably to avoid a compiler warning and Ju=
st In
> Case.  We really should halt here, unless shutdown is disabled.
>=20
>> -    qts =3D qtest_initf("%s %s -M %s -no-shutdown "
>> +    qts =3D qtest_initf("%s %s -M %s %s "
>>                         "-chardev file,id=3Dserial0,path=3D%s "
>>                         "-serial chardev:serial0 -accel tcg -accel kvm %=
s",
>>                         codeparam, code ? codetmp : "", test->machine,
>> +                      shutdown ? "" : "-no-shutdown",
>>                         serialtmp, test->extra);
>=20
> And thus avoiding the -no-shutdown should in fact shutdown.
>=20
> Are you saying this doesn't happen, or what?  I think I got lost with the=
 rest
> of the message...

"If the command-line option "-no-shutdown" has been specified,
  qemu will not exit, and a STOP event will eventually follow
  the SHUTDOWN event"

What I see is the HPPA firmware calling HALT, then QEMU doesn't exit.

The QTest keeps reading the console for "SeaBIOS wants SYSTEM HALT.".
When this string is displayed on the graphic output instead of the=20
serial, the QTest keep reading indefinitely, and the test never=20
succeeds/fails, it is just stuck.


