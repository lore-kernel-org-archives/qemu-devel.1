Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2055CC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CED624813
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNpshgrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CED624813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXsFY-0002WP-6N
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXsEY-00024X-Hg
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:39:50 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXsEW-00027c-PS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:39:50 -0400
Received: by mail-ej1-x642.google.com with SMTP id p5so827913ejj.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EaWYZoYaCUqyKbxwAj7vRmqBYMGqrrIrMR99p/ejPNc=;
 b=FNpshgrJnQjuEyEDegLGtQAq0ePV4AYeB6SSZSdlp7cyFYHzVbYI4czUxFVkgPqzvb
 7HuU30+cpHqtTW58nWG6afxYdGiUr1pELER/x30G9C2SF6k+eadKhru9Q0jW8GF6MmFk
 O3hDxcWzisbh2iBZzNnJQmBH4Bv2wrrHNk75DvHvF2DppdG9tKPrMo9tNrLU83oRGA/b
 eyYYUTP4L/OYmuSsQVScSrwqraKj2Rf9SUBUeK+7JP3q4zvPi2r4CSeBfAFc2ZJLUpcH
 Aob+LxBw/JIgiKq5UY6RRqy2PuLyUM09lUn+fzpcB648n3on5bnIw/HAsuP09thSY9nQ
 uYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EaWYZoYaCUqyKbxwAj7vRmqBYMGqrrIrMR99p/ejPNc=;
 b=IkoWutURoAoM+mwvFH3zyMsVoyDR2mdoUAFcP1pREJCWs/aTaeHJHzeMsYllQv58q5
 TycMzUinqD/bX0f/uuPkDzdoykPdi5mLTdkeXAnNQoVLS6sEA9ecWnbATX4TjgRe8Oo0
 Dp0PfZNR7kTF4winzODvoQbmq1ZpicyYcTgEDufxXI71XPTXMRqMjhXy310owkTkfe35
 c/o1l8wkbbfNB2uJ3Ti14bikl3XXMRE98RxUKS9p+Mhq+sNiGfzDyfOdWu5rR+3cFUf8
 qnnnY5L2qC8nMF5L7l82GY9VjCay52C0f5harWlhZh5Dt83WGl1bL8Eurke/1v3mEhCZ
 uNbg==
X-Gm-Message-State: AOAM530SRm7kkFVvWlDFO+7foWbP2w+X0UGcz8DAUiIxuMlE8djzm8CI
 amliwP/7Yd/NYcWhqlEm3Al6MR83zeANW0WPEKpAdQ==
X-Google-Smtp-Source: ABdhPJwVUto374kwuVDAamzK685FuV9vbJroB0c6dQIP1Q7TNsmnxG92m95LjASmLkGM+LSYq9THLIhlIGe25YeREkY=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr856227ejk.382.1603917586656; 
 Wed, 28 Oct 2020 13:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201027055317.351868-1-michael.roth@amd.com>
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 20:39:35 +0000
Message-ID: <CAFEAcA8-F-dbXO8gL_1wRDv0oz2FpTk91B+ZMTcUAK3P2S8S-w@mail.gmail.com>
Subject: Re: [PULL 00/12] qemu-ga patch queue for soft-freeze
To: Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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

On Tue, 27 Oct 2020 at 05:53, Michael Roth <michael.roth@amd.com> wrote:
>
> The following changes since commit a46e72710566eea0f90f9c673a0f02da0064acce:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201026' into staging (2020-10-26 14:50:03 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2020-10-27-tag
>
> for you to fetch changes up to 568979ea819d945e8af6c14658793b58bcd4485c:
>
>   qga: add ssh-get-authorized-keys (2020-10-27 00:22:30 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for soft-freeze
>
> * add guest-get-disks for w32/linux
> * add guest-{add,remove,get}-authorized-keys
> * fix API violations and schema documentation inconsistencies with
>   recently-added guest-get-devices
>
> ----------------------------------------------------------------

Link failure trying to link qemu-ga on OSX and the BSDs:

ld: error: undefined symbol: qmp_guest_get_disks
>>> referenced by qga-qapi-commands.c:987 (qga/qga-qapi-commands.c:987)
>>>               qga/qemu-ga.p/meson-generated_.._qga-qapi-commands.c.o:(qmp_marshal_guest_get_disks)

and a compile failure with Clang on x86-64 Linux:

../../qga/commands-posix.c:1383:33: error: unused variable 'deps_dir'
[-Werror,-Wunused-variable]
            *size_path = NULL, *deps_dir = NULL;
                                ^
1 error generated.

thanks
-- PMM

