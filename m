Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E6B2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO6P6F4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E6B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jladF-0002kW-7E
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlacT-000107-DS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:08:57 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlacR-0008D2-Jg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:08:57 -0400
Received: by mail-lf1-x141.google.com with SMTP id i8so1656031lfo.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B7OpIdvwwJ6dMqe2bdNIv/fEEahLa2yMeXnF6IpXGPs=;
 b=hO6P6F4a4aiBB19YOP9rvaFNQY2XpQ0d00+TLHGDwG0GzRmcbrF2HbPxS4+Dgkinrv
 HBRwD1MwXuEsJ3/a+cfY1yU//1TCH3ATCUXymcPPn7pIeOyOsajAXO8+O/oOJb0Xqc+o
 Evj6e79UY0QLxowJLEzOtnc6Zmw7K5Ez75/oPYR6GlvmXLHcMU31BkJrTxXhI4FDaLib
 QykURsGi0UqjdST4Jl27C1+ATNfR/cKbEnx1kVgyL4zQCrILCHP4lCP522bkRZONp058
 gBVGMoz/si0cTp45wq3dZ/3YN23FwE2hgh8I8gGPdALl4HXlPdCMVpzOOdTgzQcTOtJT
 +p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B7OpIdvwwJ6dMqe2bdNIv/fEEahLa2yMeXnF6IpXGPs=;
 b=KSQmaTylajG/5pb/7crZdjH2R3ESRB71HpbYtKMCSPNE/LBfkZIWzXl6+UEMzNsUl2
 vVB7mZa6zcQA8/3J6m6J/DWPpyTUQFjWm2XXUdROPX+xZrdVuvnh5OOCNjZtmm232ZaZ
 mKVnHWCMsnmjw4vjMOP6mFb/BFovXqvBH6WLnnE35UWBpIgTmx52Q/C+Y+1tCiXBOQAb
 x9Gd4smXZeCpTfqoVwMG5sb/djPC0Edx4syZHbb08u8RJFZHidY+CcvIkcAL4lGkFpCT
 THEgVcEC0OwjAYpMW4Fhk6axHO7oVMJ7H1vO4gYR5IeW6a2/5LxSEYQzODI3nO4TyD27
 u7+g==
X-Gm-Message-State: AOAM531/0TBnuLaOT3wKl4BUkm8MYNMo4pLQaHc+xWLkx+dD2X8AQTBH
 osnuZwM1LHT2h3t78UN+TqJXf1TubiySEfiKZZg=
X-Google-Smtp-Source: ABdhPJwJqceq4hECuOc9YrdwwDN+Vx8mpI3tgZeTUNK8if8LX0or0xkfSkK99rZbDcQvBWDOxjDR8coldcnq+u757Zw=
X-Received: by 2002:a05:6512:691:: with SMTP id
 t17mr5204346lfe.85.1592410133539; 
 Wed, 17 Jun 2020 09:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-3-ahmedkhaledkaraman@gmail.com>
 <874kr9yjjc.fsf@linaro.org>
In-Reply-To: <874kr9yjjc.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Wed, 17 Jun 2020 18:08:17 +0200
Message-ID: <CALTWKrWtK83iSUUfhtX8bBacQZ5zNWt=vE3nGqXYLw+vJ_VKng@mail.gmail.com>
Subject: Re: [PATCH 2/3] scripts/performance: Add callgrind_top_25.py script
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, ehabkost@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, crosa@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Mr. Alex for your suggestions. I will send a v2 of this series
with the updates.

On Wed, Jun 17, 2020 at 2:16 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> You will want the script to be +x if the user is to execute it.

Thanks for the reminder. Forgot to do this before sending the patch.

> > +#  Print the top 25 most executed functions in QEMU using callgrind.
> > +#  Example Usage:
> > +#  callgrind_top_25.py <qemu-build>/x86_64-linux-user/qemu-x86_64
> > executable
>
> Why limit to 25, make the name generic and maybe just default to 25
> unless the user specifies a different option.

Very valid suggestion. Thanks!

>
> I would recommend using:
>
>   from argparse import ArgumentParser
>
> from the start as adding options with hand parsing will be a pain. I
> would suggest a specific option for the qemu binary and then using a
> positional argument that can be read after -- so you don't confuse
> options.
>

Great, what do you think of the format below:
topN_callgrind.py -n20 -- /path/to/qemu executable -executable - arguments

> Direct os.system calls are discouraged, you tend to get weird effects
> like:
>
>   ../../scripts/performance/callgrind_top_25.py ./aarch64-linux-user/qemu=
-aarch64 ./tests/tcg/aarch64-linux-user/fcvt
>   sh: 1: Syntax error: "&" unexpected
>   Traceback (most recent call last):
>     File "../../scripts/performance/callgrind_top_25.py", line 52, in <mo=
dule>
>       with open('tmp.callgrind.data', 'r') as data:
>   FileNotFoundError: [Errno 2] No such file or directory: 'tmp.callgrind.=
data'
>
> I would:
>
>   - check for valgrind in path and fail gracefully if not found
>   - use os.subprocess API for launching (with or without the shell)
>

This weird error was because of the space between "&&" and "2>/dev/null"
These were inserted by the autopep8 python formatter before committing.
When this is fixed, everything works fine, but I believe your
suggestion of using the os.subprocess is valid so I will implement it
and also check for valgrind as you've said.

> > +
> > +# Line number with the total number of instructions
> > +number_of_instructions_line =3D 20
> > +
> > +# Line number with the top function
> > +first_func_line =3D 25
>
> for example
>
>     parser.add_argument('-n', dest=3D"top", type=3Dint, default=3D25,
>                         help=3D"Hottest n functions")

Will also use:
    parser.add_argument('command',  type=3Dstr, nargs=3D'+',
                help=3D"QEMU invocation to report the top functions for")
To parse all remaining arguments after "--".

> > +# Get the total number of instructions
> > +total_number_of_instructions =3D int(
> > +    callgrind_data[number_of_instructions_line].split('
> > ')[0].replace(',', ''))
>
> There is no harm in having your steps split out a little.

Noted!

> > +# Remove intermediate files
> > +os.system('rm callgrind.data tmp.callgrind.data')
>
> os.unlink()
>

Noted!

