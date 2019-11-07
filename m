Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1110C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28762178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSzVGlzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28762178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSm48-0001qJ-T3
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSm2z-0001IX-0x
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSm2x-0003ms-HD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:58:16 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSm2x-0003kd-Bo
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:58:15 -0500
Received: by mail-ot1-x342.google.com with SMTP id m15so2781113otq.7
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yv4ylwd25GxZ7ALmze/v8BUzVwPLvD72QcNplUocu5k=;
 b=mSzVGlzcCLG/TN2hqhH7zzmnG8PLcLzInUUJ5G5B9tChnxLpJQd4/ux0vdwJeb05Ol
 CtO1oHKYBhDpBECqPJ9iTEHFGabpn1J9+319ZoOfs393R5cMY4MiOzC8GVBmcLCnCvbL
 2XDzlitCmnOFDDaUPK2K9MZEB8l8t6J7HubAqrfMQ09UBJDGtuOBgfylytj/K1/3+wUK
 PHBrKkQW+GIR49+0wRm+P+uKTal/vPBZHgfiTneV4cAj8/CYw8e3435bf60c0XjAZot7
 FAOw/dHpfghIjnOU1AbDgHGW3VztJEfJaRm9JMuUCfoIGsCCvbw9a0Ty6GLLPZ2AQ++L
 T+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yv4ylwd25GxZ7ALmze/v8BUzVwPLvD72QcNplUocu5k=;
 b=TvYuXH0zcPTwbBweB/geH7s5gDFF7VKRLi2uU58ETv0HM/nXgHWCfMM7KcwQLhzYXw
 3PDAUfCDrGiPNNVjJoRqk4Ys2cYdzaPL8RyVV8RDgkdcF0Mtq4VLG4E0A/FTMm0cBSTU
 1Lm7jYv4WYU4o9fpDi2lkoqWkVnt1VgR80Qau6ywLzmeMZ4BFS5+NvkRODOjscPGh/Id
 R/ZeoieM8YaCikBmDvoWZM0BIfucjlwGuhAdfe/4ycCNL4jA92FKufbdaxGpmWkCncJf
 Uk4qN/F065rCAJ9Zobvz/GNHQ3a6FPmZcMym6Utt5XJ+3S1hUcli2YJuYF4S0tW6MfPl
 WTDw==
X-Gm-Message-State: APjAAAVa2yf3AreuK2+V1vB5SyGAaX+DARMcQF5BW4cNOns5dEpbLb9a
 pEd3L3NB8s9OIyeQ9iC4anWoq7jiOO4G4EukNzS0Eg==
X-Google-Smtp-Source: APXvYqxBdHmD8PqV0ztRdp5PjYgPhtRtnEotw0BXbTCdeuu3G5CncOvG3W2PndzpAad32SWeIBW/uPTUXKhxnQbewI0=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr2125115otk.91.1573149493963; 
 Thu, 07 Nov 2019 09:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <CAFEAcA9SOok49C8NS-+kEZyk7EYS10R+RNmhprk2J=KB3bJQFw@mail.gmail.com>
 <c926f927-34d2-3efa-b721-f4036939182e@gmx.com>
In-Reply-To: <c926f927-34d2-3efa-b721-f4036939182e@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 17:58:02 +0000
Message-ID: <CAFEAcA8W_g=DsFXaE7cmMvqa3AtnWc0+xQMQvFFhWENvieV3Rw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] testing/next (netbsd stuff)
To: Kamil Rytarowski <n54@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, "Emilio G. Cota" <cota@braap.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 at 17:54, Kamil Rytarowski <n54@gmx.com> wrote:
>
> On 07.11.2019 18:46, Peter Maydell wrote:
> > On Mon, 4 Nov 2019 at 17:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> Hi,
> >>
> >> As we approach hard-freeze I'm trying to temper what comes in through
> >> the testing/next tree. However it would be nice to get the NetBSD upto
> >> speed with the other NetBSDs. Although the serial install is working
> >> well for me this has had a rocky road so if others could also give it
> >> a good testing that would be great. I've also disabled one of the
> >> regular failing tests for non-Linux targets. There are other tests
> >> that still fail however including the tests/test-aio-multithread which
> >> asserts in the async utils around about 20% of the time:
> >>
> >>   assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
> >>     "/home/qemu/qemu-test.nS1czd/src/util/async.c", line 279, function
> >>     "aio_ctx_finalize"
> >
> > This is unrelated to your NetBSD update in this series -- it's
> > one of the persistent intermittents I see on the BSDs:
> > https://lore.kernel.org/qemu-devel/20190916153312.GD25552@stefanha-x1.l=
ocaldomain/t/
> >
> > (though the failure rate I see is I think <20%, but I haven't
> > really carefully measured it.)

> Does this patch rely on AIO API in the kernel? If so than this is
> unreliable as of today on NetBSD. We plan to fix it, but there is no
> expected time of accomplishment.

No, we use our own AIO implementation which puts fds into non-blocking
mode and uses a thread which polls them to identify when they're
ready to actually perform IO (plus a lot of coroutine magic).

thanks
-- PMM

