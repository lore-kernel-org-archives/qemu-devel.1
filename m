Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A57ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06249215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06249215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPkL-0008No-Rk
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFP3L-0005sC-P9
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFP3K-0006aI-3Q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:47:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iFP39-0006Rj-G4; Tue, 01 Oct 2019 16:47:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5BB2310CC1E6;
 Tue,  1 Oct 2019 20:47:10 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7197E1001956;
 Tue,  1 Oct 2019 20:47:04 +0000 (UTC)
Subject: Re: [PATCH 4/6] qemu-nbd: add compression flag support
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1569958040-697220-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4afd7d6c-7e38-c325-b009-c798186715bd@redhat.com>
Date: Tue, 1 Oct 2019 15:47:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569958040-697220-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 01 Oct 2019 20:47:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 2:27 PM, Andrey Shinkevich wrote:
> Added possibility to write compressed data by using the
> blk_write_compressed. This action has the limitations of the format
> driver. For example we can't write compressed data over other.
> 

> +++ b/blockdev-nbd.c
> @@ -191,7 +191,7 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>       }
>   
>       exp = nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !writable,
> -                         NULL, false, on_eject_blk, errp);
> +                         0, NULL, false, on_eject_blk, errp);

This is a lot of parameters.  Should we be combining some of them into a 
struct, or even at least the booleans into a flags parameter?


> +++ b/include/block/nbd.h
> @@ -25,6 +25,10 @@
>   #include "crypto/tlscreds.h"
>   #include "qapi/error.h"
>   
> +enum {
> +  NBD_INTERNAL_FLAG_COMPRESS = 1 << 1, /* Use write compressed */
> +};

What happened to flag 1 << 0?  What other flags do you anticipate adding?


> +++ b/nbd/server.c
> @@ -91,6 +91,7 @@ struct NBDExport {
>       uint16_t nbdflags;
>       QTAILQ_HEAD(, NBDClient) clients;
>       QTAILQ_ENTRY(NBDExport) next;
> +    uint32_t iflags;
>   
>       AioContext *ctx;
>   
> @@ -1471,7 +1472,8 @@ static void nbd_eject_notifier(Notifier *n, void *data)
>   
>   NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>                             uint64_t size, const char *name, const char *desc,
> -                          const char *bitmap, bool readonly, bool shared,
> +                          const char *bitmap, bool readonly,
> +                          bool shared, uint32_t iflags,
>                             void (*close)(NBDExport *), bool writethrough,
>                             BlockBackend *on_eject_blk, Error **errp)

Again, this feels like a lot of parameters, combining more through 
iflags may make sense.

>   {
> @@ -1525,6 +1527,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>           exp->nbdflags |= (NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZEROES |
>                             NBD_FLAG_SEND_FAST_ZERO);
>       }
> +    exp->iflags = iflags;
>       assert(size <= INT64_MAX - dev_offset);
>       exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
>   
> @@ -2312,6 +2315,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>           if (request->flags & NBD_CMD_FLAG_FUA) {
>               flags |= BDRV_REQ_FUA;
>           }
> +        if (exp->iflags & NBD_INTERNAL_FLAG_COMPRESS) {
> +            flags |= BDRV_REQ_WRITE_COMPRESSED;
> +        }

This unconditionally tries to make all writes compressed if the option 
was selected when starting qemu-nbd.  Should we at least sanity check 
that it will work during nbd_export_new, rather than waiting to find out 
on the first (failed) write, whether it actually works?

/me looks ahead [1]

>           ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
>                            data, request->len, flags);
>           return nbd_send_generic_reply(client, request->handle, ret,
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 9032b6d..3765c4b 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -139,6 +139,7 @@ static void usage(const char *name)
>   "      --discard=MODE        set discard mode (ignore, unmap)\n"
>   "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
>   "      --image-opts          treat FILE as a full set of image options\n"
> +"  -C, --compress            use data compression (if the target format supports it)\n"

I'm not necessarily opposed to burning a short option.  But it's a shame 
that we can't use -c to be similar to 'qemu-img convert -c'.  Requiring 
the use of a long option is also okay (short options have to be for the 
more likely uses, although it does seem like this use case might qualify).

> @@ -610,7 +612,7 @@ int main(int argc, char **argv)
>       int64_t fd_size;
>       QemuOpts *sn_opts = NULL;
>       const char *sn_id_or_name = NULL;
> -    const char *sopt = "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:B:L";
> +    const char *sopt = "hVb:o:p:CrsnP:c:dvk:e:f:tl:x:T:D:B:L";

Pre-existing, but we don't sort this very well.

>       struct option lopt[] = {
>           { "help", no_argument, NULL, 'h' },
>           { "version", no_argument, NULL, 'V' },
> @@ -619,6 +621,7 @@ int main(int argc, char **argv)
>           { "socket", required_argument, NULL, 'k' },
>           { "offset", required_argument, NULL, 'o' },
>           { "read-only", no_argument, NULL, 'r' },
> +        { "compress", no_argument, NULL, 'C'},
>           { "partition", required_argument, NULL, 'P' },

Above you put 'C' between 'p' and 'r', but here between 'r' and 'P'.  We 
really don't sort very well :)

>           { "bitmap", required_argument, NULL, 'B' },
>           { "connect", required_argument, NULL, 'c' },
> @@ -786,6 +789,9 @@ int main(int argc, char **argv)
>               readonly = true;
>               flags &= ~BDRV_O_RDWR;
>               break;
> +        case 'C':
> +            iflags |= NBD_INTERNAL_FLAG_COMPRESS;
> +            break;
>           case 'P':

At least this matches your lopt[] ordering.

>               warn_report("The '-P' option is deprecated; use --image-opts with "
>                           "a raw device wrapper for subset exports instead");
> @@ -1117,6 +1123,14 @@ int main(int argc, char **argv)
>   
>       blk_set_enable_write_cache(blk, !writethrough);
>   
> +    if ((iflags & NBD_INTERNAL_FLAG_COMPRESS) &&
> +        !(bs->drv && bs->drv->bdrv_co_pwritev_compressed_part))
> +    {
> +        error_report("Compression not supported for this file format %s",
> +                     argv[optind]);
> +        exit(EXIT_FAILURE);
> +    }
> +

[1] ah, you DO make sure that compression is supported before passing 
the option through.

The idea seems reasonable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

