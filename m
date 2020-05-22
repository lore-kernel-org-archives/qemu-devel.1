Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC2FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A9B20738
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUVjsqoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A9B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc4rK-0007Rh-Mt
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 06:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc4qf-0006wp-MV
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:24:17 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc4qe-0005m7-AY
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:24:17 -0400
Received: by mail-ej1-x643.google.com with SMTP id j21so12427519ejy.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qSHqxNlblbpfa+Z8YJIscBRiQLz+wUHN2PsrSwJMULc=;
 b=kUVjsqoZ9ysMl+8bQPXZ5ZCTn3hsJA/00yrOCHSRlhmrTiyLBP5/HexXRyz4mXxpAY
 k5p9H6NpR0j/iqeWfUsKfto+32tJ9zRLVZG/l7bcZOjGEukzG5fhPl7WKntqcb//GaR/
 ysFTPrTI9/UThgoncoqxZ3dWEX3SBekx7rbfNHMHLLyWKCwqTUM8UdmrYqng2spGHNzu
 Li0BQ9g+CgofRzj8AC0bdT7QJXMBKGdYVaiqnocPXhRMMSdhACQx6Faz9QCCQTRhje2M
 u/bo8jU1bYhMINwkcAwWuIxFvW1BkbJJQMyTIwYgW8AdmJAY5Ymqm0Ww5VsNffD9LWtE
 Z98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qSHqxNlblbpfa+Z8YJIscBRiQLz+wUHN2PsrSwJMULc=;
 b=nwrJ+Yo+cSSJVruqHWpsM/GV80aqQPWa/sGWDSs6AcOAPJvEQTyj2A9Q7bfwCt4Qfl
 h8nPEREWx9vxUaJQQvs7tV0RJcMG9AOvjr8duuEbjr4veofYHSVXjjwGILHtH1fWywLz
 Y7lnQRAJXFBFUe9DjRTBE9E8IeY929ZFfBZ/A727k+ON6+CayIGrTkW7vfLCso0tETcS
 lckjV8meJATMvzA0Ii6wTX77U04qQDgos61VKfGlK0oDqyvg2eD/7XYRQXl4Rd5NkJ7x
 4ca3Ft5YMAy6uOIk0gOQiZr6eVvtowyvkBZFRi2Dsrlnj6H++LTMECeAVdKxe8tuFx2m
 HzLg==
X-Gm-Message-State: AOAM531yXtrXsrv4rM6kxPpUTFmrO3V8hEN/rzxENcochzx4aZUhtGA5
 oXimLW+YRW7ATWDOBuyT4AYgbQ==
X-Google-Smtp-Source: ABdhPJxcW9Jw5+70lQuwJUg1IAOSCJO7BJBP7CHPHt3KR92K/ZvrBb9JGPfD4pKsHgQINkC9NHQ1Mw==
X-Received: by 2002:a17:906:703:: with SMTP id y3mr7594542ejb.61.1590143054637; 
 Fri, 22 May 2020 03:24:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id dh15sm6583429edb.35.2020.05.22.03.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 03:24:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6973A1FF7E;
 Fri, 22 May 2020 11:24:12 +0100 (BST)
References: <20200513175134.19619-1-alex.bennee@linaro.org>
 <20200513175134.19619-5-alex.bennee@linaro.org>
 <958a1d7e-305d-96f5-2e0c-f8a2dd53e1c0@redhat.com>
 <87eerdg0kx.fsf@linaro.org>
 <0fcdef39-2e6f-11db-121b-874805ff2518@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 04/10] linux-user: completely re-write init_guest_space
In-reply-to: <0fcdef39-2e6f-11db-121b-874805ff2518@linaro.org>
Date: Fri, 22 May 2020 11:24:12 +0100
Message-ID: <87tv08e08j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/21/20 1:21 AM, Alex Benn=C3=A9e wrote:
>>=20
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 13/05/2020 19.51, Alex Benn=C3=A9e wrote:
>>>> First we ensure all guest space initialisation logic comes through
>>>> probe_guest_base once we understand the nature of the binary we are
>>>> loading. The convoluted init_guest_space routine is removed and
>>>> replaced with a number of pgb_* helpers which are called depending on
>>>> what requirements we have when loading the binary.
>>>>
>>>> We first try to do what is requested by the host. Failing that we try
>>>> and satisfy the guest requested base address. If all those options
>>>> fail we fall back to finding a space in the memory map using our
>>>> recently written read_self_maps() helper.
>>>>
>>>> There are some additional complications we try and take into account
>>>> when looking for holes in the address space. We try not to go directly
>>>> after the system brk() space so there is space for a little growth. We
>>>> also don't want to have to use negative offsets which would result in
>>>> slightly less efficient code on x86 when it's unable to use the
>>>> segment offset register.
>>>>
>>>> Less mind-binding gotos and hopefully clearer logic throughout.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Acked-by: Laurent Vivier <laurent@vivier.eu>
>> <snip>
>>>> +    } else {
>>>> +        if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>>> +            error_report("%s: requires more virtual address space "
>>>> +                         "than the host can provide (0x%" PRIx64 ")",
>>>> +                         image_name, (uint64_t)guest_hiaddr - guest_b=
ase);
>>>> +            exit(EXIT_FAILURE);
>>>>          }
>>>
>>>  Hi Alex,
>>>
>>> this causes an error with newer versions of Clang:
>>>
>>> linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>>> long' > 18446744073709551615 is always false
>>> [-Werror,-Wtautological-type-limit-compare]
>>> 4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>> 4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>>> 4687 1 error generated.
>>>
>>> Any ideas how to fix this?
>>=20
>> I guess this check only makes sense when abi_ulong > uintptr_t or IOW 64
>> bit guests running on 32 bit hosts. We could just wrap that check in:
>>=20
>> #if HOST_LONG_BITS =3D=3D 32
>>=20
>> #endif
>
> As I've suggested elsewhere, I think we should disable this warning on the
> command-line.

Yeah - although after having pushed down this bug it seems there are
still a lot of things clang-10 is finding. I think maybe I should punt
the fedora32 bump to a new series of clang-10 fixups?

Examples:

  /tmp/qemu-test/src/fpu/softfloat.c:3365:13: error: bitwise negation of a =
boolean expression; did you mean logical negation? [-Werror,-Wbool-operatio=
n]
      absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              !
  /tmp/qemu-test/src/fpu/softfloat.c:3423:18: error: bitwise negation of a =
boolean expression; did you mean logical negation? [-Werror,-Wbool-operatio=
n]
          absZ0 &=3D ~ ( ( (uint64_t) ( absZ1<<1 ) =3D=3D 0 ) & roundNeares=
tEven );
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                   !


  /tmp/qemu-test/src/audio/mixeng.c:274:34: error: implicit conversion from=
 'unsigned int' to 'float' changes value from 4294967295 to 4294967296 [-We=
rror,-Wimplicit-int-float-conversion]
  static const float float_scale =3D UINT_MAX / 2.f;
                                   ^~~~~~~~ ~
  /usr/lib64/clang/10.0.0/include/limits.h:56:37: note: expanded from macro=
 'UINT_MAX'
  #define UINT_MAX  (__INT_MAX__  *2U +1U)
                     ~~~~~~~~~~~~~~~~~^~~


--=20
Alex Benn=C3=A9e

