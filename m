Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05955C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C039920721
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHn+8QV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C039920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3qZ-0000yL-TC
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3pn-0008PU-7X; Tue, 05 May 2020 16:06:31 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3pl-0005Yl-O7; Tue, 05 May 2020 16:06:30 -0400
Received: by mail-io1-xd43.google.com with SMTP id j8so2710297iog.13;
 Tue, 05 May 2020 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lk9d6y3WflI060qfsBRpugvczsC8H+HCmG/Xg4SKmrY=;
 b=FHn+8QV3G4/6350uVw6eMjAnTvdBNAGa1iXcPifWnH4WOBjDDMntMzmTlaKB8E43Ev
 Jc55LmTqlWiAC3fxN3iSmwNNA3YrNbqv9o3QveuU3kwRLgMrLCYD1BQIaPuuck3dHg+J
 F6lIFruF8oQqPBMhDYhHWfR8KzXDMzNwCiUkPEXoap4Sh8h23/21F4sQpIKp8hIruUuW
 26X6MLBPM3PXr8V/kwjdmY14Ax5iMBwJAtXjboawT8oJZkdm5umvq9uLgGkB+R82DTvN
 XkDW1nKwk15CgN1j0m/SwXTk1rCa1Bvb6L/Sx8IVAQckDvpVK5/vMc4A6iVz3lRZtow9
 /ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lk9d6y3WflI060qfsBRpugvczsC8H+HCmG/Xg4SKmrY=;
 b=Kvdd25ywHovqzI3sOy3riu48e7FQlOER2olXuxjoEUZ9czzTVTXefha208N3CSppFA
 SOsj3NYQEQQBtQ4LDmuR2J3Ka2SbnQILRrJhXn69RJpjnG5qMzf7pnvT7x8KGTe+kf23
 kLj5eZP0EvDUAWbxsbF8R6gcj2guSwPXDACSDeX/A0dosc5u6wrv3hHPMtZpjCIstm8v
 k6C+vSRqmGu1J23tTinoB1GXshhCHmV2ysGIicrSi4rPHMuAeCMBpklcBvrhSGZ126vN
 NDn10SIMRAHLsjb073ob1BzZoLrhpFKfIaAbFJ2AY3LaiSKROovaEfIrPotpeJXd5IGY
 hzWQ==
X-Gm-Message-State: AGi0PuY5RkJ5cm9gy5dH9OSOPJnsUgHybEIIwgoGZ+lHiTNHpSCbePw1
 dgJH7rzbgOJCiuCvSavdC/LjYEpM2u5xVheFIvw=
X-Google-Smtp-Source: APiQypK5JnTKfai4H9xJ/zILFoOF45585i2QfbU8VcJQqa+JCpDThuWn16Rb3BQySRV2P10fxWHz+bQNLmFsb7VZ6i8=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr5271803ioj.42.1588709188340; 
 Tue, 05 May 2020 13:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-10-edgar.iglesias@gmail.com>
In-Reply-To: <20200430162439.2659-10-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 12:57:45 -0700
Message-ID: <CAKmqyKOtqyZoYK-WdpsdP2fmv5UK-2jgawt4_mnpyn5nM1LjfA@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] MAINTAINERS: Add myself as streams maintainer
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 9:34 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Since we're missing a maintainer, add myself.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cbc1fac2b..9f504e32df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2311,6 +2311,12 @@ F: net/slirp.c
>  F: include/net/slirp.h
>  T: git https://people.debian.org/~sthibault/qemu.git slirp
>
> +Streams
> +M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> +S: Maintained
> +F: hw/core/stream.c
> +F: include/hw/stream.h
> +
>  Stubs
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> --
> 2.20.1
>
>

