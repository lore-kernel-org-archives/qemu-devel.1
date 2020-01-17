Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB0C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4304520748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GajIDTpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4304520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWlu-0003Dh-Ea
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1isWlB-0002mf-Pt
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1isWlA-0003Qu-4t
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:54:21 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1isWl9-0003Q5-Su
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:54:20 -0500
Received: by mail-qt1-x842.google.com with SMTP id w30so22502940qtd.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4bjCZVAVPqpMQRMnA00f5Fr81FPhgtMkrBmSTe0Wx6M=;
 b=GajIDTper7tK4qMWNPEQfVc1D7xDlRDxbh+JelWmPlZiBHArBPWNKwni6CaHDb68kA
 XdyB1SSaH+ivD7i6p1PXDP/Uj0UuqWTsNJ/CmptU6GsLH8ni9eIr5pXTBmcBOb01EB+L
 fvQt0PVSbMpE/J7vHbtbkjTtYu5IlcN/FsUWRX2S053hO1wyOSIkKcRuom/9OhGa9ua/
 LLdwBRuhq9rJ73KvRjeB04LeJuTJ6+e0k2zmde3ErBFPSOTvj80MKSKF5DHFp5cVifuq
 F5uHJII3B/Sm6VQiX/z66upbwm1RqtJ5RN1WO5noPAGw80R1uGMz3PUz5zULp664Q1Iq
 pcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4bjCZVAVPqpMQRMnA00f5Fr81FPhgtMkrBmSTe0Wx6M=;
 b=e3PnpB/5YijEQUhpzE4i+DYPprQ+rgH6Hgz3sHXzEg7jIWQja3VSpfqhfXK8VhLhoH
 WRSrVxQBdEG5Wd+Umxb3LN3Nhb6/6Bcehu5YkGOte66ViF7IoS2po4VGtuGC7PzJW/yw
 KbA3H1Po8ONxKVFnO/Mbbe9nfa4YNsZVc59kB5H+tY/B2kDOF+UkLet8YTO4oW0XiNHW
 5Tjmef7HqsXMy+RDt/xms+XJihCtkE4ycdkApTjmKZSIDipYXw0wkWoPDM47VeVM+46v
 0J4XV8/695F2IlDp854W7HwAEkS32k3kVMSoZf/6DBU0Qp852dA/AbVVIqh+DKh66o7O
 N30g==
X-Gm-Message-State: APjAAAVUlPBaIEkj1k76dQVwEbFLthIFGI8HPKzA6Y7kiiwwkPU4vRon
 5auz3EoMq+a0GEDVPulCZ/zxWqc=
X-Google-Smtp-Source: APXvYqyn+MqNsbN/P4toZU0B8HLuWt9oVGqVRObjVucUyJNmAOqCitgJGww+dQ1JYpR+lln3Y5p05w==
X-Received: by 2002:ac8:276a:: with SMTP id h39mr8707436qth.207.1579287258561; 
 Fri, 17 Jan 2020 10:54:18 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id h204sm585305qke.6.2020.01.17.10.54.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 10:54:18 -0800 (PST)
