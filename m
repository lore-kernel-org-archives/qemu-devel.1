Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA01C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE3B20843
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XShN8zM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE3B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhVM-0001tF-P7
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzhTy-0000Po-PB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzhTv-0001cI-Vp
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:13:57 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:43633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzhTs-0001VA-1Y
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:13:54 -0400
Received: by mail-ot1-x336.google.com with SMTP id e12so1580437otp.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=60JqoMGoIGS0wuoTg7tCXWkqHLgyT5zwk1k40i2w9oU=;
 b=XShN8zM0FeycGd6J4Vue6KXBldbeZTOJ8mLuPMgS9j5tQ9WFOQ+zGHSYWL5czBzhLQ
 KtwP9SYLBiK+9kDivXKtFHCXaMDjIP94si2HRtYTc7ZbCsWKFO1YcPPfwqojgbf1p1gV
 ZaofQ/p4mY4mbrAl8O5kVaO3h56aldVkRy0n8kvEvPULQ4SHkHu3qDk8djKdWC1EYJw2
 kN0NBMD4g5B44vVFw6K3be8WYhePg8FBZNg13FF//29bVCcb3m0XGDpG3Iz3O1boHdFm
 WGclUZJZN+0EC9qizAUQzjxzmuANcLDLIN8al/Uw6j1Aga7LWSMv6ufyK3RCI9MG5a+A
 4f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=60JqoMGoIGS0wuoTg7tCXWkqHLgyT5zwk1k40i2w9oU=;
 b=sR8HLETJKgRSAkGgyslgHJAStZeUxX26VFbgfdI8J/RfmOpSwSd0p+ZZW95mIMVgNm
 yvO2vJMqgBmzYKuLrGKaUWWB4MlU4G74ZJrPI5Iet5Ldv7Tu/QupJAbnOE9C+R1rcmgI
 EZ+om6tNeFK5oQ/xoFa74H85G4TTNqYKrwfyQnqrWrRXKnvR77oqm249UAIkDhFvEQrp
 4GKh7FFOfzTCtscoquYx8RywlE807Dk1Tq1U1ofLkhhfeFTDPzD5bk8d6fbgqmI6qnK/
 tJO5NBKqajhhvCHONhs8wHOhi6yLkoIpx9Dkbq9QogaI8Cziht7u2GcnR8n96lUZeAsl
 uruA==
X-Gm-Message-State: APjAAAXJ6mwMAmBZDorib1iuZv16CSdJmElhPFyK6/fRZ+QISoK03MqQ
 HdtNGtcjvIBrbzuCNCZxwtw+oDJ1dLbaaBfGbR4RaA==
X-Google-Smtp-Source: APXvYqzpLfenCwlHqpcVJFrMN3dph47k155IlVAJKCcYg+mmcGc9XQhSZWyZjWedNEBTEY/PjiRPgmXV5fVwE7WJt3c=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr16832112otf.97.1566220426047; 
 Mon, 19 Aug 2019 06:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190816231609.9521-1-jsnow@redhat.com>
In-Reply-To: <20190816231609.9521-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 14:13:34 +0100
Message-ID: <CAFEAcA_1c1aajeKhBKzGWRS6c=iC8zmXXb3en+sLo09TxG63-w@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 0/3] Ide patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Aug 2019 at 00:16, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit afd760539308a5524accf964107cdb1d54a059=
e3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90816' into staging (2019-08-16 17:21:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 614ab7d127536655ef105d4153ea264c88e855c1:
>
>   hw/ide/atapi: Use the ldst API (2019-08-16 19:14:04 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> Stable notes: patches one and two can be considered
>               for the next -stable release.
>
> ----------------------------------------------------------------
>
> John Snow (1):
>   Revert "ide/ahci: Check for -ECANCELED in aio callbacks"
>
> Paolo Bonzini (1):
>   dma-helpers: ensure AIO callback is invoked after cancellation
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   hw/ide/atapi: Use the ldst API

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

