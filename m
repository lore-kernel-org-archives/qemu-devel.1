Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8BB2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybVmTYrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8BB2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpsC-0007lQ-Pa
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkprY-0007Al-Qj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:13:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkprX-0003WE-EK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:13:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id k15so13203064otp.8
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rIq499snR+IAxnCfa6MmA7fu8l+qzQbovoxE8Cbplbs=;
 b=ybVmTYrKxTxrJtWl61I+UK1ouHzvhgpo5mAjKMYUPQvIvLY/0caZ5Mz9UMtAoc037h
 3t3qOQjpnLH160Mr5yI2L7lt4Qd8d1vs/hrmjV28IM/zywZLOeuTK634bK61lG4eeDi0
 XRC0yJHHZs7cYKudesQPOHHgOdlkMCLGlPBR8QQfdHfgsZI9UHVq3GzcToanWuwf2feJ
 xlUbArmyn0qVp2aX6JtL7T/efrW93zo/cvnJriQ6x9jDMYUfc0LVP7skL6VmRHS4A0uP
 33DcgG6BMsdvKc0Qf3e1hWj3lP+tKEeMPkahy9Ry3t00/phbDFByrA0+UxaTWf0aeSFY
 t+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rIq499snR+IAxnCfa6MmA7fu8l+qzQbovoxE8Cbplbs=;
 b=tIDq+zxWln9ppkPLGdnBEuV4I0IoPZR0ZOYcJuPwr8V81Xos9ASG7lmbpdb5PU6zmn
 n5vf1U+b3/l0NSfj0EpAEbtBaQs9C69bbvlqMicxrMsYlTovV+BBjA3+jbORB1742N33
 32KmZTC4bC+XTu1gNk8vxsht4vSRm3ibksSkksbLSJTRm7OxsNpNojjAMQ4r+8E861q1
 acsV45+xy3OEWLOitKuB3D/PKCkJTe5TnA4Os0HlBnqTAnzEfJacWmabpYL1x1aOf8Ug
 DM9U/skwK+MH4Y4QVNwjCA4t9hUqii7q4mFuJ6qMC+49VKJweltEz8TpuXLcg6V21FTa
 eq9Q==
X-Gm-Message-State: AOAM533ZWQn03AibyNfhXYdBmDrKpc6SHMLTXhOkcXCf2vs+kTvn612R
 BOd0ByGIQXW/HnhyMoPa3ZLnGhNSm4xBzwhV0l32XQ==
X-Google-Smtp-Source: ABdhPJwFVLkkaJoZNnvC0ntfyla6UW086zT50dR21jpaBiHBPuAGdQq4UzL+7jaiFRkYiYVEU8Nqb8j21ME0GAjsq4c=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr21395339oto.91.1592230402212; 
 Mon, 15 Jun 2020 07:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-9-philmd@redhat.com>
In-Reply-To: <20200605102230.21493-9-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 15:13:11 +0100
Message-ID: <CAFEAcA__1Q3YB-dbwGheVPGAU63aex208poycmRQsa3nfew8Ug@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] hw/sd/sdcard: Make iolen unsigned
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 11:27, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> I/O request length can not be negative.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/sd/sd.c         | 2 +-
>  hw/sd/trace-events | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9d51138b11..952be36399 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1950,7 +1950,7 @@ uint8_t sd_read_data(SDState *sd)
>  {
>      /* TODO: Append CRCs */
>      uint8_t ret;
> -    int io_len;
> +    size_t io_len;

size_t seems an odd choice -- we initialize it with
    io_len =3D (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;

where sd->blk_len is a uint32_t, and we use it mainly with
            BLK_READ_BLOCK(sd->data_start, io_len);
where BLK_READ_BLOCK is a rather unnecessary macroization
of sd_blk_read(), which takes a uint32_t.

thanks
-- PMM

