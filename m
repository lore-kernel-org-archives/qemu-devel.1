Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E14C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6022F222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msGtWbH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6022F222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3r2-0001jV-JX
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT3qB-00018V-MH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT3qA-0006Ua-Da
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:58:15 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:45202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT3qA-0006U3-7s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:58:14 -0500
Received: by mail-oi1-x22f.google.com with SMTP id k2so5108046oij.12
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 04:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=THuG9nggnh0rx3KcM2odNLOdtJmca35rT84ozzmT4zc=;
 b=msGtWbH1cH4N6SCA9hW+sEFYSXkVHbUJi87x5Ci4Drt03NbxOsaWwK4/CpWXHhGm21
 GojVCgW5zE+U9GkXBEp+gCDMhIoJ1mjlmLchD3y48MHRpqZuxyfUfWab6d4rLn7XygwJ
 z+BMF792qFkzdG1v1a+9tEYgE4l+vUZpA+3qGHeE+CxOiuQqwNPWNhO0vmdzAC04ME0M
 hVC3esreBYTvUOPLQ+kZ8nTFQcBhrWm39/JNU3pwnEMqehfHSbPt6nE01YSr1AlPiOhI
 Dry88+JtQWxcQOTDyup7ax6eVZh7ChIOz8ZYCJgGE4zLxVIE0vb1mSoFjiARYp5zDRIa
 rtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=THuG9nggnh0rx3KcM2odNLOdtJmca35rT84ozzmT4zc=;
 b=BCscbregX0nG8Wz7kmThFyw13swcOE0ZHqED4a2iVJUNt7U0+kr+Khe96FIvIcMtNK
 vhJw31K1R1kFARL0Xmf1DywEV8sDh/PEXlcVTtCOgUEu1yGDT0MI8SZMg1fwA/M+dSaK
 9cKwW563EpvsWDtszE0MhqgyWszL4cr5q+3qZ5nKtfhQGmV+Dtu+WYr7drIf/XXNtBZV
 Tx2Y8/2BsARyeW0TQCqoA+3eqyHVohEEjBntPMgqP9wIPSxBPbNMegyJXCJIK3VZlIpj
 FMF8xmxeyVfmvfg6++KXYu5/06OexanJPLBk4jBeFLxMbWD7fNIUvMsJYitOq4MrAvPO
 zZ5w==
X-Gm-Message-State: APjAAAUx1I5CH1qzeDGb7h1v7TQAK/IHnVGupBNBuqAxrqSw69hwoWav
 kxrRVw6n5WJ8C0ghIxSINnmmd7FclacXKEOZncRyiw==
X-Google-Smtp-Source: APXvYqyWlfhZ0cfMJNNA1bL0flzQ67Mmn3iwGd2HQ1Xrw0UHR9N6CrVujax7Y+TvDM0wxU0d4CpqYk97o+U0xuPi2L4=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr9769676oij.163.1573217893324; 
 Fri, 08 Nov 2019 04:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20191107085525.30902-1-kraxel@redhat.com>
In-Reply-To: <20191107085525.30902-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 12:58:02 +0000
Message-ID: <CAFEAcA_1kyJNMps+ZfPYoAf3W0zb+oy944jeo=6ZbU6fDkUnAA@mail.gmail.com>
Subject: Re: [PULL 0/1] Usb 20191107 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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

On Thu, 7 Nov 2019 at 08:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66a3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pull-request' into staging (2019-11-05 20:17:11 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20191107-pull-request
>
> for you to fetch changes up to 1dfe2b91dcb1633d0ba450a8139d53006e700a9b:
>
>   usb-host: add option to allow all resets. (2019-11-06 13:26:04 +0100)
>
> ----------------------------------------------------------------
> usb: fix for usb-host
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

