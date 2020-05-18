Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406D2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD0220657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7/5Lyws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD0220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahsg-0001Zr-6M
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahrb-0000b0-KQ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:39:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahrZ-0004tR-E6
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:39:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id v17so8434893ote.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PNQuBFCv9wrH4GrYqjG8sxVuv9PD9ornhzuaxzknjsU=;
 b=v7/5LywsgAo+5PX+qO8OrOS0aXR4rZfuvf7schO7mhJ6tP3VAfgDeFQBgz39fHR2Fo
 ZTuVD4k6zSXhLHNGzGLuGXTSEMJ1CezkcvwcEGbxXAwHj6PR5KdGt6hTamYUBKEIqhwE
 PKaJFSl/+GrhtmSXQk4Mej3ovzNnXJZ7Nh9hwVityqfMTW/LeBYRrPwqGi1K0FJ+rOi2
 H9vlFY2Q9mSSKEDAopYZT0kt+JOLDIqptZKJTfa103Q2ckCnqFnljJVtzGZOAT9Znrk6
 4ozimLQdLtnNOlZUYW9JLxR2Nd9PjlqJkqh7xGR8rje5Bsq2TmlSo11Zs7cs5aprCkUP
 Ul+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PNQuBFCv9wrH4GrYqjG8sxVuv9PD9ornhzuaxzknjsU=;
 b=ijNJwk6Zv/aKWlahObIT4rVEUakBojj9ED1ffTP1Gdu/6pvVvmIlLB+Mim/8I7mDl3
 jBRrbkW4gxVNoGojpiU/1pmi2eLy7Nb3xIM4jkI0C3Q4V0JGAKirVpGHieNCZ0cwLCmN
 2OwMM/YMA4UVBnKpF54nyBRhkBAO+kma1uUoRlbQTNANiOR2xihrOyR+YuVvG5NC8SzM
 USPcowcOisJFoLEKblFq7DR0XVY5KPvFChSs0/3YfZeb28suKlodE6uec1q76PjjBXcF
 FYmvgsVuiAB1ULP7NXZrUblaRwUIR50o2hRNX9W17xHcECXZeryKjnjU4GGIf30OuRl8
 Cz5g==
X-Gm-Message-State: AOAM533CeHp+qN8RhpF6nGA8KfmaTKE+AV2pn8YtFgnHEZT2iT6CXU2u
 V6Jmuu+2+d8cQgqhGP4es+lt9s99Y693M8VCHyP6HA==
X-Google-Smtp-Source: ABdhPJxtHk8MZE26N3bjqDUwT3b4FYy8medXiMBvlDtmfhvVl8dWgEzAT8SdUPZF5NI+HtinIFJCLMXs2MKHWa5Ml7Q=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr3181822otr.135.1589816371525; 
 Mon, 18 May 2020 08:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200512064900.28554-1-pauldzim@gmail.com>
In-Reply-To: <20200512064900.28554-1-pauldzim@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:39:19 +0100
Message-ID: <CAFEAcA93EM=90r5yjpPyGFE5rD=z9SOLHW0UJ=WUxGsZgqbVPQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 at 07:49, Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> Gerd, Peter, what do you think about accepting this patch series? The
> only possibly disruptive patch is #5, which modifies the dev-storage.c
> code a bit, the rest is all new code which shouldn't affect anything
> else. Felippe Mathieu-Daud=C3=A9 has done quite a bit of review of the
> patches, and has said he thinks it could be accepted now.

I had some minor comments but other than those I think it looks good.
I'm assuming Gerd will review the usb-storage patch.

thanks
-- PMM

