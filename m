Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27051C4320D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 20:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5B7207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 20:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5B7207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCVLx-0006Vp-LX
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 16:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCUzd-00077L-Pp
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 16:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCUzb-0000aJ-S4
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 16:31:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCUzS-0000Vf-3H; Mon, 23 Sep 2019 16:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DAE9E3090FC3;
 Mon, 23 Sep 2019 20:31:19 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3F0601AF;
 Mon, 23 Sep 2019 20:30:35 +0000 (UTC)
Subject: Re: [RFC v2 7/9] Use auto-propagated errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20190923161231.22028-1-vsementsov@virtuozzo.com>
 <20190923161231.22028-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <59c5ccc7-3d4c-9613-fcd3-97642c1394cd@redhat.com>
Date: Mon, 23 Sep 2019 15:30:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923161231.22028-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 23 Sep 2019 20:31:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Mailman-Approved-At: Mon, 23 Sep 2019 16:51:49 -0400
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
Cc: stefanha@redhat.com, codyprime@gmail.com, jan.kiszka@siemens.com,
 berto@igalia.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, samuel.thibault@ens-lyon.org, philmd@redhat.com,
 green@moxielogic.com, lvivier@redhat.com, ehabkost@redhat.com,
 xiechanglong.d@gmail.com, pl@kamp.de, dgilbert@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, ronniesahlberg@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 crwulff@gmail.com, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 david@redhat.com, palmer@sifive.com, thuth@redhat.com, jcmvbkbc@gmail.com,
 den@openvz.org, hare@suse.com, sstabellini@kernel.org, arei.gonglei@huawei.com,
 namei.unix@gmail.com, atar4qemu@gmail.com, farman@linux.ibm.com,
 amit@kernel.org, sw@weilnetz.de, groug@kaod.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, cohuck@redhat.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, pburton@wavecomp.com, sagark@eecs.berkeley.edu,
 jasowang@redhat.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 gxt@mprc.pku.edu.cn, ari@tuxera.com, quintela@redhat.com,
 mdroth@linux.vnet.ibm.com, lersek@redhat.com, borntraeger@de.ibm.com,
 antonynpavlov@gmail.com, dillaman@redhat.com, joel@jms.id.au,
 xen-devel@lists.xenproject.org, integration@gluster.org, rjones@redhat.com,
 Andrew.Baumann@microsoft.com, mreitz@redhat.com, walling@linux.ibm.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, v.maffione@gmail.com,
 marex@denx.de, armbru@redhat.com, marcandre.lureau@redhat.com,
 alistair@alistair23.me, paul.durrant@citrix.com, pavel.dovgaluk@ispras.ru,
 g.lettieri@iet.unipi.it, rizzo@iet.unipi.it, david@gibson.dropbear.id.au,
 akrowiak@linux.ibm.com, berrange@redhat.com, xiaoguangrong.eric@gmail.com,
 pmorel@linux.ibm.com, wencongyang2@huawei.com, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 11:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> This commit is generated by command
> 
> git grep -l 'Error \*\*errp' | while read f; \
> do spatch --sp-file \
> scripts/coccinelle/auto-propagated-errp.cocci --in-place $f; done
> 

As mentioned in your cover letter, this fails syntax-check and
compilation without squashing in some followups; if we can't improve the
.cocci script to do it automatically, then manually squashing in
cleanups (and documenting what types of cleanups they were) is fine.
(The goal for a mechanical patch like this is to make it easy enough to
automate downstream, even where the file contents are changed, but where
the process for creating those changes are the same).

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Spot-checking

>  block/io.c                          |  11 +-

>  block/nbd.c                         |  44 +++---

>  qapi/qapi-visit-core.c              |  53 ++-----

just to see how it looks.

