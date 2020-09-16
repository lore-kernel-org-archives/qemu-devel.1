Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16EC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2054022272
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp2RR01B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2054022272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZYU-0003Wf-Uh
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIZWd-0002Nz-L4; Wed, 16 Sep 2020 11:39:15 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIZWb-0000DZ-Pw; Wed, 16 Sep 2020 11:39:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id o6so7129936ota.2;
 Wed, 16 Sep 2020 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ac1g458O7/MnYRgO9bXKxfK/RPSp/oMzJpRL6z5WDjI=;
 b=qp2RR01BIDgg3+PMburLZcz76/EmknVvlP0j6eqGZUXgITFN/4PorxoJj/ecxlwnSH
 iK34F3iMWjkYIBTybpiQJGZSrZsKS3aF8p/tas5RMw8fPWS++0QRnBB0VoXz64vrXFak
 DYCg4RikcK3EAx20nMM6rFdMdyI+tndmZfzxXmlCa+NKPtoRY1RaBqixri3BqdIZzslK
 Xh4hDk7A+0dzl0pYKh2WLyqWHzT9DggfYGYHZT3Nh9e2eosEw2DpJ8mymzqsrZb4W4ZM
 8jF/twyglB3Wb+a1xZpLO7lu0utiTs8MByM2IK7949VlETiWY1HXHiLi3rWZe4yzhyIE
 McLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ac1g458O7/MnYRgO9bXKxfK/RPSp/oMzJpRL6z5WDjI=;
 b=KdYV2TRslUlR93Y5M3sO2vm8YAKHv4jCBlIQeADXGbJvWPdELfQ+kiNOjeHR14hzxJ
 4TDhnjXS3L4vgRr6uPo2gOHTXtx3NOiOzX8roKXnzHZ7KiWMdKSWYpIWsp3UeZ4unASk
 ZO/uwOTnqmwZbWIKID1Ps/HrYfj3VZqN1A40J75JDUSAuLh0pjomDBF1TbqBN4EEP2/V
 1EhFEP9oisJgqNaX4XUKzWnwNT5bxUokwAUt4oAX/b+sKQ1E0D4/B8ezw5q0xRhaGz9d
 /Ct6rvAKPatdKh8dlNFr3cua98GVhuWu/PXsdsRSM2nDtiwCTjKj9lKOoBOsNkfSnLMj
 xT+A==
X-Gm-Message-State: AOAM533lkYAG1jfYmdc9UJ0fpODOYVbe2RQfnKLM97TedRtgHDx77LY8
 KRQDew4pqNR11nE/NynAPw6KT5nHpTfxwKeYC8s=
X-Google-Smtp-Source: ABdhPJwHVUmiFDPhAo3atTFw4IcnbKy1koQNgDbS9hilv542VfHo6fz4mjvB0vDGMJMEZaFBZMgO4WVKVcMCCRzKEOA=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr16108506ote.181.1600270752222; 
 Wed, 16 Sep 2020 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200812104918.107116-1-stefanha@redhat.com>
 <20200812104918.107116-3-stefanha@redhat.com>
In-Reply-To: <20200812104918.107116-3-stefanha@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 23:38:36 +0800
Message-ID: <CAKXe6SJqS61dUaKjbXb4-TGMcDLCG-ss2Mo0WaHYa32bcgO0TQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] virtio-blk: undo destructive iov_discard_*()
 operations
To: Stefan Hajnoczi <stefanha@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Fuzzing discovered that virtqueue_unmap_sg() is being called on modified
> req->in/out_sg iovecs. This means dma_memory_map() and
> dma_memory_unmap() calls do not have matching memory addresses.
>
> Fuzzing discovered that non-RAM addresses trigger a bug:
>
>   void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                            bool is_write, hwaddr access_len)
>   {
>       if (buffer !=3D bounce.buffer) {
>           ^^^^^^^^^^^^^^^^^^^^^^^
>
> A modified iov->iov_base is no longer recognized as a bounce buffer and
> the wrong branch is taken.
>
> There are more potential bugs: dirty memory is not tracked correctly and
> MemoryRegion refcounts can be leaked.
>
> Use the new iov_discard_undo() API to restore elem->in/out_sg before
> virtqueue_push() is called.
>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890360
> Fixes: 827805a2492c1bbf1c0712ed18ee069b4ebf3dd6 ("virtio-blk: Convert Vir=
tIOBlockReq.out to structrue")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/virtio/virtio-blk.h | 2 ++
>  hw/block/virtio-blk.c          | 9 +++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
> index b1334c3904..0af654cace 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -68,6 +68,8 @@ typedef struct VirtIOBlockReq {
>      int64_t sector_num;
>      VirtIOBlock *dev;
>      VirtQueue *vq;
> +    IOVDiscardUndo inhdr_undo;
> +    IOVDiscardUndo outhdr_undo;
>      struct virtio_blk_inhdr *in;
>      struct virtio_blk_outhdr out;
>      QEMUIOVector qiov;
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 413783693c..2b7cc3e1c8 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -80,6 +80,8 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req=
, unsigned char status)
>      trace_virtio_blk_req_complete(vdev, req, status);
>
>      stb_p(&req->in->status, status);
> +    iov_discard_undo(&req->inhdr_undo);
> +    iov_discard_undo(&req->outhdr_undo);
>      virtqueue_push(req->vq, &req->elem, req->in_len);
>      if (s->dataplane_started && !s->dataplane_disabled) {
>          virtio_blk_data_plane_notify(s->dataplane, req->vq);
> @@ -632,10 +634,12 @@ static int virtio_blk_handle_request(VirtIOBlockReq=
 *req, MultiReqBuffer *mrb)
>          return -1;
>      }
>
> -    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
> +    iov_discard_front_undoable(&out_iov, &out_num, sizeof(req->out),
> +                               &req->outhdr_undo);
>
>      if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
>          virtio_error(vdev, "virtio-blk request inhdr too short");
> +        iov_discard_undo(&req->outhdr_undo);
>          return -1;
>      }
>
> @@ -644,7 +648,8 @@ static int virtio_blk_handle_request(VirtIOBlockReq *=
req, MultiReqBuffer *mrb)
>      req->in =3D (void *)in_iov[in_num - 1].iov_base
>                + in_iov[in_num - 1].iov_len
>                - sizeof(struct virtio_blk_inhdr);
> -    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr));
> +    iov_discard_back_undoable(in_iov, &in_num, sizeof(struct virtio_blk_=
inhdr),
> +                              &req->inhdr_undo);
>
>      type =3D virtio_ldl_p(vdev, &req->out.type);
>

It seems there is another error path need to do the undo operations.
case VIRTIO_BLK_T_WRITE_ZEROS & ~VIRTIO_BLK_T_OUT
handler has an error path.

Thanks,
Li Qiang

> --
> 2.26.2
>

