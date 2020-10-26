Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C34922263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPvn9yQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C34922263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2PO-0001NL-7p
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX2MS-00083j-EN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:16:32 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:41572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX2MP-0004y2-O6
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:16:31 -0400
Received: by mail-ej1-x635.google.com with SMTP id s15so8884130ejf.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bqaAXVIqGyngj7Tmv8hmH7bXoL1vwuXyq/7AboBK5Vo=;
 b=vPvn9yQbrs/BcqPNjYwui+0b1DIlZdYA97+LKV1SvO+VNKEU2xslq/SG/F8ddQS6vY
 mPaJnuyihsiGTzHs6wg88Xzy1zlbIu+Fpe6pjxi83xhwPbYAjB1jL8cs23S9S+B5OwuM
 VgtebXja/qaXVpQ/3ypUWX2U3C+TqSl3v7yfutSR7ows3VxgiYf7MNKmhA0bDALmgOUh
 +5/sc3tYPIGkMGxy3myPdYtquLmHiXwX+S6ID9iZ0i9T8rsoJwVuu9NXpPMntb2eOzhs
 ABJf1yh1NWd/whBzW0L1CiK/ees6+2feyvSVQg63ycujIsERSK69L8r25biEbQR84DD7
 N6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bqaAXVIqGyngj7Tmv8hmH7bXoL1vwuXyq/7AboBK5Vo=;
 b=mkmu21yFTtxwirDBVN7Shk4FaNU/jHI9wXkYhwWZhjN0urhGBaCVYup677f5akUIsl
 lpKdGd5enbYMNiO19/4k2x01nvlZKpjMeNH0xTRkZX1LgmDeb7CWySlbS1pYgQTzloZz
 aW82BU7KqKKnCKHa8eRkI/zGI9R6Xf3hAEtq+NjqChr2owq0ENj80W8QlmA4nTfhajme
 tz6vXiiZ0IVkpPnTlgd/hFBhCe8aRiPP9ilWzG1+qQyqhilhMbsCAWgReIKod88A2jMd
 1j3f0rLrPfiHvsbGYDn5Hhd0klLWS0thITa/YRpOLY2Rf72L/B2ITFrCgFRshMod6vJ6
 hAZQ==
X-Gm-Message-State: AOAM5304++OINzlNWSCub1jaudQz4aOJyvID3vjqf7n2BrSNdGMOJjnF
 P7E435rGsWe+WYvkzsnBAbyI0IymE+DcZuryCVc5kg==
X-Google-Smtp-Source: ABdhPJw3M3I0x47wzda2kv78iPdD5dfslhVfAzRe0JXZz194jgq5H1tC44YqoC5/QjN3eowQLVWDRK8TT31XVQ3S8QM=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr15004291ejk.382.1603718185669; 
 Mon, 26 Oct 2020 06:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 13:16:14 +0000
Message-ID: <CAFEAcA85kL1KRUaM+HUe0h+nddtrZJe_yHb7Vs7QAB_v1fqBqA@mail.gmail.com>
Subject: Re: [PULL 00/12] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 16:27, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20201023
>
> for you to fetch changes up to 51b6c1bbc3dd1b139a9e9b021d87bcfd7d82299e:
>
>   hw/misc/sifive_u_otp: Add backend drive support (2020-10-22 12:00:50 -0700)
>
> ----------------------------------------------------------------
> A collection of RISC-V fixes for the next QEMU release.
>
> This includes:
>  - Improvements to logging output
>  - Hypervisor instruction fixups
>  - The ability to load a noMMU kernel
>  - SiFive OTP support
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

