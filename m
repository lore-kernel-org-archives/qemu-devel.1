Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED5AC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C75022B49
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vD3SkzJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C75022B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeug-0002t1-He
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFeu5-0002Sl-I0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:47:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFeu3-0001bG-OX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:47:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id m12so12100950otr.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oM0FyZleEA+fLmv1lAaygRqzMM1NudaYnsA8gqo/fxA=;
 b=vD3SkzJO2fdyshDgLLDb8fLd05CUBUxQ+F+jYVH1Sn54rD8PkjPFrIXRvNBY1lih+G
 T1+MCmvjjCp2O6HkoXyt7OrBhHzlgHWWeWeNF2Anap+mNuD/lnd4uholJMTVc8iqlNmX
 UP94xSB1w/oVPSpf+PsTg8yVoIslqzr3zFhG1FvLYFCqXBoF0TG8pURs4YH8GweKh7tm
 mmLirvnyHqakun7UbpHSJD2iXrNe5jJjjBElTi5T9uGUAUb0CJsq8LvJ7gxk6LA9kpHO
 LEdeXX7OEToHPQeWhelYXHZ0JxmP8b930jwpKDuJP524QwzRCZeyBiYQe3ynXjLFtuui
 C6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oM0FyZleEA+fLmv1lAaygRqzMM1NudaYnsA8gqo/fxA=;
 b=Ib7+e75AhVrg/19tWcYSRJrhSfG/yldQPpp+fgRBOLVxqQAeU+mj1mv7Ynr+4WlEJn
 iHShB4xYl7gUCAOMRgYBAwxm9OouZxw00acECvEYvwVIjmXsz5Kcx/zSP10j2TUrufmT
 tEvXYFXvkbUPCjuz7DttHlZh7Wbu1nX+2cz+5GnQ8azOW7+Kb24m2WU3xNT86OTIk9ck
 /avLsogvFaB4wTucT/Yb6MuuyyttmXzdp4gxU1MTa8/Bjj/cjOfgqWzFxdyuSf6cDqRT
 ZcgTOZO6gy+mJK+JxlwPOiRNbbmp74jF1lHJJuG6+J5waFOLYCl8OUwZmhmuOKF5Eblo
 JXeQ==
X-Gm-Message-State: AOAM5330VfDNtVF0eJCyYHbWWN/XJtiAKEYyJ8VTFIA6U6gd31/vKUih
 3tAP1MCpI5TErxmppjj91EsQ+gMrSHiOGOblo6k=
X-Google-Smtp-Source: ABdhPJzA3HD+H2DHaG4rZiJlOwCtV8MAd3D4gC09uLM9oKiC0V8Q4CMiZs5PrcKF3ZF6oGucqTaQlSUpW1eqxRonK1w=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr17319077ote.181.1599576442186; 
 Tue, 08 Sep 2020 07:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200816142245.17556-1-liq3ea@163.com>
 <CAKXe6SJjrTZ5cW3h227MUpPt8jsPimcrjiN8-WXSbVCZvdkCFg@mail.gmail.com>
 <CAKXe6SLt8r3bm0bGiGQ5sPoz-8xWrZkpnRFa1GEaT5_iRO1+Rg@mail.gmail.com>
 <20200908101025-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200908101025-mutt-send-email-mst@kernel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Sep 2020 22:46:45 +0800
Message-ID: <CAKXe6SJTRt=4GJeep8nGq2QwGz1krwsSq03Pj_eDT5m9PoMpmQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-mem: detach the element from the virtqueue when
 error occurs
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:10=E5=86=99=E9=81=93=EF=BC=9A
>
> For some reason I didn't receive the original email.
> Sorry.
> Queued now.
>

Kindly notice:
Here is another patch for virtio-pmem.

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02639.html


Thanks,
Li Qiang

> On Mon, Sep 07, 2020 at 09:36:40AM +0800, Li Qiang wrote:
> > Ping!
> >
> > Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:21=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Kindly ping.
> > >
> > > Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8816=E6=97=A5=
=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:23=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > If error occurs while processing the virtio request we should call
> > > > 'virtqueue_detach_element' to detach the element from the virtqueue
> > > > before free the elem.
> > > >
> > > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > > ---
> > > > Change since v1:
> > > > Change the subject
> > > > Avoid using the goto label
> > > >
> > > >  hw/virtio/virtio-mem.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> > > > index 7740fc613f..e6ffc781b3 100644
> > > > --- a/hw/virtio/virtio-mem.c
> > > > +++ b/hw/virtio/virtio-mem.c
> > > > @@ -318,6 +318,7 @@ static void virtio_mem_handle_request(VirtIODev=
ice *vdev, VirtQueue *vq)
> > > >          if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) =
< len) {
> > > >              virtio_error(vdev, "virtio-mem protocol violation: inv=
alid request"
> > > >                           " size: %d", len);
> > > > +            virtqueue_detach_element(vq, elem, 0);
> > > >              g_free(elem);
> > > >              return;
> > > >          }
> > > > @@ -327,6 +328,7 @@ static void virtio_mem_handle_request(VirtIODev=
ice *vdev, VirtQueue *vq)
> > > >              virtio_error(vdev, "virtio-mem protocol violation: not=
 enough space"
> > > >                           " for response: %zu",
> > > >                           iov_size(elem->in_sg, elem->in_num));
> > > > +            virtqueue_detach_element(vq, elem, 0);
> > > >              g_free(elem);
> > > >              return;
> > > >          }
> > > > @@ -348,6 +350,7 @@ static void virtio_mem_handle_request(VirtIODev=
ice *vdev, VirtQueue *vq)
> > > >          default:
> > > >              virtio_error(vdev, "virtio-mem protocol violation: unk=
nown request"
> > > >                           " type: %d", type);
> > > > +            virtqueue_detach_element(vq, elem, 0);
> > > >              g_free(elem);
> > > >              return;
> > > >          }
> > > > --
> > > > 2.17.1
> > > >
> > > >
> >
>

