Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3011DC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAD82065C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs/Jn8mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD82065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7EO3-0007kl-6z
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 04:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7ENS-00073A-5O; Sun, 16 Aug 2020 04:50:54 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:37929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7ENQ-0004VA-Iu; Sun, 16 Aug 2020 04:50:53 -0400
Received: by mail-yb1-xb44.google.com with SMTP id e187so7707684ybc.5;
 Sun, 16 Aug 2020 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WM81FUooLa0WVXS+UjOCZ/wG1bbk9t8qGS+VYBWibBo=;
 b=hs/Jn8mosBdbxqzJ5ztNKElGWO52K8rnov+ofIIHBIKo62kFD1BCyP1ibij1ElhfLK
 P/deJB5gSwuNVzYx/P4thPlL4t0vHWdtY4Aruh3BjeFr8qnhwWWNs1yecCf2i5xedGLr
 RB8BzsFrgbPT1F3Uuh1bwMDj1gaqsdVFYyohcOq6WnujT9GZPMvBf5PPLyfc9EdHi3SW
 /xom1hhax2a4+6ejY1qyJer/5IsRF1TIjUXasat69GxoSTi+wcAD89a9OCrDo/7Vvodb
 X1tGOtQQzeF51gky8ncY4SaFX0V6K0EYb8rjeRVMs7QmWqFs5RFTjgYjxxCDkwEmY+my
 3AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WM81FUooLa0WVXS+UjOCZ/wG1bbk9t8qGS+VYBWibBo=;
 b=qYB00EF6VjZBpGRW/gyk1/c+THEwLkDzzbvH0f41wNa4cjpxstZjGRwH37BDi0tXpG
 ZpVgHqLTgILRMalQPxJNEu9XJMBOCFSQJFXApvj7WSVhc+SgQdgSP8o3FkQKOYYYO0Ml
 48YMr0zEIgp5+k+K2eLLSOSZDDuUUVwTvNwmUDAuYXXfnIfnSumX2SL9eIjkJ3OdIwWf
 e9zwntOYW7IZz4DAxpHxBNyAhV7O6ZLmR89dbxgdVFzqDod/wLXdP1lrTqfZ0De5pODF
 c+5DooTrqVmIdzDGcDPTNAuTMUA3T0PlJjIna8oC83QPuwj9LPxdODCccVDx+Bj2Bf9V
 ABAg==
X-Gm-Message-State: AOAM533+Y7DibLR3USWDSXuH+uwfsI8IEqsVRN2D85qrAcB94BI01amR
 YYSOTT7jLQjSPz4RHvpRvCUMnVwc0mfUZRJ5rVk=
X-Google-Smtp-Source: ABdhPJwQoFoJ+Z5CFmoinXAGKMnfkIhh4A4P7ZqMLUiWgJJZtzFCizbcg0j/0ILMT0tDoQtTZIWmbh5cl1dkAL1MpkI=
X-Received: by 2002:a25:8290:: with SMTP id r16mr13534343ybk.122.1597567850460; 
 Sun, 16 Aug 2020 01:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-10-git-send-email-bmeng.cn@gmail.com>
 <e68381fd-e4cd-a56a-ab44-ff603242e1cc@amsat.org>
In-Reply-To: <e68381fd-e4cd-a56a-ab44-ff603242e1cc@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 16 Aug 2020 16:50:39 +0800
Message-ID: <CAEUhbmUtD2miWZk8uYvB6VkM8bu9rqr32J29WJADoNy9JethRg@mail.gmail.com>
Subject: Re: [PATCH 09/18] hw/sd: sdhci: Make sdhci_poweron_reset() internal
 visible
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-block@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sat, Aug 15, 2020 at 3:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 8/14/20 6:40 PM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > sdhci_poweron_reset() might be needed for any SDHCI compatible
> > device that is built on top of the generic SDHCI device.
>
> NAck. Please use device_legacy_reset() instead.
>
> In next patch:
>
>   device_legacy_reset(DEVICE(&sdhci->slot));
>

The function comments say this API is deprecated.

/**
 * device_legacy_reset:
 *
 * Reset a single device (by calling the reset method).
 * Note: This function is deprecated and will be removed when it becomes un=
used.
 * Please use device_cold_reset() now.
 */

Should we use device_cold_reset() here?

Regards,
Bin

