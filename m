Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5793CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1655820657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOis1mTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1655820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7iok-0006hb-An
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k7inj-0005gL-JQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k7ing-0004R1-Eq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597684799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WRpM1QfB5AbcYwpk/wYWeDfEaghf2AKp1bvKj99KPXM=;
 b=SOis1mTkB3v8olPaU4dbPB8Tw3bpqwkSAIpgTw7Y49B8959Igza++yoa0XYg6tr0UDmTut
 NXzmHtetgY/A/iy8YpWnRVHvdO+EdUwoIdWaqhkn4Y7SFJ0xiTGHl69nhlUsXGOydICRkp
 BKRu3NG4nXnHBhR5HV8vmN+cSRXa0Qc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-27dXJP_fMJmaLEoHIkvT5g-1; Mon, 17 Aug 2020 13:19:56 -0400
X-MC-Unique: 27dXJP_fMJmaLEoHIkvT5g-1
Received: by mail-oi1-f197.google.com with SMTP id t83so6400513oih.18
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 10:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WRpM1QfB5AbcYwpk/wYWeDfEaghf2AKp1bvKj99KPXM=;
 b=OwVM3Q+2V1laWZVrmdTJwY2FPa4r88E7m9sIhcA6jGCxlNnU/6q9jm8c9X2OCog97G
 iWqu2d9rAkbE/UtzsiPzv95OI66ei4VnPX53uybOXwZis1r23Nwcs0WZwFI1yhsBpIXq
 RZm46zMn72Kn49XSbwAzG6svjhYOihYwvSdbyytlDRuHwaim51xxw7G3YJ4AzopftfnS
 iRplDWBoFFk9rHd+7GPhBtCvzkPb2wcipxGLy4d1ehsCc3LlZMg+7XaTA+yLYbfbnyXZ
 HuHUdzxrcgrZ5jFiMzFcCGmLh0tN8TO2aQfDp7ZTaHdOL0xhCItmGpALizcpOcfeBsNE
 bINA==
X-Gm-Message-State: AOAM533Gv53F2YTrgpech7/o8bS/zVbaqtcrGIDJ3nwg3Vbel3Sl+f/c
 b6TXIkp4CV9rQC6QdIa2Y4nPsC0TlHpFSgZ02v42DKopFsc2eCpL5V4DXoAR2DNqW3CwMySw5Rq
 0dLZ6zGKa+duL0lwkh5vyNNk003wA7FQ=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr10666977oif.56.1597684793235; 
 Mon, 17 Aug 2020 10:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZSXIlryc+VWXfOOzLph7hpsSPm6/InNTVWOUMqrrQkVs/1F+rAqC1yrlI53rIiOIz27fQb6ISPKdmMt7X+Rk=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr10666960oif.56.1597684792967; 
 Mon, 17 Aug 2020 10:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-7-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-7-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 17 Aug 2020 20:19:36 +0300
Message-ID: <CAMRbyyu8=uFJkqCuC5BBamzHOwfXaw-rWVa+KT4gQc3bE=WKfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/22] qemu-nbd: Use raw block driver for --offset
To: Kevin Wolf <kwolf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000008c72e505ad15faf0"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c72e505ad15faf0
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 13, 2020 at 7:36 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Instead of implementing qemu-nbd --offset in the NBD code, just put a
> raw block node with the requested offset on top of the user image and
> rely on that doing the job.
>
> This does not only simplify the nbd_export_new() interface and bring it
> closer to the set of options that the nbd-server-add QMP command offers,
> but in fact it also eliminates a potential source for bugs in the NBD
> code which previously had to add the offset manually in all relevant
> places.
>

Just to make sure I understand this correctly -

qemu-nbd can work with:

    $ qemu-nbd 'json:{"driver": "file", "filename": "test.raw"}'

And:

    $ qemu-nbd 'json:{"driver": "raw", "file": {"driver": "file",
"filename": "test.raw"}}'

I assumed that we always create the raw node?

