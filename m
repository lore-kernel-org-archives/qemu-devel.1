Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0612DC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2ADF2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRJgWJ/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2ADF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04bO-0000jJ-UR
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i04am-0000Kn-Jl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i04al-0000KM-AH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:54:32 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:40358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i04al-0000Jc-4r
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:54:31 -0400
Received: by mail-oi1-x22d.google.com with SMTP id h21so4116994oie.7
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1tYhMEODOYzMF3OKQ8B2i3Sctd/+03gzupPv1rcsq6A=;
 b=fRJgWJ/urbZKpa6weMOl+lVCRK6hTUxkUlZdYgLxzfKO5Wze3bvMQcE0jaVUqBBoUm
 2TolFDL44XxD31Ydtd/58MM17zvrcUrigYES5DK6/JNKrvlRK7JEsE1sGmk2kcRaXfsx
 DGs+qjRrYDGnH6vCiq2IzCzOWmebJBULbOzGxbOB2a7rXA0SSbv/HvWFB+0AoW2FmRAv
 5jvoSmIIQ67oZkI3EBch1x8G6UWJeC+X79VpkVuYUK+FclZPK0A4r5Jdv0v7wqQqfj+E
 53GE8OQCeJPomlLETWdjiJiY3sZ9vrhGJVQmieXm6vsE8FaN38geC+GJb6TEU6+EJfo3
 c4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1tYhMEODOYzMF3OKQ8B2i3Sctd/+03gzupPv1rcsq6A=;
 b=IecBjqsCBr73Tu4sJqwFrg/pkI3cthSZESnOwJImftdXnkrWA2Pm4Wr1yjfzES6CsP
 7GBt9EbUd6O6JHmOKvDlNG6no34f3HIr8xLLNHy/KzIl5tBTDHRKY1ZLNm89Sbh1vXV7
 tE/aWeENzIaaB8x9PUmUK+T5BBorXrQTSzr2lZfzjGtA+RA60JsfO6ovDWVQ7Rp/TaJb
 sp96Sx70nWZAOVRwd9B8MAz2+dyr4s2KmFQjOIzTuHPAlK6aunDiypp8Wl1XTeIGaCGn
 G9Uo0doCOij8qZR5DxHfkSkGv0AHA0QMrxBq7NGBylWV94R1zciJpLsR9+7ESTto9ygz
 av1Q==
X-Gm-Message-State: APjAAAVQitovX8go3cg1N1BHhPt4rs+8JaroHCPejSBBuKJuZmrlx7oD
 2jkgY42hLUNulNykDxFzk9VojYPO6NpYAboe/T7hWQ==
X-Google-Smtp-Source: APXvYqxFbUIyf9lH0fBaozTk+v7HFf2xe6n9B6G/ecgVhMGTECplwJXVDAEXH7Q0es99D5Qp4t5qj3i7HiDTljYpQmA=
X-Received: by 2002:a54:4718:: with SMTP id k24mr74736oik.146.1566309270216;
 Tue, 20 Aug 2019 06:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190820074749.25208-1-thuth@redhat.com>
In-Reply-To: <20190820074749.25208-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 14:54:19 +0100
Message-ID: <CAFEAcA_GwEjt+4qt3_dY=mWpavphkyy0zHdUVHKMDLL9s7zTGA@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL 0/8] Improvements for the Kconfig switches
 and Makefiles
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

On Tue, 20 Aug 2019 at 08:47, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 50d69ee0d82378c7c21f482492dacfe0916b4863:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-softfloat-headers-190819-1' into staging (2019-08-19 15:58:01 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-08-20
>
> for you to fetch changes up to f874d7293589ab42bf5da0c03c9048e5d11c292f:
>
>   hw/core: Add a config switch for the generic loader device (2019-08-20 09:11:17 +0200)
>
> ----------------------------------------------------------------
> * Improvements for the Kconfig switches and Makefiles
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

