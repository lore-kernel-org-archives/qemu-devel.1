Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F016FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C899120820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C899120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRW8-0004MO-2B
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iLRVI-0003v7-FK
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iLRVF-0004p1-UB
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iLRVF-0004op-La
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62916101BC52;
 Fri, 18 Oct 2019 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D286F60852;
 Fri, 18 Oct 2019 12:37:04 +0000 (UTC)
Date: Fri, 18 Oct 2019 14:37:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v7 2/4] block.c: adding bdrv_delete_file
Message-ID: <20191018123703.GE6122@localhost.localdomain>
References: <20190903135708.21624-1-danielhb413@gmail.com>
 <20190903135708.21624-3-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190903135708.21624-3-danielhb413@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 18 Oct 2019 12:37:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2019 um 15:57 hat Daniel Henrique Barboza geschrieben:
> Using the new 'bdrv_co_delete_file' interface, bdrv_delete_file
> can be used in a way similar of the existing bdrv_create_file to
> to clean up a created file.
>=20
> The logic is also similar to what is already done in bdrv_create_file:
> a qemu_coroutine is created if needed, a specialized function
> bdrv_delete_co_entry is used to call the bdrv_co_delete_file
> co-routine of the driver, if the driver implements it.
>=20
> Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

The only caller of bdrv_delete_file() is in coroutine context, so I
think this patch can be made much simpler by turning it into a pure
coroutine function bdrv_co_delete_file().

> diff --git a/block.c b/block.c
> index 874a29a983..250c69ca7a 100644
> --- a/block.c
> +++ b/block.c
> @@ -548,6 +548,79 @@ int bdrv_create_file(const char *filename, QemuOpt=
s *opts, Error **errp)
>      return ret;
>  }
> =20
> +typedef struct DeleteCo {
> +    BlockDriver *drv;
> +    BlockDriverState *bs;
> +    int ret;
> +    Error *err;
> +} DeleteCo;
> +
> +static void coroutine_fn bdrv_delete_co_entry(void *opaque)
> +{
> +    Error *local_err =3D NULL;
> +    DeleteCo *dco =3D opaque;
> +    BlockDriver *drv =3D dco->bs->drv;
> +
> +    assert(dco->bs);
> +
> +    dco->ret =3D drv->bdrv_co_delete_file(dco->bs, &local_err);
> +    error_propagate(&dco->err, local_err);
> +}
> +
> +int bdrv_delete_file(BlockDriverState *bs, Error **errp)
> +{
> +    DeleteCo dco =3D {
> +        .bs =3D bs,
> +        .ret =3D NOT_DONE,
> +        .err =3D NULL,
> +    };
> +    Coroutine *co;
> +    int ret;
> +
> +    if (!bs) {
> +        error_setg(errp, "Could not open image '%s' for erasing",
> +                   bs->filename);
> +        ret =3D -1;

For a function returning 0/-errno, -1 is not a good return code because
it could be any error (or an undefined one). On Linux, this happens to
be -EPERM.

> +        goto out;
> +    }

We're not trying to open it here, so the error message is odd.

I think the caller should make sure that bs !=3D NULL.

> +    if (!bs->drv) {
> +        error_setg(errp, "File '%s' has unknown format", bs->filename)=
;
> +        ret =3D -ENOMEDIUM;
> +        goto out;
> +    }

bs->drv means that file isn't open. It has nothing to do with an unknown
format. Maybe you can combine both cases into one with an error message
"block node is not opened".

> +    if (!bs->drv->bdrv_co_delete_file) {
> +        error_setg(errp, "Driver '%s' does not support image delete",

s/delete/deletion/

> +                   bs->drv->format_name);
> +        ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    if (qemu_in_coroutine()) {
> +        /* Fast-path if already in coroutine context */
> +        bdrv_delete_co_entry(&dco);
> +    } else {
> +        co =3D qemu_coroutine_create(bdrv_delete_co_entry, &dco);
> +        qemu_coroutine_enter(co);
> +        while (dco.ret =3D=3D NOT_DONE) {
> +            aio_poll(qemu_get_aio_context(), true);
> +        }
> +    }

We don't really want to have this kind of different behaviour for
coroutine and non-coroutine contexts. It only exists for compatibility
reasons in other places (when we already had callers that didn't know
whether they were run inside a coroutine or not).

With a bdrv_co_delete_file(), it will go away.

> +
> +    ret =3D dco.ret;
> +    if (ret < 0) {
> +        if (dco.err) {
> +            error_propagate(errp, dco.err);
> +        } else {
> +            error_setg_errno(errp, -ret, "Could not delete image");
> +        }
> +    }
> +
> +out:
> +    return ret;

No cleanup code, so all "ret =3D ...; goto out;" instances above could be
replaced with a direct return.

Kevin

