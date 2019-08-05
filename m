Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D31C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755F4218B6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755F4218B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXlq-0003Gx-OI
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1huXlT-0002rB-RQ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1huXlS-0003x4-OD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:50:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1huXlS-0003ws-II
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:50:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so83466918wru.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 00:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pc1+6kKvsrAahTFtGOMUgN8Ux7PBC/UQ7I2D1VZGUtI=;
 b=UuRsHiXXZgHmJnsMzYw1/FjDwGksDPYYgEf0KZagi5HFXEjofjW47zM8xdBFm77XCA
 i0x0NZ0OvDUw721sJPYtt3+auWbBrZLjx0O4CezKnUioh30wGq5Ld9J/gTLFYRy7Plcc
 7EWdiMkd75dhq6XZ31MNsRT1AMg6HMenjRevTKn4Vnp6+UR6zzMSQtgs3TEZRRxya3Sr
 9tupTErUR1ttqaM+SeeFnOAK3micBPn89y4neG5Q/arghA8ELZIR7HZ17waa5hxadOWH
 beW5XvqcgMKDidx8I1OHg6iYEGIUrtal8GABqsvZodaOxfQjbMUevDNqvfWAvgjIxfCn
 2NeQ==
X-Gm-Message-State: APjAAAWyYXBtlllZ9KizlmJF/HTKovMni16FbDdKGq7E1JamaPLkevPZ
 aBOtn6F6mLvpHEjlMCnhY6ff2g==
X-Google-Smtp-Source: APXvYqyFs7RzW+Ht7YsYqzIhCqh3lHj8Q20iuGPGf8lqGCGFj89LCjTpRKVlClhd5OIELXYRsuZrwg==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr9302972wrw.345.1564991441419; 
 Mon, 05 Aug 2019 00:50:41 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
 by smtp.gmail.com with ESMTPSA id o26sm177499447wro.53.2019.08.05.00.50.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 00:50:40 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-8-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <686a9e42-5030-a16c-c59e-0bde8bcb0ca7@redhat.com>
Date: Mon, 5 Aug 2019 09:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805071038.32146-8-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/19 09:11, Oleinik, Alexander wrote:
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

A lot of this code can be replaced with GByteArray:
https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html

Since GByteArray is reference counted, you could also easily get rid of
qemu_freopen_ro_ram.  Instead, just close the old QEMUFile and open a
new one.

Paolo

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
> 