oVirt always uses the second form to make it easier to support offset,
size, and backing.
https://github.com/oVirt/ovirt-imageio/blob/2021164d064227d7c5e03c8da087adc66e3a577e/daemon/ovirt_imageio/_internal/qemu_nbd.py#L104

This also seems to be the way libvirt builds the nodes using -blockdev.

Do we have a way to visualize the internal node graph used by
qemu-nbd/qemu-img?

Nir

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/nbd.h |  4 ++--
>  blockdev-nbd.c      |  9 +--------
>  nbd/server.c        | 34 +++++++++++++++++-----------------
>  qemu-nbd.c          | 27 ++++++++++++---------------
>  4 files changed, 32 insertions(+), 42 deletions(-)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index c8c5cb6b61..3846d2bac8 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -329,8 +329,8 @@ typedef struct NBDExport NBDExport;
>  typedef struct NBDClient NBDClient;
>
>  BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error
> **errp);
> -NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
> -                          uint64_t size, const char *name, const char
> *desc,
> +NBDExport *nbd_export_new(BlockDriverState *bs,
> +                          const char *name, const char *desc,
>                            const char *bitmap, bool readonly, bool shared,
>                            void (*close)(NBDExport *), bool writethrough,
>                            BlockBackend *on_eject_blk, Error **errp);
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index a1dc11bdd7..16cda3b052 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -154,7 +154,6 @@ BlockExport *nbd_export_create(BlockExportOptions
> *exp_args, Error **errp)
>      BlockDriverState *bs = NULL;
>      BlockBackend *on_eject_blk;
>      NBDExport *exp = NULL;
> -    int64_t len;
>      AioContext *aio_context;
>
>      assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
> @@ -192,12 +191,6 @@ BlockExport *nbd_export_create(BlockExportOptions
> *exp_args, Error **errp)
>
>      aio_context = bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);
> -    len = bdrv_getlength(bs);
> -    if (len < 0) {
> -        error_setg_errno(errp, -len,
> -                         "Failed to determine the NBD export's length");
> -        goto out;
> -    }
>
>      if (!arg->has_writable) {
>          arg->writable = false;
> @@ -206,7 +199,7 @@ BlockExport *nbd_export_create(BlockExportOptions
> *exp_args, Error **errp)
>          arg->writable = false;
>      }
>
> -    exp = nbd_export_new(bs, 0, len, arg->name, arg->description,
> arg->bitmap,
> +    exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
>                           !arg->writable, !arg->writable,
>                           NULL, false, on_eject_blk, errp);
>      if (!exp) {
> diff --git a/nbd/server.c b/nbd/server.c
> index 774325dbe5..92360d1f08 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -89,7 +89,6 @@ struct NBDExport {
>      BlockBackend *blk;
>      char *name;
>      char *description;
> -    uint64_t dev_offset;
>      uint64_t size;
>      uint16_t nbdflags;
>      QTAILQ_HEAD(, NBDClient) clients;
> @@ -1507,8 +1506,8 @@ static void nbd_eject_notifier(Notifier *n, void
> *data)
>      aio_context_release(aio_context);
>  }
>
> -NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
> -                          uint64_t size, const char *name, const char
> *desc,
> +NBDExport *nbd_export_new(BlockDriverState *bs,
> +                          const char *name, const char *desc,
>                            const char *bitmap, bool readonly, bool shared,
>                            void (*close)(NBDExport *), bool writethrough,
>                            BlockBackend *on_eject_blk, Error **errp)
> @@ -1516,9 +1515,17 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
> uint64_t dev_offset,
>      AioContext *ctx;
>      BlockBackend *blk;
>      NBDExport *exp;
> +    int64_t size;
>      uint64_t perm;
>      int ret;
>
> +    size = bdrv_getlength(bs);
> +    if (size < 0) {
> +        error_setg_errno(errp, -size,
> +                         "Failed to determine the NBD export's length");
> +        return NULL;
> +    }
> +
>      exp = g_new0(NBDExport, 1);
>      exp->common = (BlockExport) {
>          .drv = &blk_exp_nbd,
> @@ -1553,8 +1560,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
> uint64_t dev_offset,
>      exp->refcount = 1;
>      QTAILQ_INIT(&exp->clients);
>      exp->blk = blk;
> -    assert(dev_offset <= INT64_MAX);
> -    exp->dev_offset = dev_offset;
>      exp->name = g_strdup(name);
>      assert(!desc || strlen(desc) <= NBD_MAX_STRING_SIZE);
>      exp->description = g_strdup(desc);
> @@ -1569,7 +1574,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
> uint64_t dev_offset,
>          exp->nbdflags |= (NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZEROES
> |
>                            NBD_FLAG_SEND_FAST_ZERO);
>      }
> -    assert(size <= INT64_MAX - dev_offset);
> +    assert(size <= INT64_MAX);
>      exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
>
>      if (bitmap) {
> @@ -1928,8 +1933,7 @@ static int coroutine_fn
> nbd_co_send_sparse_read(NBDClient *client,
>              stl_be_p(&chunk.length, pnum);
>              ret = nbd_co_send_iov(client, iov, 1, errp);
>          } else {
> -            ret = blk_pread(exp->blk, offset + progress + exp->dev_offset,
> -                            data + progress, pnum);
> +            ret = blk_pread(exp->blk, offset + progress, data + progress,
> pnum);
>              if (ret < 0) {
>                  error_setg_errno(errp, -ret, "reading from file failed");
>                  break;
> @@ -2303,8 +2307,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient
> *client, NBDRequest *request,
>                                         data, request->len, errp);
>      }
>
> -    ret = blk_pread(exp->blk, request->from + exp->dev_offset, data,
> -                    request->len);
> +    ret = blk_pread(exp->blk, request->from, data, request->len);
>      if (ret < 0) {
>          return nbd_send_generic_reply(client, request->handle, ret,
>                                        "reading from file failed", errp);
> @@ -2339,7 +2342,7 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient
> *client, NBDRequest *request,
>
>      assert(request->type == NBD_CMD_CACHE);
>
> -    ret = blk_co_preadv(exp->blk, request->from + exp->dev_offset,
> request->len,
> +    ret = blk_co_preadv(exp->blk, request->from, request->len,
>                          NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
>
>      return nbd_send_generic_reply(client, request->handle, ret,
> @@ -2370,8 +2373,7 @@ static coroutine_fn int nbd_handle_request(NBDClient
> *client,
>          if (request->flags & NBD_CMD_FLAG_FUA) {
>              flags |= BDRV_REQ_FUA;
>          }
> -        ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
> -                         data, request->len, flags);
> +        ret = blk_pwrite(exp->blk, request->from, data, request->len,
> flags);
>          return nbd_send_generic_reply(client, request->handle, ret,
>                                        "writing to file failed", errp);
>
> @@ -2386,8 +2388,7 @@ static coroutine_fn int nbd_handle_request(NBDClient
> *client,
>          if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
>              flags |= BDRV_REQ_NO_FALLBACK;
>          }
> -        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
> -                                request->len, flags);
> +        ret = blk_pwrite_zeroes(exp->blk, request->from, request->len,
> flags);
>          return nbd_send_generic_reply(client, request->handle, ret,
>                                        "writing to file failed", errp);
>
> @@ -2401,8 +2402,7 @@ static coroutine_fn int nbd_handle_request(NBDClient
> *client,
>                                        "flush failed", errp);
>
>      case NBD_CMD_TRIM:
> -        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
> -                              request->len);
> +        ret = blk_co_pdiscard(exp->blk, request->from, request->len);
>          if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {
>              ret = blk_co_flush(exp->blk);
>          }
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index d2657b8db5..818c3f5d46 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -523,7 +523,6 @@ int main(int argc, char **argv)
>      const char *port = NULL;
>      char *sockpath = NULL;
>      char *device = NULL;
> -    int64_t fd_size;
>      QemuOpts *sn_opts = NULL;
>      const char *sn_id_or_name = NULL;
>      const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:B:L";
> @@ -1028,6 +1027,17 @@ int main(int argc, char **argv)
>      }
>      bs = blk_bs(blk);
>
> +    if (dev_offset) {
> +        QDict *raw_opts = qdict_new();
> +        qdict_put_str(raw_opts, "driver", "raw");
> +        qdict_put_str(raw_opts, "file", bs->node_name);
> +        qdict_put_int(raw_opts, "offset", dev_offset);
> +        bs = bdrv_open(NULL, NULL, raw_opts, flags, &error_fatal);
> +        blk_remove_bs(blk);
> +        blk_insert_bs(blk, bs, &error_fatal);
> +        bdrv_unref(bs);
> +    }
> +
>      blk_set_enable_write_cache(blk, !writethrough);
>
>      if (sn_opts) {
> @@ -1045,21 +1055,8 @@ int main(int argc, char **argv)
>      }
>
>      bs->detect_zeroes = detect_zeroes;
> -    fd_size = blk_getlength(blk);
> -    if (fd_size < 0) {
> -        error_report("Failed to determine the image length: %s",
> -                     strerror(-fd_size));
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    if (dev_offset >= fd_size) {
> -        error_report("Offset (%" PRIu64 ") has to be smaller than the
> image "
> -                     "size (%" PRId64 ")", dev_offset, fd_size);
> -        exit(EXIT_FAILURE);
> -    }
> -    fd_size -= dev_offset;
>
> -    export = nbd_export_new(bs, dev_offset, fd_size, export_name,
> +    export = nbd_export_new(bs, export_name,
>                              export_description, bitmap, readonly, shared
> > 1,
>                              nbd_export_closed, writethrough, NULL,
>                              &error_fatal);
> --
> 2.25.4
>
>
>

--0000000000008c72e505ad15faf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Aug 13, 2020 at 7:36 PM Kevin Wol=
f &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrote:<b=
r></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Instead of implementing qemu-nbd --offset in the NBD code, just =
put a<br>
raw block node with the requested offset on top of the user image and<br>
rely on that doing the job.<br>
<br>
This does not only simplify the nbd_export_new() interface and bring it<br>
closer to the set of options that the nbd-server-add QMP command offers,<br=
>
but in fact it also eliminates a potential source for bugs in the NBD<br>
code which previously had to add the offset manually in all relevant<br>
places.<br></blockquote><div><br></div><div>Just to make sure I understand =
this correctly -=C2=A0</div><div><br></div><div>qemu-nbd can work with:</di=
v><div><br></div><div><div>=C2=A0 =C2=A0 $ qemu-nbd &#39;json:{&quot;driver=
&quot;: &quot;file&quot;, &quot;filename&quot;: &quot;test.raw&quot;}&#39;<=
/div></div><div><br></div><div>And:</div><div><br></div><div>=C2=A0 =C2=A0 =
$ qemu-nbd &#39;json:{&quot;driver&quot;: &quot;raw&quot;, &quot;file&quot;=
: {&quot;driver&quot;: &quot;file&quot;, &quot;filename&quot;: &quot;test.r=
aw&quot;}}&#39;<br></div><div><br></div><div>I assumed that we always creat=
e the raw node?</div><div><br></div><div>oVirt always uses the second form =
to make it easier=C2=A0to support offset,=C2=A0 size, and backing.</div><di=
v><a href=3D"https://github.com/oVirt/ovirt-imageio/blob/2021164d064227d7c5=
e03c8da087adc66e3a577e/daemon/ovirt_imageio/_internal/qemu_nbd.py#L104">htt=
ps://github.com/oVirt/ovirt-imageio/blob/2021164d064227d7c5e03c8da087adc66e=
3a577e/daemon/ovirt_imageio/_internal/qemu_nbd.py#L104</a><br></div><div><b=
r></div><div>This also seems to be the way libvirt builds the nodes using -=
blockdev.</div><div><br></div><div>Do we have a way to visualize the intern=
al node graph used by qemu-nbd/qemu-img?</div><div><br></div><div>Nir</div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D=
"_blank">kwolf@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/block/nbd.h |=C2=A0 4 ++--<br>
=C2=A0blockdev-nbd.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +--------<br>
=C2=A0nbd/server.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 34 +++++++++++++++++-------=
----------<br>
=C2=A0qemu-nbd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 27 ++++++++++++-------=
--------<br>
=C2=A04 files changed, 32 insertions(+), 42 deletions(-)<br>
<br>
diff --git a/include/block/nbd.h b/include/block/nbd.h<br>
index c8c5cb6b61..3846d2bac8 100644<br>
--- a/include/block/nbd.h<br>
+++ b/include/block/nbd.h<br>
@@ -329,8 +329,8 @@ typedef struct NBDExport NBDExport;<br>
=C2=A0typedef struct NBDClient NBDClient;<br>
<br>
=C2=A0BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **=
errp);<br>
-NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint64_t size, const char *name, const char *desc,<br>
+NBDExport *nbd_export_new(BlockDriverState *bs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *name, const char *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const char *bitmap, bool readonly, bool shared,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0void (*close)(NBDExport *), bool writethrough,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0BlockBackend *on_eject_blk, Error **errp);<br>
diff --git a/blockdev-nbd.c b/blockdev-nbd.c<br>
index a1dc11bdd7..16cda3b052 100644<br>
--- a/blockdev-nbd.c<br>
+++ b/blockdev-nbd.c<br>
@@ -154,7 +154,6 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_=
args, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0BlockDriverState *bs =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0BlockBackend *on_eject_blk;<br>
=C2=A0 =C2=A0 =C2=A0NBDExport *exp =3D NULL;<br>
-=C2=A0 =C2=A0 int64_t len;<br>
=C2=A0 =C2=A0 =C2=A0AioContext *aio_context;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(exp_args-&gt;type =3D=3D BLOCK_EXPORT_TYPE_NBD);=
<br>
@@ -192,12 +191,6 @@ BlockExport *nbd_export_create(BlockExportOptions *exp=
_args, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0aio_context =3D bdrv_get_aio_context(bs);<br>
=C2=A0 =C2=A0 =C2=A0aio_context_acquire(aio_context);<br>
-=C2=A0 =C2=A0 len =3D bdrv_getlength(bs);<br>
-=C2=A0 =C2=A0 if (len &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -len,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to determine the NBD export&#39;s length&quot=
;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!arg-&gt;has_writable) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg-&gt;writable =3D false;<br>
@@ -206,7 +199,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_=
args, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg-&gt;writable =3D false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 exp =3D nbd_export_new(bs, 0, len, arg-&gt;name, arg-&gt;des=
cription, arg-&gt;bitmap,<br>
+=C2=A0 =C2=A0 exp =3D nbd_export_new(bs, arg-&gt;name, arg-&gt;description=
, arg-&gt;bitmap,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 !arg-&gt;writable, !arg-&gt;writable,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL, false, on_eject_blk, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (!exp) {<br>
diff --git a/nbd/server.c b/nbd/server.c<br>
index 774325dbe5..92360d1f08 100644<br>
--- a/nbd/server.c<br>
+++ b/nbd/server.c<br>
@@ -89,7 +89,6 @@ struct NBDExport {<br>
=C2=A0 =C2=A0 =C2=A0BlockBackend *blk;<br>
=C2=A0 =C2=A0 =C2=A0char *name;<br>
=C2=A0 =C2=A0 =C2=A0char *description;<br>
-=C2=A0 =C2=A0 uint64_t dev_offset;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t size;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t nbdflags;<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_HEAD(, NBDClient) clients;<br>
@@ -1507,8 +1506,8 @@ static void nbd_eject_notifier(Notifier *n, void *dat=
a)<br>
=C2=A0 =C2=A0 =C2=A0aio_context_release(aio_context);<br>
=C2=A0}<br>
<br>
-NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint64_t size, const char *name, const char *desc,<br>
+NBDExport *nbd_export_new(BlockDriverState *bs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *name, const char *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const char *bitmap, bool readonly, bool shared,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0void (*close)(NBDExport *), bool writethrough,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0BlockBackend *on_eject_blk, Error **errp)<br>
@@ -1516,9 +1515,17 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint=
64_t dev_offset,<br>
=C2=A0 =C2=A0 =C2=A0AioContext *ctx;<br>
=C2=A0 =C2=A0 =C2=A0BlockBackend *blk;<br>
=C2=A0 =C2=A0 =C2=A0NBDExport *exp;<br>
+=C2=A0 =C2=A0 int64_t size;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t perm;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
+=C2=A0 =C2=A0 size =3D bdrv_getlength(bs);<br>
+=C2=A0 =C2=A0 if (size &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to determine the NBD export&#39;s length&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0exp =3D g_new0(NBDExport, 1);<br>
=C2=A0 =C2=A0 =C2=A0exp-&gt;common =3D (BlockExport) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.drv =3D &amp;blk_exp_nbd,<br>
@@ -1553,8 +1560,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint6=
4_t dev_offset,<br>
=C2=A0 =C2=A0 =C2=A0exp-&gt;refcount =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;exp-&gt;clients);<br>
=C2=A0 =C2=A0 =C2=A0exp-&gt;blk =3D blk;<br>
-=C2=A0 =C2=A0 assert(dev_offset &lt;=3D INT64_MAX);<br>
-=C2=A0 =C2=A0 exp-&gt;dev_offset =3D dev_offset;<br>
=C2=A0 =C2=A0 =C2=A0exp-&gt;name =3D g_strdup(name);<br>
=C2=A0 =C2=A0 =C2=A0assert(!desc || strlen(desc) &lt;=3D NBD_MAX_STRING_SIZ=
E);<br>
=C2=A0 =C2=A0 =C2=A0exp-&gt;description =3D g_strdup(desc);<br>
@@ -1569,7 +1574,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint6=
4_t dev_offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exp-&gt;nbdflags |=3D (NBD_FLAG_SEND_TRIM=
 | NBD_FLAG_SEND_WRITE_ZEROES |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NBD_FLAG_SEND_FAST_ZERO);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 assert(size &lt;=3D INT64_MAX - dev_offset);<br>
+=C2=A0 =C2=A0 assert(size &lt;=3D INT64_MAX);<br>
=C2=A0 =C2=A0 =C2=A0exp-&gt;size =3D QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (bitmap) {<br>
@@ -1928,8 +1933,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDCl=
ient *client,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stl_be_p(&amp;chunk.length,=
 pnum);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D nbd_co_send_iov(cli=
ent, iov, 1, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_pread(exp-&gt;blk, o=
ffset + progress + exp-&gt;dev_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 data + progress, pnum);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_pread(exp-&gt;blk, o=
ffset + progress, data + progress, pnum);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_er=
rno(errp, -ret, &quot;reading from file failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -2303,8 +2307,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *cl=
ient, NBDRequest *request,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data, re=
quest-&gt;len, errp);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D blk_pread(exp-&gt;blk, request-&gt;from + exp-&gt;de=
v_offset, data,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 requ=
est-&gt;len);<br>
+=C2=A0 =C2=A0 ret =3D blk_pread(exp-&gt;blk, request-&gt;from, data, reque=
st-&gt;len);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nbd_send_generic_reply(client, req=
uest-&gt;handle, ret,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rea=
ding from file failed&quot;, errp);<br>
@@ -2339,7 +2342,7 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *c=
lient, NBDRequest *request,<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(request-&gt;type =3D=3D NBD_CMD_CACHE);<br>
<br>
-=C2=A0 =C2=A0 ret =3D blk_co_preadv(exp-&gt;blk, request-&gt;from + exp-&g=
t;dev_offset, request-&gt;len,<br>
+=C2=A0 =C2=A0 ret =3D blk_co_preadv(exp-&gt;blk, request-&gt;from, request=
-&gt;len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return nbd_send_generic_reply(client, request-&gt;handl=
e, ret,<br>
@@ -2370,8 +2373,7 @@ static coroutine_fn int nbd_handle_request(NBDClient =
*client,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (request-&gt;flags &amp; NBD_CMD_FLAG_=
FUA) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D BDRV_REQ_FUA;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_pwrite(exp-&gt;blk, request-&gt;fr=
om + exp-&gt;dev_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data, request-&gt;len, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_pwrite(exp-&gt;blk, request-&gt;fr=
om, data, request-&gt;len, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nbd_send_generic_reply(client, req=
uest-&gt;handle, ret,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;wri=
ting to file failed&quot;, errp);<br>
<br>
@@ -2386,8 +2388,7 @@ static coroutine_fn int nbd_handle_request(NBDClient =
*client,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (request-&gt;flags &amp; NBD_CMD_FLAG_=
FAST_ZERO) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D BDRV_REQ_NO_FALL=
BACK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_pwrite_zeroes(exp-&gt;blk, request=
-&gt;from + exp-&gt;dev_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request-&gt;len, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_pwrite_zeroes(exp-&gt;blk, request=
-&gt;from, request-&gt;len, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nbd_send_generic_reply(client, req=
uest-&gt;handle, ret,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;wri=
ting to file failed&quot;, errp);<br>
<br>
@@ -2401,8 +2402,7 @@ static coroutine_fn int nbd_handle_request(NBDClient =
*client,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;flu=
sh failed&quot;, errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0case NBD_CMD_TRIM:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_co_pdiscard(exp-&gt;blk, request-&=
gt;from + exp-&gt;dev_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request-&gt;len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_co_pdiscard(exp-&gt;blk, request-&=
gt;from, request-&gt;len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0 &amp;&amp; request-&gt;f=
lags &amp; NBD_CMD_FLAG_FUA) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_co_flush(exp-&g=
t;blk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/qemu-nbd.c b/qemu-nbd.c<br>
index d2657b8db5..818c3f5d46 100644<br>
--- a/qemu-nbd.c<br>
+++ b/qemu-nbd.c<br>
@@ -523,7 +523,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0const char *port =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char *sockpath =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char *device =3D NULL;<br>
-=C2=A0 =C2=A0 int64_t fd_size;<br>
=C2=A0 =C2=A0 =C2=A0QemuOpts *sn_opts =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const char *sn_id_or_name =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const char *sopt =3D &quot;hVb:o:p:rsnc:dvk:e:f:tl:x:T:=
D:B:L&quot;;<br>
@@ -1028,6 +1027,17 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0bs =3D blk_bs(blk);<br>
<br>
+=C2=A0 =C2=A0 if (dev_offset) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QDict *raw_opts =3D qdict_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_put_str(raw_opts, &quot;driver&quot;, &q=
uot;raw&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_put_str(raw_opts, &quot;file&quot;, bs-&=
gt;node_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_put_int(raw_opts, &quot;offset&quot;, de=
v_offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bs =3D bdrv_open(NULL, NULL, raw_opts, flags, =
&amp;error_fatal);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_remove_bs(blk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_insert_bs(blk, bs, &amp;error_fatal);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bdrv_unref(bs);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0blk_set_enable_write_cache(blk, !writethrough);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (sn_opts) {<br>
@@ -1045,21 +1055,8 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0bs-&gt;detect_zeroes =3D detect_zeroes;<br>
-=C2=A0 =C2=A0 fd_size =3D blk_getlength(blk);<br>
-=C2=A0 =C2=A0 if (fd_size &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to determine the ima=
ge length: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0strerror(-fd_size));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (dev_offset &gt;=3D fd_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Offset (%&quot; PRIu64 &quo=
t;) has to be smaller than the image &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;size (%&quot; PRId64 &quot;)&quot;, dev_offset, fd_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 fd_size -=3D dev_offset;<br>
<br>
-=C2=A0 =C2=A0 export =3D nbd_export_new(bs, dev_offset, fd_size, export_na=
me,<br>
+=C2=A0 =C2=A0 export =3D nbd_export_new(bs, export_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export_description, bitmap, readonly, shared=
 &gt; 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nbd_export_closed, writethrough, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
-- <br>
2.25.4<br>
<br>
<br>
</blockquote></div></div>

--0000000000008c72e505ad15faf0--


