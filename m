Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5419CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BD421872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BD421872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIMO-0002t2-BF
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNI5q-00062u-5P
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNI5n-0007ze-T9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:58:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNI5l-0007y6-Th; Wed, 23 Oct 2019 10:58:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MTR6K-1iZHbX2leG-00Thjr; Wed, 23 Oct 2019 16:58:23 +0200
Subject: Re: [PATCH 3/3] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
To: Eric Blake <eblake@redhat.com>, Frediano Ziglio <fziglio@redhat.com>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-3-fziglio@redhat.com>
 <5f20705e-60bc-08d5-8b6e-72438afabefe@vivier.eu>
 <c2836c58-5a3c-2356-6e94-9b2341ab2194@redhat.com>
 <1860840671.8198083.1571840126307.JavaMail.zimbra@redhat.com>
 <21fd3aa0-232c-06e8-1e20-b5c98f125468@redhat.com>
 <8b52c02c-1e26-4ac7-3f79-db4459f9c178@vivier.eu>
 <173d8641-ff6b-adc4-b0d4-f4dd5909f87c@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fbc49211-35f6-2b98-b21d-faad37ed8aea@vivier.eu>
Date: Wed, 23 Oct 2019 16:58:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <173d8641-ff6b-adc4-b0d4-f4dd5909f87c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1ThzeD0fXIluSylcZnTq3BtMqF+doyJAVa8fqc19LWfjC/ZIUq8
 8FbzeOppJEFCkxk1NrEUigxexQWikaZThBEIH80euqsu3I1aeE0Z0A3KZAIXgqfdzQic/6p
 lvrXTwcJvvYzrE1tyH9c8JZPLD8iR9zAX83h/2fr1mKMHHxlmVVzo418zW8GgpndUGfhyWy
 E6kOHvh++hKLKCkuyIVyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DxG/JVHJkQ=:fMyqK2o14IQ4pIDm8Qflfe
 XaOGvz1tolYyKU5FAHHCXvHZ87zVSmTvbKhIS26cw7xi2xpQtqHRMWfzlNN5BjDpqb/1Aloau
 tOt5f1n8jaadrWtiTLSl/84KgKOMB7MJ6rbh+wN9nTdKupH6/ItFXI1PQ0uPYFmMFPt4uu7f6
 TQssX3rxwLJS0eBOvFlcWPm1e/6BGnzX2kSr0XS4F5Zy9LGvSdlaA+FL28vA3MKnfQSiphQiT
 Q1/zgRQd220DBltmYU1mkDpGeO110LFiziRuCpEW0nzwU7zJ4p0xr6ly4Ng1g9ADt0+vuu1aI
 kgy9dfwztaZ96EIrX5PaY1ta7VDBXSI3iTQGr1Mwd4Nd1wG+ZMy6aB9hFyoppW5IxKVAYQRXn
 SXY+ROX0I2sOY14TMr1CbNmufITJB03rCwyGULO1kgKjnSnwFyHXS+oOFKjGXBNz9gDr8MxfJ
 UokrjCS/0IirDZ+aa5ny/3oIPxwhjfVVtgzrZQtLNjo5LpVWulraMLIfDFlfUpoK/jKud9wKL
 ZIrBSAM4t1T1e4WI/4yUTsZaHwDwsufisKQ2T31VJi9ehvmwlVbEt6e7ed9WlWo7cg8GB8GgV
 XyUZ6sX6o7e04YMq0MrLoU27WtWGoa6DVemxzWQDjy99i0GIPdC/p7Te2WvEcT0Zvqhwx9tID
 ixGSx/s+6sOUsrx91VvnoL8Y/UJ/W5v3bcPIB0FZbc5wZYnnC5dUiO0Y+4ysDBbHCsGbYO0WT
 +xEmR4ZS0V+sni8vYyywjv3w5Q7X1a2QRd5t8Nxb1foDhRYplRXIGcXs8pKd0/Ijy58Giyd/L
 L7hO7VmLgpw2d3z0U2QVFLnZA/aRfuvRk6geYntUwlzQtb593bc3ct64QqBesg+ot2yPfhJLT
 /GKdbpsUG8XeeagKBQmox6GDK1ubQNXf0T0xb914w=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/10/2019 à 16:51, Eric Blake a écrit :
> On 10/23/19 9:45 AM, Laurent Vivier wrote:
> 
>>> The C rules for ternary type promotion guarantee that the MIN macro
>>> produces the correct type without the cast ('cond ? int64_t : int32_t'
>>> produces int64_t).
>>
>> gdb seems to disagree with that:
>>
>> (gdb) whatis l
>> type = long long
>> (gdb) whatis i
>> type = int
>> (gdb) whatis 1 ? l : i
>> type = long long
>> (gdb) whatis 0 ? l : i
>> type = int
> 
> It looks like you've found a gdb bug.
> 
> C99 6.5.15 p5 states:
> "If both the second and third operands have arithmetic type, the result
> type that would be determined by the usual arithmetic conversions, were
> they applied to those two operands, is the type of the result."
> 
> and the usual arithmetic conversion of 'long long OP int' is 'long
> long', per 6.3.1.8.
> 

Ok, you're right [1]

Frediano, sorry for my misleading comment.

Thanks,
Laurent

[1] and gcc agrees:

int main(void)
{
        long long l;
        int i;
        typeof(0 ? l : i) f;
        typeof(1 ? l : i) t;
}

(gdb) whatis l
type = long long
(gdb) whatis i
type = int
(gdb) whatis f
type = long long
(gdb) whatis t
type = long long

