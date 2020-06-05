Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D14C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E47206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGljGoEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E47206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEs9-0007uX-04
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEoq-0002E5-2T
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:03:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEoo-0006nk-OC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:03:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id c3so10279429wru.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8EexMQA70ETa8QjhFfnSw6ESWJ/YQLYynDrVlFusago=;
 b=bGljGoEYgBbDpi/lBfQFkkRht6aGyTvdb8SKIx7nlpFstwmN6PdaWp//UjUHj1DKu/
 KBnm+j1ZjqToixk2RSxrEsKPrL6zcLS0sEn0sfNxedHlz2WTVHJe00zVffNQJsHvCExW
 3g1xafu4a61aOObicGJlFLmH+DriIbU6cWtjzMxVGmoiidLJRGsuPDj9gvl4Ajw8R8Cm
 D9uSCYqCcNfSUOBW4p+9LD4C/xbxOxHeidzmCipdIEL+QB5oVwaSLY1Yl5TwNAumrM69
 YTDx3rrkxVJxwjmJbgl21LWtMOM1oFmSQ3rA4ok3t8OKfBxYSmiF8juKP5l/sU6WyjJE
 ZwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8EexMQA70ETa8QjhFfnSw6ESWJ/YQLYynDrVlFusago=;
 b=NvO4J0YSrP2beQkux6S5Bi06mWWmGQneR7Of0JOsQy9yVm4w2yXdoNBuTmy5b7AY3C
 JpaeKVLDorNDJZYwRLqR5o/XuQWG7dpqhN5lg+MjmXQTCQ7ldfVUvtsPdO2PmhUgt22d
 ZR8vU2Tz3rQQYPEelDM2i3TtBksX4qcNmGzruKPB8c84y44EkfhUUd76+CL6QMiu7bu8
 J+qAYWrxtw/ojj5S84Kwy0vHsW7NTa/IGKshTOfgLroqD752rmxgDf0Yj4apdpWJmMOs
 buJtwhz6VGSQ5hIvTmN3acf6Ch4dPxN0svN9okhbecUYdvVRBB8Wd6Z23vW9tufPQiUl
 rQfg==
X-Gm-Message-State: AOAM531ivbPmcDvvf3zunjdE3q4z83jKiJFAeUZhvx8ZVfcBi207HTes
 cah8GK4fa34D6YHciPLT/r0rHg==
X-Google-Smtp-Source: ABdhPJyvX15hJiizioAf861oJFLJ9Lm6duq9yVAVWbHv/EMF1BtUU5awDZobyesC6sLrsmTkakQj4g==
X-Received: by 2002:a5d:54c3:: with SMTP id x3mr10019554wrv.312.1591373021094; 
 Fri, 05 Jun 2020 09:03:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h12sm12204315wro.80.2020.06.05.09.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:03:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99C441FF7E;
 Fri,  5 Jun 2020 17:03:33 +0100 (BST)
References: <20200604034513.75103-1-richard.henderson@linaro.org>
 <f5bc0532-e731-b56f-df7f-55da2585e955@redhat.com>
 <8bee167c-098c-a298-cd05-ffd753dbd934@redhat.com>
 <51412778-5b6d-f080-c62b-eda42d9f52cc@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
In-reply-to: <51412778-5b6d-f080-c62b-eda42d9f52cc@redhat.com>
Date: Fri, 05 Jun 2020 17:03:33 +0100
Message-ID: <878sh14i0a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 05/06/2020 14.51, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/4/20 8:11 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 6/4/20 5:45 AM, Richard Henderson wrote:
>>>> Clang 10 enables this by default with -Wtype-limit.
>>>>
>>>> All of the instances flagged by this Werror so far have been
>>>> cases in which we really do want the compiler to optimize away
>>>> the test completely.  Disabling the warning will avoid having
>>>> to add ifdefs to work around this.
>>>>
>>>
>>> Fixes: https://bugs.launchpad.net/qemu/+bug/1878628
>>>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>=20
>> Clarifying: I tested with clang-10, but Alex/Cornelia reported on IRC
>> the failure persist with clang-9 until using --disabler-werror.
>
> Does -Wno-tautological-constant-compare help on Clang-9 instead?

Yeah that variant works for clang-9

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>  Thomas
>
>
>>>
>>> I dare to add:
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>  configure | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/configure b/configure
>>>> index f087d2bcd1..693f01327f 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -2009,6 +2009,8 @@ gcc_flags=3D"-Wno-missing-include-dirs -Wempty-b=
ody -Wnested-externs $gcc_flags"
>>>>  gcc_flags=3D"-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>>>>  gcc_flags=3D"-Wno-initializer-overrides -Wexpansion-to-defined $gcc_f=
lags"
>>>>  gcc_flags=3D"-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flag=
s"
>>>> +gcc_flags=3D"$gcc_flags -Wno-tautological-type-limit-compare"
>>>> +
>>>>  # Note that we do not add -Werror to gcc_flags here, because that wou=
ld
>>>>  # enable it for all configure tests. If a configure test failed due
>>>>  # to -Werror this would just silently disable some features,
>>>>
>>>
>>=20
>>=20


--=20
Alex Benn=C3=A9e

