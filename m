Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C04C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE327204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDPY4nJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE327204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd4Oe-0002Le-P8
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 00:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jd4O8-0001qv-EI; Mon, 25 May 2020 00:06:56 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jd4O7-0002cP-Jw; Mon, 25 May 2020 00:06:56 -0400
Received: by mail-il1-x143.google.com with SMTP id 4so16262845ilg.1;
 Sun, 24 May 2020 21:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nRsDtZy2YlYIMN21R4+B7daGTFftOIQce142+jcEmlQ=;
 b=KDPY4nJiAi2a4Tsc4HVBl1JOi0F38RGE3orcXG1UMXmg8R1noB255BWh2aR91h5Gbu
 l8EXWWkgaiWOofe/lP8fgyZ/DMvGdh8pFnQqKOI+iE+9PAX9m/rL/Eo6WvmRVW9wv0G0
 0+RdYm6k7DZJf1iKk8GFeCEvt04urseJCEeyQZ6BiSVPIUz+6sIKiWp8O+Hnl70Wt2nr
 W271Vsb6t2fzoty8eZKCWQ6pwCoigUWBt2OstFcfowGGB5lSupLIJxv2OcULZJLMU3oN
 qVKvuBMdozGvdKVbpKad46JjABMVoV/RM0gWgc4UfL55SS7IFeN5VzKdoA4WQ5yUi5Nn
 UGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nRsDtZy2YlYIMN21R4+B7daGTFftOIQce142+jcEmlQ=;
 b=J9FYqGUXu7g0pfnszU6JBsW9/Rb8Kx4BeyaxL1hsDG0BGWr6uwc/lefiIb0mwkknl3
 odK+iBLGa5x/I9BPykYVSCk0LDD+nnEgsAQjD531RTd+1XI2vzv45qdFdTYnIN4PGyAn
 rGrR0lyFtW4htOAnJ9+hO7TCt3zQaPYPG5bxFG+XaEIuUgdNiUGwD/IW4zMXEkJGPpSp
 gWF6iDKY/ip/NXMufgdN+42edYm8lPx7+vnu5a9icfVUT8wm+XexCs89oiYx0TQ1CjoU
 EaGOIcMk9bvLPN/k2xoq6Wdhbi/CrR9i1pZ9WQr9mlzVlrFmdrouK+pkYBRdGX0Nl9Fy
 ESUA==
X-Gm-Message-State: AOAM531DRiONaqOA5S6frf5Ga1kplGZnbqSB15PUPhdclEdzbS441uGU
 X3CPT3ho4BS8vTy6Xwrps74wmbPa78PnK+vQWDc=
X-Google-Smtp-Source: ABdhPJy6VkTosKj8EQSKBJ3sSiZtXvVcw7ipcDE1DXTOIVFwbzxqnzXT6/RaqOTbT5P4DFhXjcY1aGjiJ/u64mi5QqU=
X-Received: by 2002:a92:d188:: with SMTP id z8mr21610866ilz.60.1590379613944; 
 Sun, 24 May 2020 21:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-4-stefanha@redhat.com>
In-Reply-To: <20200522171726.648279-4-stefanha@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 25 May 2020 00:06:43 -0400
Message-ID: <CAFubqFtNAJTAV4XRvNRJQEFMMxk0maX=2iOohe_T5hjWHy=gwQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] vhost-user-blk: add VIRTIO_F_RING_PACKED feature bit
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, QEMU <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 1:20 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Vhost devices have a list of feature bits that the device backend is
> allowed to control. The VIRTIO_F_RING_PACKED feature is a feature that
> must be negotiated through all the way to the device backend. Add it so
> the device backend can declare whether or not it supports the packed
> ring layout.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  hw/block/vhost-user-blk.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9d8c0b3909..10e114a19a 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -44,6 +44,7 @@ static const int user_feature_bits[] = {
>      VIRTIO_BLK_F_DISCARD,
>      VIRTIO_BLK_F_WRITE_ZEROES,
>      VIRTIO_F_VERSION_1,
> +    VIRTIO_F_RING_PACKED,
>      VIRTIO_RING_F_INDIRECT_DESC,
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_F_NOTIFY_ON_EMPTY,
> --
> 2.25.3
>

