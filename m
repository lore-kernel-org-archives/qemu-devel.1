Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17991C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DAF2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1Yi8fYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DAF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtiA-0006dD-St
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTtfo-0003mv-O2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTtfn-00005e-Iy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:51:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTtfn-000055-41
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:51:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so4211242wrt.5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lLc+w8h+0tcUssa/ZZ0mD/6b560cq3kMauYmicGKZD8=;
 b=X1Yi8fYlStto6hLwsN9agHHwwRBZCTkiii+yPLHbLJnnt8qIFQk7iO0KIhFJsKKKCK
 VpSbs8oHXwsSqIRUU9apQqxPTNhoTe0peL6HO27Q6gkCIORYUi0stlMbR64p40uPnP5r
 Y3PDDV7stzM7zwgIT5d5MHDqwuICttfaEIftTVYJGExsSk1Ozy6T6PpswvlY2ekN2yWU
 /OfjUGC/+NAqqmuDIzXgOJHyjUr6sIj7FcUCa89++U9MrpqFBnCYLc1LcBEgfmtpAARk
 SldjmPtC17L+GfQF0gx0Ib+A7l1PRGNt1YsfARkuzga4g/Kfkwt2qY0aErdsjtiYup79
 dqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lLc+w8h+0tcUssa/ZZ0mD/6b560cq3kMauYmicGKZD8=;
 b=P9KOawtopCe7bqoevMASHO1bNZfaFCwuJ1W8uEDcNpI+pERE80wjvBmDmS/X/yXT0s
 XUgc8uda+2+pCxlX7kRtiz4MPeRYAovjuVZCOS4tWf2wiOLzveFGCU03R+urMGIpoDRq
 DtmqFRimvGwdpj913OzRX+FeJ64GIOe2+bv48VU5xYAIQNxZfiFbUKefyKbIvY123ads
 dWgvmKdZhN+bOpYCW10aOJlWP32rL8gSx/nrEG4GJVQH8gxnZxSdN27dJ63ug3TZO0P9
 XptpAZ04po+FMdyxLaiSUxG3M4ATd6KvP3ABFMjhbEP8jZDVpREH+Q72fOd/OJc5iLWn
 nafg==
X-Gm-Message-State: AGi0PuaNV3hNhxRHfkUycuHu+jMHxEBDcy5G1B+7fN1kOGhpbwxIXTXI
 AsUyMFPdSRkpNsH6lFECF0h6Iw==
X-Google-Smtp-Source: APiQypJaCZlFqFVeI786JT3o47pqv5jWApe5Jy500rtXoVl/zL9j5uBYAcBsvZnXJgJxl2Fd2VEhzA==
X-Received: by 2002:adf:8162:: with SMTP id 89mr39873372wrm.387.1588193473253; 
 Wed, 29 Apr 2020 13:51:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f2sm712760wro.59.2020.04.29.13.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 13:51:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B38B1FF7E;
 Wed, 29 Apr 2020 21:51:05 +0100 (BST)
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <87d07rlac5.fsf@linaro.org>
 <9f6c1efc-a195-0f5d-8c34-4dfb45d910f8@vivier.eu>
 <87a72ulk1z.fsf@linaro.org>
 <1a78341c-b481-c9f2-f8fd-f50ab3bf197f@vivier.eu>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
In-reply-to: <1a78341c-b481-c9f2-f8fd-f50ab3bf197f@vivier.eu>
Date: Wed, 29 Apr 2020 21:51:05 +0100
Message-ID: <87pnbqj9s6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, philmd@redhat.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 29/04/2020 =C3=A0 11:26, Alex Benn=C3=A9e a =C3=A9crit :
>>=20
>> Laurent Vivier <laurent@vivier.eu> writes:
>>=20
>>> Le 28/04/2020 =C3=A0 20:43, Alex Benn=C3=A9e a =C3=A9crit :
>>>>
>>>> KONRAD Frederic <frederic.konrad@adacore.com> writes:
>>>>
>>>>> The MC68881 say about infinities (3.2.4):
>>>>>
>>>>> "*For the extended precision format, the most significant bit of the
>>>>> mantissa (the integer bit) is a don't care."
>>>>>
>>>>> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
>>>>>
>>>>> The m68k extended format is implemented with the floatx80 and
>>>>> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000=
 as
