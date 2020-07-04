Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 08:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAA820747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 08:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcvEP2xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAA820747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrdnv-0004eu-OJ
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 04:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrdnG-0003xN-SF
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 04:45:07 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrdnF-0003c8-2c
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 04:45:06 -0400
Received: by mail-wr1-x42c.google.com with SMTP id b6so35133515wrs.11
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
 :date:mime-version:content-transfer-encoding;
 bh=x3SeRKQpp+3eT5h1tNXskGzzKCqfHrpOvnQRZSqhku4=;
 b=mcvEP2xV9NeKvDaJESTafISoC/LA9mvS5AGaJy/chk/Sx9rg+rTCq/tDmt0x6r98xX
 VJgV/RiNYkGhspf1eSHEgz7S/1qbkL+YsjzU/nXaQAHdsJFhcAfmYnqjaoY2FHVfX6U6
 Ngr/MI+U6nKNJr+sXcHCdfFYhiSNGzgfgbDNk3VKMJTLTXLljJSKzLcW7b5jUIAFM7WM
 Jz8h8RW7dpB/3qDIpDtR0ghls6pgBxHVG14dnKk1wub8JsbSTMDslw0AhwTstyzWDRDp
 GBpCf+SYk+i0T8cCcmpAPGUociPkFKJn32FUoLhHOlOx184M+j0nGSbvSRJAxccMY4DX
 2qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
 bh=x3SeRKQpp+3eT5h1tNXskGzzKCqfHrpOvnQRZSqhku4=;
 b=pOk5b7F/Bzr8EagGKfiwQSgYGpkxvS/hmtXziDqsSStrtkf7yo84nNnC7R7ic+bAal
 F5aMa5hrc4ggR4JB9SV1AvK9bdR/tNC51EFydTnyt3RdRzbnDGZ/R3PMlfONPpAjxQJ7
 kMx7J4HxzVsL0oVXRhZGvgIS5Cw2QrJdZNi9KSYNTNTkkHvBv7GZArl2t3QHVEpDV8wA
 5aNCEFzuE2UI17j0ybMSXbA74dDWSlZ2zsGX+aei2noW6oYvGVmYB/px5tTPrYNUqMeS
 cGfZasuQAW9Qm1vVvxLQwP9xcS0bO6V8B/EUOy9opHhNevG3ibf7QB0k01xLpQHt2Hd/
 BIIA==
X-Gm-Message-State: AOAM532rtGu++VlUmL5cEpeYEud2XN3YF66WW8h1a1pJTYJc+YSG746c
 uc3Pd5tcMLl6zPhLLr+mNqg83g==
X-Google-Smtp-Source: ABdhPJwv+cJeR/5KR9LQrXFU6Z5qtc6n6k56McY9LuuNLBKsZY9QZf/lwGS1C1qTJeYfy8ai5DsrKA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr43499178wrx.219.1593852302937; 
 Sat, 04 Jul 2020 01:45:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r28sm7841878wrr.20.2020.07.04.01.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 01:45:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A42C1FF7E;
 Sat,  4 Jul 2020 09:45:00 +0100 (BST)
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
 <CALTWKrVx+e0oRVrvd27WeXAbAAZHVispG27cRPKwVo3HfNYbkQ@mail.gmail.com>
 <87sgebqm1i.fsf@linaro.org>
 <CAHiYmc4R2hP=ROCC_O0+0sO09TcH-ybwbk3aijxQo=LPpBztpg@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
In-reply-to: <CAHiYmc4R2hP=ROCC_O0+0sO09TcH-ybwbk3aijxQo=LPpBztpg@mail.gmail.com>
Message-ID: <87fta7fz3n.fsf@linaro.org>
Date: Sat, 04 Jul 2020 09:45:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> On Wednesday, July 1, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>>
>> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>>
>> > On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg>
>> wrote:
>> >>
>> >> Assuming your test case is constant execution (i.e. runs the same each
>> >> time) you could run in through a plugins build to extract the number =
of
>> >> guest instructions, e.g.:
>> >>
>> >>   ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so -d
>> plugin ./tests/tcg/aarch64-linux-user/sha1
>> >>   SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
>> >>   insns: 158603512
>> >>
>> >> --
>> >> Alex Benn=C3=A9e
>> >
>> > Hi Mr. Alex,
>> > I've created a plugins build as you've said using "--enable-plugins"
>> option.
>> > I've searched for "libinsn.so" plugin that you've mentioned in your
>> > command but it isn't in that path.
>>
>> make plugins
>>
>> and you should find them in tests/plugins/
>>
>>
> Hi, both Alex and Ahmed,
>
> Ahmed showed me tonight the first results with number of guest
> instructions. It was almost eye-opening to me. The thing is, by now, I had
> only vague picture that, on average, "many" host instructions are generat=
ed
> per one guest instruction. Now, I could see exact ratio for each target,
> for a particular example.
>
> A question for Alex:
>
> - What would be the application of this new info? (Except that one has ni=
ce
> feeling, like I do, of knowing the exact ratio host/guest instruction for=
 a
> particular scenario.)

Well I think the total number of guest instructions is important because
some architectures are more efficient than others and this will an
impact on the total executed instructions.

> I just have a feeling there is more significance of this new data that I
> currently see. Could it be that it can be used in analysis of performance?
> Or measuring quality of emulation (TCG operation)? But how exactly? What
> conclusion could potentially be derived from knowing number of guest
> instructions?

Knowing the ratio (especially as it changes between workloads) means you
can better pin point where the inefficiencies lie. You don't want to
spend your time chasing down an inefficiency that is down to the guest
compiler ;-)=20

>
> Sorry for a "stupid" question.
>
> Aleksandar
>
>
>
>
>> >
>> > Are there any other options that I should configure my build with?
>> > Thanks in advance.
>> >
>> > Regards,
>> > Ahmed Karaman
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e

