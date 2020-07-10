Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EC5206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYR7a1c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EC5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuVn-0005ml-Ph
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtuUb-0004sj-Fw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:59:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtuUV-0000SP-Qa
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:59:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id z15so6267781wrl.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TA/HkXSapHZeZe5bfTpqkCWfDhLsdsc8tqcDOZY4jlI=;
 b=aYR7a1c+34KqNLVuAfWp4pw3oBZ1VmTYI2LFh7wgswFE7Lpo161qmoSbNSsAeplwsu
 qZ600TyYleuPs3rIiOk8DDPWrB3gcoRm56dRJtjC86w07NMXAEIMeEJKmH7xikiDRjak
 NDNzT85CbnYVqmzBZ6/5yZLxwex4Gjg9+xjeVKgLYBnl2KtiY+qkfrN4p0aAIOHY4edN
 /B92GkROFP4cJQYuItaYsTHe0oCZP06N/MddfvBKL9WzMHSYPEjUlemK/wZwDc9TQ5eU
 0q7qmmPiETukUej7ahBkiRVbVty3xa81x3vZqizig5G7zkFn26u2Vw8LXNmioXoagxyu
 /bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TA/HkXSapHZeZe5bfTpqkCWfDhLsdsc8tqcDOZY4jlI=;
 b=XWXuUEpX6hiSlAZZuR2kYupKMWdSkq0iIOXcYVanPaufrxkaeFkGzbzLAY3Tmgp3S2
 e3o79p4NB2maEo0B4202PnTaFN1l9SkMFeFftyz31qpb7o2IthWdckNEjAOwox5r+DB9
 UMQirHI+hp5/JQwhXJV2G/E46nKZsHzgJ2eGliQcvbh1lOwEIRjKzs90Uwnjyb34rcjB
 0VFVRvzexfzWGCBTTX/zrF+5zd5xJb7lS34tfSqN4XxAbenXHHZNI+JSnAP2cNliFeS2
 jYROWEOdUzJy+Y+RNL2aFndY5gJf4Wj0OxhOtiJaGycW5LkASd7KHgIeiwDPeCvpEuN6
 XLBQ==
X-Gm-Message-State: AOAM5324R0N/kC88AaOIIvpJ8HTtBTuYkdqWA7dHdPUJO8gf0etsqfrv
 qqUmJhDvZJbnh+WT7Vs5PNVngg==
X-Google-Smtp-Source: ABdhPJyXdq5B8QVpPtA/vGhBnMsMBSDg5AHWXFSNZLjVLUgNRmQL0nqZJ0NKkSD+D9My3dMqyqPl1A==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr66296042wru.373.1594393146438; 
 Fri, 10 Jul 2020 07:59:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r8sm10186461wrp.40.2020.07.10.07.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 07:59:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 846AB1FF7E;
 Fri, 10 Jul 2020 15:59:04 +0100 (BST)
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-61-frank.chang@sifive.com>
 <87k0zblgjx.fsf@linaro.org>
 <CAE_xrPhKg1FeRwW0zS-jpfo8XL7WvSFywif27X0kAYgh044N6w@mail.gmail.com>
 <878sfrleq9.fsf@linaro.org>
 <CAE_xrPht7BytoFxLdkGk+CRr+kEyT50woe_UE5mRVHjk6=pORA@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Frank Chang <frank.chang@sifive.com>
Subject: Re: [RFC 60/65] softfloat: add fp16 and uint8/int8 interconvert
 functions
In-reply-to: <CAE_xrPht7BytoFxLdkGk+CRr+kEyT50woe_UE5mRVHjk6=pORA@mail.gmail.com>
Date: Fri, 10 Jul 2020 15:59:04 +0100
Message-ID: <87zh87ju13.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Frank Chang <frank.chang@sifive.com> writes:

> On Fri, Jul 10, 2020 at 8:46 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> Frank Chang <frank.chang@sifive.com> writes:
>>
>> > On Fri, Jul 10, 2020 at 8:07 PM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg>
>> wrote:
>> >
>> >>
>> >> frank.chang@sifive.com writes:
>> >>
>> >> > From: Frank Chang <frank.chang@sifive.com>
>> >> >
>> >> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
>> >>
>> >> Did I miss the rest of the series somewhere?
>> >>
>> >> Otherwise this looks fine to me:
>> >>
>> >> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >>
>> >> If you mean float16 to uint8 and int8 conversion functions, this comm=
it
>> is
>> > everything.
>> > I think I just cc the mail based on *scripts/get_maintainer.pl
>> > <http://get_maintainer.pl>*, so probably didn't send the whole series =
to
>> > everyone.
>>
>> Usually I see the rest of the thread from the mailing list. I can't see:
>>
>>   In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
>>   References: <20200710104920.13550-1-frank.chang@sifive.com>
>>
>> on any of the qemu mailing lists.
>>
>> --
>> Alex Benn=C3=A9e
>>
>
> The rest of the patches are coming out:
> https://patchew.org/QEMU/20200710104920.13550-1-frank.chang@sifive.com/
> Not sure what caused the delay...

Ahh the mailing list is still chugging a bit it seems.

--=20
Alex Benn=C3=A9e