>>>>> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
>>>>> accepts that the most significant bit of the mantissa can be 0.
>>>>>
>>>>> This bug can be revealed with the following code which pushes extended
>>>>> infinity on the stack as a double and then reloads it as a double.  It
>>>>> should normally be converted and read back as infinity and is current=
ly
>>>>> read back as nan:
>>>>
>>>> Do you have any real HW on which you could record some .ref files for
>>>> the various multiarch float tests we have (float_convs/float_madds)?
>>>> Does this different of invalid encoding show up when you add them?
>>>
>>> On my side, in the past when I started to implement m68k FPU, I used
>>> TestFloat and SoftFloat I have ported to m68k and I compare the result
>>> in QEMU and in a Quadra 800.
>>=20
>> Surely TestFloat and SoftFloat is all emulation though?
>>=20
>> Anyway if you have a Quadra 800 running Linux could you generate some
>> .ref files for the float_convs and float_madds test cases. The binaries
>> are static so you should just be able to copy them and run.
>>=20
>>
>
> Here are the files I have generated on Q800.

So running those with:

  run-float_convs: QEMU_OPTS +=3D -cpu m68040
  run-float_madds: QEMU_OPTS +=3D -cpu m68040

We see the m68k float needs a fair bit of work from the get go:

      Reference                                            qemu-m68k -cou m=
68040

  ### Rounding to nearest						### Rounding to nearest
                                                                >	from sing=
le: f32(-nan:0xffbfffff)
                                                                >	  to doub=
le: f64(-nan:0x00fff7ffffe0000000) (OK)
                                                                >	   to int=
32: 2147483647 (OK)
                                                                >	   to int=
64: 9223372034707292159 (OK)
                                                                >	  to uint=
32: 2147483647 (OK)
                                                                >	  to uint=
64: 9223372034707292159 (OK)
  from single: f32(-nan:0xffffffff)				from single: f32(-nan:0xffffffff)
    to double: f64(-nan:0x00ffffffffe0000000) (OK)		  to double: f64(-nan:0=
x00ffffffffe0000000) (OK)
     to int32: 2147483392 (INVALID)			      |	   to int32: 2147483647 (OK)
     to int64: 9223370939490631424 (INVALID)		      |	   to int64: 92233720=
34707292159 (OK)
    to uint32: 2147483392 (INVALID)			      |	  to uint32: 2147483647 (OK)
    to uint64: 9223370939490631424 (INVALID)		      |	  to uint64: 92233720=
34707292159 (OK)
  from single: f32(-nan:0xffffffff)			      |	from single: f32(nan:0x7fffff=
ff)
    to double: f64(-nan:0x00ffffffffe0000000) (OK)	      |	  to double: f64=
(nan:0x007fffffffe0000000) (OK)
     to int32: 2147483392 (INVALID)			      |	   to int32: 2147483647 (OK)
     to int64: 9223370939490631424 (INVALID)		      |	   to int64: 92233720=
34707292159 (OK)
    to uint32: 2147483392 (INVALID)			      |	  to uint32: 2147483647 (OK)
    to uint64: 9223370939490631424 (INVALID)		      |	  to uint64: 92233720=
34707292159 (OK)
  from single: f32(-inf:0xff800000)			      <
    to double: f64(-inf:0x00fff0000000000000) (OK)	      <
     to int32: -2147483648 (INVALID)			      <
     to int64: 1 (INVALID)				      <
    to uint32: -2147483648 (INVALID)			      <
    to uint64: -9223372034707292160 (INVALID)		      <
  from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)	from single: =
f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
    to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe	  to double=
: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe
     to int32: -2147483648 (INVALID)			      |	   to int32: -2147483648 (OK)
     to int64: 1 (INVALID)				      |	   to int64: 1 (OK)
    to uint32: -2147483648 (INVALID)			      |	  to uint32: -2147483648 (OK)
    to uint64: -9223372034707292160 (INVALID)		      |	  to uint64: -922337=
2034707292160 (OK)

snipped a bunch more.

--=20
Alex Benn=C3=A9e

