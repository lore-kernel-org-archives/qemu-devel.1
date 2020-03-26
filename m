Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97940C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC5020722
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joBeHdyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC5020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZee-0003jR-IC
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZd7-000255-8R
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZd6-0006mN-8Y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:01:33 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHZd6-0006l4-2o
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:01:32 -0400
Received: by mail-oi1-x241.google.com with SMTP id m14so6934874oic.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ne+d+Y4anm0FeFq9N6PoCQUG4ARAatC/9qkLGfyZxnU=;
 b=joBeHdyqwK4eEzVc02zmIdav1a/r0e6/eDZvdLA5MiK2LF3Q8ZVfBg+iE2HrNLjnWj
 M8LvvR/c59r9dnmpxvkbK7XiZ4OZLZbQAWNEz2ftBoGRWbwv6w3C72hJtWYiK+ENxFKb
 o+lH7/IVto7i/qgfnisLxh+rDQgjmFWT7Sug7hvVJ8lfl/Op6RBv4GhQvm/dMSAlH82n
 8w6Rbno9XPnEGVmsyM9KAK3tbf+ExfDNWjXo4M1WSYLpLn+wk4/FdIJugUBpJ2CTbaGW
 Q3IkP04Cjc+wCt8d6dObYi7HIrLaTtNfr/vbA/inGsSXsNIcxSoXzDJgltfskRKjZ221
 4iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ne+d+Y4anm0FeFq9N6PoCQUG4ARAatC/9qkLGfyZxnU=;
 b=LN6vGCB/LKqw5jQj0C1v0ixD0xE0HPR6wRsv7sX0yrY67FfEsu7/ndPq0nTNb0vJTn
 eDIZnyZ7PYd1wzbFcSrkqwhLK0TTbXNQ+5SjTTY0XkMdI/VHbzsgfsp+/FMMM+QU4wXj
 CkUGYe4tTY+7xuI6sEhqs9mgYn+lgAx1aht9ROJCv1O2DrGOfiBViohJcnfbb+utrwg1
 oAYSQL9NpI3WMoSbsz30bIJFYBTh6cdDp1suXjppDrU+v8e2IBx6G5sTUxSoAvA0BYrd
 8qPYcEFzRphRdPyOFs7jngOKY+87zF75xgvlm4HPqQgld9YUpk4Z7/S+pYd+L2nJ/rT2
 UDLg==
X-Gm-Message-State: ANhLgQ3Q4U9CQaTpkGSfOju0crCGQ90OBGpCV4mvrh0G1UlVTpJpI3Vm
 Xbg+uKUMIRHz8G/f5Dq6qEW+Pgz2TnFRaWJOi/akBQ==
X-Google-Smtp-Source: ADFU+vt3uvCPA9+XnQHxAa7qHx67SmCfz5eLYXDHK6+WaAyFbRRmjQnI18jAVBXVg4SS4a5H8AwWVJ33aC6L0Cyf/fw=
X-Received: by 2002:aca:c608:: with SMTP id w8mr1797640oif.163.1585256490887; 
 Thu, 26 Mar 2020 14:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200323192944.5967-1-nieklinnenbank@gmail.com>
In-Reply-To: <20200323192944.5967-1-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:01:18 +0000
Message-ID: <CAFEAcA_qBW1ip26-O05fF-PLZfXJDCa2=A7oCTxPpURsYVc0hw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/allwinner-h3-dramc: enforce 64-bit multiply
 when calculating row mirror address
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 19:29, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> The allwinner_h3_dramc_map_rows function simulates row addressing behavior
> when bootloader software attempts to detect the amount of available SDRAM.
>
> Currently the line that calculates the 64-bit address of the mirrored row
> uses a signed 32-bit multiply operation that in theory could result in the
> upper 32-bit be all 1s. This commit ensures that the row mirror address
> is calculated using only 64-bit operations.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  hw/misc/allwinner-h3-dramc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

