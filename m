Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87625C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8312311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MK1V/27u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8312311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLX35-0008Et-3X
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLX04-0005yc-LS
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:33:52 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLX00-0007HY-JE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:33:52 -0400
Received: by mail-ed1-x543.google.com with SMTP id n22so116473edt.4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Btl4FPZQgdO78dzpd+d4Ko721XLDPeypchuq83fgFw=;
 b=MK1V/27u+7+RUV3t+oObtYiBFS1mO+Nxsc1bJff4XX8eqPrjo1aFQtu5IBrM5jBIY5
 mQUvdsyHjVtufgYBLPBJy7tA5CwDnTh0SsFn2l6erEQ+LmxRTLrn8xQzcZmt5U4c68AB
 5JiHUaDalYcF+SDf9RVudFL00nNAf1le1rfsnY8Y1bfGfR7mN5k1qYhWH1ZX/pjPgEPl
 /ef3EUxvjARpfmdfn+CPY0Oj/8Mk/YaH0lLfOj00a9QA2TcrwAriK2YOBGkKQoh/2JSO
 +w9yC70wKXScY24Zy4Te/HYC+xb3hwEIE0B21vECy2XidXAW8b6PjhTEgWL7w7Q4rzfu
 SxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Btl4FPZQgdO78dzpd+d4Ko721XLDPeypchuq83fgFw=;
 b=heRbfXWIQEvonxHAVCKX/Bq5W7O32i/UsatobNJGz8MrJqzhzNmtG4fwbY8oA9F6Zh
 22pzB5q0ONLVc7jvDVPMipsZ7IpKmVeItYD2FF8XYxxpqJ3U9LewMnU9t1kPdi35lyUX
 AfHshn6RcmDYXAfcd72clKlwm8bcJzZldg/J8RS8+IYKMkQR7UBFOl+Jg+gNh0xxrurd
 RzzD1OiEJJMsNldAHR+iB9jSOgckoFkLOV8Jo8o2o1Bcs75uRtHgXbbkz1++20TkeSMl
 BWqQBY8YSt2YY+ggxIaCKD/9Mwnaex0JO1WlfcjJutS/LOzXCHKEtylOMwvrh/beR8z6
 SzXw==
X-Gm-Message-State: AOAM53252liJEvpfSr1t7uOEghavceK0jPpsoy4u9iZWokJnhpjzskiR
 8nTr/j4HpI266vR6FpOp1CGx0F9AoW2B48VAyLF1rg==
X-Google-Smtp-Source: ABdhPJzAzq2CZ6V0oWRSDqhDyMTkUxMwZrFQMmw/XnMylbzSUK7zldWVYjvlxY5bB2OD2KeGjic+vzonTEZ3GX9TQcs=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr347616edw.251.1600976026577; 
 Thu, 24 Sep 2020 12:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-5-philmd@redhat.com>
 <CAFEAcA9XOpCyWr0QXn6T_y9nh4ZX5Op2ztonefr-pV2oQfU3iw@mail.gmail.com>
 <fd8a9c3e-45f2-caae-25ab-5e1365fd9298@redhat.com>
 <2a2cc60d-2d30-eb38-369e-0a26f0eac9bd@linaro.org>
In-Reply-To: <2a2cc60d-2d30-eb38-369e-0a26f0eac9bd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 20:33:35 +0100
Message-ID: <CAFEAcA-+ssh05EdeYLSoF=m8Yvg_ENoChrV6vT6H=NVSPUPFAw@mail.gmail.com>
Subject: Re: [PATCH 4/4] qemu/bswap: Remove <byteswap.h> dependency
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Sep 2020 at 20:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/23/20 3:30 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/23/20 12:16 PM, Peter Maydell wrote:
> >> I suppose if we wanted to just use the __builtin_bswap*
> >> implementation on all hosts (ie drop the special casing
> >> of CONFIG_MACHINE_BSWAP_H/FreeBSD/Haiku) we'd need to
> >> rename our macros to avoid potential conflicts with the
> >> versions in the system headers there in case they were
> >> pulled in via some other path ?
> >
> > Yes, this is why I couldn't get ride of everything
> >
> > After reading Paolo's suggestion to use qatomic*, I
> > am tempted to suggest qbswap* but I am still looking
> > for better alternatives...
>
> Hum, maybe.  It's pretty ugly.  We could just leave those alone and hope =
the
> system version is decent enough.

Mostly what I would like is to be able to be rid of the
configure machinery so we could just use a single
portable implementation.

thanks
-- PMM

