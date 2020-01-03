Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C351AC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BF120866
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rgf/gQOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BF120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQaK-000773-MN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 12:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1inQZ5-0006by-CU
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1inQZ3-0005xG-LH
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:16:46 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:40700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1inQZ3-0005uV-9q
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:16:45 -0500
Received: by mail-oi1-x22a.google.com with SMTP id c77so14191570oib.7
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 09:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zzSdRGJjsSIDetHUCej9BNvDEe6se0AjL3Ex5yiX/4E=;
 b=Rgf/gQOHIVIzMk/TLT5k6LupNFCDYueGz+lpp8Pcf3WYxGHkpZvqVLs+6kozT34KJo
 3OJF69nLzHfdfb2YE/k3FDaevwVbEaDyHjbWZBpp3lN5cvwEJpUJzQCpl/aWQ4dc9oGY
 hIoHYgL3zcUAlLYz0uKUpYX4ULy+9V9/l6au9Qf1iISoNxTzq6TbGjl640uKKzFCIpJ8
 YwkNjiL2pxqv43AKmXWUOzqVdfCcUF5X380xR8BYKJMXPyJQFX+99ynRXYs5IxAAVNFa
 5fx7k4PSR2DBMt2KIVbFAuN21CSRsq5VY/1yQLDN72qjbm5SsJrE0j/CkW7+W73l471x
 nuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zzSdRGJjsSIDetHUCej9BNvDEe6se0AjL3Ex5yiX/4E=;
 b=RWU7vU4/MRA1MtjXPEmqwIwhBBItx230WfT3j2d9iMRBpwlWhUduddQvABTmek8JUq
 qbyVzVdnBiCk5ylNR2jRV3nwZHfe4Q6l+SwT0CMbg+staHSElf1zmtXQq7cMFav0mdlR
 sQClV+TeLVyBJpYEchmWDGFW2/6P8QZ1mXbylxVfeAOwD6kaJxSQGDIjJnviDc4guSry
 Qjv7e9b3AC6RJrd9dfDyqR+t2Wksq7IZnbDivPx2MgixPxR0iMMKckir9YOC8JIeiOI3
 HODUNiZhHsoYkjDVdJjTHGurKMxBIvX3CzQ/W3OTBND6LwIfe++hLQm17CC4+lwlHsZc
 9ihQ==
X-Gm-Message-State: APjAAAWxiZMFGZgz7qYSn3oUmITosbUz/q8EN79vALd4k3ELURDefO9o
 fHF+s9rgnh9PhtShpLd6QcGAebMfTTa5RUgfj8BzokDecEE=
X-Google-Smtp-Source: APXvYqzrR3JJToDnAQCxucdVVNrad4sEOVs3dZE16Ick5Ybv0K6LOIods0Kaf1KDkLYj3NaMpkzIGeQvap54MXlNCx4=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr4552935oid.98.1578071804207;
 Fri, 03 Jan 2020 09:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20191220060805.1741-1-kraxel@redhat.com>
In-Reply-To: <20191220060805.1741-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jan 2020 17:16:33 +0000
Message-ID: <CAFEAcA_srgveBPFptDCc6jAEP1f1i3Uk6ME7SfLj8scdgM1oRA@mail.gmail.com>
Subject: Re: [PULL 0/1] Seabios 20191220 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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

On Fri, 20 Dec 2019 at 06:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20191220-pull-request
>
> for you to fetch changes up to db211f245b76193f7ce2cf7ebed8a0b3cb321c37:
>
>   seabios: update to 1.13.0 final (2019-12-20 07:06:39 +0100)
>
> ----------------------------------------------------------------
> seabios: update to 1.13.0 final
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

