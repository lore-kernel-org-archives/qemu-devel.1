Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EEEC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CF02074D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMGfI8zA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CF02074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9nOc-0002pV-BR
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nNw-00020K-Lq
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:38:00 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:45181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nNt-0005u3-Oe
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:38:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id si26so8266337ejb.12
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CEyuEsnaP6Ks3ABsjkhtKDGslnnjuldxxwBDZz05Xv4=;
 b=ZMGfI8zAQN90nNCvGuHm5ZKHAUmprT9R01fpNw2wusRotZv8QhNgk3gig/0pegLg5O
 vLUxl/xuA2Geeg9qx4gSlEVJv1k1I1LEmZ1HBx2CT+P2thod26n4AKswOWh0V3JOF3Hg
 WnniQzI8lwtfu/YbLAX9dMxhO+53I5ee9dbHmNBZfdmzLof3s0SWrVy1BDN4UrEaAFkV
 GPeKyxg1nzncrt3Iw18skQzr6KW4+rYza0SMZB+2gn8X4V/iww8vfJloyaFdZa1ldtfQ
 XxDydKo8Q8bZlXKSsCJ+GwZx+8lzZ6WV3Ibrp6YAYB6K+7Y+0wtuMnibc+tzZcZ3A/r/
 kAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CEyuEsnaP6Ks3ABsjkhtKDGslnnjuldxxwBDZz05Xv4=;
 b=OA5YaYH9fQ39URhTUnu8CdGG0F43owATz8HXPqkokoFGxgCSZmgpAhS8iGy1/dMIgk
 pWqwqRKp4+a89WWSjO1AjsTvSZI8VTAi54AMF7S80Jaw35GSDxdyXvDIycpNgmzjU686
 fh4uoL3c1WculWcsQsJOrUie7vEVy4SRoJdZCfhFhg+4SUH1V40JfiJ1Yt9kjveNtiUQ
 nTst/W4e9Vzvo939R05qOsjLLhhlx5QOFROI6iTJd5sQXihJYXkTh8ZRhdc94oqbJtbz
 QNyPW9zNRyf9Ub9X4Km8BzXcCGGvw9NKj8lJ9tQH9hxCuqzbu3/hRnLuhyMfxPUYWrwj
 4bzA==
X-Gm-Message-State: AOAM530Ph1SxkT4T8A+rsEFDABbUflRkDpMoD4tLfHjPfwnTJCVQxlt+
 x1wyrXLMR8xDDQeNkTgH+X5H51v+buDdW52zHaaYNw==
X-Google-Smtp-Source: ABdhPJzZ3NGVmqTcZsH+sRV4qg4C9rO4kCbf08HFeqc2MVmNBS+V8W+AZ70Pb1lJk4DtamlH49vWXHAZUGFDklDt3s8=
X-Received: by 2002:a17:906:b248:: with SMTP id
 ce8mr944697ejb.85.1598179075730; 
 Sun, 23 Aug 2020 03:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200821172916.1260954-1-f4bug@amsat.org>
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Aug 2020 11:37:44 +0100
Message-ID: <CAFEAcA_eHxosDuYu4QpDmV6oM7ssipOwCAqce-kO6+3ttCgAjg@mail.gmail.com>
Subject: Re: [PULL 00/23] SD/MMC patches for 2020-08-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 at 18:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit d6f83a72a7db94a3ede9f5cc4fb39f9c8e89f9=
54:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-tes=
ting=3D
> -20200812' into staging (2020-08-21 14:51:43 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/sd-next-20200821
>
> for you to fetch changes up to 6d2d4069c47e23b9e3913f9c8204fd0edcb99fb3:
>
>   hw/sd: Correct the maximum size of a Standard Capacity SD Memory Card (=
2020=3D
> -08-21 16:49:22 +0200)
>
> ----------------------------------------------------------------
> SD/MMC patches
>
> - Convert legacy SD host controller to the SDBus API
> - Move legacy API to a separate "sdcard_legacy.h" header
> - Introduce methods to access multiple bytes on SDBus data lines
> - Fix 'switch function' group location
> - Fix SDSC maximum card size (2GB)
>
> CI jobs result:
>   https://gitlab.com/philmd/qemu/-/pipelines/180605963


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

