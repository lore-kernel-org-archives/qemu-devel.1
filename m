Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD739C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 19:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7604720717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 19:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aS8907Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7604720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxxzl-0007Cv-Px
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 15:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxxz2-0006mg-Tu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 15:31:24 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxxz1-00086Y-BY
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 15:31:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id g37so7946otb.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A0ETbU8zA6WcVL7mFmyucrOMg0zcqqnKFX8j+wMFZZM=;
 b=aS8907UduISoVWVmM/NMDSB57FHCD72rRnKySQB5OGbWdoR1hrjxhc344fpY+rYam1
 vutS7sz4WHs+RmYGglNgdlnXrjgFgvozDXEhCVgpNJHQmUW5OsNr4Hvi8ST5bpZZt5GT
 K8qmvGEoCpfbjWw3lh2z17Nq58f+7J7Zw7vgfvU0Yqbt4qt0QQihIzfRY5fDjxPNpR7K
 UAA9hUCcmePCSCDRBttbgpqNuuNVZx/0weYrKbEUeHZDi3bFFk2fcrzd+ycAimqMLxAC
 6GYcUpZ3wff8RUoBuroAQbd+jawqlh+3yQHc9KOyHi5GKvM4PMrOC0WYktCCtTcf79P8
 6vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0ETbU8zA6WcVL7mFmyucrOMg0zcqqnKFX8j+wMFZZM=;
 b=X5BCVJtKEHPL9rENBWxaJn0kSugo+Zw8vaAbojVst+oZJrs0lbfKTiDasEBdgHCttA
 1NQ0mTtjAH0Fx6Jo3qfyVSiuKvZmmimhyrcggY164tnGQnfrAB1AkJfMMJ+ssrlD86vT
 KdgNTyNlUxe0hX6WZCj1P7JFtWuvVdGwVioa6GVpfQt0X9EgK/IUfVgKhDgQrp+w9aCX
 U+nxUDrClXn9AVQDlANAIgTT/oa1XUcG1IOwLud0EVj+1mDC0xPNIARynDv3FclwG3lv
 iIixvywPM7gi8aiBZC1tRHJBIDUurM0bAou9rcW+O9GDmw6XqHoPZIxdmgdogeV5e6zb
 lFPA==
X-Gm-Message-State: AOAM533oOV+pcs2PgpvlN7i6c61NeXZ83mliPGiFIUCXYtZJft1FJ5kk
 9CPEAdTCELTZT1TynkV7AuhZQTItM+XdHJ+c7jSi5Q==
X-Google-Smtp-Source: ABdhPJzu8Wfjs38RHbsmWU6jwmaLvryhIxc6UMMITX9eZsVjeL8tZm/qRuxSQIdYhCbFYimG8g8hHQuSEuQAZI7sur8=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr26470192oto.135.1595359882189; 
 Tue, 21 Jul 2020 12:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200721152521.1578693-1-armbru@redhat.com>
In-Reply-To: <20200721152521.1578693-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 20:31:11 +0100
Message-ID: <CAFEAcA8b3ac2HkOXuD2MRr-gS7proHb+PrfPpp7J8G23D1=hhQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Monitor patches for 2020-07-21
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Tue, 21 Jul 2020 at 16:25, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2020-07-21
>
> for you to fetch changes up to 029afc4e76041e1a320530d97f99122a1b3d5da2:
>
>   qdev: Fix device_add DRIVER,help to print to monitor (2020-07-21 17:22:44 +0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2020-07-21
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       qdev: Fix device_add DRIVER,help to print to monitor
>
>  qdev-monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This missed rc1, I'm afraid; will go in for rc2.

thanks
-- PMM

