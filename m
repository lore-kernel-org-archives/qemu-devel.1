Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FDEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 05:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E54520656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 05:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNR7cmv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E54520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzvz7-0000L0-R8
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 01:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jzvyW-00081y-2W
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 01:47:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jzvyU-0006p5-JT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 01:46:59 -0400
Received: by mail-oi1-x244.google.com with SMTP id u63so1627796oie.5
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 22:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MEDZRAatbRPTJNqezlcerxMm4fCr16K91Yf4xw/9TLM=;
 b=KNR7cmv/mktlwTMSe47zAM3joBK4P3ESnWbTvWGcwqPUc1rLNvLkG9mwzg+dclpvhX
 yffWyy77B7KWCXLv2TY30KsxTZRP2FiMfWUy/hmMD8jKrxdAauU09Se3VL8OridxQiB7
 Z8OQVCLLSM3cMg7F7x6swAb4UxYkTPqmWNwSwVGBpJvf8pJ4aB/rJWqPWYBEELa8zplX
 g2+G9gWEMJi3LoA/eRPPH+T8LpTjBVf8QLwG8KXxVHQvd7T8HyniK/q42ZL1v8oxVA0Y
 XGwLCwJs9/9mYC6y9sJqKgCQ3vj+embkCp0QjsGw/64GIzEg8Mr1PFZwVwuz7I76ArcN
 i0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MEDZRAatbRPTJNqezlcerxMm4fCr16K91Yf4xw/9TLM=;
 b=TSomkjjSnNOulJho3Hd970h5zlZfwLB6SGiCDzp2qI4eVn1mo0iz+s28OntZSNOc74
 nQU0SIoljEIeKz6HVlelxBNZ450wQjTcz+Kd/v9k0o00i+ctOeYq+Wxqw3lEKKFpuulb
 XUeDOA945sJPGDPHyscLuohS9AWt/WTii4G/4HH4UbgzOaU0ijbfr5XT2f3m6fvuBlfn
 yqqr7I4mmrra+IU/xLkGs6eFIwoMEYlvnj33grP7MBUes764zvnCYFLXOiuR7RZo1Wf3
 e9gD4/TdqG9rI4vjaeAPXU/9Dqiuz2uCk1GhT0Wr5Kxlnn7JxuGFYJoH1veLyZmScXxJ
 eezw==
X-Gm-Message-State: AOAM530eKTF0rXBWqhDyhzHJ/kQBDLWuLX7T0FzTbCwa+Z9wImTkzKWc
 ACwrBLF70kpXMi99SNV35TPvDVk5tTTcxLvbICs=
X-Google-Smtp-Source: ABdhPJxt9k9DcQIOBTo7GNchQirxWBAIykjdEVKnzVcbg+B5K+4gCd0KSOJrp+ePofKFv16DUBF7amPXnmXqmcQq53A=
X-Received: by 2002:aca:524c:: with SMTP id g73mr16677147oib.150.1595828817111; 
 Sun, 26 Jul 2020 22:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 27 Jul 2020 13:46:21 +0800
Message-ID: <CAKXe6SJ5hX8bTwL0ztmMjqTiSq-xB1+1K6nujbhL6OqXZFTOJA@mail.gmail.com>
Subject: Re: [PATCH] qemu-options.hx: Fix typo for netdev documentation
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> =E4=BA=8E2020=E5=B9=B47=E6=
=9C=8827=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=881:00=E5=86=99=E9=81=
=93=EF=BC=9A
>
> This patch fixes the netdev document description typo in qemu-option.hx.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 708583b4ce..92556ed96d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2684,7 +2684,7 @@ SRST
>      disable script execution.
>
>      If running QEMU as an unprivileged user, use the network helper
> -    helper to configure the TAP interface and attach it to the bridge.
> +    to configure the TAP interface and attach it to the bridge.
>      The default network helper executable is
>      ``/path/to/qemu-bridge-helper`` and the default bridge device is
>      ``br0``.
> --
> 2.17.1
>
>

