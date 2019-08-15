Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F3C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092AD2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092AD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyLvk-0003qN-1S
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 16:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1hyLv2-0003Oa-SD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1hyLuz-000889-JF
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>)
 id 1hyLur-00085a-Md; Thu, 15 Aug 2019 16:00:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA389300413D;
 Thu, 15 Aug 2019 20:00:08 +0000 (UTC)
Received: from localhost (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41D5B1000343;
 Thu, 15 Aug 2019 20:00:08 +0000 (UTC)
Date: Thu, 15 Aug 2019 21:00:07 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190815200007.GJ3888@redhat.com>
References: <20190815185024.7010-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815185024.7010-1-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 20:00:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd: Advertise multi-conn for shared
 read-only connections
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 01:50:24PM -0500, Eric Blake wrote:
> The NBD specification defines NBD_FLAG_CAN_MULTI_CONN, which can be
> advertised when the server promises cache consistency between
> simultaneous clients (basically, rules that determine what FUA and
> flush from one client are able to guarantee for reads from another
> client).  When we don't permit simultaneous clients (such as qemu-nbd
> without -e), the bit makes no sense; and for writable images, we
> probably have a lot more work before we can declare that actions from
> one client are cache-consistent with actions from another.  But for
> read-only images, where flush isn't changing any data, we might as
> well advertise multi-conn support.  What's more, advertisement of the
> bit makes it easier for clients to determine if 'qemu-nbd -e' was in
> use, where a second connection will succeed rather than hang until the
> first client goes away.
> 
> This patch affects qemu as server in advertising the bit.  We may want
> to consider patches to qemu as client to attempt parallel connections
> for higher throughput by spreading the load over those connections
> when a server advertises multi-conn, but for now sticking to one
> connection per nbd:// BDS is okay.
> 
> See also: https://bugzilla.redhat.com/1708300
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/interop/nbd.txt | 1 +
>  include/block/nbd.h  | 2 +-
>  blockdev-nbd.c       | 2 +-
>  nbd/server.c         | 4 +++-
>  qemu-nbd.c           | 2 +-
>  5 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
> index fc64473e02b2..6dfec7f47647 100644
> --- a/docs/interop/nbd.txt
> +++ b/docs/interop/nbd.txt
> @@ -53,3 +53,4 @@ the operation of that feature.
>  * 2.12: NBD_CMD_BLOCK_STATUS for "base:allocation"
>  * 3.0: NBD_OPT_STARTTLS with TLS Pre-Shared Keys (PSK),
>  NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
> +* 4.2: NBD_FLAG_CAN_MULTI_CONN for sharable read-only exports
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 7b36d672f046..991fd52a5134 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -326,7 +326,7 @@ typedef struct NBDClient NBDClient;
> 
>  NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>                            uint64_t size, const char *name, const char *desc,
> -                          const char *bitmap, uint16_t nbdflags,
> +                          const char *bitmap, uint16_t nbdflags, bool shared,
>                            void (*close)(NBDExport *), bool writethrough,
>                            BlockBackend *on_eject_blk, Error **errp);
>  void nbd_export_close(NBDExport *exp);
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 66eebab31875..e5d228771292 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -189,7 +189,7 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>      }
> 
>      exp = nbd_export_new(bs, 0, len, name, NULL, bitmap,
> -                         writable ? 0 : NBD_FLAG_READ_ONLY,
> +                         writable ? 0 : NBD_FLAG_READ_ONLY, true,
>                           NULL, false, on_eject_blk, errp);
>      if (!exp) {
>          return;
> diff --git a/nbd/server.c b/nbd/server.c
> index a2cf085f7635..a602d85070ff 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1460,7 +1460,7 @@ static void nbd_eject_notifier(Notifier *n, void *data)
> 
>  NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>                            uint64_t size, const char *name, const char *desc,
> -                          const char *bitmap, uint16_t nbdflags,
> +                          const char *bitmap, uint16_t nbdflags, bool shared,
>                            void (*close)(NBDExport *), bool writethrough,
>                            BlockBackend *on_eject_blk, Error **errp)
>  {
> @@ -1486,6 +1486,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>      perm = BLK_PERM_CONSISTENT_READ;
>      if ((nbdflags & NBD_FLAG_READ_ONLY) == 0) {
>          perm |= BLK_PERM_WRITE;
> +    } else if (shared) {
> +        nbdflags |= NBD_FLAG_CAN_MULTI_CONN;
>      }
>      blk = blk_new(bdrv_get_aio_context(bs), perm,
>                    BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 049645491dab..55f5ceaf5c92 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -1173,7 +1173,7 @@ int main(int argc, char **argv)
>      }
> 
>      export = nbd_export_new(bs, dev_offset, fd_size, export_name,
> -                            export_description, bitmap, nbdflags,
> +                            export_description, bitmap, nbdflags, shared > 1,
>                              nbd_export_closed, writethrough, NULL,
>                              &error_fatal);
> 

Multi-conn is a no-brainer.  For nbdkit it more than doubled
throughput:

https://github.com/libguestfs/nbdkit/commit/910a220aa454b410c44731e8d965e92244b536f5

Those results are for loopback mounts of a file located on /dev/shm
and served by nbdkit file plugin, and I would imagine that without the
loop mounting / filesystem overhead the results could be even better.

For read-only connections where the server can handle more than one
connection (-e) it ought to be safe.  You have to tell the client how
many connections the server may accept, but that's a limitation of the
current protocol.

So yes ACK, patch makes sense.

Worth noting that fio has NBD support so you can test NBD servers
directly these days:

https://github.com/axboe/fio/commit/d643a1e29d31bf974a613866819dde241c928b6d
https://github.com/axboe/fio/blob/master/examples/nbd.fio#L5

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/

