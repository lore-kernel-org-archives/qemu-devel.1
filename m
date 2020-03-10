Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089ABC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BC8205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNBkO/Su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BC8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi67-0005iM-07
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBi5B-0005Du-Sr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBi5A-0002KB-Ig
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:50:17 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBi5A-0002Iq-D2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:50:16 -0400
Received: by mail-ot1-x336.google.com with SMTP id a9so7625928otl.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3lwpQDPB9V7m5IZWUs0qHQ2Sr7Q1+VLt/P6z7ZkysiE=;
 b=MNBkO/Su0BDmMt2PYKhbPXSko7Mo076FfubjzwcifIqE2H1B1LJ6DUfqydUB2av/J0
 NUnra3YMcW0n8OKJQLFqQ+hLMPT0axwWKRu+r4vjJ5dPLai8MqV8jhh/d0E+LzZA2bAh
 YMIhzxGUr0qiQNq6D6xIs0ItVcaET/r56z9evpMXwSH4uaOla/xDvPV9NtG/teVdX9pc
 HFzSyp8OJE/TE80yl4CDQ0MPlhVhf+fVfgzQ52Yowmiv30em5rjj9sr4z2MCeKaN42mY
 MbifJlgc+Ww/HN4pJTMQb58r5uY0SYqKi0XllNHjiW6aFJkAvx3hPFQ3aEmSfVsocYnC
 EUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3lwpQDPB9V7m5IZWUs0qHQ2Sr7Q1+VLt/P6z7ZkysiE=;
 b=C675DHCInIydeoKQ3o/pCO7rxoUvVvzkN1bPDheLbYsle1bq7QXPCvWCiX+yxhcVEG
 mJHuatBD/wrb3Q7xeFCgowOYZlrMa1EICuLbpRwE57gaR/9rRxx6raRbBP/RvuYfKeeE
 Zz2pU8MHNPZNSrgRpcJrh3ibQYoyyiBYvBwnHxW0RamUwKi/uE3e26IdZWbOY8V/YdAN
 rv5+5xeVqUCTEcByo6S03ulWPesuVUNoo59QlLhDi3sT0ksAT9Ec4eehVPR3mxdlg/wh
 Ll2G5ZnNl5Gcj6cDlgHGhXu5AfbSefNdXSvuFiROF/PPqOIPA4OnZPNpwX4yDwWgcTui
 HbrA==
X-Gm-Message-State: ANhLgQ1YdRuppyAb2acU8t2IhUh7FqvB70MAXhGcJYRs8e43qIpMuyPW
 GHto1tY0R/8bGfO5s47nvfzYEtGPMag6wSMYvUYTHA==
X-Google-Smtp-Source: ADFU+vu8bKkKntatWSQ8vQ/wyYnukKCO045M9tXLb4m5VTe3HXNaSAcp3kWlOZTdxjsLJccNHkvHTskhOlPBZnEMywg=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr17644101otl.135.1583859014846; 
 Tue, 10 Mar 2020 09:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200310082402.22839-1-kraxel@redhat.com>
In-Reply-To: <20200310082402.22839-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 16:50:03 +0000
Message-ID: <CAFEAcA9OafwmrJ2MUtSJve6u8MMahdqjWcTeypWOm4VYoJ-+pA@mail.gmail.com>
Subject: Re: [PULL 0/2] Usb 20200310 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 08:25, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 67f17e23baca5dd545fe98b01169cc351a70fe35:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-03-06 17:15:36 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200310-pull-request
>
> for you to fetch changes up to e13a22db0d47012e19ad02c9dafacbe25f94e1b4:
>
>   usb/hcd-ehci: Remove redundant statements (2020-03-09 11:12:55 +0100)
>
> ----------------------------------------------------------------
> usb: bugfixes for ehci & serial.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

