Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BEEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 01:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623A320838
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 01:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKGjuwKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623A320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6O78-0000Yk-N7
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 21:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6O6W-00005J-34
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 21:01:56 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6O6U-0001lR-DJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 21:01:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id h22so6355701otq.11
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=E9whj3CQehYKsYDVk57ANzXRKMo6pl2XlQUAdEL8JY8=;
 b=NKGjuwKfZQgWHqP0kMPsVj2/5Yo4WeYKAc4u+cFMBP8KACIgpPXpL3NVD3OjXGUsX+
 hGhLjrNH8zyy4B2tePWohztLqmVzvw0G91zWiEUMvTB5fGrTcsD7EY4obX7B38Yssol2
 Av0vyf593/21V40x76nQ3UbGQj7A6AwlCATNoKj6ghVXBu7koBB2NHSA5Qu3foxcfQLQ
 JWQ94odMEy6BcO5/yhRSzqYxbjaYBxt74XOW4Mkuc6J+zTbiWUAIPMpwWuF9z7V1M1ek
 lABcQFc8KDv+21FHHOYAdDxMMFswOZTVqhzpoyAIq986VMdOpvEfWCKPIHGVuO+l4vZT
 2X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E9whj3CQehYKsYDVk57ANzXRKMo6pl2XlQUAdEL8JY8=;
 b=SoPyQtkWA2/Cvz9/Q1zX358BWr6uPQjId5uHQvnZ/sIj4eRP4bzc0pPnFjHa9T6KSs
 OSHYZZtl+u61rDK53xmboPq8O8ILn16CdKXtdICuAyfqhHZMft90X6wtanVjjkLvMe+U
 YCC147EvOUvvjYEIVNlGdGNDjU2fIXdy+2ESX64wyz1WnER34TCTmXMNJakPZ/mBzb3+
 ycCK4t0ODzpjlPindY/NCGSb5BgpeVIPvifyZmH5OdUXXGFHawmD5HmNiV5RxbZLiamH
 HPPEZ9pgxjOIqZtSTi/+WCWq6lXkOes6AWBr6EKkNj1e38bnRsyPbrsFvoO0FYldp9BA
 7D8Q==
X-Gm-Message-State: AOAM531ePbcXOyNasAhNj4yolnaUiDEVwpYqqTxVN57VdqwmCo6Z/kxN
 zpx+z/sZCHti5nf7Y5PMEjbCTl1PHQu1eKk2yws=
X-Google-Smtp-Source: ABdhPJyVBuGbV9jvrwzsrcg1b3TnmDF1N7qtAZuzJOos5dz+kKw7qRJp5pndaoT+A5RBERnhpRKX6l1sS0Vz7bO+Cok=
X-Received: by 2002:a05:6830:796:: with SMTP id
 w22mr281673ots.353.1597366913186; 
 Thu, 13 Aug 2020 18:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200813164637.58904-1-liq3ea@163.com>
 <e3c0b22e-f8dc-b7ba-65f2-2cae488a41ce@redhat.com>
In-Reply-To: <e3c0b22e-f8dc-b7ba-65f2-2cae488a41ce@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 14 Aug 2020 09:01:16 +0800
Message-ID: <CAKXe6S+ZqV7XMx7e_3ZAW2zk8EQEayUeKBNA1x3PrsdhH_rZyg@mail.gmail.com>
Subject: Re: [PATCH] hw: virtio-mem: detach the element fromt the virtqueue
 when error occurs
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13.08.20 18:46, Li Qiang wrote:
>
> For now we use "virtio-mem:" for the subject, without the "hw: "part.
>
> > If error occurs while processing the virtio request we should call
> > 'virtqueue_detach_element' to detach the element from the virtqueue
> > before free the elem.
>
> What's the effect of this? In all cases we trigger a virtio_error(), so
> do we really have to bother?
>

Though the 'in_use' will be reset to 0 while reseting the virtio device.
The mapped sglist will not be unammped.
There maybe some undesired behavior.  CC Paolo to make a confirmation.

Thanks,
Li Qiang

> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/virtio/virtio-mem.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> > index 7740fc613f..5ac6c3ec67 100644
> > --- a/hw/virtio/virtio-mem.c
> > +++ b/hw/virtio/virtio-mem.c
> > @@ -318,8 +318,7 @@ static void virtio_mem_handle_request(VirtIODevice =
*vdev, VirtQueue *vq)
> >          if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < le=
n) {
> >              virtio_error(vdev, "virtio-mem protocol violation: invalid=
 request"
> >                           " size: %d", len);
> > -            g_free(elem);
> > -            return;
> > +            goto out_free;
> >          }
> >
> >          if (iov_size(elem->in_sg, elem->in_num) <
> > @@ -327,8 +326,7 @@ static void virtio_mem_handle_request(VirtIODevice =
*vdev, VirtQueue *vq)
> >              virtio_error(vdev, "virtio-mem protocol violation: not eno=
ugh space"
> >                           " for response: %zu",
> >                           iov_size(elem->in_sg, elem->in_num));
> > -            g_free(elem);
> > -            return;
> > +            goto out_free;
> >          }
> >
> >          type =3D le16_to_cpu(req.type);
> > @@ -348,12 +346,15 @@ static void virtio_mem_handle_request(VirtIODevic=
e *vdev, VirtQueue *vq)
> >          default:
> >              virtio_error(vdev, "virtio-mem protocol violation: unknown=
 request"
> >                           " type: %d", type);
> > -            g_free(elem);
> > -            return;
> > +            goto out_free;
> >          }
> >
> >          g_free(elem);
> >      }
> > +
> > +out_free:
> > +    virtqueue_detach_element(vq, elem, 0);
> > +    g_free(elem);
> >  }
> >
> >  static void virtio_mem_get_config(VirtIODevice *vdev, uint8_t *config_=
data)
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>

