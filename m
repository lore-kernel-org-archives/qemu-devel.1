Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE53C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B445D20878
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWGZdAim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B445D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzd1-0003q8-NG
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzbt-0002sO-OT
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:19:37 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:40792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzbr-0005Or-09
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:19:37 -0400
Received: by mail-ej1-x62b.google.com with SMTP id p15so23702217ejm.7
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KwoPxa6l/5vcNUnXKr5qq42wNsqGWGpA98A9mwfkJDo=;
 b=EWGZdAimtTpHMFbrXzrbarrmjHVNxIzDxLvTsUAXOtrQQMKWpRmnq8DOWiEhjizOot
 tZvDa3qst/HuCpL3+E2FGrVE/PzxIN8Axn/cqFtKUNf47HVjsFs6FPfoyj5/HIiGE/Vl
 FtNe2H+srRxfMbZba4Q9OKtT1zKa99ds2gESKtDZcCYrCfYu8tVQlZyB2Sevc1YNL/7m
 bRRL8zz/iuCK1IN8VksDwsqhk1kux+c7uXf5mwFg3f7hdWygA+8jzU1tV1yQq2++Xc+C
 huT9UQqRosevUc+PXWUNgS2RhyunkgYIW5EPUSxZ/1Jw0SF6owGyYGIAYBktgxqvbLre
 gajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KwoPxa6l/5vcNUnXKr5qq42wNsqGWGpA98A9mwfkJDo=;
 b=FYrKd20XqiTuQEDFvmp/DyhgrMZkuMinUDqkdE4qg8JGYTbcAjan/+n1qGD0fIAdPT
 Qv849q0lgFZuArXQuiQqb6pnw46XCVVqbSSR76N6ciON96wepbEFvAgCMK3uc2eqE0eN
 OlbkuB2qgq3yUvuIcLnS7qJP8Gg5UgJONGzSm1+V836tX+pYTgBZVEFiMb6DAgVRQ755
 DszPU8G9mAQWERzSSBoeIuanHpWVIDwk+GNJi/FJXcklWsK3eWgggWjaDAAAAWX8qpGf
 iT+bm82lCXUx7VwBDtqbN+pWBQdreaxkDfzlYKLgHXjkIi7GtFihpX8rAZSpfpUeluIZ
 5SBg==
X-Gm-Message-State: AOAM533DugQlOTCT6my3678HFULqX6s0L5JsVEzLwtjB68ME2EbQbHB5
 5VYmAq9jjocnba3N0vp/EzfWh9niDl9pi8MrekkhBQ==
X-Google-Smtp-Source: ABdhPJzBXG9tGZuZuOzIVZNH0aHHBcBn5xUV8tTQlKoGUrdF1aOpwXKIFUJDXj/mFeEfXRt+U0slaogDlkPJeP4O8B4=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr27296752ejk.382.1602515972530; 
 Mon, 12 Oct 2020 08:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201012114425.104765-1-dgilbert@redhat.com>
In-Reply-To: <20201012114425.104765-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 16:19:21 +0100
Message-ID: <CAFEAcA__gS0osErLSUeDw+HHvin2uA8QwQhsaMzcf1C14ke_pw@mail.gmail.com>
Subject: Re: [PULL 0/6] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 zhengchuan@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 12:48, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2ef54:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-10' into staging (2020-10-12 11:29:42 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20201012a
>
> for you to fetch changes up to b1a859cfb04db1d2b80dd9979ce6081cb9c00d75:
>
>   migration/dirtyrate: present dirty rate only when querying the rate has completed (2020-10-12 12:39:38 +0100)
>
> ----------------------------------------------------------------
> v3 Migration+ virtiofsd pull 2020-10-12
>
> V3
>   Remove the postcopy recovery changes
>
> Migration:
>   Dirtyrate measurement API cleanup
>
> Virtiofsd:
>   Missing qemu_init_exec_dir call
>   Support for setting the group on socket creation
>   Stop a gcc warning
>   Avoid tempdir in sandboxing

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

