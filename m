Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB05EC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 19:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39B120720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 19:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEZs92Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39B120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxxwt-0005xx-Tu
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 15:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxxwB-0005T4-5k
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 15:28:27 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxxw9-0007OI-FY
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 15:28:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id 18so14143otv.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TDmq2zgJfLVH46znHIYeN6Cj1t1kDmFzHCLtRfGXMZo=;
 b=aEZs92Gwu1F9wDuP7r+AXIg+j5F7Z09Q9ZdcStNMSn9p3HUfHKiPjepQfqDxdoUtd8
 Cd+HV9kfS5oVG+eDwXxS4pqHVZsJCcKw7Yqa8CkE3XhpVre4Fhv4vfdW4JbAPT9pbPZg
 zmZJkdGfrJrYitTlxsbATZa60OkIsj/ZZuEe0FRq+wPFBfSIZopH3HkAOsgfPNDah5PH
 rRnfFGbgOnNHVeQ1GM19kafIiTF7+gWuRCEQT3x/VfJvH/bp7NNrlv5h1Z37LQB8iNCn
 z/4aPhhTCC/ZK7yy7yZVcj+Z6JT7GtzuYsp6c+/ooc4tmSNbpXYul4PMtwUjMw2NwLHj
 2vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TDmq2zgJfLVH46znHIYeN6Cj1t1kDmFzHCLtRfGXMZo=;
 b=dtWWHnoIvHRK/rr6rpO/K+ZZeGMCIJbH+BzBIkPOZGUZVGJDV1hWRT96TAxNekov+9
 QLmq2HbgbqvtItUFQBNSQEhKahxZg8ERaDG9pLSxIXnGLW7eyNNaf9nsrbvGk1519ejp
 BTtFAYgomamkAB0snFgJRiWKQ1pFVq3Y6to9n5u+oN9mHIrDU9bNDwjsIcgGwZAXcY2s
 zan+UcTa3fC8946sbWcVYYU8hWT+PSR3+V0COBdM8VlfWUC8tpEeO4yKqxNulVR9VJXi
 VPNFctm8i+5nSzYS/6sUo+V+ZO3ztWlApAgFy09J0H5sQujiMMZoXk3UlY7/iGItevbu
 f7hQ==
X-Gm-Message-State: AOAM532+HU90vLXd9JkWnlgS9hM5fPnUb/SXjzsk/TQtAW0cwnVKNoYe
 cEl9tXN4x8XceM/eV3HAvX6UPOw9X2B6NrguNfvz4A==
X-Google-Smtp-Source: ABdhPJxfYLpRJD9QIdxPumi85gAh0GFTbH1H+DqMz6fKMXPNhaafPrQXDBzIO/OUMplsaLNBD1fdaqLlX8AG61mlp4k=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr25445512ota.91.1595359703725; 
 Tue, 21 Jul 2020 12:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200721154637.220022-1-kwolf@redhat.com>
In-Reply-To: <20200721154637.220022-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 20:28:12 +0100
Message-ID: <CAFEAcA8diQuxauqxCOgxXdZ+aK++Q6-OmKqxFCd3y7X45347Lw@mail.gmail.com>
Subject: Re: [PULL 0/3] Block layer patches for 5.1.0-rc1
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 16:46, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3bd4:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-21' into staging (2020-07-21 10:24:38 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 4a01e27ddcb5921efd68820d05d85ba71293fea6:
>
>   iotests: Test sparseness for qemu-img convert -n (2020-07-21 17:44:35 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Handle `EINVAL` fallocate return value
> - qemu-img convert -n: Keep qcow2 v2 target sparse
>
> ----------------------------------------------------------------
> Antoine Damhet (1):
>       file-posix: Handle `EINVAL` fallocate return value
>
> Kevin Wolf (2):
>       qcow2: Implement v2 zero writes with discard if possible
>       iotests: Test sparseness for qemu-img convert -n


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

