Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0AC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7021C20736
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7021C20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQcan-0005SX-Hw
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 16:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQca4-0004y1-6x
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQca3-0000BL-I5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:59:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jQca2-0008WJ-SA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:59:47 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McGtA-1inyRK3DA4-00clAI; Mon, 20 Apr 2020 21:59:38 +0200
To: KONRAD Frederic <frederic.konrad@adacore.com>
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
 <429d6d9c-fff7-d64d-3dfb-917d1985ec90@vivier.eu>
 <268c0a26-9ed2-4812-a985-1321e35eb00a@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
Message-ID: <14d2e9b5-e712-5adb-6715-3f9dba921028@vivier.eu>
Date: Mon, 20 Apr 2020 21:59:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <268c0a26-9ed2-4812-a985-1321e35eb00a@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GZSf42TxUUAQ5FSu3NUbjZVOdB3Ij8WJn2p7QI6kADEJClHm8Ye
 uhIwnsAaBq7oiAwUdJobfozuVm5H56U1gY24/19fSLXWT7D2Y+ckMrdWVndnkTsX+zxy3A+
 vHprWCxFYmyzOYUmg8RO42Au4Z7RMB4ci9RNFywe6M69LKL1dCpRDUbKaU6t6sIkBZwkJTA
 3CiUrz3ugXlu5zvZd/ILQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0hM4SujqvMk=:gaIS8uqsqJ6U01LC5JUIRM
 /XWA7eOo6n7x892uY0ERKoPHDCK9/DwY6I7aVIdGWtvfuYrx8rKNB7XNgbYoZFgV51WU5fP+s
 IogRN6UdnMdP7BnNBNLNmPWuubMYM1brbNyCuavbM0byjWtPsAz7TqgklL9vFQf7rRWmTid6T
 andTKJd/PCxgwUs8EnY41h5XqUt1VPO/hYvs67/YqqjuoM7dF8q+9MVzyZp8pMxLn7rRU67xS
 aXs74HcLqzXVRK/c++Py48uRAN0RPlwXofuQELVd7elPo+rArO/V4+SVYNQL6hXhnSwxvDkd/
 kFVKXGkBLyiautLXXujVRxsh3vMmLCLn2soHdFZzNw5sKbmcxaS8RSIjfapa2NhCiyaleRtWK
 lwdoZ7+OtoLjyqYFK5hg9CbcvqR+D/2GIXaRU24HCx1yJDJJFyamuCb+PVbRFWtrDPeMFTPwL
 QltnLQtY8GnCVuXy1UAYv9rMwyHYYs0saix12ofS9s7bdvCJRtJ8F1Ry9zq17IronAEHnCKq+
 +SGIHhuWrtSVw2wa1ROnHw6UF0j8zqfAvuZ3VskLU9Ifw7s9bQwCntu2aOgMVeIj8HuyRZje9
 bc0zByj0IjZ9fEkfCiqWTLAH+KDeB+weOVJhhv/sWObC29PAAI67DjXZZaDZDtfaBQe2GMMn8
 zNFiXhh+u7e9bp+xAMj+zKzi5fR2s7LfXvbRujqjo+K5OOkuh76kVXElsZLETQE56Pup0Iiid
 SXkRTJs2Jx3x5it/H0BVkvCkk6QHbHcXdsRxrwXmFJA3F2YKYJWBx4uNY5TFr4ErNuWJ5ElYv
 90X4ZPhlQoqYp45/nRYPYPosnCXcOcO7ve5LFfWHE1I2Wo/2q+vI5hzj/Nx0mki3P1CIPeF
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 15:59:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.126.187
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
Cc: huth@tuxfamily.org, alex.bennee@linaro.org, f4bug@amsat.org,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pierre@freepascal.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/04/2020 à 21:08, KONRAD Frederic a écrit :
> 
> 
> Le 4/20/20 à 5:46 PM, Laurent Vivier a écrit :
>> Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
>>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>>
>>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor. 
>>> Thing is
>>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then
>>> expects
>>> a coldfire FPU instead of the default m68881 FPU.
>>
>>
>> I checked in gdb sources and there is no cf definition.
>>
>> Moreover if I change only the cf to m68k in QEMU it seems to work in
>> both cases:
>>
>> diff --git a/gdb-xml/cf-core.xml b/gdb-xml/cf-core.xml
>> index b90af3042c..5b092d26de 100644
>> --- a/gdb-xml/cf-core.xml
>> +++ b/gdb-xml/cf-core.xml
>> @@ -5,7 +5,7 @@
>>        are permitted in any medium without royalty provided the copyright
>>        notice and this notice are preserved.  -->
>>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> -<feature name="org.gnu.gdb.coldfire.core">
>> +<feature name="org.gnu.gdb.m68k.core">
>>     <reg name="d0" bitsize="32"/>
>>     <reg name="d1" bitsize="32"/>
>>     <reg name="d2" bitsize="32"/>
> 
> Doesn't that break gdb with coldfire?

No, it seems to work, but I didn't test this really carefully.

So perhaps we can only change the feature name in the two existing xml
files and it will work for all the cases? (and renaming cf-core.xml to
m68k-core.xml).

The core files are the same for cf and m68k, so according to the sample
code you show, if it finds "org.gnu.gdb.m68k.core" if will use for both.

I think the only bug we have is the feature name is not good in
m68k-fp.xml, and fixing that should be enough.

Thanks,
Laurent


