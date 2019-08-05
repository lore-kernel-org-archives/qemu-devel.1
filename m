Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7EFC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F59020679
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F59020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huaWf-0001EM-Ff
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1huaW5-0000oK-Cx
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1huaW4-0003in-7D
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:47:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1huaW3-0003i0-VW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:47:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A8BCFC01DE0D;
 Mon,  5 Aug 2019 10:46:58 +0000 (UTC)
Received: from work-vm (ovpn-117-168.ams2.redhat.com [10.36.117.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCA795C1D4;
 Mon,  5 Aug 2019 10:46:51 +0000 (UTC)
Date: Mon, 5 Aug 2019 11:46:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190805104649.GG13734@work-vm>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-8-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-8-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 05 Aug 2019 10:46:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/17] fuzz: Add ramfile qemu-file
 type
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Oleinik, Alexander (alxndr@bu.edu) wrote:

Actually, we've already got a RAM backed QEMU File setup.
You create a 'qio_channel_buffer' and use qemu_fopen_channel_* on it;
see migration/savevm.c:loadvm_handle_cmd_packaged   where we load into
one of these buffersa(bioc)  and then open it as a QEMUFile (packf)

And see migration/migration.c postcopy_start where we create one
(again the channel buffer is bioc, the file is 'fb')

Dave

> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  migration/qemu-file.c | 84 +++++++++++++++++++++++++++++++++++++++++++
>  migration/qemu-file.h | 11 ++++++
>  2 files changed, 95 insertions(+)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 0431585502..453e2897d5 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -786,3 +786,87 @@ void qemu_file_set_blocking(QEMUFile *f, bool block)
>          f->ops->set_blocking(f->opaque, block);
>      }
>  }
> +
> +#ifdef CONFIG_FUZZ
> +#define INCREMENT 10240
> +static ssize_t ram_writev_buffer(void *opaque, struct iovec *iov, int iovcnt,
> +        int64_t pos)
> +{
> +    ram_disk *rd = (ram_disk *)opaque;
> +    gsize newsize;
> +    ssize_t total_size = 0;
> +    int i;
> +    if (!rd->base) {
> +        rd->base = g_malloc(INCREMENT);
> +        rd->len = INCREMENT;
> +    }
> +    for (i = 0; i < iovcnt; i++) {
> +        if (pos + iov[i].iov_len >= rd->len) {
> +            newsize = ((pos + iov[i].iov_len) / INCREMENT + 1) * INCREMENT;
> +            rd->base = g_realloc(rd->base, newsize);
> +            rd->len = newsize;
> +        }
> +        memcpy(rd->base + pos, iov[i].iov_base, iov[i].iov_len);
> +        pos += iov[i].iov_len;
> +        total_size += iov[i].iov_len;
> +    }
> +    return total_size;
> +}
> +
> +static ssize_t ram_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
> +        size_t size)
> +{
> +    ram_disk *rd = (ram_disk *)opaque;
> +    if (pos + size > rd->len) {
> +        if (rd->len - pos >= 0) {
> +            memcpy(buf, rd->base + pos, rd->len - pos);
> +            size = rd->len - pos;
> +        }
> +    } else {
> +        memcpy(buf, rd->base + pos, size);
> +    }
> +    return size;
> +}
> +
> +static int ram_fclose(void *opaque)
> +{
> +    return 0;
> +}
> +
> +static const QEMUFileOps ram_read_ops = {
> +    .get_buffer = ram_get_buffer,
> +    .close =      ram_fclose
> +};
> +
> +static const QEMUFileOps ram_write_ops = {
> +    .writev_buffer = ram_writev_buffer,
> +    .close =      ram_fclose
> +};
> +
> +QEMUFile *qemu_fopen_ram(ram_disk **return_rd)
> +{
> +    ram_disk *rd = g_new0(ram_disk, 1);
> +    *return_rd = rd;
> +    return qemu_fopen_ops(rd, &ram_write_ops);
> +}
> +
> +QEMUFile *qemu_fopen_ro_ram(ram_disk* rd)
> +{
> +    return qemu_fopen_ops(rd, &ram_read_ops);
> +}
> +
> +void qemu_freopen_ro_ram(QEMUFile *f)
> +{
> +    void *rd = f->opaque;
> +    f->bytes_xfer = 0;
> +    f->xfer_limit = 0;
> +    f->last_error = 0;
> +    f->iovcnt = 0;
> +    f->buf_index = 0;
> +    f->buf_size = 0;
> +    f->pos = 0;
> +    f->ops = &ram_read_ops;
> +    f->opaque = rd;
> +    return;
> +}
> +#endif
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 13baf896bd..7048674f1b 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -177,4 +177,15 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>  
>  void qemu_put_counted_string(QEMUFile *f, const char *name);
>  
> +#ifdef CONFIG_FUZZ
> +typedef struct ram_disk {
> +    void *base;
> +    gsize len;
> +} ram_disk;
> +
> +QEMUFile *qemu_fopen_ram(ram_disk **rd);
> +QEMUFile *qemu_fopen_ro_ram(ram_disk* rd);
> +void qemu_freopen_ro_ram(QEMUFile *f);
> +#endif
> +
>  #endif
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

