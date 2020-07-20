Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11BF2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFWJ95e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11BF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxRtS-0000CN-3V
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxRsr-00083U-4D
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:14:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxRsp-0000d0-Fk
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:14:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id h13so11613202otr.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d+whMWSfIDFt3TpeZWPgYbGftykB3ke3qgvp5C039gY=;
 b=wFWJ95e3t/VCj7+G3JYo1aieG1+ejHBzRgE/evE+nHlAz6ZqqOzcLHgUPA+lTcsZBB
 CziJZdRAW1TAR0cqioENBbjHCnxEje/2qnLa680U5bOMaUoyZfkmQQVB4NbA7tV26933
 +PSvjk7gyn7y7c93KbmgXiwIxjsfd74bYZZOjd4Oh97T8umgZ6cmdpRgLpPEeV+hU1YM
 +Z7m4d0e9vEauW6HUmZ74aHDw2uIkwvi1xL5jzTa07tynxvl3JUS7cm8zKso6FZRPBCO
 ZdJIea6Cim76XgTgjezJVlG74jFIGgkTtzytmACj80IvPtZeUAQh3yftvRWt+V1Tmy5W
 6NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d+whMWSfIDFt3TpeZWPgYbGftykB3ke3qgvp5C039gY=;
 b=IfraTpqHYugyC4OQUs5/KhIMkFfuLY3G7dcN7ami656upFyfvrqMERMJvDcM+ZS7kn
 1FOYHG9T6k9eD0Q+SRuuIX22yPRsWu85xE6aDRt3zIKtHYiQ1eG6Z6VZ3VaWXFWURCyJ
 fqBCZhYy2d9sV0Ag/N3iKnEsBMjzGabc2sa5RR/2JwRXLlIoMdRKjNtIMb1OVCuM2QQQ
 Ea08OX7FLHBP1+dPOlgk8s1HPraCDi9LoL2N5RUIeGBVDqjl1IW6Lt3Ddfb/GZOVf8XB
 daHtVWGl0E6LagpMW/SBOMiizuCoNtqoge1ke8yOq9uFYgKe3/UZpmnOgC916wp4wduj
 673A==
X-Gm-Message-State: AOAM530KCBriesWBnKdkn8YN6ScCQL1Rr5gdFnEqCk0coQiZn8oR+6m9
 irN5AwLyVokRll9viWt16vZUBmiQeH3aBQTPJuEROQ==
X-Google-Smtp-Source: ABdhPJxlGjRRD5uBleC3oYOoI2XpcKzysNrGg6IKUQXVdmBBDtF2UCte2BkI9DHvHSEoG+FA9L5NU8tCEMf35Xh/TZU=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr18192653otk.221.1595236490044; 
 Mon, 20 Jul 2020 02:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200710091940.641296-1-mcascell@redhat.com>
 <CAFEAcA9XQUcdiy2x18Zr+EYDaJ4hY-1Bd-DgL6-j6sJi5Ow+Gg@mail.gmail.com>
 <df0eae88-2bc8-04fa-feb9-7633ba13d635@redhat.com>
In-Reply-To: <df0eae88-2bc8-04fa-feb9-7633ba13d635@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 10:14:39 +0100
Message-ID: <CAFEAcA_2zG1E1COPTi78DY2V2-e8sJwc-s0c7cCfm12U2DE00Q@mail.gmail.com>
Subject: Re: [PATCH] hw/net/xgmac: Fix buffer overflow in xgmac_enet_send()
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Rob Herring <robh@kernel.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 10:09, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/7/10 =E4=B8=8B=E5=8D=887:07, Peter Maydell wrote:
> > On Fri, 10 Jul 2020 at 10:20, Mauro Matteo Cascella <mcascell@redhat.co=
m> wrote:
> >> A buffer overflow issue was reported by Mr. Ziming Zhang, CC'd here. I=
t
> >> occurs while sending an Ethernet frame due to missing break statements
> >> and improper checking of the buffer size.
> >>
> >> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> >> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> >> ---
> >>   hw/net/xgmac.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
> >> index 574dd47b41..b872afbb1a 100644
> >> --- a/hw/net/xgmac.c
> >> +++ b/hw/net/xgmac.c
> >> @@ -224,17 +224,20 @@ static void xgmac_enet_send(XgmacState *s)
> >>               DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
> >>                           "xgmac buffer 1 len on send > 2048 (0x%x)\n"=
,
> >>                            __func__, bd.buffer1_size & 0xfff);
> >> +            break;
> >>           }
> >>           if ((bd.buffer2_size & 0xfff) !=3D 0) {
> >>               DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
> >>                           "xgmac buffer 2 len on send !=3D 0 (0x%x)\n"=
,
> >>                           __func__, bd.buffer2_size & 0xfff);
> >> +            break;
> >>           }
> >> -        if (len >=3D sizeof(frame)) {
> >> +        if (frame_size + len >=3D sizeof(frame)) {
> >>               DEBUGF_BRK("qemu:%s: buffer overflow %d read into %zu "
> >> -                        "buffer\n" , __func__, len, sizeof(frame));
> >> +                        "buffer\n" , __func__, frame_size + len, size=
of(frame));
> >>               DEBUGF_BRK("qemu:%s: buffer1.size=3D%d; buffer2.size=3D%=
d\n",
> >>                           __func__, bd.buffer1_size, bd.buffer2_size);
> >> +            break;
> >>           }
> >>
> >>           cpu_physical_memory_read(bd.buffer1_addr, ptr, len);

> > This is correct in the sense that it avoids the buffer overflow.
> >
> > I suspect that we should probably also be reporting the error
> > back to the guest via some kind of error flag in the descriptor
> > and/or in a status register. Unfortunately I don't have a copy
> > of the datasheet and it doesn't seem to be available online :-(
> > Does anybody have a copy to check ?

> I tried to download the datasheet from [1] but it's not a programmer
> manual.
>
> I think we can apply this patch first and do follow-up fixes on top?

Yes, agreed, since nobody seems to have docs for this device.
This is an only-happens-with-malicious-or-buggy-guest case anyway,
and the highbank/midway (only users of the device) aren't important
or widely used machine types any more.

I suppose we could add a comment
/*
 * FIXME: these cases of malformed tx descriptors (bad sizes)
 * should probably be reported back to the guest somehow
 * rather than simply silently stopping processing, but we
 * don't know what the hardware does in this situation.
 * This will only happen for buggy guests anyway.
 */

but anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Were you planning to take this patch, Jason, or should I?

thanks
-- PMM

