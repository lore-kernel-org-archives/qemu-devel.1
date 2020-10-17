Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C3C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532CE2064B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySGG2iI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532CE2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTjpN-0001EF-GC
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 06:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTjoF-0000S7-3o
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 06:51:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:36428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTjoD-0007tB-EX
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 06:51:34 -0400
Received: by mail-ej1-x630.google.com with SMTP id qp15so7151151ejb.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+GkEjtcrckr7ZXL36ntqQcfJtHBXedswOvHyVxLizKM=;
 b=ySGG2iI/JJUzN/VkdMDH9K3/0aWK+L1l1SS0LMPFg8gyRk3P4IhL71BT0Citf10Wj9
 LsswlaHE9cIUpk9SjJoYDY7C9m0WMdLuQQiiUgujUeEJDaeMxaOLagjbtxwt+IhmkrHP
 4QtL9Hq/vabvP4uBCP/NvVVxko48Hj0x8Gp/JzfYZCndEO4E4aE0cycbvts3c08m4Aky
 JxoTN/W7bW02LoajxyaAt+6XO1R/HAPG9HLvX+T5/yM3jBYQSqN8z/uHadaqeUghBwPu
 uS9zMX9LqSx4SWnqkPkf2202yZdzRfZVTp96/YSY2Jco5Qs+oI2M2+c/8TF8O/HPSUoi
 6P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+GkEjtcrckr7ZXL36ntqQcfJtHBXedswOvHyVxLizKM=;
 b=LIFg0EKp9cNYkbVrv+rf9JA2u/wgdlchqMLG/RjTJSaiGMIS6ByckFPojXILPePfdY
 /xT/Hp/OezCbAlgDZemwlIkoen/S2QzhqHWCiUevXxGEbQocJCwQfBdYYAS8huo1rq7O
 61DuonO0WenSuxJ8B9EQ3NBtTDjXC+XcpbJnGbGcoMYC2m2QmfWAPOAnf7sLl7kqNxxF
 lbUXuMxijnyYimJKxU2sCE+PcqhsCEbtlvMSy8RZOLcObdRBD+9BGgPTnj3zk4OSea3R
 JsNvxA8lGCM6F2YEpWl+13fKFwp5i/Hu+CfWQXXsrkZL8PIE5UdW90W/iwyRpNGT9L/Z
 obmA==
X-Gm-Message-State: AOAM53129oqmL+GSqWr/XqHC95NImVSpKlRz9FQ3s/NZQtJUhL0TD9LR
 mZPuMAep8PXUs/Lc21rQ4aAJipva1Hk7uEjXgb9J4w==
X-Google-Smtp-Source: ABdhPJybLTegHSrlBIPHRzilewhbbRnADl6OGJv6fzvaFFnwspYedeKKwzmh+1XbpLeg4cvv37zALABuqru+0QdCf5c=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr8272029ejb.4.1602931891848; 
 Sat, 17 Oct 2020 03:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201016052435.26180-1-kraxel@redhat.com>
In-Reply-To: <20201016052435.26180-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 11:51:20 +0100
Message-ID: <CAFEAcA-jNYAZjT9WaNABLn-9LG-_aA5jBQC9oQzRCwaKR0PDLw@mail.gmail.com>
Subject: Re: [PULL 0/3] Usb 20201016 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Fri, 16 Oct 2020 at 06:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20201016-pull-request
>
> for you to fetch changes up to 9832f6783c4198658d101c6b8e8a14e1f2c57aa3:
>
>   hw/usb/hcd-dwc2: fix divide-by-zero in dwc2_handle_packet() (2020-10-15 12:16:42 +0200)
>
> ----------------------------------------------------------------
> usb: fixes for dwc2 + ehci.
>
> ----------------------------------------------------------------
>
> Anthony PERARD via (1):
>   usb/hcd-ehci: Fix error handling on missing device for iTD
>
> Mauro Matteo Cascella (1):
>   hw/usb/hcd-dwc2: fix divide-by-zero in dwc2_handle_packet()
>
> Paul Zimmerman (1):
>   usb: hcd-dwc2: change assert()s to qemu_log_mask(LOG_GUEST_ERROR...)

Anthony PERARD via (1):
      usb/hcd-ehci: Fix error handling on missing device for iTD
ERROR: pull request includes commits attributed to list

Can you fix up the author for that commit, please?

thanks
-- PMM

