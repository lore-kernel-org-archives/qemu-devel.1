Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77216C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4265720737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thHHPCwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4265720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIIv-00009C-AX
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKIII-0008AN-RC
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKIIH-0005ZU-FL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:07:18 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:41869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKIIH-0005X9-2D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:07:17 -0400
Received: by mail-oi1-x229.google.com with SMTP id k9so5477579oia.8
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n9iRHRfqWAc+ipBCSK6Ei6cBcqx2iVlLKjkjpyzozKA=;
 b=thHHPCwmTUKxNw35BA1cd6TJjxPGB+9pKti85lmDMKu9yuCZrMoKdrLUIl/dLflz4I
 ivWmA35+J24XMwtong75W1bX18wcGOoHnxBZM3k7YDhwJqqGpOfN5BX1HGBRbNFIGVnI
 anztsP9IOxI2IjeazXOjl+mP2niUYwdZLGnqHphA8UPi2oylHnu8O58fyeUxpvjjR0+B
 pXDAGm7wics53ttdF/PFbMEa1i09UHEwMPEKPau2JUPUls1kEOoWPDq5Iexy9nnyH3X4
 vvQQkaKAhttsijFUM+5yBENGF4bsN8HuSl/7GP3sPAifjQ2m51LqEJ5Vgq/3aPWW73Cf
 J0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n9iRHRfqWAc+ipBCSK6Ei6cBcqx2iVlLKjkjpyzozKA=;
 b=Qm1FEp+jsNyH+NKc8jfBk17RqjfwDRxl5gulFuLk2gCPWxeu5FjuUqHIhlYMZdNZ7Z
 jCoQekUxT+Tjff88r4ueKRX1E31clw7Lqhl+VDuByBRjV3AgWcUUc2Tre9w5vUwJZtRc
 U6wHRuksnr/SZWl81TyXpBDVEmh2ciLAH/87ArRqr+unYJQ7F5b1m9dMqdan12GPR4Go
 6Nj0fTuHMXnYAhIp2gZnM4VPv+P5VhiNPeEGADQTIXS9HRDs/4VzV4YXrxZCDGXcc5xN
 PIwnPsbw0p5YZvibDofTwzd0pgDf12ovziZ2KAn/ohkg7nRaKGANuSOQZRa6jX0G5VsP
 jh0w==
X-Gm-Message-State: AGi0PuYBqGetj6Db/wjcrk6WKY4PL2NcTHowwIepyHIYIZjOYAMi4q1N
 bubF+2jDUDsyYFJDpqKo3HfY0VrV/mRrNBLil28tMw==
X-Google-Smtp-Source: APiQypK8FmZUC+c5RShBqjrR9zABRmUbThAjKS7qxVMWbGSo3g9zipPMps4Qyshpo9eBOSZ9i9tl+Z7goBC+lnva670=
X-Received: by 2002:aca:3049:: with SMTP id w70mr359186oiw.146.1585904836142; 
 Fri, 03 Apr 2020 02:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200402190640.1693-1-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 10:07:04 +0100
Message-ID: <CAFEAcA_xZWFod10KJz15ZD0osSQAAe8cfD1nuxrQbKExV5CQhw@mail.gmail.com>
Subject: Re: [PULL 00/15] Misc patches for 5.0-rc2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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

On Thu, 2 Apr 2020 at 20:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 2833ad487cfff7dc33703e4731b75facde1c561e:
>
>   Update version for v5.0.0-rc1 release (2020-03-31 18:02:47 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0dc0389fa5455bb264866701892ed06bc3eb06e4:
>
>   xen: fixup RAM memory region initialization (2020-04-02 14:56:29 -0400)
>
> ----------------------------------------------------------------
> Bugfixes for 5.0-rc2.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

