Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A634CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D42921897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FH+WV4ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D42921897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXMP-0001Xp-5y
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iLXGx-0008Sq-9g
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iLXGw-0001zg-11
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:46:47 -0400
Received: from mout.web.de ([212.227.15.4]:35129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iLXGv-0001xu-Jh; Fri, 18 Oct 2019 14:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571424388;
 bh=9czTDDpKPA4uzAwvfli8wXLz0Uo2kLx2fFVUmSRI9ug=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=FH+WV4ejt0DzB7yxcnwIaaL01yzF0jc4l4ZimKEuqDF67zTE+p1COCuO3mgGnEGFA
 jo3qiE+mFAYCL+eZuZLUgloD3Wie30VIbyLnNWbPJyvdCm0vP/f7sIrWq8XSVkjeU8
 TEwk0URtI9rAo93qqp77uXQfA7TS4KYnOs3FBKvA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.121]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhlP1-1ihLgF1tIZ-00MrMP; Fri, 18
 Oct 2019 20:46:28 +0200
Date: Fri, 18 Oct 2019 20:46:26 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/4] block/replication.c: Ignore requests after failover
Message-ID: <20191018204626.0559de89@luklap>
In-Reply-To: <596a6f07850002a09461f317afa75f3e0c9bb784.1570280098.git.lukasstraub2@web.de>
References: <cover.1570280098.git.lukasstraub2@web.de>
 <596a6f07850002a09461f317afa75f3e0c9bb784.1570280098.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BnykwpK8Qd+HSNsiTODqg7pLGS9tZ/Z75Jk9VKRp54MQIM8GZ5o
 +qPy8hdtPsMQzAG1jNppV76WnB/aQaBcFyDwX1w8eTw5GwalVMMylQsCpBmfovGwWUxOjE1
 C3X6FEVOhWNsRjrru4jz7Q50RPktyE+yJMGDPcg6tCKGBcZ5pSQ9jXFCuEz0cWhn8xSzccA
 hbtf/gOXkBG9VW/MeUU5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u5mUe8UGvBs=:cQ1FePVGBEvEFMnsqLom4c
 7Ylskjwfv8cAcdB26uCSdcUfJkZ9jm7E8PAyXc9YA0I1izqk+WOO5KrIguuL9gVapw9n8KvbF
 ULNeoChMKyb1udTZkWTtUAU4Zeo9Iq0ebZUrkmOjmyvXJIahyQkpAFui+LFLWs1cw7T+Lbt7E
 dhCMa18N3HLEcgqDkywbOPxXtqxvbF9wl1rjnrAC7ZRgpDDndwACJNhZ+88TjPmYdh6bClY0M
 KSPd3lkRkjmcszDo7/kYuIZaUBYGJUFzELZisLZ8esZbEslEuti5bAnWmJlMkmzVkIf0N+R2x
 gW+bLTn54n8L34S5hx4OLEgXDSomskAaPyJQ04gjZVmWRBwKXmhU+tt4+M0CWWv1j4rDaxVe0
 8IVcsMvnsuyDXVCwpYFdQMCH6JxG6SUSrm/ouENsCexpSctwHQeS39oNAftXOo8a+RfBJXvqh
 j7pGAouJAvRgDjH/cmwTm7az04kLs5x4DJJgBqzwEcV4y6/wO+llIuz052jSx17DF617mtF4g
 g1/s0mlC/QuxaIdnN7c1YiR4XkjT/1F5j/OhogdM2872qagaxNRCp7yyGqgcYME/V2AOslzg6
 MwXBjJcYKZ9bKdl1FCHMRFUhTY+nBnUgeTtMHM2p75Sy3/g9RdFKm5veWE0miizZW23zCTvcF
 TcLTq8QXAVa6F9BdpGuH43m678bY5QZPITeHxEs6Zw3SBzejiJRe/bAwp8d4psALr240woM31
 p+ZezeNGEjolEJH+NEMZS0KrDWHYrSzRe2KED4n48L9QtrdRPmE2kXRkH8RTqSnDU606BPaC7
 e9jwq8eCpYcdnggXLH82NFEOoMQwN1uzg/ViMCQ54VtBZLOSyJ0Li2Z/Ucl/QmpXIZwS+MoDH
 gjjW+vLIBtUHMVXMX3wnuzKf3+BsLyhcv6GPYwQO+ckWIThImq5OaKd8jljQqFhorfjlCov+p
 4lBDFo4gGBE7WRYYXhnVOUKAPOQF1VA7XHdCIcdRDsB6oVJ5WQHOE+NDNN45S2ZG8U7urr1zc
 17VuGX3A9bVjHTQJhKBP40ETkAR/lBW1H8g3PvQM8v+CZW8JGT9rgyVkSkMTSKaDMyw9KjB4C
 MWFfoz9v44D7PGRbkiQEUruKpxdNoNxCLxQh6ApHlWKXbz6SNwl/oTvKbAm2iz7iqioXho3jm
 GymW4x3YA9Nm79OnbiR+4rbgbT4jDf59hS8Jh2RU7WDum8B30FILZ97WxXr5nVAwUtFFGTgb+
 52ERxfVToT1HsssFf4IgKqlzOeAUfQynvY2h4I73w7DkAt45nK/7XunKQ8kM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.4
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 5 Oct 2019 15:05:23 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> After failover the Secondary side of replication shouldn't change state,=
 because
