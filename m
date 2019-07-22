Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB8C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26052229C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlAL5+VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26052229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpULz-0007JL-Sa
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpULp-0006uh-TG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpULo-0006R5-PF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:11:21 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpULo-0006Qh-I8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:11:20 -0400
Received: by mail-oi1-x244.google.com with SMTP id w79so29066696oif.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=793T83tkHyyLAnyCOHvI0+kL3CPH0eBoZJlQrJ0IMH8=;
 b=FlAL5+VRUvHesoO/jIyRDxMo+7Hl/bKtpcy1rwNNIYfkchugtp9/W6SzryNJV5Bp8T
 HhEdU4sVXPVRm7ysoEA39OPcRIsnv/htECMY3F2eW+2afAPaptJg6mShsIgmh6Bg1mDF
 COfz+ps+MdkUN5qI/S+eJhmNh0PAhVnJ5zQR7f9grcoE9B8Qvx6Esqc0iIcGAm8YxTtc
 qwGcgXadLlVeCMW/AstkvHMNVowdNPzFfj7VGaM0usrAZXnIPA2750g84o4EPz6Ilvkx
 oKR1Oh9qdX9nUM1u48ZfgCXeBfT3xu52Ynf3y+65NvpHAdFPx6Qp0fuUyr8dje7gHlRc
 MrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=793T83tkHyyLAnyCOHvI0+kL3CPH0eBoZJlQrJ0IMH8=;
 b=dZQkoI+bO+PRJuYjGWaKROZSZY8qHqOaYO1qoPVifhbNuucqmfNTlTc5Aa5bc9rTGS
 kI2NbJXTOBzzctQB4sPaysHiq3eRcvTJOOIsw9xjtiE5knRROuBVnOAo1qunwxX6IM64
 kFUwjv9mHTXkTBiDImR8t9mi8CUabPv5gV9lOOJho3O78TABRiZqEVzpMHjbSIxK37FZ
 5Bz5qSHcs+2lXhFTFLGTr1R7WyV4qKpL3CYKlN68xPgIu4EixOEyOXInEAbkhziYuMEU
 w1cHf8Wg3+PQ7RrJjFVIzU4Yf20niSKVIj4MS2JC+d90eoBdxqPcggDX8PayjR4Tk5yD
 GyqA==
X-Gm-Message-State: APjAAAW0Cf+Q8whzloX9zZaFtNwT1UavfufoArXsjKTkb0wDFXhp+CwE
 0bCH6wydwutY6dH8HHQrO8Qa7uAyluxE37I2nfLo0Q==
X-Google-Smtp-Source: APXvYqwOVEJ7SU88PZ2DtbWg1gRd4WwEGD1ctvYDMCn5qmnQ3fi4h4hrPOZ2nFLdH/Y+3Ba0ZviNidF/8JCsLHwxEFY=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr34578628oib.163.1563786679732; 
 Mon, 22 Jul 2019 02:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190719134345.23526-1-kwolf@redhat.com>
In-Reply-To: <20190719134345.23526-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 10:11:08 +0100
Message-ID: <CAFEAcA_ph3inyE=usa3ODjpPnsfk90Az0E22=SaLfufZgRvTig@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 00/13] Block layer patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 14:43, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 0274f45bdef73283f2c213610f11d4e5dcba43b6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging (2019-07-19 09:44:43 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 49278ec065da3fbf90f7effcde3b39ac606b2e9e:
>
>   iotests: Test quitting with job on throttled node (2019-07-19 15:17:55 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: Fix forbidden use of polling in drained_end
> - block: Don't wait for I/O throttling while exiting QEMU
> - iotests: Use read-zeroes for the null driver to be Valgrind-friendly
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

