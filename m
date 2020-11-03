Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7336AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC38520E65
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ByFCCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC38520E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Si-0002lc-Lt
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ka2Rn-0002JK-Mr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:58:27 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131]:36175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ka2Rl-0002Ik-KU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:58:27 -0500
Received: by mail-il1-x131.google.com with SMTP id p10so17249578ile.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u6q8jG5bHWI7eqWyRnKTw72n3Ayv/dRHFS2O0XAnqOo=;
 b=O/ByFCCeA9qkSC7tWZe4JHSw0FntCsNn0iL0nO5PQvLcHhnmQ0X9rp5QKuEDfxXzVe
 /aKorRp3iU4cuzAim4uxITvLlxdj9WUctEet3/4iph+bcKpn+bR6v4xNXvEp0yyB5riP
 AzmhNzU6u9tBot1WcxsTEDgWOymMnMrTD2fiQH+6nywdAzlh1m1wWR4B5BcYpYKasvJ6
 j47SBghU/4Df8Qv7Vbp8usSPItZqANtehRgeMyAibYIRhrM/3QwRdZgemStDHT6qTiKf
 /mKYkCwSYql47Ek6mn/qXJPBgLAtkr8SLo+YlxMbJqivHPw9VPwvw9mq4+SsZPn8oV1M
 305Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u6q8jG5bHWI7eqWyRnKTw72n3Ayv/dRHFS2O0XAnqOo=;
 b=uNmOs+8oo6MFIHECG8vifXsIRxkfuOYfhTQ21ChzuYtLUZfAx7SmMQpmo/kI9CYanM
 zVdN370CXRlwUt3d6UFoHt3StRyyll4xepMcqNxE+neLvqcu99b8YjaFnCPWAqH9rh6K
 2H/SnO8vvN04aPMpsj0rZZ/FWD+ipaoRIxtcrmb980F9dketTeeK6EpAuXW7iCJjM918
 IF71jRcZkTc4yhpRm/7r80YfhtbmiwQdAp08o3iHB0eyGVoGcEFUsirfWhv6VnjKsfEG
 t4eN2h8M2csNdX/TEpp6OnerZ1fanwsDQL6tZYv6IihmHFkgTnv34lolm30iEU48/Kkp
 eyKA==
X-Gm-Message-State: AOAM530EKNnoSGwRm2Z2kZBuF5csNZqS0Yh/yqkFp7fBTKRKuQA3fb7B
 YnHZNGoyFxHw9LZsvZO00pRfyWKlR6osfDmCPsc=
X-Google-Smtp-Source: ABdhPJyNqQ/5sEmG3UGN1Q4lGKmLr3DpBPdkMU56zipHqc738QOo91eiqH1cTqoDZ92IgRcdtBbS6NUSIwGAkIifBMg=
X-Received: by 2002:a92:d991:: with SMTP id r17mr14022620iln.227.1604433504515; 
 Tue, 03 Nov 2020 11:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20200330102945.2388294-1-laurent@vivier.eu>
 <20200330102945.2388294-2-laurent@vivier.eu>
 <CAFEAcA97s+jiZxH+ObdFeFgs7-Wub6XjZvJFmL2s4voRrny38Q@mail.gmail.com>
 <a1fd7792-b7fa-6e86-4a24-b53fb7ecac0f@vivier.eu>
 <CAKmqyKN81bBXtJei7ch3CFLqjsnyiVfZOmYuTEL68a=i7JNPOQ@mail.gmail.com>
 <7a26a668-cd6f-8d7c-5c35-fd15ad74a92b@vivier.eu>
In-Reply-To: <7a26a668-cd6f-8d7c-5c35-fd15ad74a92b@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Nov 2020 11:46:28 -0800
Message-ID: <CAKmqyKO7LDqXt8=1mw0g8dLoTN1cDyL_PP-+cD8k0tCn+4xRgw@mail.gmail.com>
Subject: Re: [PULL 1/1] linux-user: Support futex_time64
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x131.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 3, 2020 at 8:00 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 03/11/2020 =C3=A0 16:40, Alistair Francis a =C3=A9crit :
> > On Mon, Nov 2, 2020 at 11:29 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Le 02/11/2020 =C3=A0 19:15, Peter Maydell a =C3=A9crit :
> >>> On Mon, 30 Mar 2020 at 11:31, Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>>>
> >>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>
> >>>> Add support for host and target futex_time64. If futex_time64 exists=
 on
> >>>> the host we try that first before falling back to the standard futex
> >>>> syscall.
> >>>
> >>> Hi; I dunno why Coverity's only just noticed this, but in
> >>> CID 1432339 it points out:
> >>>
> >>>> +#if defined(TARGET_NR_futex_time64)
> >>>> +static int do_futex_time64(target_ulong uaddr, int op, int val, tar=
get_ulong timeout,
> >>>> +                           target_ulong uaddr2, int val3)
> >>>> +{
> >>>> +    struct timespec ts, *pts;
> >>>> +    int base_op;
> >>>> +
> >>>> +    /* ??? We assume FUTEX_* constants are the same on both host
> >>>> +       and target.  */
> >>>> +#ifdef FUTEX_CMD_MASK
> >>>> +    base_op =3D op & FUTEX_CMD_MASK;
> >>>> +#else
> >>>> +    base_op =3D op;
> >>>> +#endif
> >>>> +    switch (base_op) {
> >>>> +    case FUTEX_WAIT:
> >>>> +    case FUTEX_WAIT_BITSET:
> >>>> +        if (timeout) {
> >>>> +            pts =3D &ts;
> >>>> +            target_to_host_timespec64(pts, timeout);
> >>>
> >>> ...that here we call target_to_host_timespec64(), which can
> >>> fail with -TARGET_EFAULT, but (unlike all the other times we call
> >>> the function) we aren't checking its return value.
> >>> Is there missing error handling code here ?
> >>>
> >>
> >> I think the code is like that because this is a cut&paste of function
> >> do_futex() witl "s/timespec/timespec64/".
> >>
> >> And yes I think we should check for the return value.
> >> I'm going to fix that.
> >
> > Thanks! Let me know if you want me to do it and I can send a patch inst=
ead.
> >
>
> If you have time, please do.

Sending the patch now.

Alistair

>
> Thanks
> Laurent
>

