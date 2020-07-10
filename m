Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41177C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AB02065D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCpIefrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AB02065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtv1j-0004rI-BT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtv0l-0003cr-VB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:32:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtv0k-0005zk-CK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:32:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id b6so6373217wrs.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v6uWs2BBVXepd9ZQRwtZiYDuCwjB99VUDuVBdxE0IFw=;
 b=SCpIefrIqaf20yKbr4DvSQ0p0CHgl+DwFh2UbouYoGTlj1c8OCa5TfYQS+gyey2omu
 XANwL7FhM+LEIiJxCvTTIGT1Sz7ZLl1504+kgJPzPUyJ04gTqnFOU/LfGD+yRmuHO0j/
 ZdIxjbgLPoGPxFF8vS2cccyY/ki0LLGXQDE095tu6jD3gCoxLoJno1zeKZsPiBgA1bAm
 oWAxHbFJ3sjhett9XGn/Ym6SLaqFfck8F9a9emQHnw1aqiV+sSzQjAgZ3G8fxJkouYzQ
 If24h88IKlGaE9IADu7U1h071VWzFW4YMUOc7gSyR9VJoklBi4uRNfj+BMtmwhxj2FJd
 URSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=v6uWs2BBVXepd9ZQRwtZiYDuCwjB99VUDuVBdxE0IFw=;
 b=cmSSIaHZi+VMvibsX8OgJv8oIKdOwqsrMju/koKlhR4EOI4yWwiTaYFgzIluOYjclZ
 bZYotLsk+YobQQRozP7k4SsZDDkpd+ht7TXomOeSzABdKSk82NEGNNOqWxxtHEapKNSO
 z1FNZIA2i9U4HCov8Z7ulc8F1Qq4EwvRuJWEAVe6hK/RNLQ+/K1E/Eat2tAfyEEyVE5g
 CKYSXekTZmhLOEN2rx5H3afP6RxCqeCjVRMefiqrg6W04ZVDxkC0dVjlBVD+mfUXGa3F
 z+gLOqcKXvoKGQSK47y8SZJSOrAL+M+vPNi3Y6ArRN4JVNdI4QFLJt/2FMXjSqOm/e1P
 u/qg==
X-Gm-Message-State: AOAM5329QIKmQgORho0xFIm2lEM6isMatslAJuhIZm2xmesRTNmBa6LF
 yPDVl+tTaAHLB0XP5yoLZ9c=
X-Google-Smtp-Source: ABdhPJxNT3RBtC0bFikpR/OVP/NRjb/3S9XixVDzETMwsmImlIDOFsT/uuHszWhoOuiVHeE4yoEQ/Q==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr66866809wru.310.1594395145151; 
 Fri, 10 Jul 2020 08:32:25 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j15sm10465450wrx.69.2020.07.10.08.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 08:32:24 -0700 (PDT)
Subject: Re: [PULL 00/32] AVR port
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20200707181710.30950-1-f4bug@amsat.org>
 <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
 <47ca6b92-cedb-a6c4-754b-b7cd5da597e7@redhat.com>
 <CAFEAcA_wBT+Yfsn+DFZkcRxYWKmF04U2JHNVz5mNuXabeDcN5g@mail.gmail.com>
 <544208da-9dad-5fab-ab43-b2537a1f2f90@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <d2dd51b4-2f10-a33a-66be-6357c52d8564@amsat.org>
Date: Fri, 10 Jul 2020 17:32:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <544208da-9dad-5fab-ab43-b2537a1f2f90@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 5:17 PM, Philippe Mathieu-Daudé wrote:
> On 7/10/20 5:12 PM, Peter Maydell wrote:
>> On Fri, 10 Jul 2020 at 16:03, Thomas Huth <thuth@redhat.com> wrote:
>>> Endianess bug ... this should fix it:
>>>
>>> diff --git a/target/avr/helper.c b/target/avr/helper.c
>>> --- a/target/avr/helper.c
>>> +++ b/target/avr/helper.c
>>> @@ -337,6 +337,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data,
>>> uint32_t addr)
>>>          helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
>>>      } else {
>>>          /* memory */
>>> -        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
>>> +        uint8_t data8 = data;
>>> +        cpu_physical_memory_write(OFFSET_DATA + addr, &data8, 1);
>>>      }
>>
>> Or equivalently
>>   address_space_stb(&address_space_memory, data, MEMTXATTRS_UNSPECIFIED, NULL);
>>
>> (better choices of address space may be available, but this is
>> the exact-same-behaviour one).
> 
> Ah, this is my stashed fix:
> 
> -- >8 --
> @@ -320,8 +320,10 @@ target_ulong helper_fullrd(CPUAVRState *env,
> uint32_t addr)
>   *  this function implements ST instruction when there is a posibility
> to write
>   *  into a CPU register
>   */
> -void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
> +void helper_fullwr(CPUAVRState *env, uint32_t data32, uint32_t addr)
>  {
> +    uint8_t data = data32;
> +    assert(data == data32);
> +
>      env->fullacc = false;
> 
> ---
> 
> 3 ways to do the same :) The assert is probably superfluous.
> 
> I don't like the fact that env->r[addr] (which is u8) is silently casted
> from u32.

I'll squash Peter suggested fix:

-- >8 --
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -232,7 +232,9 @@ target_ulong helper_inb(CPUAVRState *env, uint32_t port)
         break;
     default:
         /* not a special register, pass to normal memory access */
-        cpu_physical_memory_read(OFFSET_IO_REGISTERS + port, &data, 1);
+        data = address_space_ldub(&address_space_memory,
+                                  OFFSET_IO_REGISTERS + port,
+                                  MEMTXATTRS_UNSPECIFIED, NULL);
     }

     return data;
@@ -289,7 +291,8 @@ void helper_outb(CPUAVRState *env, uint32_t port,
uint32_t data)
         break;
     default:
         /* not a special register, pass to normal memory access */
-        cpu_physical_memory_write(OFFSET_IO_REGISTERS + port, &data, 1);
+        address_space_stb(&address_space_memory, OFFSET_IO_REGISTERS +
port,
+                          data, MEMTXATTRS_UNSPECIFIED, NULL);
     }
 }

@@ -305,13 +308,14 @@ target_ulong helper_fullrd(CPUAVRState *env,
uint32_t addr)

     if (addr < NUMBER_OF_CPU_REGISTERS) {
         /* CPU registers */
-        data = env->r[addr];
+        data = cpu_to_le32(env->r[addr]);
     } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
         /* IO registers */
         data = helper_inb(env, addr - NUMBER_OF_CPU_REGISTERS);
     } else {
         /* memory */
-        cpu_physical_memory_read(OFFSET_DATA + addr, &data, 1);
+        data = address_space_ldub(&address_space_memory, OFFSET_DATA +
addr,
+                                  MEMTXATTRS_UNSPECIFIED, NULL);
     }
     return data;
 }
@@ -337,6 +341,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data,
uint32_t addr)
         helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
     } else {
         /* memory */
-        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
+        address_space_stb(&address_space_memory, OFFSET_DATA + addr, data,
+                          MEMTXATTRS_UNSPECIFIED, NULL);
     }
 }
---

