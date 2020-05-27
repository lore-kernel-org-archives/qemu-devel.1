Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBAE2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mef5W4UC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBAE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdz3Y-0000dX-FJ
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdz2w-000079-PM
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:36:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdz2v-0007AJ-K9
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:36:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id n5so49531wmd.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RJNApYvDySDQ1uNPsNpysqX69qiIb5CmpiDaP6Dtwnk=;
 b=Mef5W4UCv4uO3gYZIUL9gj1RDx5S6k8HvIGPgipG4Fn9ewOHrAgHeA6NrrjTrCyMVn
 pgjcXccx+BmK32/WH6rmiCEzq6tN+Sp5X+AXOgpZmYNlnlimDmARkIpZUNt4Z/47Z1h5
 D8lRXfFTi3wgr9zgaanOVb6YvhumdbOlJPQs8jA5yp1AJFMvmomyA3CbyEH6Y+Y06+hT
 ViWrFfqSmlj0ayg5U8xByMS5LCkV1R1eXch41sNkwQedIyPxeu9MvLFkixkYE2PQEO5P
 K3MM6ST3G1WxNePfAMPCficUUT+zuut/Rqo0FkyUKnZMWKtALGVcS/Rpi2I7oMy9VK2X
 TkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RJNApYvDySDQ1uNPsNpysqX69qiIb5CmpiDaP6Dtwnk=;
 b=rdsXR4auDgkuqO2c+hubgC6IY/8dm3osh5uSFtXnRNWq+BcXB7xqHIMGOlmwhE4ZL7
 cMYP4quktuFJy9tvRer4A24M/vtXHLn3wjT3XOWZnxh5YnRSIhNHLfVK+KdZ1R3hRi8c
 zYXn9IvONPJYYO1DiulIEXM7zpC48D2sfGV4yBMk3mMIj7NnlnLJd02umFfbPgIugcSE
 Ly/9ABezgq4H6moKfAIcAClZ9TrvH44THlBoq6tOCralWetDw0LEWyFw6mlM8pFsnk4q
 rA23RZed1SwDGLql3OYkwNDmlK3oRCZpnuvyjxIAEnRrZBLMLxRQiDxU/Wf62EU/X2zW
 fjEw==
X-Gm-Message-State: AOAM5315PUcmZ8qCnvMt/CUrqersVD0ksRt437wZWhoWPeRGUgYKcmFw
 nW5WnVdsjNtFzTEIiXHlY0kqsRwHvLY=
X-Google-Smtp-Source: ABdhPJzvDPMirilAL7ZIlto9vH3mDVbczrmGESZiUcr7uFMWzdzpsihxn7dKWWKHSr4MO/2JD/EBgA==
X-Received: by 2002:a1c:9d96:: with SMTP id g144mr4923531wme.126.1590597407244; 
 Wed, 27 May 2020 09:36:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 190sm3605537wmb.23.2020.05.27.09.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 09:36:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 411AF1FF7E;
 Wed, 27 May 2020 17:36:45 +0100 (BST)
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-8-thuth@redhat.com>
 <1b050c61-0cd3-bc91-7610-856a28a27175@vivier.eu>
 <ab17e3cd-5117-b54b-6460-60c595d97033@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 7/7] linux-user: limit check to HOST_LONG_BITS <
 TARGET_ABI_BITS
In-reply-to: <ab17e3cd-5117-b54b-6460-60c595d97033@redhat.com>
Date: Wed, 27 May 2020 17:36:45 +0100
Message-ID: <87imgh5o82.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 27/05/2020 16.44, Laurent Vivier wrote:
>> Le 25/05/2020 =C3=A0 15:18, Thomas Huth a =C3=A9crit :
>>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>> Newer clangs rightly spot that you can never exceed the full address
>>> space of 64 bit hosts with:
>>>
>>>   linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>>>   long' > 18446744073709551615 is always false
>>>   [-Werror,-Wtautological-type-limit-compare]
>>>   4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>>   4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>>>   4687 1 error generated.
>>>
>>> So lets limit the check to 32 bit hosts only.
>>>
>>> Fixes: ee94743034bf
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> [thuth: Use HOST_LONG_BITS < TARGET_ABI_BITS instead of HOST_LONG_BITS =
=3D=3D 32]
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  linux-user/elfload.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>> index 01a9323a63..ebc663ea0b 100644
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -2073,12 +2073,14 @@ static void pgb_have_guest_base(const char *ima=
ge_name, abi_ulong guest_loaddr,
>>>              exit(EXIT_FAILURE);
>>>          }
>>>      } else {
>>> +#if HOST_LONG_BITS < TARGET_ABI_BITS
>>>          if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>>              error_report("%s: requires more virtual address space "
>>>                           "than the host can provide (0x%" PRIx64 ")",
>>>                           image_name, (uint64_t)guest_hiaddr - guest_ba=
se);
>>>              exit(EXIT_FAILURE);
>>>          }
>>> +#endif
>>>      }
>>>=20=20
>>>      /*
>>>
>>=20
>> Philippe sent the same patch:
>>=20
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg699796.html
>
> Indeed, but looking more closely, he's using slightly different
> locations for the #if and #endif ... not sure what's better though...?

Richard was more inclined to suppress the warning:

  Subject: Re: [PATCH v2] linux-user: limit check to HOST_LONG_BITS =3D=3D =
32
  From: Richard Henderson <richard.henderson@linaro.org>
  Message-ID: <3069bc1b-115d-f361-8271-c775bf6957ea@linaro.org>
  Date: Thu, 21 May 2020 20:15:51 -0700

One reason I dropped the f32 patch from my last PR was because this
wasn't the only warning the latest clang picks up.

--=20
Alex Benn=C3=A9e