Date: Fri, 17 Jan 2020 13:54:12 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 026/104] virtiofsd: Fast path for virtio read
Message-ID: <20200117185412.5hmvojeqzg7vgpko@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-27-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-27-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:46PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Readv the data straight into the guests buffer.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> With fix by:
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> ---
>  tools/virtiofsd/fuse_lowlevel.c |   5 +
>  tools/virtiofsd/fuse_virtio.c   | 159 ++++++++++++++++++++++++++++++++
>  tools/virtiofsd/fuse_virtio.h   |   4 +
>  3 files changed, 168 insertions(+)
> 
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index c2b114cf5b..5f80625652 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -475,6 +475,11 @@ static int fuse_send_data_iov_fallback(struct fuse_session *se,
>          return fuse_send_msg(se, ch, iov, iov_count);
>      }
>  
> +    if (fuse_lowlevel_is_virtio(se) && buf->count == 1 &&
> +        buf->buf[0].flags == (FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK)) {
> +        return virtio_send_data_iov(se, ch, iov, iov_count, buf, len);
> +    }
> +
>      abort(); /* Will have taken vhost path */
>      return 0;
>  }
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index c33e0f7e8c..146cd3f702 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -230,6 +230,165 @@ err:
>      return ret;
>  }
>  
> +/*
> + * Callback from fuse_send_data_iov_* when it's virtio and the buffer
> + * is a single FD with FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK
> + * We need send the iov and then the buffer.
> + * Return 0 on success
> + */
> +int virtio_send_data_iov(struct fuse_session *se, struct fuse_chan *ch,
> +                         struct iovec *iov, int count, struct fuse_bufvec *buf,
> +                         size_t len)
> +{
> +    int ret = 0;
> +    VuVirtqElement *elem;
> +    VuVirtq *q;
> +
> +    assert(count >= 1);
> +    assert(iov[0].iov_len >= sizeof(struct fuse_out_header));
> +
> +    struct fuse_out_header *out = iov[0].iov_base;
> +    /* TODO: Endianness! */
> +
> +    size_t iov_len = iov_size(iov, count);
> +    size_t tosend_len = iov_len + len;
> +
> +    out->len = tosend_len;
> +
> +    fuse_log(FUSE_LOG_DEBUG, "%s: count=%d len=%zd iov_len=%zd\n", __func__,
> +             count, len, iov_len);
> +
> +    /* unique == 0 is notification which we don't support */
> +    assert(out->unique);
> +
> +    /* For virtio we always have ch */
> +    assert(ch);
> +    assert(!ch->qi->reply_sent);
> +    elem = ch->qi->qe;
> +    q = &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
> +
> +    /* The 'in' part of the elem is to qemu */
> +    unsigned int in_num = elem->in_num;
> +    struct iovec *in_sg = elem->in_sg;
> +    size_t in_len = iov_size(in_sg, in_num);
> +    fuse_log(FUSE_LOG_DEBUG, "%s: elem %d: with %d in desc of length %zd\n",
> +             __func__, elem->index, in_num, in_len);
> +
> +    /*
> +     * The elem should have room for a 'fuse_out_header' (out from fuse)
> +     * plus the data based on the len in the header.
> +     */
> +    if (in_len < sizeof(struct fuse_out_header)) {
> +        fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for out_header\n",
> +                 __func__, elem->index);

> +        ret = -E2BIG;

The ret should be positive value, right?

           ret = E2BIG;

> +        goto err;
> +    }
> +    if (in_len < tosend_len) {
> +        fuse_log(FUSE_LOG_ERR, "%s: elem %d too small for data len %zd\n",
> +                 __func__, elem->index, tosend_len);

> +        ret = -E2BIG;

           ret = E2BIG;

> +        goto err;
> +    }
> +
> +    /* TODO: Limit to 'len' */
> +
> +    /* First copy the header data from iov->in_sg */
> +    copy_iov(iov, count, in_sg, in_num, iov_len);
> +
> +    /*
> +     * Build a copy of the the in_sg iov so we can skip bits in it,
> +     * including changing the offsets
> +     */

> +    struct iovec *in_sg_cpy = calloc(sizeof(struct iovec), in_num);

       assert(in_sg_cpy) should be here? in case calloc() fails...

