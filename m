Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFCC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E3C2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzhtGiST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E3C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSSqy-0001dG-96
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 16:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSSqD-0001EA-N5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSSqC-0001u8-8X
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:27:49 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:40943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSSqC-0001rI-37
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:27:48 -0500
Received: by mail-oi1-x22c.google.com with SMTP id 22so4341931oip.7
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 13:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9vI3TuK0idmoRUHiUDlBVvn3yZo3eJIPGpgOeSMQYRc=;
 b=FzhtGiSTXYYG/Ikc14zgkcfmgkXlR6WZZR3DRDLc8Xlriw78m70w2MPROY9Hif7u31
 m3uTSqmKuDHOiDUNIhWWx7zV/Y3v1BeHLfDL4puU/fNQrzYZN9SqO1w73vIO+CjhVFdO
 SHYEMXQyHf/D6Gh6PnINXH0nSAlqn1xw/d6kM3MLWEv5qoHrCAIGpy88rFVAmzFyaIid
 e63hDICDvDPJI4veF1g8yaGQ0KHQzHpJHviFOOvmXWRZOeK+Fiqm+ZRHdCulO6QONtl1
 D5ZBMyMV4mh2oYA5c7WAuB/LbV/FG21Nz19enN2zS5mAo0O9SbsWYO2O+JoE7HW6ccF5
 BvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9vI3TuK0idmoRUHiUDlBVvn3yZo3eJIPGpgOeSMQYRc=;
 b=MPPY59h3+XLzMdImK01Fx4HYvgiFeWNsME3+E+rPChe+aix+da4hIC/Kay4yCcgRlo
 bqzvvqYYvlVw9JIbizJNnw1tszJWLKrbOxUdx0fPRnT+5c1mW6QzoFgV/U7+bYwy8MRQ
 BmSdzPTCt38uspOqebsmUKAYgJ5W5/h7PLO73xoAZFUBw+Wz+B1wOPUFQ/9Zad8t/eMm
 if7Y0ipqaXBdm1fgmS+sx/Rv2rDZKnk/jfzw1slzHxBvo32aLgfjk0eBvzrx9u3up1uz
 4bk+Tm7UzHAFVkGmfNTC2eVXwcYOKZFwA0xSZT7V4rEkl/5C9AETsIV38uWs2AQK6rrb
 LXWw==
X-Gm-Message-State: APjAAAXBJW2qHtOVXuxdxOfWKWRkqI7WOZabnH4yWcgVWu6Bsly39Ypx
 PhJP6h+sHcHIuzBzx6AEvb6gu+zwFxa4E4cAwU/u8w==
X-Google-Smtp-Source: APXvYqwvr4OIYP1l5cr7xV4IhfsYBeSCh/jMQkiQS/AxGJPYYEIaPyYdhqyF74ZTgs0KQ3luhmFl8hfIE5DmmkLpXiQ=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr29046oij.163.1573075666760; 
 Wed, 06 Nov 2019 13:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20191105225353.9900-1-philmd@redhat.com>
In-Reply-To: <20191105225353.9900-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 21:27:35 +0000
Message-ID: <CAFEAcA9_Eka_HSfncudmyeHuhs_83nXKupE0JnxFOLS05r0J2w@mail.gmail.com>
Subject: Re: [PULL v2 00/21] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 22:55, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html
>
> Since v1: Fixed the Kconfig bug you reported here:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00125.html
>
> This is not a new feature, and the series was already posted before
> soft freeze.
>
> Regards,
>
> Phil.
>
> The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66=
a3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pu=
ll-request' into staging (2019-11-05 20:17:11 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/mips-next-20191105
>
> for you to fetch changes up to 48bc99a09cb160a3a2612c4bd5a8a225ed7bf6fb:
>
>   hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-11-05 23:33:12 +=
0100)
>
> ----------------------------------------------------------------
> The i440FX northbridge is only used by the PC machine, while the
> PIIX southbridge is also used by the Malta MIPS machine.
>
> Split the PIIX3 southbridge from i440FX northbridge.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

