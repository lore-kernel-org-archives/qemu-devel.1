Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B66C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26D22084C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpgw34DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26D22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKm0t-0006hB-Uc
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKlx8-0004Er-8p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:19:43 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:43365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKlx5-0000lR-T0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:19:41 -0400
Received: by mail-ej1-x634.google.com with SMTP id o8so23979381ejb.10
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KJHXTuNkWPWf7f0MWTG8/mc85jv4+CUCltDxmv7hpBI=;
 b=tpgw34DPVuESGeqdjdJBh6nozboyleV3LI/3VQB6tXQndI9fRMp5vgkpYajqGSEGbT
 OdLc/Jtf2aYSmm7lWcNB0R/KagdctYGMf/uFPCx/WhswmrpmDWxw0Jd3qoFEF22kgtnR
 0Im1nNQxYBF8FT0StyILdqh5iml4ALmCIQpHgyus6BG6Hzune/1J5PYiBtHslZLF7GLu
 hEwlZAUH3ndVt9TEnfpTBnfhsxH7uKwN0RzAeqtTrA7/f4wAYbnJvnS3EvjwUSTbaYOZ
 4r04EGPV8eseu0EX04Ne3TQs7KKMEwsiDEodyeulLDtNNnoaS1fMipivOuUFu1BqU7Az
 3abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KJHXTuNkWPWf7f0MWTG8/mc85jv4+CUCltDxmv7hpBI=;
 b=Hi4JrIgUDdQqNWE/mcdWdp8RvAUAl5339E9YwswPrWFCB2Ip9JzQfYi/hDkOeFScM6
 Jtgtwt3fDhOSLUdQpSFP2m50Wqp0EPTz6pMZwkj6z1kx5MtbbVsrMvIzogD5aAMMNd+V
 TQKrpcC1O9WzUfERSXaxJ+cbmfnIHqFis8IFPfC6UNQ+wfbopEFtDk2r1+XFZM8ZVI5E
 8vDVDRmDhXWX/9CR0rH02NcMn7B7+jJW0VxtHkIVuGRDLxcPGLlqUQDb0B3D9TdDFN6U
 k98swrT49djCfMySGGwF8rhyttq51AUebeD6wUuBHFhabtTNYkcDeeaqQlTEAvtvllfW
 JZXQ==
X-Gm-Message-State: AOAM530IkPHcq2hot0YJV2lvFN42qIfuO5B8Rr6zugOipqlhTR5LO4Hv
 LTmTSNOO6FFRGbGkUbw5RCnYCE60AxsOD1MtGoj8FA==
X-Google-Smtp-Source: ABdhPJx52FeQIkDBa6u++i/dLmMoJ9+5rnUNovert6XUiYUb0XgZZjL+KWzhTXRpQdYOYKcf6M2x22kD2EWh1ANvSoc=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr6270690ejb.4.1600795178073; 
 Tue, 22 Sep 2020 10:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200921085823.980-1-kraxel@redhat.com>
In-Reply-To: <20200921085823.980-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 18:19:27 +0100
Message-ID: <CAFEAcA82qY4VUBJKTcGBk8zX=A5qVnptfbZ6aOAv1rigpHY=gA@mail.gmail.com>
Subject: Re: [PULL 0/3] Usb 20200921 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 at 10:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 053a4177817db307ec854356e95b5b350800a216:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918' into staging (2020-09-18 16:34:26 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200921-pull-request
>
> for you to fetch changes up to 1be90ebecc95b09a2ee5af3f60c412b45a766c4f:
>
>   hw: usb: hcd-ohci: check for processed TD before retire (2020-09-21 09:44:54 +0200)
>
> ----------------------------------------------------------------
> usb: fix u2f build
> usb: fix ohci oob access and loop issues
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

