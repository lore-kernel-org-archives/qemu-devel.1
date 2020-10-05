Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4EBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CDC2078A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHupQ5k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CDC2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRYh-0005jH-DS
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPRXp-0005Gw-Ok
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:32:53 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:43810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPRXn-0005Dm-J6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:32:53 -0400
Received: by mail-ed1-x531.google.com with SMTP id dn5so9588539edb.10
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y5D6O6Ks05Ad2KQEshe5cLgX4BSZG7k9toNzHw+OK5U=;
 b=SHupQ5k3TMStGT7l6DHuGsXSFrWlf4Q/+oI8lVMPRJrgANx1M+osVeXSVWMcsun4+H
 8wfjIzBArKdynLOXQZn5RfhaBeGPHef3od8Dy1jFLoeC3x/KmlesA08A4jhoExjszqvo
 ZjVKOspcGIlZ04gTAeEbO7UrjQRWLxtMNifZxl7XkKhWnqgmNX0oOczSc7PaOiboDkNo
 p9D8Vu904gRMuYUq4LzeCD3EBr9Sb5eETb1YqIjBzGJjvzD6NILBvSKQY4IMUVuZP7+A
 UEPVBo0UuAHzK11zmJ+ieap+5FHRbY5URQ88nXIV69UCveHSubfiVGf3RW5XrJFWmHXO
 eWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y5D6O6Ks05Ad2KQEshe5cLgX4BSZG7k9toNzHw+OK5U=;
 b=MI2hQT20QWxJyxyGBoIA61SC9E2kFUygiNdUlG3Lt4mU/siInfo9BXAzCaDHBSjt99
 2KtplVHUBrJizgvMUZ4i2op/Nhm8ITEhwjManRbD723mzZ1RkB4jirsVzNk/BqHHAc7z
 fwtyYfIOWxgOeBuJdJ4Wm8OkrLkHCw5k7v4eX4lVQVnHU6BcHV6sxEZLWW2cPaqLiEKl
 Giut65LT1CYYU0LqCqpLrwU5nDZeCBeyz+Lj+kWeLf2qSRHb4bbmYuvYje7qUWEcYsF4
 hI8ase5VGDlgRHUDdsygRrIPGR45VFWPEtAiE2FPqnz3zVWc6z/ohSIhEcgspXBBxpQV
 Z6vA==
X-Gm-Message-State: AOAM5311Xi8XEbP4bkk02/IYk5oPU6Vjc5YMgQURFqzUVr7BsUALlThw
 YOxbo1M+3fcGgZz6gaWDBORGh9lJa1bzCgYwSSkFmg==
X-Google-Smtp-Source: ABdhPJw0eA9RxFgpRkGoRB2qPTP5FpXYUlDk02H/mflitsJhbvbS+2mbsNgMyvk/RprHQd/Yf4tDTFAN8MqzVc3TX74=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr17185900edw.251.1601908369357; 
 Mon, 05 Oct 2020 07:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201005082349.354095-1-pbonzini@redhat.com>
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2020 15:32:38 +0100
Message-ID: <CAFEAcA9HNoqLft2X3TCtNu_PERmoJdT_QQP_4m=pCMaUMKqFWg@mail.gmail.com>
Subject: Re: [PULL 00/19] Build system + MCE patches for 2020-10-05
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 5 Oct 2020 at 09:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 469e72ab7dbbd7ff4ee601e5ea7c29545d46593b:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-10-02 16:19:42 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to d72d6dcb0d633bb08c2dc5a959a47608a1655018:
>
>   dockerfiles: add diffutils to Fedora (2020-10-05 09:14:19 +0200)
>
> ----------------------------------------------------------------
> * move target configuration to default-configs/targets (myself)
> * Memory failure event (Zhenwei)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

