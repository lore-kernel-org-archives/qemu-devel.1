Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED192C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D302073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccAZyJr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D302073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjsX-0008Ov-VL
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTjrq-0007TW-CF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTjrp-0006xD-Co
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:23:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTjro-0006wv-Vr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:23:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id v8so4551856wma.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eSKUYntKCTyYntGJGMSSW4qtbxQ3Gd3UdV05xcaWvnI=;
 b=ccAZyJr72NOnKyQnax7eO7oBD//0+HYb9zXDN1qqvlFpyfdnkVDMSa30zKoHbRhoEz
 CLb3gHYiLRprlOeIvF9GdcetBmyhMJmSQcD33BDcIh2YQdB4Rcfc+mOY+pLEFDLG0/4m
 9sDu4Dz6g2Gz4xQJBKCMI9kIxm1pMQg5TFG3t6Ob7poTIUGK39O234/OB+Cs+yu1HVhh
 drHhjtzmIvYOsiyF/xOCxOgOIZETU260EdmnLOYR/a1hs+6S/wxHXYA7cmahOlg3ZG0B
 JOGunujrl++1M2I8RZFvtWew4Pbl7Cw8l4HoPZXXQv1zwf9GeOdk3Ka2VQQxhvUAccBV
 Mo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eSKUYntKCTyYntGJGMSSW4qtbxQ3Gd3UdV05xcaWvnI=;
 b=UKzWym4Lg+1c7tJuyWP+pz5mNt1lv2/17hKx7i9AeCNqsIHhdn9g0rag4PAje4u9j3
 Ps2I4rJwz9Vn7KrzjhDyavPq0AvW0Hcl4Mcue8NFQX4GBqNaCkfDdHO+Y3H5piY1fuBa
 ngVG0AnO+L3i6JdY145ks6Hqf//mLm4rYYgLavTfEhlPNnoeWDvKKI+sCe1zvmydloit
 dLOuDAmz60mivaS7fjYubq+paQ/skVEiDCwWw3To5q7AbfjCZvk4q5aRUCMle+J9/XGT
 NZOKXApv7T76H7skmnE9VO1L53vSlfRzz9USzjIjd4JFZlQuymiTD2+9e5QZ2EXRjc3A
 3WJw==
X-Gm-Message-State: AGi0PubuqOzkj4VftcJmcY87kEoVbGcRcZ7xElK21u2iVELto3pwqHsE
 s8hVhnc9okUu/mWZW3Kn43ligA==
X-Google-Smtp-Source: APiQypIlV5IjE81wOvIFa3GHJtb8Ff82YzAA5w4JXY2U15aAmWdFojNMExw5LSrc0laC56TulBxNGQ==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr2323499wmb.37.1588155779230;
 Wed, 29 Apr 2020 03:22:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u30sm29575042wru.13.2020.04.29.03.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 03:22:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB5911FF7E;
 Wed, 29 Apr 2020 11:22:56 +0100 (BST)
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <87d07rlac5.fsf@linaro.org>
 <9f6c1efc-a195-0f5d-8c34-4dfb45d910f8@vivier.eu>
 <87a72ulk1z.fsf@linaro.org>
 <b6a2a382-6124-5ece-22b3-2af153fd9ffe@vivier.eu>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
In-reply-to: <b6a2a382-6124-5ece-22b3-2af153fd9ffe@vivier.eu>
Date: Wed, 29 Apr 2020 11:22:56 +0100
Message-ID: <874kt2lhfj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
>>
> Is there any HOWTO somewhere? Or should I dig into the code as usual?

On your known good HW:

  ./float_convs > float_convs.ref

and copy the file into tests/tcg/m68k and the:

  run-float_%: float_%
          $(call run-test,$<, $(QEMU) $(QEMU_OPTS) $<,"$< on $(TARGET_NAME)=
")
          $(call conditional-diff-out,$<,$(SRC_PATH)/tests/tcg/$(TARGET_NAM=
E)/$<.ref)

should automatically include the diff on the next run.

>
> Thanks,
> Laurent


--=20
Alex Benn=C3=A9e

