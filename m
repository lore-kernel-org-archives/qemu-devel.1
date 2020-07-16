Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41DDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BC820739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZcd//SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BC820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6eK-0003ze-TM
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6dO-00034E-2d
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:21:22 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6dM-0002Av-7x
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:21:21 -0400
Received: by mail-oi1-x242.google.com with SMTP id w17so5538376oie.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OvJlvjZ6pSrB0BWJKuiPGwS3qxQi6Ecd1+OqNyJHYlg=;
 b=hZcd//SAnHtpnWH30gU+UvFgExGHikWGkU/UhzTHz7j12y1iQItTeltyGWvRVChj/c
 yfC6oeadu2t1x5kXcLGIMwBvW46Cdm4CwxLRQF9NSEbvnxEeeIr1h6Td6wCc81tM3K6P
 tU0EqsXQYCzAvyWxXJVA8qPchxEaPKnCPFK/8AXptbXNBP3hOSrfY0AMXIZL5xh/rE/S
 w/vUjSWc333CFt3/41GytIawt6+fPsC+2f8JCaNVKNkH3McJSgaXoEGXsEPzd7AKCQtw
 pK01GpTSNqW/OukNhRItZ7uZYj8TyzKNKx0TbRKx7MpxVXmkOS0nnd7eKvNuRqwPNMf3
 tP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OvJlvjZ6pSrB0BWJKuiPGwS3qxQi6Ecd1+OqNyJHYlg=;
 b=YWZq7p3Z0pKRBdYJebJGFVKmkXY7OM7W7p847YAKU5Zvyfgnb9oL5o2LKHlOeMuLnU
 1NCnGxQ4guKccWTVG7Kpjy01YwpPXvCqEzMAqYdNAQo0x0Bbl0Xb3OrdCeLOZ3Tv6vIt
 uB1FStUCkqeqA9WvMWLvaHK0io/vg+BXoGAZy/TPRycDS3XUnNBRI8LypcQVUf859OfY
 /tLVmHvwgwLs5irej5UaYJK0dDWV1kx1Lr8dKEEBvU9bsxs0XcH8bjqub+eiYhj1ykV+
 KHI8rZKXzsoSnWgABKEdqX9Aj4Vg9s29K2E5JiruPZn0B8/cZoqw6AOfa/apMoYgMOFU
 ZRTA==
X-Gm-Message-State: AOAM532+pLWr+/IZ+mRvrRoSzvQr1tI1i/MwzlY/Z6RpOjTh3hqOAmYR
 ErLDmloze0Ywzpi6kem7s0Hpv0OTgqiRq4KZHkhz/w==
X-Google-Smtp-Source: ABdhPJwZgF63lvDobkzNymRZ9/zX2s9X2eoMxnyLVuwUZ4MnPPO1XoKcfTsfMSkxcmIC6TqZp/ZaAD8qNjDnfAyWZGY=
X-Received: by 2002:aca:2819:: with SMTP id 25mr4149062oix.48.1594916478722;
 Thu, 16 Jul 2020 09:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-9-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-9-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 17:21:07 +0100
Message-ID: <CAFEAcA83oGZMFS40m2rcFF+b-k_B1=e5QORwPAN68e1zjhqDHQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] imx7-ccm: add digprog mmio write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 13:31, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add digprog mmio write method to avoid assert failure during
> initialisation.
>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/misc/imx7_ccm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> Update v3: Add Reviewed-by: ...
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09452.html
>
> diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
> index 02fc1ae8d0..5ac5ecf74c 100644
> --- a/hw/misc/imx7_ccm.c
> +++ b/hw/misc/imx7_ccm.c
> @@ -131,8 +131,15 @@ static const struct MemoryRegionOps imx7_set_clr_tog_ops = {
>      },
>  };
>
> +static void imx7_digprog_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +}

This covers a single register (DIGPROG) which is read-only
(it returns a silicon revision number). So this is not a
LOG_UNIMP, but a LOG_GUEST_ERROR:

     qemu_log_mask(LOG_GUEST_ERROR, "Guest write to read-only
ANALOG_DIGPROG register\n");

thanks
-- PMM

