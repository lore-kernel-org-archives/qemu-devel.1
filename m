Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F643C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09382207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6ffwxLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09382207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYR8-0007Nb-BY
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYPF-0005t7-Od
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:24:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYPD-0001r5-NL
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:24:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id n24so1929358otr.13
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VYgo77E7YwfBL3bNIbHbEnhF3ci8aWj25htXShMeZSE=;
 b=M6ffwxLKJCSz/J4a1cV93y/5V3za8hoZI0OhcxhHBMJ+jIcc1xM3U7bDyX5I+fVeyq
 I2p9J/GmuFlQmEN4izgyv6o6OW8er44RSNun6dE36wL2DTKDRsLWIJX1TSbkbCkQqx8I
 HUFxjuBRpjLTaw4/vyJ5dbE6JcbZF+LWG1dQZOWbXETb8GOje1bMzcTVr9bG0oiaSwU2
 koq3QtekdoD40kr4d3KAsMFLcw2T3VhmTIxwwl+8N1fOHfJOHnFwsT+NG2gV6mWWgaAM
 vLWL1lXmH77uXwoGQnMHphzj3iQ5RXUsSRE2sKKLLJMH+jMQiPtzE1g3icLeunUcmLwj
 ym0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VYgo77E7YwfBL3bNIbHbEnhF3ci8aWj25htXShMeZSE=;
 b=pxxssDd2T7hcT+kvpDwIb18xz3N/b65Liuha/YEt9N7rDW+dtBvEgYVRLtc65s/3Is
 5XTEdJdJTHJ3tKaQ16ABZlqUw5ZusNZjfNJTDrRhJyfvd3NlRmb04IzGu3JFklAvIcxu
 Wx7MgaeumuYUKrOwJs8iEaFyGCRb9uPOZn/DhQg50xUM4Rq44B2wkIzODpjCOqZBhNdk
 JLi2l6tAMmXtp5yUZlin5mk5fD1MODWKJWLVnygdOQ595nEhE2Y77AM2sqz23lc9B0dr
 XCCKINS1QLcpc6PASccXeGw2nTtKFOIwTDQgzeE/pNdeU7dFdlDynVlAVhi8QU9TEbqB
 isTw==
X-Gm-Message-State: AOAM532ik/zTWJ02EAMP/zDu8FAXzOLbx3Cr6MBvnT4wS/hi7rDkYzC7
 EsJgWPm+8OLhvuTMqsT2LwERBDCvPMsFU0OMS/yF5A==
X-Google-Smtp-Source: ABdhPJwsq1oHQc/lYiBB8Yw0rgNCyg1ArprTvIOWCWKyHSyzMkSQFpy9NVETDdMGWB9srww7DIrBAZwcHk8XnIn1oTU=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr46746171otk.221.1594308250439; 
 Thu, 09 Jul 2020 08:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200706211314.20018.89695.stgit@localhost.localdomain>
 <20200706211407.20018.51061.stgit@localhost.localdomain>
In-Reply-To: <20200706211407.20018.51061.stgit@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:23:59 +0100
Message-ID: <CAFEAcA9O-oYay+-ttJHQDcFJU-=pX76Tize-KQjhPEinKNFrZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio-balloon: Add locking to prevent possible
 race when starting hinting
To: Alexander Duyck <alexander.duyck@gmail.com>
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 22:15, Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> There is already locking in place when we are stopping free page hinting
> but there is not similar protections in place when we start. I can only
> assume this was overlooked as in most cases the page hinting should not be
> occurring when we are starting the hinting, however there is still a chance
> we could be processing hints by the time we get back around to restarting
> the hinting so we are better off making sure to protect the state with the
> mutex lock rather than just updating the value with no protections.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 0c0fd7114799..b3e96a822b4d 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -593,6 +593,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>          return;
>      }
>
> +    qemu_mutex_lock(&s->free_page_lock);
> +
>      if (s->free_page_report_cmd_id == UINT_MAX) {
>          s->free_page_report_cmd_id =
>                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> @@ -601,6 +603,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>      }
>
>      s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
> +    qemu_mutex_unlock(&s->free_page_lock);
> +
>      virtio_notify_config(vdev);
>  }

Coverity spotted this lack of locking too: CID 1430269.

thanks
-- PMM

