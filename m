Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B7EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 14:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06472070E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4Yri8mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06472070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwng8-0000SK-UP
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 10:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwnfH-0008CV-8y
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 10:18:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwnfE-0004df-1W
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 10:18:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id e90so8978655ote.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ALTmyTbkrboopNee/5LGQVDdqqrDjvus0ZMXWnu1kbQ=;
 b=z4Yri8mX0sWkse7rh/K9Ed8xmWBOBC5lbrcmnLs+3d1s1UUm2qjBqcV9vsMOTUBS8U
 0EvdfIJDIfy/ucDXSWuRTtpCwEVyXSWcQ1a8jpFvCcerhT7aD1p5Tcg237hEQXN2F7p/
 6Z5aAI1G00vtscI9lBpLNkKvIrvCM9qvEgciQ324Qj3taSYjKn9oSKpVFpRS3pZDCXxy
 vIWq8FqLbIh5noQ0lu18Hghevuv054F+9uJOrmgMoWbquOiOgYLUYSH905ur2DBS0fsc
 /q0Q7IW6vDaD+XmE3z2hPSGVJQoXhal/7AvhbGeIn4EfHC2PzqwUw91lFikvCHsEcYS8
 Vq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ALTmyTbkrboopNee/5LGQVDdqqrDjvus0ZMXWnu1kbQ=;
 b=F1AFui78h100wN29HfKFyNj7o08vo5oJQPU/Qmrmjt9ePW0ukJnYSjrFUcn2VJT16A
 arqpi/6zFXwe5bqWowQ3OnlNg7t/u863HAPyky3LWmw+ClYxfHmPk+T6aQtiw9oVbx3S
 OhibgpXwwJ5x6xSwqId60cbnJVtA1JDJpwZpfUYXDM23Y22vSjZQRoFy8a4j/9cTZHXS
 cuTx3l+v0ehXR6d73+obs95IeoqEfA0hd+pWHUxHzkCOgUXw1iYZp85uOiWCHwptE5vF
 FneBpwOEOWu1XCwfr6H+V9KsxPbkAopu7TB1KM1EckKCHh4+/B0aDVl+wCAFdzCracNf
 72Fw==
X-Gm-Message-State: AOAM531pBQySJjmg1woI8KD3HbG4DYuxHJWi5yVf9qpm/AGcA3jn7ZeN
 ZGxiwaFczjZsAJ890wsEJ4sSEUlxY08lQU7xGD+atA==
X-Google-Smtp-Source: ABdhPJxZ4d+NpEJiul55RA4p9DaNAYWnOE+ocmzKTg7XfziWw8Gc5wv+9geY5vLi/4ILWDj2OC56r48oiqr5nS9sCQQ=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr12784404ota.91.1595081885763; 
 Sat, 18 Jul 2020 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzHPG5ezqY-YxbA+tMoadA3VDFWBX8_LaLC5YsQOMrz+A@mail.gmail.com>
In-Reply-To: <CA+XhMqzHPG5ezqY-YxbA+tMoadA3VDFWBX8_LaLC5YsQOMrz+A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2020 15:17:54 +0100
Message-ID: <CAFEAcA88cskF-PP48Z2Lnj7rYoKObkV7kD-VdB1XONSzRX=9Pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] contrib: ivshmem client and server build fix for
 SunOS.
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jul 2020 at 14:22, David CARLIER <devnexen@gmail.com> wrote:
>
> From 1c5225132a01ad67c87d603659ef4e4bcd46a16d Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Sat, 18 Jul 2020 13:32:47 +0100
> Subject: [PATCH 3/3] contrib: ivshmem client and server build fix for SunOS.
>
> sun is a macro on these systems, thus renaming the variables on the
>  client and server.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  contrib/ivshmem-client/ivshmem-client.c | 12 ++++++------
>  contrib/ivshmem-server/ivshmem-server.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

