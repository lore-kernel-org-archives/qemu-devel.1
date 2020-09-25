Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB9DC47423
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6984F20738
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ol3Tz5oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6984F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqcj-0007ZN-7b
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqUK-0005AC-GW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:22:24 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:40384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqUI-0006iO-Dd
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:22:24 -0400
Received: by mail-ej1-x62f.google.com with SMTP id p15so3829476ejm.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NkfhhgbnSJFP6m1lekGKiGHbvbxn8gAl7E+qJO4QD0g=;
 b=Ol3Tz5oSy3ExfdV4XItsXUMzzPU/DTDXhH09EFYi+FmZvbi4+WBBTqAPrJyDslpNW+
 sqXUzqZGFTuK7ikHJMuUqzAHnlismYseD2V3VbnDEeB4KFpU46KglNOHd5dPT8JRSbsC
 h+H1cVruZYuUywWgGuR3ojjlwit/hvpvigYA/dsybFzBbgOYGHRtkph59R2JV+RKuA7s
 vDDM7mvSGt2EXwazPsAOhlc+b/bCOwzKDy39GdrxmcxIcNHLmhC1ovIu8ZsFmXnGLWR+
 qwMzE8Qb5wzMcHZwvCfgzXhPgjYAnwbThbSrh7HBW1EBZ8N6hJHGsVXddC5klYxmmkgq
 OynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NkfhhgbnSJFP6m1lekGKiGHbvbxn8gAl7E+qJO4QD0g=;
 b=tySzU8INGyG9w5EV6YsqupDyD2I9hfvFVJ05qZDK3lHL8BUkKNm1Tvi356GDDLUjS+
 RFTDXFTApJaVCbbq0kbPzVoHGQX2VdQ94G+L9yWN2zeYf3la66FFhgmSWtyEF11YRq4O
 T+KDrj74GS2/X7msv5vIB6clLfU4Zq3I80oE/Xf02QY5PnFoE+1YomOtzgw35vcd/nmM
 PJGKUFeAjarHfN01PmiwUZNDQ+ZX8ewYfcMRvVj2hzsW2D/VhCBIIWr0PKKH5ZdGE/Io
 Kbx8RBxMQaDpXcNkAwfv58vsT7D5dacgjiH4laF1+2i2abIPXmkB3VLeMYwsIDOZik27
 NRLw==
X-Gm-Message-State: AOAM53375OakxZwr//TWZIKDRlikV9u/CHR7WcD5i9yFjva4P+gMxhdr
 Y76W3vUu6MYRd7oJu6yhYlPZvj4VdNMPlJrCwhww6Q==
X-Google-Smtp-Source: ABdhPJy7HM3ptpwbL8s3BcPniA+R7rxePZxBPwvM4XYdGt17ZqLOUTSYcvKzNJ1DRnhZh0x1nySO6fFyIUSAwWbKzTQ=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr3455599ejk.250.1601050940358; 
 Fri, 25 Sep 2020 09:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200925120655.295142-1-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 17:22:09 +0100
Message-ID: <CAFEAcA-O1MqE4dbJ=zqvMyTiLz-a-GJAf=i0U5UxaLLb+fjSAA@mail.gmail.com>
Subject: Re: [PULL 00/26] migration and friends queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>,
 hgcoin@gmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, zhengchuan@huawei.com,
 dovmurik@linux.vnet.ibm.com, zhangjiachen.jaycee@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>, ann.zhuangyanying@huawei.com,
 jinyan12@huawei.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 at 13:09, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 8c1c07929feae876202ba26f07a540c5115c18cd:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-09-24 18:48:45 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200925a
>
> for you to fetch changes up to e12a0edafeb5019aac74114b62a4703f79c5c693:
>
>   virtiofsd: Add -o allow_direct_io|no_allow_direct_io options (2020-09-25 12:45:58 +0100)
>
> ----------------------------------------------------------------
> Migration and virtiofsd pull
>
> Chuan Zheng's Dirtyrate and TLS changes, with small fixes from Dov and
> Luarent and Peter.
> Small virtiofs changes from Harry, Stefan, Vivek and Jiachen.
> One HMP/monitor rework from me.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

