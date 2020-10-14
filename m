Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C66AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D3F22201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQrZF0nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D3F22201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShiZ-0001hR-1s
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kShhd-00011w-PB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:24:29 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:33821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kShhb-0004YM-Rw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:24:29 -0400
Received: by mail-ed1-x532.google.com with SMTP id x1so3354263eds.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dynEcdEPSMJLnsWvDQKyiY1xzaNnqgENiw8V6I3Tb7Y=;
 b=OQrZF0ncuTjIEBBqOVxKiAnBZ8XYwThHGAIdxkmzslfPJ3fZK/jaI3YpBpZ8T3Rrkf
 /MFuDbNVUTM2KLPgDykk3pt0DI//4H5pXzWUi8Mfuq4KQ6qItDG5MDb7KGd83y7r9K+b
 vSHK0w4wdMntzERcWhNHg0qcMxtBHQYcfvl1ABlgOgBp8jVBN3icq7gCETNmVXFzPvXx
 LH4i+QDEVkF9cwl/x2NfaJFo7kWbqZsVVCIaIZYHGW7rInN+dIE0xFS6iJuAYaQfmjYE
 EbZKmgis924srtWRz0Jku1HH3WWIpc47weNDRgWSbyHhEjpOsB5azUMdfaRTME42JHNX
 L7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dynEcdEPSMJLnsWvDQKyiY1xzaNnqgENiw8V6I3Tb7Y=;
 b=Zxb6jkFiQCN0PZcE3Bgoe8YemP8BWt+6jU1OvuCegkNbuoGreNZbnQmTd9eKhT/1bh
 /zsSqxpSl7J+MjShMFLEnCoNKBQar1faPJx8SSHR8YoBBm7gCYniNqAFc6QKfabzttFD
 VS45ltogMUvEKQfZsMI3KPtj3weE9CsMKbKQkZ2E5ZUU2YVNDc1GvfyRoYTc7K60FqUx
 41Z1d1SM5/cR3pDQYacDYfEptKkJNjWebYST9ITzWKyIdQvrqNCFUJLd16qZkesI2JD0
 qhsCbJTEUsZrmVaL9yeMjQBcbZ9dWiZ2W+rXjZqMEACPIYHEsPh4um/CN6CLsH/jEq/o
 /wDQ==
X-Gm-Message-State: AOAM5327cXI9yvHljqnP5yc3K4EqMeozlqR4+NTqFhLPYh9RfFJ5mHZl
 nDeYzv6SssNrvgMpK2a6AtEhYQ/avv5hqmOmd6bbTw==
X-Google-Smtp-Source: ABdhPJyemNmZxnw133vCJ4Y0cpH7YI0tcRB0WsEhaI7ykzXxQSv4DwM3kKi2zymtpYveypHq0eW/9+CT9NHJnjEGIpE=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr5593481edq.204.1602685466127; 
 Wed, 14 Oct 2020 07:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201014082149.26853-1-kraxel@redhat.com>
In-Reply-To: <20201014082149.26853-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Oct 2020 15:24:14 +0100
Message-ID: <CAFEAcA_S59LHSp23szmoDN4N4UjybM9Hhw4LFTXgFueWvZCp0g@mail.gmail.com>
Subject: Re: [PULL 0/9] Ui 20201014 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Oct 2020 at 09:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 96292515c07e3a99f5a29540ed2f257b1ff75111:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2-pull-request' into staging (2020-10-13 14:06:22 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20201014-pull-request
>
> for you to fetch changes up to 41d004d8af59885da2c21460a73898b1aa09690f:
>
>   ui: Fix default window_id value (2020-10-14 10:20:26 +0200)
>
> ----------------------------------------------------------------
> ui: fixes for sdl, curses, vnc, input-linux.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

