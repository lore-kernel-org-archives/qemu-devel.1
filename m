Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F19CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D51420675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/hMO9/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D51420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6HJ8-0007fa-FN
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k6HI3-00077q-Nr; Thu, 13 Aug 2020 13:45:23 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k6HHv-0001aV-JR; Thu, 13 Aug 2020 13:45:23 -0400
Received: by mail-ot1-x344.google.com with SMTP id v6so5437744ota.13;
 Thu, 13 Aug 2020 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c2U0W6xs4+RlY5Ev034LKwq7JLsCY7DpPGjM9pL9G+U=;
 b=B/hMO9/FhIz/8cmm+1RURJwB85SfM9krz9orfUaHQquuSC4gfL1GgVOpCqVGl7St7m
 7x+jZeO0ePPirc0R2IE2D+f2yduJchjRmm/JvxfubKSOEXZEV9Tr0rmX5DiYrMLmOoCI
 huZKl2aCDK6sLxDkuBe+oXvNUum27usu1cMTPNK+x4uo0FvgH0QrOZLkN1l10aEPjPmq
 lDfC2y/pcvYJj3+g4jaiZoZnqLDTZrzi4YrvGREi4aNFJmdFBQqURN9QxDSqWim5+g1V
 h014QuQZurD2YiVqC52BvNW2F85eAaJCjmGxCrhq2H0jR3Ay7whcUdQZJugvbtfGIVPb
 0ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c2U0W6xs4+RlY5Ev034LKwq7JLsCY7DpPGjM9pL9G+U=;
 b=KY8cTnQUuGvs/F5EbfxsQH48sd0HXtyn+wnFWzFWaL4goByFjCsBLFdpqQi0Wy4Lvg
 +ooToHNalTPV6aAX5o1wl94OxH5hFbx+pKKUkNhaPVBGpfdebTx83nUGYpgAQ7Zx3IxI
 rJS4zjFcn8653tVmMYaNwSRk0shoDT9psY3wszji8oz2+Yb7OdUladVSD9MdTcQiQGK7
 su5JRvBNoFxGIyO64f0Xry2/F07uNt+iNrAUMWeRmhOjk5BtWxhVRGA22nLa6TupuunT
 YP2ZecXVdVCRDeq2tBgy8iDHzg6VzD8UsFwKRQZhWS9sqc0aKlxhyW1QBmDrdmoWNJ2V
 qQQg==
X-Gm-Message-State: AOAM533EXV0XDuHryXfcz4oBwN4rQ8tQgK8C8n0VLvXc5ZOP5nDuIIFI
 f3bSAi1PoMZ44L6jbfYUc3ofM1Xx7iKR38Eh2/U=
X-Google-Smtp-Source: ABdhPJxp+2SxjPjaYH3c8BkGBompCNIWzL1DtyhKC0SQAZW8W1mPKrdBlEcH/uowWepk+3GR866ewG5ZL1WbYauYJdQ=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr5132611oth.337.1597340713617; 
 Thu, 13 Aug 2020 10:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-6-kuhn.chenqun@huawei.com>
In-Reply-To: <20200813073712.4001404-6-kuhn.chenqun@huawei.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 13 Aug 2020 12:44:57 -0500
Message-ID: <CAFubqFs4hm0mQpDbnNFpYWV3PEy68m9XEs1y7gJiS5ObYUxK=A@mail.gmail.com>
Subject: Re: [PATCH 05/11] hw/virtio/vhost-user:Remove dead assignment in
 scrub_shadow_regions()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: zhang.zhanghailiang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, pannengyuan@huawei.com, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 2:39 AM Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> Clang static code analyzer show warning:
> hw/virtio/vhost-user.c:606:9: warning: Value stored to 'mr' is never read
>         mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
>         ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index d7e2423762..9c5b4f7fbc 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -603,7 +603,7 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
>       */
>      for (i = 0; i < dev->mem->nregions; i++) {
>          reg = &dev->mem->regions[i];
> -        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> +        vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
>          if (fd > 0) {
>              ++fd_num;
>          }
> --
> 2.23.0
>
>

