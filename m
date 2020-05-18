Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E6FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFF320657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwIraq7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFF320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahqi-0007gi-8l
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jahnn-0004Lt-OT
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:35:39 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jahnm-0003cb-IH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:35:39 -0400
Received: by mail-io1-xd44.google.com with SMTP id f3so11067561ioj.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9PmfXYe7PP7KaXyx1USBnmvIOThVbvoE6psixv8jkyI=;
 b=QwIraq7cZwz79hfhaM789kKO4DIORPP1kD3zm0vG3Eo/1vKaf9U5RpzKizQS3TASFO
 iY3R6noqTYqTTN4u0NpwdQz6hc7ugvZfp32bSx/pKySnkFpvAM7a+g74YQf41rzHYQzy
 eI1Zi1hRffNsqInivMIch7dqY4WlF160DuzBXqiwIFG6fgFM689m3AH5eRppM0bI8sbw
 wbzuTxz16NckBIM8o2Y3Cu8PuImujI8icvQKo+pyK4WugqJHyl8RXVHL1kFhOcg9jbde
 ImoAaTa1wUNrWeVCOhdMBxizI9VTRAMti4NTcHinJDaGvYSNyDLn8PiZK1MIotaW6uZE
 8LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9PmfXYe7PP7KaXyx1USBnmvIOThVbvoE6psixv8jkyI=;
 b=s3eeus9G0c9K7lViPXendFcFeAJQwicbtXs3hXPCn+0Oe/jz4OZVpq+G/ZPHNJvPZ/
 2XzM24OVtWjoDFuyXiAbo3BI3eMmv8hNEYk91mPsBWNsHhlHavKtu6KwhaBtVmQ05ZoA
 U8duuJrnhb55JP3Fac3nYk1DYgac5osNtItt9b01SDSVKEvMq+hkrx8xNwjCK3xIzSUu
 /frGgwPCcxMlBok4R0x/U9fLBAw3BLvRiZuYPXp9NSONIlGlDYpgFHyRip9K774pxPEP
 V6YBZw6ysUu4C/OwKdfjWPe0PdryXsYAxulx8q4fNHcwZh2SgqSt920/wMvYHcH1O954
 PgOA==
X-Gm-Message-State: AOAM530UR7lsjqMZmejarMdfasBOlOPHD5ZO3nyp/1N8OUS8B/3LuhJH
 sF5JublH3YTHEPotdpZOmodEI8yuzShXTxQvX9o=
X-Google-Smtp-Source: ABdhPJzbyiJCnlkxQPWqQQRr5HoxPv/lVmrppm38UFDmYJLro1mFHlYlohMA9rk1MsoGESTE1qdBIF61hZ8Oi1XeXzs=
X-Received: by 2002:a6b:4113:: with SMTP id n19mr15167434ioa.187.1589816136560; 
 Mon, 18 May 2020 08:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-4-david@redhat.com>
In-Reply-To: <20200518083704.52646-4-david@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 18 May 2020 08:35:25 -0700
Message-ID: <CAKgT0UfNdU9quX75MrV0EQk-v0EP4w8g6UVFj2k2qRO=VUvRCQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: unref the iothread when unrealizing
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alexander.duyck@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 1:37 AM David Hildenbrand <david@redhat.com> wrote:
>
> We took a reference when realizing, so let's drop that reference when
> unrealizing.
>
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4fcf2d777..3f8fc50be0 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(DeviceSta=
te *dev)
>
>      if (s->free_page_bh) {
>          qemu_bh_delete(s->free_page_bh);
> +        object_unref(OBJECT(s->iothread));
>          virtio_balloon_free_page_stop(s);
>          precopy_remove_notifier(&s->free_page_report_notify);
>      }

I'm not entirely sure about this order of operations. It seems like it
would make more sense to remove the notifier, stop the hinting, delete
the bh, and then release the IO thread.

