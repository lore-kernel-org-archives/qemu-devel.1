Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEDAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 06:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A22207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 06:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFzqXPOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A22207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjdPz-0001yq-QE
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 02:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjdP9-0001XH-Ic
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 02:43:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46009)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjdP7-0007JH-Ol
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 02:43:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so8498789wru.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vIAi3vawCFGTFmOHlw4pa59PxwbjUr0Z2QRnBKvEzxQ=;
 b=SFzqXPOPAF7NCYmnDyV8NWfu2/LJCk1gkCXPCL5qYInxhV/u2Tfnt5xJ32tlzJzh7z
 CbzRctaDRI0xWxgP30xETag3ZDEf8IWZn0aShI5Js4vzhy4SmUh6mqTAyLwczTSurQJO
 OJzLvQEurfNuAvLmlZgCVPZ1fXLyAG0JbVWTZAqYbqh7D5eICOBZPDe+q1DP3h3Vw1Jh
 Wt3PtpKaBCnF+a39Ma7vokth8FX0y3OIorhWl6r93wQ/Rw9TGKrxhmE6KTfHyZScYVbd
 o/CuG1QBk7jNXf29oy5DpDjVSmqq3MLV62OoL4TsVDZ/SkNc/NTKJi2LrX17W/tl4owp
 /P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vIAi3vawCFGTFmOHlw4pa59PxwbjUr0Z2QRnBKvEzxQ=;
 b=QA/zfvyOxIRLpPCDN0d15cVnilNBGGLoFPh5lNnR3T+I6e8l9NhRjD0A2/YwkJHxoR
 xJ/4iohtX0+28kVjunn/QjFfQgkpKwPA2JmNpYeryiptRLyBnPVaAp+FLveFcEYCXz1s
 nHgqpPZAtnb4UjSortvuLSrpgWWu2JOIKD2fOrvH+dyHspf1uuMBp9gITA7HSkB7Dgwl
 /OJhdh4a13Z85l5I5TZYQQpdc0RRe+dQNd6tooccO3fs17Hi0CLEiBt+InBux8LQl+cs
 L1syMoy2fFd4r3l677+rzT/WNgHw4RMYdg2NEqzV0W8kI7B/p6y5VGtCp/j+WN3/s7XN
 EhGg==
X-Gm-Message-State: AOAM532fHzdhtmsqJm6PERlM93xKYEogGIZLFDzUOKWqaGY8dV6vCBnr
 Xgp/hFqd/EfV5U6BFqt942fd7g==
X-Google-Smtp-Source: ABdhPJy1c4godJSMbNBZi9N2A7RKNA7wmAPErodmZspVUfpC7pqJCijNaeLbe958dSHX0B8nQYEsEw==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr13393284wrp.370.1591944178743; 
 Thu, 11 Jun 2020 23:42:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v7sm7985700wme.46.2020.06.11.23.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 23:42:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 64E6E1FF7E;
 Fri, 12 Jun 2020 07:42:56 +0100 (BST)
References: <20200610203942.887374-1-richard.henderson@linaro.org>
 <20200610203942.887374-6-richard.henderson@linaro.org>
 <87bllp4kn1.fsf@linaro.org>
 <9d416d2e-593d-61c5-ab20-7b182a7bb757@linaro.org>
 <877dwd4j4n.fsf@linaro.org>
 <f5f12da1-e2fd-0bf5-1f10-6994cf7f0184@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 5/5] configure: Add -Wno-psabi
