Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F27C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F06247D4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBjh27yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F06247D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrqy-0002Hp-Be
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrqK-0001lO-Fp
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:14:48 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrqH-00075s-81
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:14:48 -0400
Received: by mail-ed1-x542.google.com with SMTP id l16so841302eds.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EI+re5JhF2PN5CNGKWP0QgpLvNRbG0r2n5XJ/TemNC4=;
 b=lBjh27yDbKVGFCcQ2b6lR8BV1f9/7oytu2GhprK/Vo0SxfcL77uCVleZ27qZZXODe8
 9iFSro6zk4hafUqZQerQFfChhIfd/OICwadXK/tW2GAwHXsGfk0YYOl6a1MG9fPDqvY5
 HcK/+ylP/0Rl1KbxNBGJ3pJkj8veekErA1+mHDoEhAf/1ozR00ypWFe6JcccbuWjY34r
 I/5AoEV68C3bOzjmVpyXDfOd5IeqhWfx8DSfnUHw1ZidvkZHtnqh2JIgkanIV/yQwaTU
 9r5A4WgP1IDWZexKbg2gcbc+pGUf7op5MS8zAkREpyCrIeKFO8R9V7PGufGS/FFB8TsQ
 ktSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EI+re5JhF2PN5CNGKWP0QgpLvNRbG0r2n5XJ/TemNC4=;
 b=nZm0g9wl7ayPJZvD/dQEfk3g6woTBHIzWn/ClyjEQNkTEBGCZwe9dqQ++ZfHpKDXD+
 /c+Ur67ZU3aCxi4a8dwp15DNotOaPzRIO7fwM3EyZjKpsDReCGY96g/VFd9F/ExTjVEv
 dUqf++CmpYljV2Mo8fxrO5GVUl8+IoJKfOaD3yIreuMUSvhR5QYyoGCYYX3DWJvq3r79
 WEmuJzbbE/Zg173kVp5U/AyXMIUoQi++Ra+8r38Qvfg4H9VpRctOvAHAK270ujaWLXJJ
 F5l7Y8/23WEKOvajLF/o+xIAExQ1uw4zFt7A2NqT7MAp8Fc2pKsQ+CTWrSwyFMRyXbeh
 EuJA==
X-Gm-Message-State: AOAM532Dp82J1jcRPPTHRAI8i7BvY4dI6PmQfXZeI5QzP5AkGKU1IH1m
 QvFG0me7deE+WDLo4V6pJ/oC16qv1xxkzKDuCgaKGQ==
X-Google-Smtp-Source: ABdhPJzxJ58G8bO1cUsujEPiECPK/tTD85csERzqMUPTYqYtyQFcm3y7ppEtAx3TIsO2dESWQpWCbFWIudUef2CZkt0=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr711452edb.52.1603916083591; 
 Wed, 28 Oct 2020 13:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-10-kuhn.chenqun@huawei.com>
 <9992abee-6af6-5fae-15f6-3039fca84e80@amsat.org>
 <61ec3c46-f01e-c4ea-de28-a55507192ff3@redhat.com>
In-Reply-To: <61ec3c46-f01e-c4ea-de28-a55507192ff3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 20:14:32 +0000
Message-ID: <CAFEAcA-Pm2n19mVV0i4=551aVYW4wcOLE5BE14YmrpqowQr_nw@mail.gmail.com>
Subject: Re: [PATCH 9/9] hw/timer/renesas_tmr: silence the compiler warnings
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gan Qixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 15:07, Thomas Huth <thuth@redhat.com> wrote:
>
> On 28/10/2020 10.59, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/28/20 5:18 AM, Chen Qun wrote:
> >> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed w=
arning:
> >> ../hw/timer/renesas_tmr.c: In function =E2=80=98tmr_read=E2=80=99:
> >> ../hw/timer/renesas_tmr.c:221:19: warning: this statement may fall thr=
ough [-Wimplicit-fallthrough=3D]
> >>   221 |         } else if (ch =3D=3D 0) {i
> >>       |                   ^
> >> ../hw/timer/renesas_tmr.c:224:5: note: here
> >>   224 |     case A_TCORB:
> >>       |     ^~~~
> >>
> >> Add the corresponding "fall through" comment to fix it.
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >> ---
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Cc: Magnus Damm <magnus.damm@gmail.com>
> >> ---
> >>  hw/timer/renesas_tmr.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
> >> index 446f2eacdd..e03a8155b2 100644
> >> --- a/hw/timer/renesas_tmr.c
> >> +++ b/hw/timer/renesas_tmr.c
> >> @@ -221,6 +221,7 @@ static uint64_t tmr_read(void *opaque, hwaddr addr=
, unsigned size)
> >>          } else if (ch =3D=3D 0) {
> >>              return concat_reg(tmr->tcora);
> >>          }
> >> +        /* fall through */
> >>      case A_TCORB:
> >>          if (size =3D=3D 1) {
> >>              return tmr->tcorb[ch];
> >>
> >
> > You fixed A_TCORA but not A_TCORB...
>
> A_TCORB cannot fall through, since it always does a "return" in both
> branches of the if-statement.
>
> However, it also looks really odd that A_TCORA falls through to A_TCORB h=
ere
> and return that register value instead. Is this really intended? Yoshinor=
i,
> could you please double-check whether this is a bug here, or intended?

See the discussion in this thread:
https://lore.kernel.org/qemu-devel/CAFEAcA8c2dywr=3DZxz1ExAV-48JwFU5vbBDDfA=
=3D_KE98XamnXiA@mail.gmail.com/
from when Coverity spotting the fall-through.

I think this cleanup patch from Yoshinori deals with the fall-through
stuff by cleaning up that area of the timer device:
https://lore.kernel.org/qemu-devel/20200711154242.41222-1-ysato@users.sourc=
eforge.jp/
It just needs somebody to code-review it :-)

thanks
-- PMM

