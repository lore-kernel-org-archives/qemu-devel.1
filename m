Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96568C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9C8215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+YNzGDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9C8215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaFiJ-0004f6-8C
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 04:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iaFgX-00049J-IW
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iaFgV-0001da-4n
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:02:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iaFgU-0001ac-R4
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574931717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gbb9JXrQgEserkknB+O3EJkKzXPp+V7pfYaZcO4LMME=;
 b=g+YNzGDmjkEo6lI1OTgQ3HFcdjR0AjRQ7DCvqgxZYCWx8z4mjJx+Bh2stOKCilBrVk8/Dd
 5M2WkOS1MIrNCQtJR/YD+6UUSXF1OPzHcXNlIRq5A3lZS78U28A9Gt10kw1IolePooVSR6
 sHr7nsczS1keXFjljdBR2WIkXD1uDfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-2eLQlSGiPSqd2FSepXrDqw-1; Thu, 28 Nov 2019 04:01:54 -0500
Received: by mail-wm1-f72.google.com with SMTP id t203so3311954wmt.7
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 01:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vhyAKYKqMWjJHjLNdpgw1XhGD7Ekasd3+ZidITCTS8Q=;
 b=Tx3gbSQMCXfrTQ/n1Z6VL6yLxTO+kPZQz0pB7o6HLA6yIl/67XI+QadYV+3DttMzmC
 NHHvHhsFW2N+0PLANilGuhozw6+S1l8f0skKvDVfc/+bWeuIJ+kwbQOA7B1ehtRpyWOu
 TdX6ukJwClWV4zvXWxusd5J+wvmydeNZEyrFvjMgtZNUrSURp3MSjkaZBByPPJpIwaBl
 72sNspW1DOXsZhA7RAmLAT69PU0yzWJ0wqbGZryoyUuDNaa3rPE1pcOG7B6AgdMnJf5q
 mmIsZ/ytuhnN4gKXHOhZJm1F89rzVsaeu2bg5Vu3PWBqW5gQ6JJwlTXDx+jUaqw839q9
 XsNw==
X-Gm-Message-State: APjAAAWHnTzEfq1HoxdbDJk2AKYSra/XkH0A0TZz/hrFew8VvPdcCulH
 S56TsmvJr1mJMGyyMgKjnhFsS/JkCYkGjr0TTikwY1Dkou5l4CmQHBD89RpKtz2gJIaTEGOqaVM
 ukpmu/HApYzBSQeo=
X-Received: by 2002:adf:ba4b:: with SMTP id t11mr45328762wrg.331.1574931713219; 
 Thu, 28 Nov 2019 01:01:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJUvhesVtTe4By/qHpiEF3i3KstVbl4eQBg2lwguR4A0odG/ih7gCxZ+zCOF+91LXKL/T2hA==
X-Received: by 2002:adf:ba4b:: with SMTP id t11mr45328726wrg.331.1574931712810; 
 Thu, 28 Nov 2019 01:01:52 -0800 (PST)
Received: from steredhat (host28-88-dynamic.16-87-r.retail.telecomitalia.it.
 [87.16.88.28])
 by smtp.gmail.com with ESMTPSA id x6sm22980362wrw.34.2019.11.28.01.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 01:01:52 -0800 (PST)
Date: Thu, 28 Nov 2019 10:01:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH] block/nbd: fix memory leak in nbd_open()
Message-ID: <20191128090149.it5w2gijbqaw3tpg@steredhat>
References: <1574930410-43468-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1574930410-43468-1-git-send-email-pannengyuan@huawei.com>
X-MC-Unique: 2eLQlSGiPSqd2FSepXrDqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, liyiting@huawei.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 04:40:10PM +0800, pannengyuan@huawei.com wrote:

Hi,
I don't know nbd code very well, the patch LGTM, but just a comment
below:

> From: PanNengyuan <pannengyuan@huawei.com>
>=20
> In currently implementation there will be a memory leak when
> nbd_client_connect() returns error status. Here is an easy way to reprodu=
ce:
>=20
> 1. run qemu-iotests as follow and check the result with asan:
>     ./check -raw 143
>=20
> Following is the asan output backtrack:
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f629688a560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
>     #1 0x7f6295e7e015 in g_malloc0  (/usr/lib64/libglib-2.0.so.0+0x50015)
>     #2 0x56281dab4642 in qobject_input_start_struct  /mnt/sdb/qemu-4.2.0-=
rc0/qapi/qobject-input-visitor.c:295
>     #3 0x56281dab1a04 in visit_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi=
/qapi-visit-core.c:49
>     #4 0x56281dad1827 in visit_type_SocketAddress  qapi/qapi-visit-socket=
s.c:386
>     #5 0x56281da8062f in nbd_config  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:=
1716
>     #6 0x56281da8062f in nbd_process_options  /mnt/sdb/qemu-4.2.0-rc0/blo=
ck/nbd.c:1829
>     #7 0x56281da8062f in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:18=
73
>=20
> Direct leak of 15 byte(s) in 1 object(s) allocated from:
>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
>     #1 0x7f6295e7dfbd in g_malloc  (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
>     #2 0x7f6295e96ace in g_strdup  (/usr/lib64/libglib-2.0.so.0+0x68ace)
>     #3 0x56281da804ac in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/bloc=
k/nbd.c:1834
>     #4 0x56281da804ac in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:18=
73
>=20
> Indirect leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
>     #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
>     #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
>     #3 0x56281dab41a3 in qobject_input_type_str_keyval   /mnt/sdb/qemu-4.=
2.0-rc0/qapi/qobject-input-visitor.c:536
>     #4 0x56281dab2ee9 in visit_type_str   /mnt/sdb/qemu-4.2.0-rc0/qapi/qa=
pi-visit-core.c:297
>     #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members  qapi/qapi-=
visit-sockets.c:141
>     #6 0x56281dad17b6 in visit_type_SocketAddress_members      qapi/qapi-=
visit-sockets.c:366
>     #7 0x56281dad186a in visit_type_SocketAddress     qapi/qapi-visit-soc=
kets.c:393
>     #8 0x56281da8062f in nbd_config   /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c=
:1716
>     #9 0x56281da8062f in nbd_process_options   /mnt/sdb/qemu-4.2.0-rc0/bl=
ock/nbd.c:1829
>     #10 0x56281da8062f in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1=
873
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> ---
>  block/nbd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 1239761..bc40a25 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1881,6 +1881,11 @@ static int nbd_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
> =20
>      ret =3D nbd_client_connect(bs, errp);
>      if (ret < 0) {
> +        object_unref(OBJECT(s->tlscreds));
> +        qapi_free_SocketAddress(s->saddr);
> +        g_free(s->export);
> +        g_free(s->tlscredsid);
> +        g_free(s->x_dirty_bitmap);

Since with this patch we are doing these cleanups in 3 places (here,
nbd_close(), and nbd_process_options()), should be better to add a new
function to do these cleanups?

Maybe I'd create a series adding a patch before this one, implementing this
new function, and change this patch calling it.

Thanks,
Stefano


