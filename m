Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBABC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5625F20736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxzwPGt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5625F20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Cq-0007tO-Hg
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY6BB-0006M4-U5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:01:02 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY6BA-0003iL-DI
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:01:01 -0400
Received: by mail-oi1-x242.google.com with SMTP id o24so14720128oic.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VSbmcI3WE1ZZCnE9PUjKL2BOkonMnm9rWGnE3O6UYOw=;
 b=uxzwPGt7h/3xCL1X2EFTh5kQVyaHzEeu7EaGRAd6m77gmhECfqd/ZMbapTHH6W5RBx
 Mm6RLrU8+pqeiCVu3poLQftnVfopH/+q8i0gA4MwYOPoLMYaOQ3H7bbwuU74tbhi4SYa
 SrI/GkMCQQq/q/ayF5u3RyV8B4FiV4UiczB09gvkStQ2/dNxcrk4p5kik10ZYRUJKNqV
 eev+YYMCdwPcTUyE7kVm3GO+svHrffOFqjDZKfh8RZJjrseJw7YseAXjkMHEMUo/6lH3
 pgAz7itnDuErb1oK2qasjGDPIGk3kWyZ02aUO1ndi5aWat9Y6Db8QE+8GV55JIvNOsHw
 dQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VSbmcI3WE1ZZCnE9PUjKL2BOkonMnm9rWGnE3O6UYOw=;
 b=pAA1crXm23x8ZG2ot/4l3rex9wU0IrGLcW5WUR8J3lCV4cEecTFq8cgCJDsAFYpRvv
 Xskf05hTW/H4IAoJZ4IJNXncsqp4GMHhYUIsZuP6L7KtRo3ksrCHtcn0kg6Vw4BIkhFd
 Ujzf/pJg04Z0JFbduB27oRJ/8xkroG89sMEWS9XJ/YA2NK2FILlWA3Xo6jlT9LxzLeob
 we6u4DZmvsg7jNU19OOrmIkXI6M01MX8hKgqErAWRImb7y9pZSc3gJdStfmCE4tbB5S8
 ff4vKNeDV/o8p5tFw9KamSS1eDIvtljzfsFMArBTWmaA3uvNFjI7jZ+QOInvSpJS2s7F
 QouA==
X-Gm-Message-State: AGi0PuYzP+NFXzXtknWBQsqSqtArtYygdYNvwKBl4j0IntyvOj0wzWfJ
 E206SjyF93Gr1lPVl8es0Ra+ifR6Pr4Wo49gxi516A==
X-Google-Smtp-Source: APiQypLERXq59L1XHY1xMbMt4On8p23TKTpHh7oYKzFY3kx0OMOgO888fjZZWG1DxBPbnCz7jC9ek0gvHUSiGRu3h7c=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr17957328oia.48.1589194858963; 
 Mon, 11 May 2020 04:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200507172352.15418-1-richard.henderson@linaro.org>
In-Reply-To: <20200507172352.15418-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 12:00:48 +0100
Message-ID: <CAFEAcA8_=zP25c+EDGT_3Uenw9zqoa6_9AnWFZ3XFgvRqLGRPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] target/arm: Misc cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

On Thu, 7 May 2020 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 2 adds a fix to a just merged patch.
>
>
> r~
>
>
> Richard Henderson (4):
>   target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
>   target/arm: Use tcg_gen_gvec_mov for clear_vec_high
>   target/arm: Use clear_vec_high more effectively
>   target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)



Applied to target-arm.next, thanks.

-- PMM

