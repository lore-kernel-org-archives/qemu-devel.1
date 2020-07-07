Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65663C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351B020738
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyaJewjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351B020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskfV-00038m-D8
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jskeR-0001qd-JZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:16:35 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:42850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jskeQ-0002B7-0w
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:16:35 -0400
Received: by mail-oi1-x22b.google.com with SMTP id t4so16627500oij.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k1Ho8k6NmQkOJ8k0psyQsnr8pa1Cbs34HVgTTP/J+BE=;
 b=xyaJewjPueB0klt5EclCEims2gjLWYN19Mf7ADXBKJWxfGQr7kEN6XzwXjbC6D2/dx
 6sEFOP4h7m3J2Y9ZgkSlVrdrtjZQZ06g5qbBjp6Xjp4p2u1H7ZRvkDh+iI5i94MOerw5
 o6vPgYEx7glo+s4+5A+ps4HprV61ibsXkOX8WAOEEwNZ8A5uFbeb67Eb/4alNFGnrPPi
 fj93nQzindZGT1AxN4LA3xhQTPCF72jDLPpKTVfShNszfRudpvu7iUo+gcjTkdkOS/dU
 kZZP2bvxpK/QQtf2BNVamGSyNB4PAs5L7P6sK0zWolYV5vkoMX3JEPXOJvjCDxOwArwJ
 tX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k1Ho8k6NmQkOJ8k0psyQsnr8pa1Cbs34HVgTTP/J+BE=;
 b=TSqFF7iv+ZkCOYePil32U9cEzeFlW95YF+bclv4w6eGA6e01/MoA9RwNGDydjMGhRx
 qjUw1jydBiwEMnX7EollSt9MdvcnSMezLIfP+JdLiEI11M5eX4sn0v2m0Jtdxnfg3qS3
 Equ2U/eF8LrA5PfjNdGLieBeFtZ+C6Zf1DGCHXlaQqGr/vEFRe5vJcBguLh/2h4e8ZiI
 VPPaBqkRmdUmKsmqvKXcPNj1/1u7BIm8Y4miQeA3Bc9zuSGEK30HCTOCzhFktguVFG1a
 +sblVCZAwkeKqJo/PEqSoKVqp0Z8M/2iD/NqqCaTenYb3DrvsZEjXT/WfFQKZWCklGlX
 /BKw==
X-Gm-Message-State: AOAM533D/2k9nBTNKm5rWFIciTXmLTQ84R/GSngEeYfQkRZflbHokdt+
 TLHJNkghWUJotrI66jvbwniFCfLWiOYpw2lv31O3Nw==
X-Google-Smtp-Source: ABdhPJwClu+XXzl2ZpBIeGide07uzQrOtFZdySBM4FoeXxpFML95rudYmOnL3ZddJt63EMcP3PLWIszJ4JgWvk3uD3Y=
X-Received: by 2002:aca:1706:: with SMTP id j6mr2553854oii.146.1594116992884; 
 Tue, 07 Jul 2020 03:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200704162545.311133-1-laurent@vivier.eu>
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 11:16:22 +0100
Message-ID: <CAFEAcA96GMZXnxChi5iiRN8VphLoZa+bqW+PGyZdDmpj92_EXg@mail.gmail.com>
Subject: Re: [PULL 00/12] Linux user for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 17:27, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit e7651153a8801dad6805d450ea8bef9b46c1adf5:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-gsoc-queue-jun-27-2020' into staging (2020-06-27 22:57:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
>
> for you to fetch changes up to 8f902c540eccd72086e8f67d977e30e05659783f:
>
>   MAINTAINERS: update linux-user maintainer (2020-07-04 18:09:29 +0200)
>
> ----------------------------------------------------------------
> linux-user pull request 2020-07-02
>
> Update linux-user maintainer
> Improve strace output for some syscalls
> Display contents of ioctl() parameters
> Fix sparc64 flushw operation


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

