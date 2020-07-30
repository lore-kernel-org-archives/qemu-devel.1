Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73380C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33297207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ai19AHP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33297207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1F6O-0002sR-D9
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1F5R-0002JY-8P
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:23:33 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b]:35662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1F5P-00037g-Ia
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:23:32 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id w1so5486943ooj.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jy+a6XT66sNCAQL1CqUdWC2u5DYxP/Gdw12l+L2mujY=;
 b=ai19AHP1BGRpGSxQmVVCi/tHCtQsosw92xJqXed0a7mqVTIVKYaHpgtKuSP+Tq7oQo
 rAF5IKZLG7A2BZYeVdcYU0hQExo8GIsZkws0WloxBjsrTOv6FalKW5rOwtzICHOYkwfM
 f15wdUAf+PBBGlUxSqLzMD2V/tTUMTiD3a3YB4E9mVzaZ49ln9u+NymCgukbH/E2Lfdc
 vxmiR6N8bN2Wdy18eXsZROy1tCLYARc9nySIRgA8/hKhHNckcc16F8ddXxmvDirQVQj2
 nMO91KCqv53wyCbb0zfVAjrzjNLpqbDEk4yXSh/e5xTUTgywcpeqePyGP1rFShaRqjMI
 u6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jy+a6XT66sNCAQL1CqUdWC2u5DYxP/Gdw12l+L2mujY=;
 b=AMjPwiraXcq0h5spHxO2cUK4pq0im5LVVgg+dJTPlu7NjhDRiK9iHGGXxGELcYBfKk
 GOQo6FGRli83QuoJfrTTaw5XxIrK1LL1YDV9GvRM/B9NvxYPznvc0RyhsGT68fzTdO7i
 MTG7UiJyhUghHJdZAV4E05NWOYkcftcrEhfLcaXw1K7ssgGCxELFffm8+lFM2VXG+qa+
 nnzAqg/j/us6Hh2lqk+0Zb5c/7or8rCCdHUXiQs3b6QxrJ1FV1+QaXebk1x/POBqHeBl
 sStRB47CNsxoPGtgPKXkVug3HCklAg0A2vg35RkP/xQcoK/GbvuGJ/jHx2g6O2OBHF6h
 dGlA==
X-Gm-Message-State: AOAM532CLJisUROkLUCP/feKEzk3aT3Ko8k0vQibVG3GqOwRDmObEIUF
 ZFRU01Je+5VZQelPZV5IMuRU5O//6Rj0Y9hEZdYxpg==
X-Google-Smtp-Source: ABdhPJxv+FXlYPW99AWOnw4HZzWC1ZnnwP2TTa7ofWdAeE0Jhb1wc+TTWzscuoOZxM0FlJABvzGZmEfI5ktzbmG7jXk=
X-Received: by 2002:a4a:4949:: with SMTP id z70mr415472ooa.85.1596140609900;
 Thu, 30 Jul 2020 13:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoBWHzJq-51dBxP8pniQPd7fy7J+jU2gHwZOkn-NRJzc5uNiQ@mail.gmail.com>
 <CAFEAcA9XmXhp+Crx09k++Ryd3jSL8U36FSMvw6X73sBFEmiofw@mail.gmail.com>
 <CAJoBWHypu+nJ4L3fE-tQzr_EWf294THGQkovTrn+j5iQ+b4MyA@mail.gmail.com>
In-Reply-To: <CAJoBWHypu+nJ4L3fE-tQzr_EWf294THGQkovTrn+j5iQ+b4MyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 21:23:18 +0100
Message-ID: <CAFEAcA_H5V4EzaDy0C2j8VBYHtPu25vNj0SXuYLbypj6-m9M-Q@mail.gmail.com>
Subject: Re: Differing PAC behavior between Qemu and Arm FVP
To: Derrick McKee <derrick.mckee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2b.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 21:06, Derrick McKee <derrick.mckee@gmail.com> wrote:
>
> Hi Peter,
>
> I just got a SIGILL trying to execute a stg instruction with the QEMU version later in this thread, but the same instruction works correctly on the FVP.  Are you sure that all the MTE functionality is present in the master head?

I would recommend that you cc qemu-devel and Richard on
these emails...

thanks
-- PMM

