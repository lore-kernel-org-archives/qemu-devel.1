Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68E720768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ml8qn6Qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68E720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopd8-0001pg-TS
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jopcT-0001J6-CL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:46:21 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jopcQ-0002Se-UM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:46:21 -0400
Received: by mail-ot1-x344.google.com with SMTP id 72so8853648otc.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lylTJONNiF+05lqI3v4IFl6XREX96gJa5ntCGs3wMhg=;
 b=ml8qn6QgjyIEG7aKySM17/4U2F/msKUdBWoyCerSkwyU6dN7PqfB0T/c3RnoFP7v+r
 Puyy5hvmdWLFjZNlFg/6ebnwRZVExwFLJvr3Ho6pgbRSI3ZqkqS87hyNDT6AFaCUej3L
 zWvDf9jkrUaI+pgVfaw2SHy3XmLX8SnOP3qWVv1OYtps8MP4/p2qp+J4rRBYISolPADk
 /R3z6CXF4RSIehyM8vYkaZgV+vY0TpTVkNtq/Ly6NewEnM1AKH/82avV8voZdMK75TAF
 Y0i6QOKgOpdePlKOeiiYVxso8h0OcFDfxWk1fsvMOLS+UbXR1vtYTw6m0303uLiNioLG
 UojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lylTJONNiF+05lqI3v4IFl6XREX96gJa5ntCGs3wMhg=;
 b=GZX4JnJ9KXPn/epV5ZCBURba8N/xAw8Vxqoacrul3oN7MvPPs2v2x9k4RWHDKz07oT
 q/4Q/mQ/yynRakfBG52MkMX7/nkMn+669dfHgZLUiP2OwfcJ2KPDeh4bTPVKCzF+7usb
 HX56hoNoP5f6f6Poner9Qeu7EQa33iS/RjBw9o/YkoxriIv9tL4rJESMtpiWftNX2UiV
 FOGBetwTxLyeB2GV323QK0PoyXz92CA5m2zLDxdf6pSkcEq8levgHBRQ9oZcqrWM/687
 3A0pRkzlG2slZVsVPSl0vjnKCUu+BvwiG8k6T2xOR2TYE+cQTsWUF/4tAuCIG86oT2bm
 xYVQ==
X-Gm-Message-State: AOAM533WxkOTX64Cr9sKKAqw+4WM874utp7d0g478nxsLn53Az6I7eqY
 2YqP/L7oEyooaGmTx5IvPAScM1nNw7UD57GbY2A1ug==
X-Google-Smtp-Source: ABdhPJz9TFvzfCoGHfbtjPqJwIPO0OnsneyVh0zHxGiRjOX39Uh6c3Pm2A4/VO8acPbA9XV2VCNOyLyhbD3FN3wJO7Y=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr83072ota.91.1593182777472; 
 Fri, 26 Jun 2020 07:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200610084551.28222-1-vav@sysgo.com>
 <CAFEAcA9uF01LnFy6o4Yy=aeuy9ixyGWZFVGtR66ah3w1458O5g@mail.gmail.com>
 <583c6e8e-fe52-881d-1a61-f02ce7b16d23@sysgo.com>
In-Reply-To: <583c6e8e-fe52-881d-1a61-f02ce7b16d23@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 15:46:06 +0100
Message-ID: <CAFEAcA8XLnUWQP9BgYfN_Q5Kg8nEMfEynFiRMx8NOS2roE+V1A@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/a9gtimer: Clear pending interrupt, after the
 clear of Event flag
To: =?UTF-8?B?VsOhY2xhdiBWYW5j?= <vav@sysgo.com>
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
Cc: "open list:ARM cores" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 08:04, V=C3=A1clav Vanc <vav@sysgo.com> wrote:
>
> On 6/15/20 1:04 PM, Peter Maydell wrote:
> We must distinguish between two cases:
> 1, Auto-increment is disabled.
> I just run some test on SABRE Lite (i.MX6) board.
> I had auto-increment disabled, I verified, that GIC is configured for
> Edge interrupts. Once count went past the compare value I got the
> interrupt. I did not touch Timer registers, just signal EOI to GIC and
> surprisingly, I got a another interrupt. If I stopped the timer
> interrupts stopped coming (Status was still set to 1).
>
>  From this behavior I assume, that every time the Timer is incremented
> (and Timer value is past the compare value) an EDGE interrupt (that
> means actual X->0->1 transition) is asserted. This is really interesting
> from HW point of view. This would mean, that a9_gtimer_update function
> should generate the pulse and not level on compare event.

That's interesting. Which version of the Cortex-A9 does this
board have? The TRM documents that the comparator behaviour
changed in r2p0...

thanks
-- PMM

