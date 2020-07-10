Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67E7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46F3207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsvUIGJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46F3207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jto4o-0003RS-SS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jto3w-00030Z-IZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:07:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jto3t-0002OW-KO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:07:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id 18so3605747otv.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u0/riIHD0M8pNf5Jl+xFOxpQVsrkKCuY7/pLjutqg5o=;
 b=RsvUIGJ7nEKzCqZw2ESbAuXpPA9IiWwpcgrCk3hz9cVNBM/CXnO34RHqyB3DMfNMO1
 NTEkZrtfBWuAjfoC9eo8HfzTFB7CWjYo0MXDbJewl3kCYRt+bqGQKjNROfTomcGZA3z7
 0WgFi8emFLanSNeiveUtxd56rs58yB5crMB/Y8bPSAmuu9Olf6PVMmg6MQPj6AV0zi3a
 EsTUfgjHUEO3b+kNIK6i7AD94qSPmdRJ6gxWQ8Neibjh64aq5FQvViW7xKzeEz2Nuo9W
 vh1t8six3S8HbXWq+GZIV9hRSvlkN4sQdME0LugDq7NxTzBqTqsvCEEP7gEeqIdmVxuq
 H+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u0/riIHD0M8pNf5Jl+xFOxpQVsrkKCuY7/pLjutqg5o=;
 b=ZiB9sC33C836FixFXjZF+e4R+cJ8+1Khv9SGDwacdLuyBJNXs3x8PvaxBu4eXP7dmW
 wEXrlGxBG10Jel3ygvgXwz4QYPlkdZUCEwg26fNzBtVpDJzAzM6iiIkY0JU4ShfAyY3I
 X74aZB+q0u7LD/F7WkEDYCykGMfEqQo7L4OG6Oldx89b8mZ7ZR1pdLrWHQ4tqCIcbp9/
 ieBeetDWNodMwj4AeRiHK+gsv44ocgQrCYLO3hqlN573v/w0ryqGWpprMqIfs6hkZCuc
 94TO0kaSSaNf/yKf/jeqvRjycBttGwpzQvpagyTs4CdnwVLQPJ0pmr+SJb0zq2viB7As
 p4Gw==
X-Gm-Message-State: AOAM530HETTj6vPOO9RFBJjWtvrfE7RtOadAWuHHJTrxzIWlnhTipipG
 sHcuz7p4u7Ai1ckuTR3JE5OzndR6z2UTUPwsPRV4Dw==
X-Google-Smtp-Source: ABdhPJz2S9OB0gSj84gRjzCBaKrK2wg5IqP8LjGdNZcB0bvT93njwHmTV+CUiJ/tG9RAfRePLH5D8JisgaX2ikaLYCM=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr50394877oto.135.1594368432366; 
 Fri, 10 Jul 2020 01:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200710064642.24505-1-lulu@redhat.com>
In-Reply-To: <20200710064642.24505-1-lulu@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 09:07:01 +0100
Message-ID: <CAFEAcA9VOHS8ZcqFTvrj5fuKAtYK_uW5XYa4duYsQ_J5xwJK6Q@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267
To: Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, mhabets@solarflare.com,
 QEMU Developers <qemu-devel@nongnu.org>, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, Christoph Hellwig <hch@infradead.org>,
 eperezma@redhat.com, jgg@mellanox.com, Jason Wang <jasowang@redhat.com>,
 shahafs@mellanox.com, "Tian, Kevin" <kevin.tian@intel.com>, parav@mellanox.com,
 vmireyno@marvell.com, cunming.liang@intel.com, gdawar@xilinx.com,
 jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, zhihong.wang@intel.com,
 ian@iankelling.org, aadam@redhat.com, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Lingshan zhu <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 07:47, Cindy Lu <lulu@redhat.com> wrote:
>
> In the function vhost_vdpa_dma_map/unmap, The struct msg was not initialized all its fields.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/vhost-vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

