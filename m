Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162F1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47A620663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Amgiys2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47A620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbWD-0001P1-2H
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvbVa-0000wy-5D
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:07:14 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvbVY-00085X-1q
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:07:13 -0400
Received: by mail-ot1-x32e.google.com with SMTP id a21so686790otq.8
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xnfUeSL57vBSCOLzceQhuyRIfGx6PcP9zz+qurWGL8s=;
 b=Amgiys2jvbxXuBiD3UrKE53n7seW3Q2+n5FhHoKBk1esHcBo+vYtZdG6AlMmvXPMGE
 iNb9W7TV/6Sf2Gg1nddZoWNY7Y7/tTqZ3zuJ9bYrSXClFfN4TxDr+nX5UAQ+o851TNoD
 QrI7qvxIbtFllm6NEzhgVuAX2pOwpbu1RtJvFvveIVS4r1Lrp3+IiMCMqfzY4/qIPmKn
 UwNDbozxtn4Lknh8AFaMQqyIgQKJm8cO+oLO0nvLdbqzw4GeE3HSxM2XeqdM1V0q6jIH
 KzZQtJc2tWs/V3Rskt6/p65iqSd35eOqub4qI1lDu3EBMf1JqjBON0dIIKxpQSLs/GPr
 7Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xnfUeSL57vBSCOLzceQhuyRIfGx6PcP9zz+qurWGL8s=;
 b=iD6boc5P1WnulXwQGKd2vhmA8FioiOoYwakdSrG+nblWy2taJICD5F94NdUublr4zR
 nSQClWqH0ffR4w4k8rWzijDlUgckHaO2xXW9S8uOiTpWCGZJOiqhQVJgKxhCX0aznrsu
 T5aCgj+HEVlAHhf6A0t7LoiZ45wX3PtxNXn2jHgH1Sgrf3PZG8USTA3WG1FBbplc8Kzm
 r39/YpKtetUwYKuVTesf5m4jW3pyp5+R+RLYsTzMivYri/ylzyWI+LT7CfpPqeeKwB9t
 lDV1RxZwTtETU3opvh1tQcoIrfAWSNhSYKutIzfNVuXaWa0grdglRN6zrHGs693gYL0W
 KsCg==
X-Gm-Message-State: AOAM532vPSwE95JWwe8zreYYLykgdaAcO3KI59donVoLuTgMaoGzdDEe
 MqaDt2aDmQlXCC8iA/XLmfNIV4uJ5GrvXYmIYetdFQ==
X-Google-Smtp-Source: ABdhPJwLWonTJ+CAFcnCB4RZY1Fl1pk4VZsmqoYO1SuUgJgactpGeLn7LYVN3c2oNkHj3iBFuWrfehmjJd6lTTFG19k=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr7486755ota.91.1594796830421; 
 Wed, 15 Jul 2020 00:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200714045114.29319-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200714045114.29319-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 08:06:59 +0100
Message-ID: <CAFEAcA_gnemdYK9ymEyKeO2yCkD-3zhbU1W42hawDUc-DD0ywQ@mail.gmail.com>
Subject: Re: [PULL 0/4] qemu-ga patch queue for hard-freeze
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
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

On Tue, 14 Jul 2020 at 05:51, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>
> The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-request' into staging (2020-07-13 16:58:44 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2020-07-13-tag
>
> for you to fetch changes up to 0d3a8f32b1e0eca279da1b0cc793efc7250c3daf:
>
>   qga: Use qemu_get_host_name() instead of g_get_host_name() (2020-07-13 17:44:58 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for hard-freeze
>
> * fix erroneously reporting stale hostname in guest-get-host-name
> * fix regression where guest-shutdown asserts when called
> * fix race condition with guest-fs-freeze/thaw on w32
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

