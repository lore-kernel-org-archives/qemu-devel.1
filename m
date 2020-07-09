Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7731C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A345C20720
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4G1S/0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A345C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYnk-0005Tz-Vw
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYmH-0004Qv-Vv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:48:02 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:34052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYmG-0005wW-Dq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:48:01 -0400
Received: by mail-ot1-x32f.google.com with SMTP id e90so2037921ote.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9DUmfFGjl3sjWTtHM3RtHZkDp6v0tAeyupQ/knhB+os=;
 b=c4G1S/0//dh9HggG26E8JNVALN9brdfllIs9r5ByaB9bglbwPauA4plRXqVnPPQb53
 5XNEVCq6QLikVV/U0wocDNfoayzKCgXVQ5i6f5/v7vEQUFT1KAM4rNRf9V19Wvq6XsMg
 httr0WXY0SojIayVFasushoIMkuP/T1sUaSF1eVZaAIW6fP796cRgKKqqfP1LUqwoAjR
 t5ptoNX/HXz3+94XTzO/MdRsQTPS0wP+CGQEhXu2NTSHwsahylUuQQ/p0uPTBIfmkBFz
 yiHxA4tTmprC3vfYodzPhLbX+j2MpEBdjScw0KL2kqT+oQ0a2ARt7ZTetPYNhkcXugOp
 Jzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9DUmfFGjl3sjWTtHM3RtHZkDp6v0tAeyupQ/knhB+os=;
 b=qP0OaGwpJMB54XdyS18cF/OJq9Qh8K6PGQ+Gd3Iex8WI5QHoGDHAFvr9YFhbrl1z2/
 Y8+1Yjq/ZQKVOMJBudoQRDhYci8PpdUv3+t0kNkzUnjb0FF3VwjjQhUo5n1NOI5Eu38/
 LryWD2p4Nfleo1/lfZ1CzFuxOEmUkALuAAbvAjoxcMFt9WlLZcml6ShG8z+M8PgJ23cz
 T1vxs4OvnI7WDTr4tTTgMuqXEkdN3hwOh3wLoVkEVB34OXMdLU2Tk+F3v0IZB0Ng/8Xq
 vVLXZc4JD5M5Ql5rn5OxUdppr6Wj8DI3G2ebGIJdteTV2+jlv0C/Cc8HVNC3FPpa/27b
 589A==
X-Gm-Message-State: AOAM533sDUl3T4+sSJofwkir1zGHD0gS8b4IgAaG9KCbdcGAyaQ/4dD/
 D8EpJCco0reX5wSCdh6xNyquy0oS6s0Xz48vLbG3Ag==
X-Google-Smtp-Source: ABdhPJzMmnk35QAu3CF+7wbGO0QVHKjCYzBB3RWwhfWGMEEwviv5bh7hRkVgmY63gc7nW+QIPhxINp6IwayRSW1Qprg=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr51918911ota.91.1594309679168; 
 Thu, 09 Jul 2020 08:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
 <2666aec2-9872-6af6-7705-d7ce553f611c@redhat.com>
 <20200709152630.GW3753300@redhat.com>
 <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
 <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:47:48 +0100
Message-ID: <CAFEAcA8hJKFy8gra9Kv9MbYv_kQqAi2dnW_KqJqGtL_8AUBMgA@mail.gmail.com>
Subject: Re: Is VXHS actually maintained?
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, ashmit602@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 16:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Jul 9, 2020 at 7:30 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>
>> On Thu, 9 Jul 2020 at 16:27, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>> > If it doesn't even compile, do we even need to go through the full
>> > deprecation cycle ? I tend to feel like the release where it first
>> > fails to compile automatically starts the deprecation countdown.
>>
>> Mmm, assuming that it's "couldn't possibly compile for anybody"
>> rather than "doesn't compile for me (but maybe it would be OK
>> on some other host OS config)".
>>
>> Marc-Andr=C3=A9, what are the details of the compilation failure?
>
>
>
> I have done some release bisection.
>
> v2.11.0 compiles, v2.12.0 started failing with:
>
>   CC      block/vxhs.o
> /home/elmarco/src/qq/block/vxhs.c:126:1: error: variable =E2=80=98runtime=
_opts=E2=80=99 has initializer but incomplete type
>   126 | static QemuOptsList runtime_opts =3D {
>       | ^~~~~~
> /home/elmarco/src/qq/block/vxhs.c:127:6: error: =E2=80=98QemuOptsList=E2=
=80=99 has no member named =E2=80=98name=E2=80=99

Missing include, probably. Anyway, if it's been broken like
that since 2.12 then I think we can reasonably deduce that
nobody can possibly have been using it and just remove it.

thanks
-- PMM

