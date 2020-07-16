Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57FF2070E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZPTDAWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57FF2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw82l-0007uN-Tg
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw821-0007Sh-18
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:50:53 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw81y-0006y5-57
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:50:52 -0400
Received: by mail-oi1-x230.google.com with SMTP id 12so5779485oir.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c+JK9ZrYW9vHPxi0xgIhaLRBJNvg/6GYv72lnu3Ktvw=;
 b=ZZPTDAWFLmBCHk9yW77rwwzb6ntIEWAb4vnB9aSQ8bSA6Z3Rcu3FQCUJPVjhf/m9q+
 /2oMy32iNZ1rEr2WxJBRRRcIrGKQ52wmu/cyoErcpiEPLa0Z/M9qt78Lu2JrVY3qCmn0
 dPaEjyFf8LY2vFxWc8m7MvQw706YIuPK50BcOEH0VXIqxMvU2+W3aghQVwzknoXGYFu1
 OZ3qx7BdWLqcIyz/76TQr04xamZ2tUzrKGDPpbUne0ESkkFKtxQ8M26tIrBguTQbBmCh
 pZiEi2xauRxQ2iLxEG971H7cnQ97soyLuxOE2dQYCceSy84gCU1PGXw1nn/orP5E9drb
 UMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c+JK9ZrYW9vHPxi0xgIhaLRBJNvg/6GYv72lnu3Ktvw=;
 b=DsuzbZYpLkR+t6kpa+Gh+wjPDDypYN9H80YsuSYdSqTIW88ls6Gq5GB5wiroFmXJzo
 IMEiWvURBbubuwwsM8nsSCvfY71wZHit0GSb6HCHUoyGPU+VnCPLHQeN/VfjF9gJNcj3
 iZNT4L18wafS9UmMhyV+klCHDiFiqJD1r0drH45ut57ZO0UoHdzKbVAZmEsA3DSYRohs
 uxhg7rn3ZaEkFgVFI7LmjA4OVFg6sNXvxfhZELbwyG83aLNqyQmLQ6M2iALalkRKJsEW
 /+DKIkG52aYCjHuVYMUC2LYYB6DunaE8SRrHJEYz7aQ4O7vChWe7DmLAmUYmuYKq6ojI
 wgZA==
X-Gm-Message-State: AOAM530zzmdVPnpDu0/HUMhBeYIhBmEpi1Tv44OXfEzS5Y7m5zMEY+sx
 ZYNu0hHoboEZr2SzvxVZsv/twpisP8/GWsoHuFOknH1t
X-Google-Smtp-Source: ABdhPJwjWcGYMzvMkUtuKVkEnR7bFgC8vSuyUAxVwg8ZSOVGBvr82bGYAVfB5v9gydQ+jGxJhjNXTvTqmPxa+aDrxJI=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4708949oib.163.1594921848515; 
 Thu, 16 Jul 2020 10:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200715192307.1798092-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200715192307.1798092-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 18:50:37 +0100
Message-ID: <CAFEAcA-ngJX877Qz3VV1qNLLcn6fO4t+igGEWJHhH+vZmZ9Ucw@mail.gmail.com>
Subject: Re: [PULL v1 0/2] Merge tpm 2020/07/15 v1
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 at 20:23, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> Hello!
>
> This series fixes a couple of minor issues with the PPC64 TPM SPAPR interface
> and a test case.
>
>    Stefan
>
> The following changes since commit 8746309137ba470d1b2e8f5ce86ac228625db940:
>
>   Update version for v5.1.0-rc0 release (2020-07-15 19:08:07 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-07-15-1
>
> for you to fetch changes up to df8a7568932e4c3c930fdfeb228dd72b4bb71a1f:
>
>   tests: tpm: Skip over pcrUpdateCounter byte in result comparison (2020-07-15 14:57:33 -0400)
>
> ---------------------------------------------------------------
> Stefan Berger (2):
>       tpm: tpm_spapr: Exit on TPM backend failures
>       tests: tpm: Skip over pcrUpdateCounter byte in result comparison


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

