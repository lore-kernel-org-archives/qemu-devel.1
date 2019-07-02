Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC31C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4BB2089C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfSxUuIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4BB2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiIWs-00035s-Fn
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 09:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiIVo-0002e5-Ux
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiIVn-0004pO-NG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:07:56 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiIVn-0004nm-HY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:07:55 -0400
Received: by mail-ot1-x341.google.com with SMTP id z23so17043988ote.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=EYKgqgSVGr/Wixu1DV2qjIh/StvL+G4ZP7yiSLnpA3k=;
 b=yfSxUuIt6rFgM4iRMiWSM6u65y4x4wYg/DayH1zyMiyKKoeX8SyeDm35QqHWRPEa2q
 Me46fZMRbe0XPC7y8gu+iduoVTcNVxJrUwS+crR5F3zvruT4yZ4cDapq0fRWTsYV7Rq5
 XlnB3ZupEMkflY6g1KXVWC14qRC3Kz118xU5U8B6SAWCBoQRm0h6kfUkmG6a3stL65m5
 5c+eDicsX+TG9uRN/3SFX5RikNtTWFKaKvvPi0SB6HO7tF74wOUDG70m1EW6i44ML0V4
 q7SGfVdTlCU2WmQ6/5UQnxW51kwNSdiJfl2TxSPjsiBnaI6vn3VyUQhXk9axy5qF6KzI
 1HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=EYKgqgSVGr/Wixu1DV2qjIh/StvL+G4ZP7yiSLnpA3k=;
 b=TJgbBpPdcJjeO3+SryWzO8QQqtPlwG8mEjtwe4u7om8+bHSIK5NQmHO+Lt4z3XGtIz
 Ju4AwwEmfrpvHE+Ozj0WGzUFWvbw0UXoA57PSKVzlYdeWi5CyOZX2JA8CKkIg0uAyHxS
 WiBDPyyvP3N8MkfwnKvOpMC/FB/c76iqY9vIKEEvqU0HmlAWoqrwm34FtbQNv2yXnG2w
 jzhYT5LOMgS47MaQDw8PPX+Z99a2GlUwRApmKpSOZeCq4nx5tmczZw23gIGDOiN66g6a
 sDeMC2RjX8OCKwCRtW2jRhXbQDd+qTQ/MGtEv2gaDKiVZR22gMk/NQqOy8bj7BCZClHh
 1Iaw==
X-Gm-Message-State: APjAAAXCshXBx6PmzIPCz/ZbzqMZ23zVbRMQyXEgrIkvin/BOV47xkJw
 4st/7DuUEgaO5Pj433yFNonYg5LS6+zrDjxJrxisHf1bRnI=
X-Google-Smtp-Source: APXvYqyPVMpJYdzjeoTwVmXF9NDXutvFhraeZ/YtIlibk7THgPwv5pINjTynJbVfmLHhSTRwqDQGDSx1GcqD4bdUxUA=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr24561780oti.91.1562072872996; 
 Tue, 02 Jul 2019 06:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190701163943.22313-1-peter.maydell@linaro.org>
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 14:07:42 +0100
Message-ID: <CAFEAcA88-rJdGsSJZGptABXtJbFq_MNCUVs--S_8CAdWjZJk3Q@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 00/46] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 17:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue for softfreeze: this is quite big as I
> was on holiday last week, so this is all just sneaking in
> under the wire. I particularly wanted to get Philippe's
> patches in before freeze as that sort of code-movement
> patchset is painful to have to rebase.
>
> thanks
> -- PMM
>
> The following changes since commit ae9108f8f0746ce64d02afb1a216153a50926132:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging (2019-07-01 15:55:40 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190701
>
> for you to fetch changes up to 787a7e76c2e93a48c47b324fea592c9910a70483:
>
>   target/arm: Declare some M-profile functions publicly (2019-07-01 17:29:01 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/boot: fix direct kernel boot with initrd
>  * hw/arm/msf2-som: Exit when the cpu is not the expected one
>  * i.mx7: fix bugs in PCI controller needed to boot recent kernels
>  * aspeed: add RTC device
>  * aspeed: fix some timer device bugs
>  * aspeed: add swift-bmc board
>  * aspeed: vic: Add support for legacy register interface
>  * aspeed: add aspeed-xdma device
>  * Add new sbsa-ref board for aarch64
>  * target/arm: code refactoring in preparation for support of
>    compilation with TCG disabled


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

