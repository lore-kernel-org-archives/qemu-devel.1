Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640E7C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFA2206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1SkTSJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFA2206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfRv-0006Nu-CD
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyfRC-0005rn-TK
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:55:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyfRB-0005BB-7n
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:55:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id 18so5011212otv.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hjO4sAqNk87d29tUpcojtJg6DKFI+TSCsesTqD6qtKs=;
 b=Q1SkTSJ/7ktS5zcmuWDJXXn2+9c9x1hlswPBRPQda4sGnOfvSDvnPqtCxBDjrU7BC7
 GNCqu+u0Zy/cwUkqNsUCmWTRTKc7BNYIoz0zfR6NgeTsDP/wDcBV6C3oyy25nxXWbkzw
 iq8mMHoPRAEW9EdwFT+pygBiZv2DgGAa82NrawOCqqZbQxN7UNQsecvd/rnT6XjQ2kBe
 /8pd5LuLK3gYWEMnkRxYsidZo6wACPF1H2lAooYt2712TuUpDNfvMMsTWQSYW17cqYF+
 HsDrTlBEXH+KwTu3qIbalD9fbZcASPZYHR7ZGXEEkR4XhycBb9ISo80rLN4zJtvVlqSU
 W75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hjO4sAqNk87d29tUpcojtJg6DKFI+TSCsesTqD6qtKs=;
 b=Y8eZyXWr+tymznJMZLbYr3abocSqwzfOTFSEKDoqVbPnRcGHoeiWVOhVCpC9vthig1
 5PnnKXUqQTyfmveggVu3RYYL76NfooiAU9FtumUBO+0Xq30m/1tG9j5IaYV1EjIXVlY0
 TiCtyc2lmiBHQny+/1BqCQbig+s20ZZhu0D1EEafAZDpQpJKiHXDcL2BcA2+QTDSYJ1U
 8obLFBhp9Resu+z8Vs3YB8Scbsud0lkMBQ9RyCYjEnUHj3JPM2ZGdMW3LkEUNup0XHF0
 mMuRThhk4kPIztUg+MLZ+xylA7mcHuO+JGZs7FIH36HL3/QXBl93b+VZ9QkYmNglASFL
 cfcQ==
X-Gm-Message-State: AOAM530/44LITZm+QBzjbw7FoLGa9zgra/SW6qbwiVRNgnGasvolV/Gy
 cbYndKRvKdBvcaM0VKY+aGHroxAOI0MNQqWZmUogdime
X-Google-Smtp-Source: ABdhPJzNBa87Z19Ftl9JhQSdW4pfQ7zUP7NJPhaBZ+Ks2ru07bhuZuZiren5FKggkfX5LjkD8Ka4RGwgeJzr+BrqtME=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr5207885ota.91.1595526919629; 
 Thu, 23 Jul 2020 10:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200710064642.24505-1-lulu@redhat.com>
In-Reply-To: <20200710064642.24505-1-lulu@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 18:55:08 +0100
Message-ID: <CAFEAcA_dhusPWdObGznvh_Ox0ntwk-fE67f26iFfLkRbbx0K1Q@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267
To: Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(trimming down the rather exuberant CC list)

On Fri, 10 Jul 2020 at 07:47, Cindy Lu <lulu@redhat.com> wrote:
>
> In the function vhost_vdpa_dma_map/unmap, The struct msg was not initialized all its fields.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/vhost-vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Michael, I guess this should go via your tree ?

thanks
-- PMM

