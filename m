Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3824B20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qO0s5XiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3824B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr26B-0000N6-HD
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jr1e3-0001HO-Nn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:01:03 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:46866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jr1e1-0000Mt-8q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:01:03 -0400
Received: by mail-ot1-x334.google.com with SMTP id n24so22276029otr.13
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8LWQQ61iYVN3LaSHnjBJ+ICJBPwPCu0hdySRX0CRLGc=;
 b=qO0s5XiARqLIYxenEL5ipOE0yX4Qu+dOjUtgxI4KXGGKd2pwpD1p/qlyV72SMYG3h2
 JqEF87+56PK3P5pT+uaO7BSTxYKQtNojxEszJza5Fn+OYtandP/78slJ3nCFKFx01Hsj
 /7c22tsp+NKGC5W8TKs+B33n2WQdveadmBhNzcN5uPHMLzVgNhfots5rBTOD5r6Fx6GN
 Vsb2MdCxvD5K5Hh5DDDL4GOrweDeJpoTtVXITZx1m3vJVGG2cxZDodh1WJ48eVx2873M
 sXIBDUgYoUkhxCDbpSqaoR0LFizkslQ3VLjKFG+zfcvbz5/HeqmOPpmuuPlomISPa3K3
 ooIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8LWQQ61iYVN3LaSHnjBJ+ICJBPwPCu0hdySRX0CRLGc=;
 b=jsrKkJf6Ux6GEpXj+dcUjW6qNWQ5JGxW5/+RQcRuH54KnMBbUFW/M0sZK37QuDUSiE
 ha7+loLMi2Mzgl2W9h414Dq963AeXhT6YuE8IIRk85XJpmAFK0YrR91Jug12WdoEdmp7
 ai43G9fbwdQLtiWr8wK1XO3O7PRO8BwwxBdCbRTtPrB+VpIlFuePJMQANVcgNNQHKnOe
 SK/tfQvZ69LnTovy4d9ERFWEAEKX87SsHvDZkkJxuzSVr5cZsdvaDTfv55aIkQ7LcPHN
 9DftxvEH/mHy3ZcE9FYnnm82pMy+sqmqk+49GRWzY/GUZaT8gg5pUFOi4YwP3G0iB/A4
 tiYQ==
X-Gm-Message-State: AOAM5330a5YaT6PS09qtXyqo22f6NsXwl/wS7wXe8YpniIOj8ARpZBkq
 oKqgpu0uyVDkfYpHiCDqfSxEgjzJL/uRwZaymxN4SA==
X-Google-Smtp-Source: ABdhPJz0fhosFupArtiHNOH/J1tucEwGQQnT+KSLNUpzyWaJfPLM1aXS7VCVyWHtKkgNZtxPw2UPyN4SB0poGnysReI=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr21010338otk.221.1593705659997; 
 Thu, 02 Jul 2020 09:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200702110931.2953148-1-armbru@redhat.com>
In-Reply-To: <20200702110931.2953148-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2020 17:00:49 +0100
Message-ID: <CAFEAcA-oachT7JphFSp6XwcM58VzqfSoE6VOrYTr_6PJSkXw=g@mail.gmail.com>
Subject: Re: [PULL 00/28] Error reporting patches patches for 2020-07-02
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Thu, 2 Jul 2020 at 12:18, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-07-02
>
> for you to fetch changes up to 9cde9caa04beac25cef32a8a9d0bd26d6b91a41a:
>
>   migration/rdma: Plug memory leaks in qemu_rdma_registration_stop() (2020-07-02 11:54:48 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches patches for 2020-07-02
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

