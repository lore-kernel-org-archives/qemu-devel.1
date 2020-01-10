Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F966C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF9D2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMvXLFt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF9D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprmh-00029s-BE
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iprlw-00019g-K3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iprlu-0007uM-Ru
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:44:07 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:38530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iprlt-0007pk-Vk
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:44:06 -0500
Received: by mail-ot1-x333.google.com with SMTP id d7so1502829otf.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C+g6Rn4QrTHZg34K5O1nyr0rdZiKDcKiyiJE3g2HsfA=;
 b=rMvXLFt+rxzDTmPC0+OdLO9DJvxuyNvURy/TWc/yreHFzK9HRWghLXtbDkc0I3cy8p
 EsOPXTcV8CZelRhTK53b3gXDIgB68Zis/eFsdsYCRDU08CMmuipCiJjbj5pjUEvUJqv1
 8CGPKVbMIpRLycK2G94sUmF2CfclIcCUmbaUon1WZZcolfXsn1l4FKPsfkTw2JLG1/sW
 MLU5VqbSx68D0WMSBq4kbFtZ22a3Tk4aQYogVUm4So7mgg4fVf1OrWvYo0fiiavlPzw2
 LlUcVccqKCUdSXeilQemxlry8ok9a51MMNZT4a2CnMEUxPWp4+QKvzB5HiY7QwZXz+Os
 AEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C+g6Rn4QrTHZg34K5O1nyr0rdZiKDcKiyiJE3g2HsfA=;
 b=RCPGxsiiS5az/6zFDbaVbl7EquT5o4LlS/i8JgzWbEsuYtbJnBYHkrFhIM6bxDADXU
 gNw1a+rV9i05fAKzOuRwmY5eUnxCVxa6sZIM2RPDoBJTt+YuJDTMtfMmEGEl8XZYoygJ
 txt+wp/kluZ1UINSC5eIiB2Iix3sJ/pOUHIvtHjfIFjroyB7yGxKxVg/asiAKR85O30f
 PsAjFkqW+NoZqHNGY21AFpYU6yeQCAeEslHQKlptJy4X7aLdp6naI0cwRgVi2IOdHLfJ
 KXEhrqEunrlLkegCNFK1r8PsRNau4btX/h5FLDehSJWsGI2hNWyqZdIiavySl6q7xecP
 ohjQ==
X-Gm-Message-State: APjAAAU/imx0NVB0hJBhYvdjR+A+4x1HTX8CyqU3N3sl9Kk7/6xiY6og
 6JUs+oqFN5vdu3Ke2xWNiHa13yiW0l+evZhQRRxXbA==
X-Google-Smtp-Source: APXvYqxitRr86srueOltmgW6GXRCLRcv4RSWcfhV9YfTtppykeO+0anuZKFzLjfvywDj/Fe+Vwvhl89YpFpwGPEZPog=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr2064765ota.232.1578653045005; 
 Fri, 10 Jan 2020 02:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com> <87d0bujkpe.fsf@linaro.org>
 <CAFEAcA-AEKKL-0c4jpV5bMeAWszWndYWbqoaOqJBnDqn82N_AA@mail.gmail.com>
In-Reply-To: <CAFEAcA-AEKKL-0c4jpV5bMeAWszWndYWbqoaOqJBnDqn82N_AA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 10:43:53 +0000
Message-ID: <CAFEAcA-MTrAbZG7hR355MzQp1GTXUHeZodTJKidLT+piaw9fGQ@mail.gmail.com>
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 11:00, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Wed, 8 Jan 2020 at 10:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> > Thomas Huth <thuth@redhat.com> writes:
> > > What about "-accel any" or "-accel fastest" or something similar?
> >
> > "any" is just ambiguous, "fastest" is just begging for me to find a
> > micro-benchmark that TCG outperforms on ;-)
> >
> > "-accel default" could be considered to have vibes of Do The Right
> > Thing (tm) and could in time actually become so!
>
> That would be a weird choice, because it's not actually the default!
>
> The obvious analogy here is with -cpu best, -machine gic-version=3Dbest,
> etc -- use "best". You can argue that it's maybe not got the ideal
> set of connotations, but I think that trying to be consistent about
> the name we use for "do the thing that seems to be the most
> sensible for the host/etc that we've got" is worthwhile.

This is actually a load of rubbish, because the cpu option is
'max', not 'best'. I still like consistency, though :-)

-- PMM