> it now functions as our primary disk.
>
> In replication_start, replication_do_checkpoint, replication_stop, ignor=
e
> the request if current state is BLOCK_REPLICATION_DONE (sucessful failov=
er) or
> BLOCK_REPLICATION_FAILOVER (failover in progres i.e. currently merging a=
ctive
> and hidden images into the base image).
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  block/replication.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/block/replication.c b/block/replication.c
> index 3d4dedddfc..97cc65c0cf 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -454,6 +454,17 @@ static void replication_start(ReplicationState *rs,=
 ReplicationMode mode,
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>
> +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> +        /*
> +         * This case happens when a secondary is promoted to primary.
> +         * Ignore the request because the secondary side of replication
> +         * doesn't have to do anything anymore.
> +         */
> +        aio_context_release(aio_context);
> +        return;
> +    }
> +
>      if (s->stage !=3D BLOCK_REPLICATION_NONE) {
>          error_setg(errp, "Block replication is running or done");
>          aio_context_release(aio_context);
> @@ -529,8 +540,7 @@ static void replication_start(ReplicationState *rs, =
ReplicationMode mode,
>                     "Block device is in use by internal backup job");
>
>          top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
> -        if (!top_bs || !bdrv_is_root_node(top_bs) ||
> -            !check_top_bs(top_bs, bs)) {
> +        if (!top_bs || !check_top_bs(top_bs, bs)) {
>              error_setg(errp, "No top_bs or it is invalid");
>              reopen_backing_file(bs, false, NULL);
>              aio_context_release(aio_context);
> @@ -577,6 +587,17 @@ static void replication_do_checkpoint(ReplicationSt=
ate *rs, Error **errp)
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>
> +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> +        /*
> +         * This case happens when a secondary was promoted to primary.
> +         * Ignore the request because the secondary side of replication
> +         * doesn't have to do anything anymore.
> +         */
> +        aio_context_release(aio_context);
> +        return;
> +    }
> +
>      if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
>          secondary_do_checkpoint(s, errp);
>      }
> @@ -593,7 +614,7 @@ static void replication_get_error(ReplicationState *=
rs, Error **errp)
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>
> -    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
> +    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) {
>          error_setg(errp, "Block replication is not running");
>          aio_context_release(aio_context);
>          return;
> @@ -635,6 +656,17 @@ static void replication_stop(ReplicationState *rs, =
bool failover, Error **errp)
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>
> +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> +        /*
> +         * This case happens when a secondary was promoted to primary.
> +         * Ignore the request because the secondary side of replication
> +         * doesn't have to do anything anymore.
> +         */
> +        aio_context_release(aio_context);
> +        return;
> +    }
> +
>      if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
>          error_setg(errp, "Block replication is not running");
>          aio_context_release(aio_context);

Hello Everyone,
Could the block people have a look at this patch?

Regards,
Lukas Straub

