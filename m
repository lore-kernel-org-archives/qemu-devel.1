Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECFCC3565B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB50208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2ET64kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB50208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5DBf-000262-EB
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5DB5-0001bk-JH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5DB4-0004tF-Dq
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:37:31 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:40922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5DB4-0004sm-8W
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:37:30 -0500
Received: by mail-ot1-x329.google.com with SMTP id i6so2884266otr.7
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ep2kTkoMeshB8FDWBTs1bikYdviCZRG5WooJpLuOS/4=;
 b=Y2ET64kwSHnAdyf1UTGpFkSd9eqFP23hnky4TD3OhBq0GhEWAcIXmezedPGUbRmFcw
 ZI4c9RFDQHcU2hjOKf7cGSnU/6x+eSkYE+6p3SdnFttFRrG7k+ODDQGlQIO0zvx4X0j2
 cy8pmYEEUqosOI2Fnr/ay7R3SKW4nLWAQDaGX3GdPHLHlcdW+fdIyljWLwxpVJP+Trop
 fvp6t6v3EyWlSv/H54zauJvE1/AgoLIqcUtjawDHVxkc5R9wnkJAoydjzI4gwKAYeSgw
 IDFaGTQi7JqU8w4kQPuqpYIy/t5DtpqqFOM0mvkkwZlB5IV9QjcXEQMnELg4b3Mr2xCN
 8gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ep2kTkoMeshB8FDWBTs1bikYdviCZRG5WooJpLuOS/4=;
 b=Ihcg0+u86baCkd7pNZ+IELlTsn1lTZoYZ25/KCwW+VEIbKHE99tCZpD2r7f1nW+Bbr
 CdgLPk8V5TNSQIXhjfYagGEbKI2DR5GdSNByg3uiCIy8i/jzmBU+Ba9ebLn7AeR1GQw5
 S2dGl81kkWG3+HS3UgH1EkiX9HVoLmF6gy1aRNvAmeRqGpa4BktoZnu0Yd1fvi/M+l/R
 IWYx8eU5xKdyfVBmeRYggLh4wd5RSRyAIRBz2a9+KKesfprvFXjqad7uBGhE0PDDEkHG
 WtuRIB3p2i2apxHQwFSnG2Y871LiciW9RckLimLmZqpmc/NIsQmlyKmmBMvttSo2HmvE
 p24g==
X-Gm-Message-State: APjAAAVaYa51N3b8TTt5oTnS9ZZZJnFaPNo80wirvn0C+m0ICuL9MKWV
 dgIfYTEKwveczx7o3dGW/pMan8vuU8J3hSI9jbiQtA==
X-Google-Smtp-Source: APXvYqwR8W3eJkp5CE1VflZHD47LnOvYjDmgO2/y01DXIb6TgxgnTCo+cB2EsjffkRNQrY5x3TehURhMH+phWMwSKp8=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr27960769otq.221.1582310249276; 
 Fri, 21 Feb 2020 10:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20200221132536.38364-1-dgilbert@redhat.com>
In-Reply-To: <20200221132536.38364-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 18:37:18 +0000
Message-ID: <CAFEAcA93VLAtzKwNG4iZzekt7=CdVzYu2kJhk_c4n=+Wxa+HQw@mail.gmail.com>
Subject: Re: [PULL 0/6] virtiofs queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, yangx.jy@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 13:52, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit b651b80822fa8cb66ca30087ac7fbc75507ae5d2:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-02-20 17:35:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200221
>
> for you to fetch changes up to 5bb8e8beedb47fc0d0a44957a154918c4f4afc80:
>
>   docs: Fix virtiofsd.1 location (2020-02-21 13:05:27 +0000)
>
> ----------------------------------------------------------------
> virtiofs pull 20200221
>
> Mostly minor cleanups.
> Miroslav's fixes a make install corner case.
> Philippe's set includes an error corner case fix.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

