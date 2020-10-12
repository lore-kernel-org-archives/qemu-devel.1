Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6B3C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F54220674
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzoycL8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F54220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRw47-0003n0-9A
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRw3N-0003Kb-Aw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:31:45 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:37951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRw3H-0006o8-Tm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:31:43 -0400
Received: by mail-ej1-x631.google.com with SMTP id ce10so22703217ejc.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b7cIso//2GX8PAmvaR++m9/99pTSHqF2ttfyrwLmbE8=;
 b=TzoycL8xHymRGsweE92bMU14W0RVifZFfNA1PROTWpbtlZJfQ+GXkloDRd5J+exCcM
 0QlEDiqAXku91TTeqkjhdYMmC6MLVCOXXllYJ3sdVScZ11rqLPx68U8/fKnjR7/R2dTf
 w/agodynXmaZ/7uAQxBj4KJFAhoI4tKGDyQwD4SGzRIP0EZijejupt/yMI4zPOYnGFZb
 NQO+mhbMK08UQMMb2ovo9cGk5fOIsRcmmU3ISPVV6f+sm5Csq720TRYF2yQVwFram+g+
 EaEvpkKJm6cvEE16MAjbHsgR2yT6JNAYn5Eho0R6cW9c3OoyqoaCW0xVZZoo2bu0Asiv
 W6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b7cIso//2GX8PAmvaR++m9/99pTSHqF2ttfyrwLmbE8=;
 b=VNmtegpaWZMzGelmnuvviTTa3CCQjdpWvoowh2U5fgQHUuPKsldO5Giw1OnADK0If5
 7W9ylwLbD9uM9kP5mIN93NEt25/rc/izcNf7NynUwvTYU/vNUXIPJjUwrIVhspJbSR6v
 rUqiN3J/lTCeqUKJhDo/NzJvvr+Ecn0qRnvoodNSa1STpZQQi5tTrowuDTIYKCv0+X0g
 9E6vCj9S6YJm7Db+arCxJGt1rjOoxUh1Q5ItqDut8IZE/ZYpUjTU+iq9rTLbYypvxa/D
 5PPLSmCumO/gc08If/AqbbFPL4mEZaQS3kCrOigB/5JbtjycbRFpL6YEECJCVIFZpLYH
 lIfQ==
X-Gm-Message-State: AOAM5309hJ3qipI4K0vR9iprUE8Ovdd/6g29xE7CdqFx0x3wXegDAiAa
 7v6cG+heus5Ze8WBGaKKuVVDqunPRShCjP+RQ0WpYFk14WzPUA==
X-Google-Smtp-Source: ABdhPJxevIE9bMuUcFUbi8/OXzdMr4EbvNvOyjXURENC43Zih8YbNG9Thwae0eolKf0rRZeBsJwkJeisGwkUXylLpuU=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr27752049ejk.250.1602502297568; 
 Mon, 12 Oct 2020 04:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201010095504.796182-1-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 12:31:26 +0100
Message-ID: <CAFEAcA8A_jX_kVcUQW39NMsiqgRK4B6H-AzC6q-fika+bV3fNg@mail.gmail.com>
Subject: Re: [PULL 00/34] QAPI patches patches for 2020-10-10
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 10 Oct 2020 at 10:55, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 15:48:04 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-10-10
>
> for you to fetch changes up to b4c0aa59aff520e2a55edd5fef393058ca6520de:
>
>   qapi/visit.py: add type hint annotations (2020-10-10 11:37:49 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2020-10-10
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