> +    memcpy(in_sg_cpy, in_sg, sizeof(struct iovec) * in_num);
> +    /* These get updated as we skip */
> +    struct iovec *in_sg_ptr = in_sg_cpy;
> +    int in_sg_cpy_count = in_num;
> +
> +    /* skip over parts of in_sg that contained the header iov */
> +    size_t skip_size = iov_len;
> +
> +    size_t in_sg_left = 0;
> +    do {
> +        while (skip_size != 0 && in_sg_cpy_count) {
> +            if (skip_size >= in_sg_ptr[0].iov_len) {
> +                skip_size -= in_sg_ptr[0].iov_len;
> +                in_sg_ptr++;
> +                in_sg_cpy_count--;
> +            } else {
> +                in_sg_ptr[0].iov_len -= skip_size;
> +                in_sg_ptr[0].iov_base += skip_size;
> +                break;
> +            }
> +        }
> +
> +        int i;
> +        for (i = 0, in_sg_left = 0; i < in_sg_cpy_count; i++) {
> +            in_sg_left += in_sg_ptr[i].iov_len;
> +        }
> +        fuse_log(FUSE_LOG_DEBUG,
> +                 "%s: after skip skip_size=%zd in_sg_cpy_count=%d "
> +                 "in_sg_left=%zd\n",
> +                 __func__, skip_size, in_sg_cpy_count, in_sg_left);
> +        ret = preadv(buf->buf[0].fd, in_sg_ptr, in_sg_cpy_count,
> +                     buf->buf[0].pos);
> +

> +        fuse_log(FUSE_LOG_DEBUG, "%s: preadv_res=%d(%m) len=%zd\n",
> +                 __func__, ret, len);

"%m" should be removed? because it may show the previous errno even if preadv()
is succsess. Like as:

[ID: 00000079] virtio_send_data_iov: after skip skip_size=0 in_sg_cpy_count=1 in_sg_left=65536
[ID: 00000079] virtio_send_data_iov: preadv_res=16000(No such file or directory) len=65536

Otherwise, looks good to me:

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks,
Masa

> +        if (ret == -1) {
> +            ret = errno;
> +            free(in_sg_cpy);
> +            goto err;
> +        }
> +        if (ret < len && ret) {
> +            fuse_log(FUSE_LOG_DEBUG, "%s: ret < len\n", __func__);
> +            /* Skip over this much next time around */
> +            skip_size = ret;
> +            buf->buf[0].pos += ret;
> +            len -= ret;
> +
> +            /* Lets do another read */
> +            continue;
> +        }
> +        if (!ret) {
> +            /* EOF case? */
> +            fuse_log(FUSE_LOG_DEBUG, "%s: !ret in_sg_left=%zd\n", __func__,
> +                     in_sg_left);
> +            break;
> +        }
> +        if (ret != len) {
> +            fuse_log(FUSE_LOG_DEBUG, "%s: ret!=len\n", __func__);
> +            ret = EIO;
> +            free(in_sg_cpy);
> +            goto err;
> +        }
> +        in_sg_left -= ret;
> +        len -= ret;
> +    } while (in_sg_left);
> +    free(in_sg_cpy);
> +
> +    /* Need to fix out->len on EOF */
> +    if (len) {
> +        struct fuse_out_header *out_sg = in_sg[0].iov_base;
> +
> +        tosend_len -= len;
> +        out_sg->len = tosend_len;
> +    }
> +
> +    ret = 0;
> +
> +    vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
> +    vu_queue_notify(&se->virtio_dev->dev, q);
> +
> +err:
> +    if (ret == 0) {
> +        ch->qi->reply_sent = true;
> +    }
> +
> +    return ret;
> +}
> +
>  /* Thread function for individual queues, created when a queue is 'started' */
>  static void *fv_queue_thread(void *opaque)
>  {
> diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
> index 135a14875a..cc676b9193 100644
> --- a/tools/virtiofsd/fuse_virtio.h
> +++ b/tools/virtiofsd/fuse_virtio.h
> @@ -26,4 +26,8 @@ int virtio_loop(struct fuse_session *se);
>  int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
>                      struct iovec *iov, int count);
>  
> +int virtio_send_data_iov(struct fuse_session *se, struct fuse_chan *ch,
> +                         struct iovec *iov, int count,
> +                         struct fuse_bufvec *buf, size_t len);
> +
>  #endif
> -- 
> 2.23.0
> 
> 

