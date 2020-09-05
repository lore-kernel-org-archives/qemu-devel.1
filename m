Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC9BC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFEC206A5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqaOBEQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFEC206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEZAW-0002Rx-HH
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 10:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEZA0-0001zD-4y
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:27:20 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:46036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEZ9y-0004JS-9U
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:27:19 -0400
Received: by mail-ej1-x62c.google.com with SMTP id i26so12216370ejb.12
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Eb8cHf8QjEQUgyQsXlYkM7EB0vqiMOuuYZoIgI5Cfpo=;
 b=oqaOBEQBXDBq8jDKVmFkJa7A/yEj99uIBN6EHWADLPqwz2mroQ4f5WM42VJpMuJmzC
 ZqzX/pAS6B94M94DRtw8sssSQ3NACXEdujExDdS2e19e1Mvc9lRfVclFEbha+YUuInoz
 JuaRB3v/UzXYFDoV6riaoGsctEXt53fQdr6b5fIZQdpolmR57xoqc4664aO/jV3hJMD2
 U/ZeESNKDebIT5iI5XfjCuzmsn3obXmufVpCLBX/PT9kN0sk1zn0PFbR9l9IE4aRk7tP
 Kff8Uf7mvETJ04M5VhB6ol4dzAdznEscwHMjeAimKuWrQCXUZgT1H3FVXGnmt06kPanM
 uLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Eb8cHf8QjEQUgyQsXlYkM7EB0vqiMOuuYZoIgI5Cfpo=;
 b=TPuyepEoTRMSx0h2yQnODB1LUtdel3De1o/WzTF664k73KE4LK/JIjLJN2iTz4t8r8
 rqDlDkPWV0PL/yO2vm7cLVilddzHfOzbhI0BfOjf7mQBM//Z1pLJC0Rv2sTupDhSli2P
 MNPVylALu9JQrVeNj+R8tcZSK0l1zy3lo6n18vciyC9NGlK+DzmXbT+W9eRFQb7tspmr
 fqTHklAqnQsZAIrQj3ISja1hWU5h8dTwEap5eGjAVAg6WQs1Na6GYtiwUmCeBy+p5b4t
 eIREMb9tWqZzgaZfewFWLYz1k816JXCCgbVdRC1ZtHo7PNnK7hag8qkl3eXI5i1Ox9y3
 C4vA==
X-Gm-Message-State: AOAM531PpIJtYvH3rHZLdmsYa2QxPzt7NYZxOSFswFn0Kt+7gs2vTRub
 JDZpcw9Ym8nM77NxSFmt56jRQZJdwlL5/sOP1p0Pcg==
X-Google-Smtp-Source: ABdhPJyfrpFt6OjcyNpvUvKpCo0EDxGnPC7erN3U92JhjFx9HbzKQPiyTeuZM4DMs+nJm7GdUSswViFmfm9GCt6x+24=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr12332792ejb.85.1599316036007; 
 Sat, 05 Sep 2020 07:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200903082344.1877175-1-armbru@redhat.com>
In-Reply-To: <20200903082344.1877175-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Sep 2020 15:27:04 +0100
Message-ID: <CAFEAcA_TpDNvfU5MAt6PPf51RSdDgrj5TteZuz0L2MUDdvsSXQ@mail.gmail.com>
Subject: Re: [PULL 0/8] QAPI patches patches for 2020-09-03
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Thu, 3 Sep 2020 at 09:23, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit ed215cec0fcaeaece064b0fdf37fe3bceb06d76c:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-09-02 15:26:38 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-09-03
>
> for you to fetch changes up to 923fbd4cbd485dc72e9f2578cd891607ec43ac70:
>
>   docs/qdev-device-use: Don't suggest -drive and -net can do USB (2020-09-03 09:58:39 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2020-09-03
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

