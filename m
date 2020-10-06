Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77920C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60D9206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYFe8u0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60D9206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkLt-0007cb-Oy
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPkJx-0006uH-5L
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:35:53 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:32922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPkJv-0000hh-F6
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:35:48 -0400
Received: by mail-ej1-x643.google.com with SMTP id c22so15537497ejx.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=luMkgmwQHq43GzfUnmo3E1V7yX3uXrHE0xvW4RHz2wU=;
 b=YYFe8u0N1KSUr6NkM5rZJNZ178DDBkVFKgU5NpLeEWNySHqBAjjf5RJtNY/TYSOZfy
 W2AfIV0jFbVsNsU1tnflV46tnvToA1ID6bbOb/2xlvulaTYg5Wfcn7NUYWhQfCxNlR8U
 OZC4jVNrhVZogVDwSgS3ApiQ4qW1DoaXwiSHmNreM27zdcrmB1Qim4hCGdLO8diP6UJb
 xwGyLh4I2ss9XHDMjubiQG+nomY9rx/MLlSXCWg8OH9PRWRApRtKzhQoiMbj+6usd0bV
 0L2qjCcLDQLnQIpNyHQXghcUp2MmtdIscbJgcUCZmxzQCRGTqaV2Ybj+CO/wXqCrXacO
 IkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=luMkgmwQHq43GzfUnmo3E1V7yX3uXrHE0xvW4RHz2wU=;
 b=uDkFkoTx/c8FKULmi1r4HTgqZRfwzwQDaA8AbB3I8lyECwhh+pMRrjhu9ncwxrNeGX
 Ur9yKIzxWKY9eMoCOYx5kzgdC2XE4jv70+DkqLmEG9+CaBuH02z/nA9JBuiTDyabvZjW
 Jgb+McdRunLjOpdG3jj4nv+3xsRS/UoqyMtg+jOztwjldKTK/JcbKA5tCeEQAL0opV4w
 eJ6cGALBu2W5+RIk2dMjwvGGL9Z4leEQKkFV+qpJVkF0tdwG7i2703HGdvjucplpUkpj
 pW6a00w51sUq/CschxC17uck8JNxWme+O4IM6abTOPGZKK7k+QQPTKjx7Kaj753A1KId
 IhsQ==
X-Gm-Message-State: AOAM531UgP85s/wbk6I0XiiHEc29x958BdFBCd37Sqk1KsCN/svpnoAx
 1JvyQ+RMX7WdFB6AxBRoqAxMto8myN1PPDcXF3HvcmhfOIQFP8XP
X-Google-Smtp-Source: ABdhPJyA9zlv2Iqon+CurtHy/iJjAbyeyuoCCX2UnVfCGrzwP2Z3YHySw12mfC6+JEK6Uy1U8UxiqEf8eeAdDgyIspo=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr4352641ejk.407.1601980546007; 
 Tue, 06 Oct 2020 03:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <152673688616.9061.7617411809661975686.malonedeb@chaenomeles.canonical.com>
 <160191065927.25016.14450333329909988777.malone@chaenomeles.canonical.com>
 <CAHXt_SXZpzjYqW1uDUXwWsu0CYRMM=NN_r_avCcHYCz=xZkoHQ@mail.gmail.com>
In-Reply-To: <CAHXt_SXZpzjYqW1uDUXwWsu0CYRMM=NN_r_avCcHYCz=xZkoHQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2020 11:35:34 +0100
Message-ID: <CAFEAcA9wUJ3-cVkSWSqrZXmu0DBQM_yRCSfctrBsCexS5UOY=w@mail.gmail.com>
Subject: Re: [Bug 1772165] Re: arm raspi2/raspi3 emulation has no USB support
To: Bug 1772165 <1772165@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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

On Mon, 5 Oct 2020 at 21:38, mcandre <1772165@bugs.launchpad.net> wrote:
> Which Beagle boards, Jetson Nano, other devices have rich support from
> qemu? ARM is critical going forward.

If you just want to be able to run a Linux kernel and Arm
userspace code and you don't have a strong preference
for which board to use, we recommend using the 'virt'
board. See the notes on choosing a board model in the docs:
https://www.qemu.org/docs/master/system/target-arm.html#choosing-a-board-model

thanks
-- PMM

