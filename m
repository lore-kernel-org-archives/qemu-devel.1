Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C8EC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 16:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3022074D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPrPVXAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3022074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9tF9-0005d9-WB
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 12:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9tEU-0005CH-7k
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 12:52:38 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:46972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9tES-00059x-4e
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 12:52:37 -0400
Received: by mail-ed1-x52e.google.com with SMTP id k25so5967207edj.13
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LV70Kj+QrBt04uKbnNoSuh+AVFvyfaUdebGPeVivdGw=;
 b=vPrPVXAfH68j71N0lpQJ8bPfahdN53fwmTxsnqn+V7igaUA+uvOPTsK18fU8TCEeyR
 AEev4v2TZhodt2VNl9cH7SVch54aFEdA29VwzlKePiru9v137EAUOAwfa2hscDaZJp9E
 /sKZwCUVIOemD2K2Z1/u1/vWT28xxZVn27/L5/cE/tax9w4i6el9hc9k6N7t2XlhzL4X
 +xKPOvS/1GI33pSaEQXU2VfHzv33dmIGFyUR0dnARx2pgXKEy7IZcNvoOg/qnFEahYiI
 RHJmSpaJH83HsO1VuMdF9JsceLKc59tdAPw3JwyQ8wvLWcjFA9YYg7Bmov0pDYwuCNQo
 PYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LV70Kj+QrBt04uKbnNoSuh+AVFvyfaUdebGPeVivdGw=;
 b=VkRuF6td8r2JXeYemj5htG8KYrDIYvVfIcXLEw+adqEQrBOTW5bCpIZ2wyI5s2s4Ot
 BMTv2jFca6RZKmuT2TiZtELmF3pbWxRq9mixf3u5rL8yjOyKLIV5GYlBBqbee3XP/RWF
 WSUECNfEmb7IiUMO2uY5P2SnLm3Zm97OWuN88PXWuIocmURW9XJvMakcZ7elkk4dsrQB
 ydVl9/Qx0gARZ3I+OANTX7jvTwXObEKuKq/jefRGhTXgJZbVKbP5v62zdSYT3BKenQZg
 u0v1hk1iOWjl3drRj+8T+oMiUJv/daOtl1nQjvvEJZOVu6szIo2I+WfRDqDRi1m38zPi
 1S1Q==
X-Gm-Message-State: AOAM530ZIjC246+AyGR1qmhtXq7EOQlCGBp8EEzeledfY9xN2Hw07Txv
 ofZV3j/zyewYQbj9DcbWhJIo8ddpicXO5iPjiqD+ug==
X-Google-Smtp-Source: ABdhPJw7V0qH/KuKchi1GlOLI9FVJKsccoJ5glJLZ/I7ubXr7mQlBz0kcEMBvSheA9q+OFgL703tLGQxVQuq3YD28ow=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr2077337edy.52.1598201554353;
 Sun, 23 Aug 2020 09:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200823145912.1171738-1-laurent@vivier.eu>
In-Reply-To: <20200823145912.1171738-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Aug 2020 17:52:23 +0100
Message-ID: <CAFEAcA9CmQjMsfrSvosTJTSE7r4m7Va_Thy-GaiiOMunkZ6OZA@mail.gmail.com>
Subject: Re: [PULL 0/6] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sun, 23 Aug 2020 at 16:00, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit d7df0ceee0fd2e512cd214a9074ebeeb40da3099:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20200821' =
> into staging (2020-08-22 23:53:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>
> for you to fetch changes up to b3a3af70c377a3e67d43f3be39a333228487b50c:
>
>   linux-user: Fix 'utimensat()' implementation (2020-08-23 16:57:58 +0200)
>
> ----------------------------------------------------------------
> Add clock_getres_time64, timer_gettime64, timer_settime64,
>     timerfd_gettime64, timerfd_settime64
> Some fixes (page protection, print_fdset, timerspec, itimerspec)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

