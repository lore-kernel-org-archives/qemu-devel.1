Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37090C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FC520675
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM015nNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FC520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jNO-0008LJ-28
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jMZ-0007lo-7Y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jMU-000191-Fo
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:35:55 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8jMU-00018W-A7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:35:50 -0500
Received: by mail-ot1-x344.google.com with SMTP id j5so8443737otn.10
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1PfBpAz4U9Q/Byx3V1zrSqBUAxWhaHpnyZd5bkeP5Y4=;
 b=UM015nNkTq2L8KPG0yKHdGvOz5PjPLc7GjhmREK6YE/VXG97CJMcqk2oJ3Cn1GYbMg
 oYNWaOdwxRo6k0zwyYghQ3DitU+PZxppnvU9ZHqISs8ACxJ2SXvwT5TJNAaQ0kFn9HiZ
 we3lsn2Ai7eqa/D5OqYjKWP2oRKrzvA30rFQkIICuHo5yS0gOD0jXim6SNFhlGLh8YP3
 Es6mzaJ0HAvJQkDL1AYG9vXoEDW24IlnYK0mUbF4eJeg8xajZkkQsQJ6RqY+ekD01jJg
 3BxHn/BPH5upwWpyED2SLVfxOQ15wiZN7oQWuBRkrHar7V7eKdcB4Ipx4WCxATHtcDgb
 qhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1PfBpAz4U9Q/Byx3V1zrSqBUAxWhaHpnyZd5bkeP5Y4=;
 b=WrohqjZ4EAfMTZvkavbcND3K4DqLw3iavwISqQAc4ScBI89xiV9H7mWa7pSaZMK4ZL
 hn1N4M+JY8YxLN0WJSz10UNXg0hYkeYTc2t5Wm1qsVFYAuq50/diOw12WWfSLGoKF2al
 x2nAEWszVyhqlrMRvWv9Ge8N47R28OIyQXLGsXX7lTIqMjtp/yFQE8Ui0KFaP+yKlsWD
 rAHSk8TEJ31P+fpVj1zZ1XnWSf7H3T1f+80FlE/7R+T4xan4IRqv2TpF9+4UguytLjYy
 OuBYTvEajUAZ3FKvmQQooQySz74RTTCHSzUgTa65Zl21DohgxgUzqRVyKfNHKQRqYBq3
 eO4A==
X-Gm-Message-State: APjAAAUNaKN+xLcS4xK5EnFldiADln4AI4Q0q1cfBYgfUBuA9ZQSLUdi
 p8MYNA0t0blYQe6RjDvrTyypdiF64+IE6/GQwPpTfQ==
X-Google-Smtp-Source: APXvYqwtOqzaCoqiCgJV7bB/FRqquSO11T2Bd5O/K/6pfSOib/pqQ0jsSKGjO4WqZYiesh5QXTbHLaRCNtjFdwfTIg0=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr12889550oto.135.1583148949522; 
 Mon, 02 Mar 2020 03:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20200227164728.11635-1-philmd@redhat.com>
In-Reply-To: <20200227164728.11635-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 11:35:38 +0000
Message-ID: <CAFEAcA9MtOyMdz4ezuc-sL0tiD__m7m+VXyvtq166bW1Ewu3hw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hw/arm/smmu-common: Avoid smmu_find_smmu_pcibus
 return dangling pointer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 16:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> This series include the previous patch from Eric, then a
> code refactor to avoid similar mistakes in the future.
>
> Eric Auger (1):
>   hw/arm/smmu-common: a fix to smmu_find_smmu_pcibus
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   hw/arm/smmu-common: Simplify smmu_find_smmu_pcibus() logic
>
>  hw/arm/smmu-common.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

