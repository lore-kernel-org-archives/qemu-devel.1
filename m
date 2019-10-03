Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABEC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52A52133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTSoirmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52A52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG3AB-00081e-1W
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iG38h-0006tp-2s
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iG38N-0008Om-QJ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:35:34 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:33847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iG38N-0008Nx-JY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:35:15 -0400
Received: by mail-ot1-x333.google.com with SMTP id m19so2707497otp.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1xtFD2Jap1qI09vF2i9RYGa6U3pXCAgZFWVn71HCoKI=;
 b=bTSoirmLCN9bLHBWRMvQdaiDkPVjeMx7Y7pXDgpJFe7a96T7Zp65OPWdYXZkn9e98J
 GE0Z85LduUs49M+FxniJ2DLc92W1Ng4WQOt090ZywI+vWogZcPWb4YU6900EOOPulJB0
 wDBCSVrpxrOd8bXWwwB0UlgE3cjhfELnLMa7SXlAJcE+PmBVVIdk7Jy1QuxUbJYz8nRl
 +UsZ11PFE1pMYx2dVcPqUn3RXmh7MZnpEWIFUirisbcPnR4ZmA3SrX1noUZN0a0Vek+Y
 D2un7UfRnSDPffgp3nRGg7aRHIP+UPBo8GJXTSFu5TRehNeTUy3GBp2VDqHRwrPDrM3N
 UAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1xtFD2Jap1qI09vF2i9RYGa6U3pXCAgZFWVn71HCoKI=;
 b=eOSUsoXer2AUKw56jxMrsWKjxxTouzGdaYx6FO6qrgSR9BazNN2OTdZ3ITss4wwWFg
 d1QoK6CmFewiAn7KVbP6DisRadLUtKuV/LE3ikhopCkoQ4ED7zCGvfyUjEObNyNPpSc5
 DAXTGY+/oeYhS4zkMH9bTjgmNXzMbqp6BAqIINyy1vEhGHRCh1eAYYaWnLIA7PYkGSAa
 lbpxRsak90jV4ckeDlwYLIGTehmkK7NlImPVUKQE54i+NFPUsygKnfUp0shN60NC5Iaq
 VZXDgXPOIQIQqWwbaHAJsM3VrSqtQROoKbHgPBL1nGzT3EbfO4Ruvo5sN5vUV4djXOrc
 Pukw==
X-Gm-Message-State: APjAAAXrl5Js3q/QaIZKOKbCsztmy/1goVdvGQpSiYrUOY9DnOQAOsN+
 Vms8L4306auSl14jjvmkGXByci429p/IY15pkcqReQ==
X-Google-Smtp-Source: APXvYqyxzJ6873ed67W0jd6xrefoJ/GMTRbycdOeAvlv/nJcowizuQX9ck8hPGnoBufOv/jrC1EoDMc4yQDrh273QLM=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr6737479ote.97.1570116914477; 
 Thu, 03 Oct 2019 08:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191001235552.17790-1-jsnow@redhat.com>
In-Reply-To: <20191001235552.17790-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2019 16:35:03 +0100
Message-ID: <CAFEAcA8q2UgQNxO41CGyAS=c7sb9V-v8kvcBFRZ9wW67Q7eo-w@mail.gmail.com>
Subject: Re: [PULL 0/8] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Oct 2019 at 00:56, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3dc:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-10-01' into staging (2019-10-01 13:13:38 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to d5eedf4633376d22a34a17a061d3ed47ddb6fee0:
>
>   hd-geo-test: Add tests for lchs override (2019-10-01 17:50:16 -0400)
>
> ----------------------------------------------------------------
> "IDE" Pull request. (CHS changes for SeaBios)
>
> ----------------------------------------------------------------
>
> Sam Eiderman (8):
>   block: Refactor macros - fix tabbing
>   block: Support providing LCHS from user
>   bootdevice: Add interface to gather LCHS
>   scsi: Propagate unrealize() callback to scsi-hd
>   bootdevice: Gather LCHS from all relevant devices
>   bootdevice: Refactor get_boot_devices_list
>   bootdevice: FW_CFG interface for LCHS values
>   hd-geo-test: Add tests for lchs override

Hi John -- it looks like you forgot to put your signed-off-by
as the maintainer on the commits in this pullreq. Could you
fix that and resend, please?

thanks
-- PMM