In-reply-to: <f5f12da1-e2fd-0bf5-1f10-6994cf7f0184@linaro.org>
Date: Fri, 12 Jun 2020 07:42:56 +0100
Message-ID: <874krg4wen.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/11/20 10:17 AM, Alex Benn=C3=A9e wrote:
>>=20
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 6/11/20 9:44 AM, Alex Benn=C3=A9e wrote:
>>>>
>>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>>
>>>>> On aarch64, gcc 9.3 is generating
>>>>>
>>>>> qemu/exec.c: In function =E2=80=98address_space_translate_iommu=E2=80=
=99:
>>>>> qemu/exec.c:431:28: note: parameter passing for argument of type \
>>>>>   =E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=
=99} changed in GCC 9.1
>>>>>
>>>>> and many other reptitions.  This structure, and the functions
>>>>> amongst which it is passed, are not part of a QEMU public API.
>>>>> Therefore we do not care how the compiler passes the argument,
>>>>> so long as the compiler is self-consistent.
>>>>>
>>>>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> ---
>>>>> TODO: The only portion of QEMU which does have a public api,
>>>>> and so must have a stable abi, is "qemu/plugin.h".  We could
>>>>> test this by forcing -Wpsabi or -Werror=3Dpsabi in tests/plugin.
>>>>> I can't seem to make that work -- Alex?
>>>>
>>>> modified   plugins/Makefile.objs
>>>> @@ -5,6 +5,7 @@
>>>>  obj-y +=3D loader.o
>>>>  obj-y +=3D core.o
>>>>  obj-y +=3D api.o
>>>> +api.o-cflags :=3D -Wpsabi
>>>>=20=20
>>>>  # Abuse -libs suffix to only link with --dynamic-list/-exported_symbo=
ls_list
>>>>  # when the final binary includes the plugin object.
>>>>
>>>> Seems to work for me.
>>>
>>> Wrong directory -- that's the part that goes into qemu, which also uses=
 other
>>> qemu internal headers.  As opposed to the tests/, which only use the one
>>> "qemu/plugins.h" header (plus libc).
>>=20
>> It's a sub-make so I just did:
>>=20
>> modified   tests/plugin/Makefile
>> @@ -18,7 +18,7 @@ NAMES +=3D hwprofile
>>=20=20
>>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>>=20=20
>> -QEMU_CFLAGS +=3D -fPIC
>> +QEMU_CFLAGS +=3D -fPIC -Wpsabi
>>  QEMU_CFLAGS +=3D -I$(SRC_PATH)/include/qemu
>
> Did you look at the actual flags passed to the actual cc via V=3D1?
> Neither of these flags is arriving.

I did:

cc -iquote /home/alex/lsrc/qemu.git/builds/all.plugin/. -iquote . -iquote /=
home/alex/lsrc/qemu.git/tcg/i386 -isystem /home/alex/lsrc/qemu.git/linux-he=
aders -isystem /home/alex/lsrc/qemu.git/builds/all.plugin/linux-headers -iq=
uote . -iquote /home/alex/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git/ac=
cel/tcg -iquote /home/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qe=
mu.git/disas/libvixl -I/usr/include/pixman-1 -I/home/alex/lsrc/qemu.git/dtc=
/libfdt -Werror  -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-g=
nu/glib-2.0/include -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linu=
x-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET=
_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall =
-Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-comm=
on -fwrapv -std=3Dgnu99  -Og -ggdb3 -fvar-tracking-assignments -Wexpansion-=
to-defined -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-di=
rs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self=
 -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype=
-limits -fstack-protector-strong  -I/usr/include/p11-kit-1  -DLEGACY_RDMA_R=
EG_MR -DSTRUCT_IOVEC_DEFINED  -I/usr/include/libpng16 -I/usr/include/libdrm=
 -I/usr/include/spice-server -I/usr/include/spice-1 -I/usr/include/capstone=
  -fPIC -Wpsabi -I/home/alex/lsrc/qemu.git/include/qemu -MMD -MP -MT hwprof=
ile.o -MF ./hwprofile.d -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g   -c=
 -o hwprofile.o /home/alex/lsrc/qemu.git/tests/plugin/hwprofile.c

It's nested between the -I's with -fPIC.

>
> I sent you mail about this yesterday...
>
>
> r~


--=20
Alex Benn=C3=A9e

