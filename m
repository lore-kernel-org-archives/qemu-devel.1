Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C246C2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHhuanXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C246C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7e6H-0002pP-W5
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1k7e5Y-0002Me-FW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:18:08 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1k7e5T-0005R8-7O
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:18:08 -0400
Received: by mail-io1-xd41.google.com with SMTP id g19so17347126ioh.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ALffDTc+qgFx9Svktko+oaUQOs5aDguHQr9PrXNI8QA=;
 b=XHhuanXXC0c/kB317FFGt+JAcB5MYKAkFRmInw+bLKuGo6E/tQEHmgyp7toLeVw/IZ
 7rqUHifqcc2fpJyWYSeIOdjnRBGT44gopbRSSmGdwhEjgUNOzXDyTSstlob21j0iXPy/
 g3XlfjJXVW/oH8HpxBfVj9XRqqcVg59nflviUu3BnvhtIJFyGxly2DAyPfTvwtqP8xa/
 D+bVFU76ksHuguOqNYjdkw6IHhiU/ZE2j696VPVNyKMlD5ePDX8XZhCdpSGBGmskSD9a
 jN3imoxopTL8oKi/+KRWZUFZrJrXW6p1qKRG/tHCmBkoU73nRLAdiXa/DoPkOgK6ffDG
 8/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ALffDTc+qgFx9Svktko+oaUQOs5aDguHQr9PrXNI8QA=;
 b=ahTId2LgY4hqC53ddY5UwElYkR70HUrnNX2HpFu7wUQYTis5QgX8vdv+wQFTZ5bQZY
 eSA1PAtT2S/+nzxic7O0cXNd0MPl5+g/f6dKlax+07FccmhVzG2i+lw6E1Ngpq5FDbFZ
 9mo0K4jAy/Hur9Eh19HnV6cBfugfgLRU8uF7ga9aLjuPXa5+DeW/H5HQXeNmNELnC77f
 q4mmBDL4rNilksUARNEC29IeIPYnFIVFQIVlPXfFdX40+IgAYIGwvLC+HsU4IIvsaJtP
 eTqaBEwEmhJwXE6PsOlILaGV0fICg25hf0bjhlvdfo/X7sXyqjwS07mXKNyPBygNnDRD
 wzog==
X-Gm-Message-State: AOAM5323y28cQG3Fy7LmFttHUrZSYnl2OddrbbjhOlOLLszaWeStxrk/
 ZPor6ARM6EhNH5Zs1gFnIkov7lrXwJEch8stqP8=
X-Google-Smtp-Source: ABdhPJywTVSfaXhlgepLsMtrGaTx3iJKN9WZoxDHuIDxyoLIo8ELqpLigRxPYwmV4r0WE9Rhj3Z9So32gysD5wetIUU=
X-Received: by 2002:a6b:b513:: with SMTP id e19mr12096006iof.167.1597666681643; 
 Mon, 17 Aug 2020 05:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200813165125.59928-1-liq3ea@163.com>
In-Reply-To: <20200813165125.59928-1-liq3ea@163.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Mon, 17 Aug 2020 14:17:49 +0200
Message-ID: <CAM9Jb+gL=3XybNooMVV17sxZ95kzc14y5HYxFTz2643f8pDijA@mail.gmail.com>
Subject: Re: [PATCH] hw: virtio-pmem: detach the element fromt the virtqueue
 when error occurs
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> If error occurs while processing the virtio request we should call
> 'virtqueue_detach_element' to detach the element from the virtqueue
> before free the elem.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/virtio/virtio-pmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> index 1e0c137497..ddb0125901 100644
> --- a/hw/virtio/virtio-pmem.c
> +++ b/hw/virtio/virtio-pmem.c
> @@ -77,6 +77,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
>
>      if (req_data->elem.out_num < 1 || req_data->elem.in_num < 1) {
>          virtio_error(vdev, "virtio-pmem request not proper");
> +        virtqueue_detach_element(vq, (VirtQueueElement *)req_data, 0);
>          g_free(req_data);
>          return;
>      }
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.17.1
>
>