> +++ b/block/io.c
> @@ -136,7 +136,6 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>  {
>      BlockDriver *drv = bs->drv;
> -    Error *local_err = NULL;
>  

Umm, no insertion of ERR_FUNCTION_BEGIN().  Oops.

>      memset(&bs->bl, 0, sizeof(bs->bl));
>  
> @@ -151,9 +150,8 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>  
>      /* Take some limits from the children as a default */
>      if (bs->file) {
> -        bdrv_refresh_limits(bs->file->bs, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        bdrv_refresh_limits(bs->file->bs, errp);
> +        if (*errp) {
>              return;
>          }
>          bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
> @@ -166,9 +164,8 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>      }
>  
>      if (bs->backing) {
> -        bdrv_refresh_limits(bs->backing->bs, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        bdrv_refresh_limits(bs->backing->bs, errp);
> +        if (*errp) {
>              return;

Rest of the changes in this file are good if the macro gets added correctly.

>          }
>          bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);

> +++ b/block/nbd.c
> @@ -808,7 +808,6 @@ static int nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t handle,
>      NBDReplyChunkIter iter;
>      NBDReply reply;
>      void *payload = NULL;
> -    Error *local_err = NULL;

Recurring problem of not inserting the macro as expected.

>  
>      NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
>                              qiov, &reply, &payload)
> @@ -827,20 +826,20 @@ static int nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t handle,
>              break;
>          case NBD_REPLY_TYPE_OFFSET_HOLE:
>              ret = nbd_parse_offset_hole_payload(s, &reply.structured, payload,
> -                                                offset, qiov, &local_err);
> +                                                offset, qiov, errp);
>              if (ret < 0) {
>                  nbd_channel_error(s, ret);
> -                nbd_iter_channel_error(&iter, ret, &local_err);
> +                nbd_iter_channel_error(&iter, ret, errp);
>              }
>              break;
>          default:
>              if (!nbd_reply_type_is_error(chunk->type)) {
>                  /* not allowed reply type */
>                  nbd_channel_error(s, -EINVAL);
> -                error_setg(&local_err,
> +                error_setg(errp,
>                             "Unexpected reply type: %d (%s) for CMD_READ",

Could almost fold these lines (but I'm not asking you to; keeping this
patch as mechanical as possible is fine).

>                             chunk->type, nbd_reply_type_lookup(chunk->type));
> -                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
> +                nbd_iter_channel_error(&iter, -EINVAL, errp);
>              }
>          }
>  
> @@ -861,7 +860,6 @@ static int nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>      NBDReplyChunkIter iter;
>      NBDReply reply;
>      void *payload = NULL;
> -    Error *local_err = NULL;
>      bool received = false;

Oops on the macro.

> @@ -1174,15 +1172,13 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
>                                                    Error **errp)
>  {
>      QIOChannelSocket *sioc;
> -    Error *local_err = NULL;
>  
>      sioc = qio_channel_socket_new();
>      qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
>  
> -    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
> -    if (local_err) {
> +    qio_channel_socket_connect_sync(sioc, saddr, errp);
> +    if (*errp) {
>          object_unref(OBJECT(sioc));
> -        error_propagate(errp, local_err);
>          return NULL;

But getting rid of error_propagate() is nice.

Did you grep for instances of error_propagate() after your mechanical
patch, to see what else the Coccinelle script might have missed?


> +++ b/qapi/opts-visitor.c
> @@ -275,6 +275,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>  static void
>  opts_check_list(Visitor *v, Error **errp)
>  {
> +	ERRP_FUNCTION_BEGIN();
>      /*
>       * Unvisited list elements will be reported later when checking
>       * whether unvisited struct members remain.

Here the macro got added, but with no obvious benefit later on (although
we also argued that adding it even when it makes no difference is not
bad, if that's easier to automate for style checking).

> diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
> index d192724b13..3ee4c7a2e7 100644
> --- a/qapi/qapi-dealloc-visitor.c
> +++ b/qapi/qapi-dealloc-visitor.c
> @@ -25,6 +25,7 @@ struct QapiDeallocVisitor
>  static void qapi_dealloc_start_struct(Visitor *v, const char *name, void **obj,
>                                        size_t unused, Error **errp)
>  {
> +	ERRP_FUNCTION_BEGIN();
>  }

Here's an example where exempting empty functions would be nicer.


> +++ b/qapi/qapi-visit-core.c
> @@ -39,18 +39,15 @@ void visit_free(Visitor *v)
>  void visit_start_struct(Visitor *v, const char *name, void **obj,
>                          size_t size, Error **errp)
>  {
> -    Error *err = NULL;
> -

Oops, macro not added.

>      trace_visit_start_struct(v, name, obj, size);
>      if (obj) {
>          assert(size);
>          assert(!(v->type & VISITOR_OUTPUT) || *obj);
>      }
> -    v->start_struct(v, name, obj, size, &err);
> +    v->start_struct(v, name, obj, size, errp);
>      if (obj && (v->type & VISITOR_INPUT)) {
> -        assert(!err != !*obj);
> +        assert(!*errp != !*obj);
>      }
> -    error_propagate(errp, err);
>  }

But the cleanup is sane, once the macro is present.

> @@ -152,12 +143,10 @@ void visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **errp)
>  static void visit_type_uintN(Visitor *v, uint64_t *obj, const char *name,
>                               uint64_t max, const char *type, Error **errp)
>  {
> -    Error *err = NULL;
>      uint64_t value = *obj;
>  
> -    v->type_uint64(v, name, &value, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> +    v->type_uint64(v, name, &value, errp);
> +    if (*errp) {
>      } else if (value > max) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     name ? name : "null", type);

Results in an empty if which looks funny.  This one could be a manual
touchup later.

> @@ -211,12 +200,10 @@ static void visit_type_intN(Visitor *v, int64_t *obj, const char *name,
>                              int64_t min, int64_t max, const char *type,
>                              Error **errp)
>  {
> -    Error *err = NULL;
>      int64_t value = *obj;
>  
> -    v->type_int64(v, name, &value, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> +    v->type_int64(v, name, &value, errp);
> +    if (*errp) {
>      } else if (value < min || value > max) {

and again

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

