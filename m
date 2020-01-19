Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E961C33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 08:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0EE20684
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 08:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0EE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it5dt-0002mF-CJ
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 03:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yangx.jy@cn.fujitsu.com>) id 1it5dD-0002M0-90
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yangx.jy@cn.fujitsu.com>) id 1it5dB-0005Kd-UI
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:08:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45409
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <yangx.jy@cn.fujitsu.com>) id 1it5dB-0005Ie-JE
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:08:25 -0500
X-IronPort-AV: E=Sophos;i="5.70,337,1574092800"; d="scan'208";a="82259448"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 19 Jan 2020 16:08:15 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
 by cn.fujitsu.com (Postfix) with ESMTP id 1F2ED5010EAF;
 Sun, 19 Jan 2020 15:59:02 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Sun, 19 Jan 2020 16:08:10 +0800
Message-ID: <5E240E69.2030803@cn.fujitsu.com>
Date: Sun, 19 Jan 2020 16:08:09 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN;
 rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 040/104] virtiofsd: Pass write iov's all the way through
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-41-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-41-dgilbert@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 1F2ED5010EAF.AB276
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 183.91.158.132
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

On 2019/12/13 0:38, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
>
> Pass the write iov pointing to guest RAM all the way through rather
> than copying the data.
>
> Signed-off-by: Dr. David Alan Gilbert<dgilbert@redhat.com>
> ---
>   tools/virtiofsd/fuse_virtio.c | 79 ++++++++++++++++++++++++++++++++---
>   1 file changed, 73 insertions(+), 6 deletions(-)
>
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 99c877ea2e..3c778b6296 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -452,6 +452,10 @@ static void *fv_queue_thread(void *opaque)
>                    __func__, qi->qidx, (size_t)evalue, in_bytes, out_bytes);
>
>           while (1) {
> +            bool allocated_bufv = false;
> +            struct fuse_bufvec bufv;
> +            struct fuse_bufvec *pbufv;
> +
>               /*
>                * An element contains one request and the space to send our
>                * response They're spread over multiple descriptors in a
> @@ -493,14 +497,76 @@ static void *fv_queue_thread(void *opaque)
>                            __func__, elem->index);
>                   assert(0); /* TODO */
>               }
> -            copy_from_iov(&fbuf, out_num, out_sg);
> -            fbuf.size = out_len;
> +            /* Copy just the first element and look at it */
> +            copy_from_iov(&fbuf, 1, out_sg);
> +
> +            if (out_num>  2&&
> +                out_sg[0].iov_len == sizeof(struct fuse_in_header)&&
> +                ((struct fuse_in_header *)fbuf.mem)->opcode == FUSE_WRITE&&
> +                out_sg[1].iov_len == sizeof(struct fuse_write_in)) {
> +                /*
> +                 * For a write we don't actually need to copy the
> +                 * data, we can just do it straight out of guest memory
> +                 * but we must still copy the headers in case the guest
> +                 * was nasty and changed them while we were using them.
> +                 */
> +                fuse_log(FUSE_LOG_DEBUG, "%s: Write special case\n", __func__);
> +
> +                /* copy the fuse_write_in header after the fuse_in_header */
> +                fbuf.mem += out_sg->iov_len;
> +                copy_from_iov(&fbuf, 1, out_sg + 1);
> +                fbuf.mem -= out_sg->iov_len;
> +                fbuf.size = out_sg[0].iov_len + out_sg[1].iov_len;
> +
> +                /* Allocate the bufv, with space for the rest of the iov */
> +                allocated_bufv = true;
> +                pbufv = malloc(sizeof(struct fuse_bufvec) +
> +                               sizeof(struct fuse_buf) * (out_num - 2));
> +                if (!pbufv) {
> +                    vu_queue_unpop(dev, q, elem, 0);
> +                    free(elem);
> +                    fuse_log(FUSE_LOG_ERR, "%s: pbufv malloc failed\n",
> +                             __func__);
> +                    goto out;
> +                }
> +
> +                pbufv->count = 1;
> +                pbufv->buf[0] = fbuf;
> +
> +                size_t iovindex, pbufvindex;
> +                iovindex = 2; /* 2 headers, separate iovs */
> +                pbufvindex = 1; /* 2 headers, 1 fusebuf */
> +
> +                for (; iovindex<  out_num; iovindex++, pbufvindex++) {
> +                    pbufv->count++;
> +                    pbufv->buf[pbufvindex].pos = ~0; /* Dummy */
> +                    pbufv->buf[pbufvindex].flags = 0;
> +                    pbufv->buf[pbufvindex].mem = out_sg[iovindex].iov_base;
> +                    pbufv->buf[pbufvindex].size = out_sg[iovindex].iov_len;
> +                }
> +            } else {
> +                /* Normal (non fast write) path */
> +
> +                /* Copy the rest of the buffer */
> +                fbuf.mem += out_sg->iov_len;
> +                copy_from_iov(&fbuf, out_num - 1, out_sg + 1);
> +                fbuf.mem -= out_sg->iov_len;
> +                fbuf.size = out_len;
>
> -            /* TODO! Endianness of header */
> +                /* TODO! Endianness of header */
>
> -            /* TODO: Add checks for fuse_session_exited */
> -            struct fuse_bufvec bufv = { .buf[0] = fbuf, .count = 1 };
> -            fuse_session_process_buf_int(se,&bufv,&ch);
> +                /* TODO: Add checks for fuse_session_exited */
> +                bufv.buf[0] = fbuf;
> +                bufv.count = 1;
> +                pbufv =&bufv;
> +            }
> +            pbufv->idx = 0;
> +            pbufv->off = 0;
> +            fuse_session_process_buf_int(se, pbufv,&ch);
> +
> +            if (allocated_bufv) {
> +                free(pbufv);
> +            }
>
>               if (!qi->reply_sent) {
>                   fuse_log(FUSE_LOG_DEBUG, "%s: elem %d no reply sent\n",
> @@ -514,6 +580,7 @@ static void *fv_queue_thread(void *opaque)
>               elem = NULL;
>           }
>       }
> +out:
>       pthread_mutex_destroy(&ch.lock);
>       free(fbuf.mem);
>
Hi,

Tested the patch and got the correct data written by guest, so it looks 
fine to me.
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,
Xiao Yang





