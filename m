Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2490C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4B12175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eop+2Hfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4B12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44119 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6KV-0003kf-OD
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:16:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP69p-0002h3-KQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP69n-0005NO-Dx
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:05:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hP69j-0005IZ-La
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:05:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id j187so7680263wmj.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=RNUPI5+XhJ6O3/esqlvjExYTl4YbpYlpj/x4Osi/CI4=;
	b=Eop+2Hfp/CynP4eB4NaEczIdzrEh8ngUIKe6lihDYrj9Ow2r/4yTHLUZ2DFh3w9kg7
	uEiTdxxlnJyc4zFvu+vnkqdu/4X3Nfs4nJb6zsKO2o2sypL0VsxTPsjXSqcP+6bCMPTY
	MVAW2fssioapvR9rgmTSvg1QXlvW1kh6OzCerbW8W0Js+62RpqTqe65tFZLxD5bcSxoe
	zIcqxmU2UliII0kwknj//ZhmIcp2RnSh3ZMm5B3Ul5MAa9qP7h7pqxye4NjcQvCaHEXb
	U0rqg25o9hCHG2uMUXqpzqyu+SwUG4oIH0mWcUZ3MEI8FmTG9PsF3AEkFAupOKmb9wob
	ZqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=RNUPI5+XhJ6O3/esqlvjExYTl4YbpYlpj/x4Osi/CI4=;
	b=NVuEUaNrTqveaEemUt30CJyr+YMMk2R9BHrW2MXzJo6bl7fG4ohitNhHCOTJRvVXtw
	zPwDJ5wapLu6MjVr92OO0OTraTl0GvM64oErr3JWAIhR43l8ghApXNebl2b7WVpvVXDb
	gBqkBU4lYZ1X7LbEo9jwGEv6+XRymt0+LvxJQJwrRQvBq92ZWsrymeUTz9WeJLU8YEC9
	Uv+nWQRC7S/7kqoTHlkczkcUp4YO+DRs2mnYM1hU3LsVwqwM6iSd94QnxST0YuP0doTR
	stcLdf4Zywx1VURkoeW/MiZRi/6xet3oTmrR8Tl8sqC8rOnrPw1aEuZmLIXIxlg31W4u
	mXzg==
X-Gm-Message-State: APjAAAUK+o6kvJNZmLSldHpe6DtNWJG4+vOMXI2vWUgMvccGmQqd6NZ6
	BixtKe+w69ztxT1DONWaJKVo2w==
X-Google-Smtp-Source: APXvYqygs9OZOlWIkk1ZdyEljW3Q4MonCnL6vKifjhlKuV7Qdd29En9kXW3I5Z8RxN2G1yA1GDIDpA==
X-Received: by 2002:a1c:d181:: with SMTP id i123mr7495393wmg.33.1557497146073; 
	Fri, 10 May 2019 07:05:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id s7sm5575315wrn.84.2019.05.10.07.05.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 07:05:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EFFBD1FF87;
	Fri, 10 May 2019 15:05:44 +0100 (BST)
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
	<252a5c4b-6ba7-6fa7-8792-fe597e766757@linaro.org>
	<87pnoq4x4o.fsf@zen.linaroharston>
	<f6abf67c-94af-22a6-c648-2fdbfe73974d@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <f6abf67c-94af-22a6-c648-2fdbfe73974d@linaro.org>
Date: Fri, 10 May 2019 15:05:44 +0100
Message-ID: <87v9yibe13.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/9/19 11:55 PM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 5/9/19 9:58 AM, Alex Benn=C3=A9e wrote:
>>>> @@ -51,12 +51,18 @@ static inline const char *semihosting_get_cmdline(=
void)
>>>>  {
>>>>      return NULL;
>>>>  }
>>>> +
>>>> +static inline Chardev *semihosting_get_chardev(void)
>>>> +{
>>>> +    return NULL;
>>>> +}
>>>
>>> Isn't the point of this function to avoid...
>>
>> Yes... but...
>>
>>>
>>>> -                return write(STDERR_FILENO, &c, 1);
>>>> +#ifdef CONFIG_SOFTMMU
>>>> +              Chardev *chardev =3D semihosting_get_chardev();
>>>> +              if (chardev) {
>>>> +                  return qemu_chr_write_all(chardev, (uint8_t *) &c,
>>> 1);
>>
>> The qemu_chr device stuff doesn't have such stubs and is softmmu only as
>> well. *sigh*
>
> Ah, I see.  Yes that's a problem.
>
> Well at least you don't need the "else\n#endif\n{" ugliness.  You have the
> return out of the then block.

Only for the first one though.. that said I'm sure the write string is
leaking when we do gdb output with whatever lock_user_string is trying
to achieve.

>
>
> r~


--
Alex Benn=C3=A9e

