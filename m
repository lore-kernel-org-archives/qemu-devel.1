Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF10FC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7347E2166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8vPGoB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7347E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlEV-0004aZ-3G
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSl8D-0006bh-BF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSl8C-0005jl-7i
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:59:37 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSl8C-0005jO-1Y
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:59:36 -0500
Received: by mail-ot1-x341.google.com with SMTP id l14so2601459oti.10
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YlTR4TdSPoOesve9OqxIozhrIPiBsAGxdnkBKhvgtrY=;
 b=K8vPGoB2VlBbIC2Tg4G3Pq/99ABraVY9h3aszfV2Io0MevfPb75Y9z8NJ0SuBXJCFa
 N3j3JyHon1wpDu7kHaLkUKm7MT3vWYasF+HbGqXFchpjsBEZj43tWtb/GOGbGOYB77V+
 uM3x1ylHoWZbcQYTs74j95rSWb88jAMerxnGaXxtdZGUhcvdL1KXV+fAtLjGyv9AXmsv
 DLolkTjPpJS1QiBhVZ3n3LhFTkt3DQ00nXehLzNy+F274JV9beZxGjQvIUXKZI+oikjs
 lne9ssA89GWUFnn9CqCSVVPUx7QQVIAg1hnEnv8jH6AoADKXRaqaNtfoDEkSbSdTZ5/v
 91yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YlTR4TdSPoOesve9OqxIozhrIPiBsAGxdnkBKhvgtrY=;
 b=aw97QJgSFBakYgYDgJ/vbDs/Wcev/gu7xPoPPGHvSEdyiQDJybtMpZB7fBm+YoFcsh
 uJxP3x75P1DSVIpybEi5snT0H9aN4rzCvtAdxuicQ/tQvaa+cAYVO0q4vWgS5oEmBm5o
 6VbMpVt0USQGossXVoa4dx9JXYLD5dUbDF6gk1cbwFD2YhnQuWWm9DFCJMqk+vAyKrwu
 OyOYznzzSDpwTrq3i5HAhKtUOzqG/KcE+uBjQ6J2bMWA9uL0EcYHm+Cd5DTKl2g+6I0d
 xiPTkm8RedZFhCH/uJLpaRi1BxDxIvc5NLVEootzQIS/JpnLnY5n874PE7apoPAR63X7
 qLmQ==
X-Gm-Message-State: APjAAAVRgjEXiETV941Kk5RhGQ0Y6fVwaxtJqtLHokeX+da0enhg0+ev
 nVu+iiUTNIIBkcYC5/kTW7bEadRsi27a41aIe1zqjA==
X-Google-Smtp-Source: APXvYqzIxmerSzgEKKe21KM237lxkZgTuMYSklK0IoD9d58+pfjE4DhN4pZiFE/zWcCTMexUHKANrqbFVaJBt80ZPqM=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr1878477otk.91.1573145975246; 
 Thu, 07 Nov 2019 08:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-3-beata.michalska@linaro.org>
 <5c75bd31-213f-88a4-2eee-0046f99f65fe@linaro.org>
 <CADSWDztHetgmbUOp4WyRAkR0daAG6kkwhUTcyKWiCTWHQ1XB=w@mail.gmail.com>
 <87lfsrhbf2.fsf@linaro.org>
In-Reply-To: <87lfsrhbf2.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 16:59:24 +0000
Message-ID: <CAFEAcA_CTNu0Zzc-carvJaFbqtDm4bftN0QCB6dksKPECMv-+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Memory: Enable writeback for given memory region
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Beata Michalska <beata.michalska@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 at 16:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Beata Michalska <beata.michalska@linaro.org> writes:
>
> > On Wed, 6 Nov 2019 at 12:20, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >> qemu_log_mask w/ GUEST_ERROR?  How do we expect the length to overflow=
?
> >
> > In theory it shouldn't, at least with current usage.
> > I guess the probe_access will make sure of that.
> > This was more of a precaution to enable catching potential/future misus=
es
> > aka debugging purpose. I can get rid of that it that's playing too
> > safe.
>
> If the internal code might get it wrong and that would be a bug then the
> g_assert(), if the values are ultimately from the guest then log with
> GUEST_ERROR as Richard suggests.

...or consider asserting at this level and making the target
specific calling code sanitize and do the GUEST_ERROR logging
(it can do a better job of it because it knows what the
target-specific operation that the guest just got wrong was).

thanks
-- PMM

