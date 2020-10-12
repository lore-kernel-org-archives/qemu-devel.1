Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF907C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AD3208B8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQvXeZnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AD3208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRy9G-0006jO-QY
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRy7z-0005bL-Bk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:44:39 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRy7v-0008Ui-HC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:44:37 -0400
Received: by mail-ej1-x641.google.com with SMTP id e22so23277979ejr.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VVKKx+irzSrHwI2CV2LmswnFVT60gRM+m6nXIjpyTxQ=;
 b=IQvXeZnYSOETe5wgWWZrTDtL60uDaF2dR/twiYRFFe5weImJeCwZ1SImgMJKQaJ+VF
 bJPRyhhIy9nFP9rfPL43KEz9cjf6URV1gI+epwDWE89XFIbAWQ7JM91ahrBbukFuhqGd
 0IqebvjTyAtNjqUj8GwkBQg4eEZlg4i7qT3+zEyH0GnjrLZqG/7RNoYFIGW7bttXnCZ3
 syY1ZjsBFKeY8o9bU2R/Ajn0Okb2OoCbjxhLMr+R8mpNiY46fTKb2NKHKWU0b+h0dOPh
 cNUDdjtWf1yUay06AmHIlMuyvIYJX3b7srUkxvJ7aY/qNOdwxNh0jSAPK8TE0kudQTA1
 kHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VVKKx+irzSrHwI2CV2LmswnFVT60gRM+m6nXIjpyTxQ=;
 b=X9TLzy7y29HCSnFHtb2PrWSSw/p4urBqMUfIc5RAMIvKRJtg1f+4vGWjnRB0g68ACS
 AWz0jDhjvDUp1FWp1s72/4tvY0PHYGexwN85NYQVvHIlAVQFUtx37ivrhpr50V+WKYwh
 1YDuBTlH0bQZshqh+KXufWtRcl/cuJfJF4mXJ/w5loyjURDM8cp/M0UruSGBqq70V/JZ
 MGbzhl2jjkNE/f3V7CH4UzZeeZ0Y5UsVQsWrVxxOY1PUzgg5VUhhpaEe/G4wourEagtM
 MmF+8D3PTXal7yzCcqMWf5a3Nm2NaXY5QxA0oQ2ztth3YAyYC/mnHdetl+fJnbEf4V5j
 G1qQ==
X-Gm-Message-State: AOAM533fpneNPGyT+PvYBZJ+ovUS+5BB9HURPX8EO9RLy6N3prb1XnuZ
 oJQ01LW0ARZFkrZ4386KonYfVVhmDTzvSfDOxMP0MQ==
X-Google-Smtp-Source: ABdhPJxHvo4vQwsolI3T2CKRPKLvniIAkvpP49n+ZtnCbZG5Xk7Nj30uHmF6QbHArTMcU1TAEJsJ/E8sBfz1q5IWSqI=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr27643606ejk.407.1602510272309; 
 Mon, 12 Oct 2020 06:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201012132017.3423954-1-f4bug@amsat.org>
 <20201012132017.3423954-5-f4bug@amsat.org>
In-Reply-To: <20201012132017.3423954-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 14:44:21 +0100
Message-ID: <CAFEAcA_rSR4_EB2jqyaYJ5i6twgCMO84t=Ozo9hFx5JQm-1uZg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] hw/pci-host/versatile: Add the PCI_BAR_COUNT
 definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 14:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Note from Peter Maydell:
>
>  The versatile/realview PCI controller has:
>    * three PCI BARs which represent memory windows on the
>        PCI bus which bus-master PCI devices can use to
>        write back into the system address space
>      - the device SMAPn registers allow the guest to configure
>        the mapping from "a bus-master access to an address
>        on the PCI bus wherever the guest mapped BAR n"
>        to "a system address", and the smap[] array holds
>        those register values
>
> Use self-explicit PCI_BAR_COUNT definition instead of a magic
> value, and rename some misnamed variables indexing the smap[]
> array from 'win' to 'bar'.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

