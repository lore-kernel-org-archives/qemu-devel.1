Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508BBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D392063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AweSRPi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D392063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7dXD-0000ud-An
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7dWW-0008Ve-Cm
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:41:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31740
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7dWS-0001Gg-ON
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597664511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K8942RwN2oGIykdFhtlgJyGZsDfj9d5ZNFnC6M5u8A8=;
 b=AweSRPi16KgDz9xP9coeRMpZUWAy7FBxA3KhyBS1D05qs9w9KAmUQYn9MJ5475v4ybBBS8
 /DaJhB46vT/v8d9z0vyaf2P3WkUZB5j4B+f6qU0L/m1ClG4YuYSuhAB+yz40Wpx2VjC+uQ
 bx2zWfe4BKnR262olGn0Dub0IUwWjqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Mdh07icJM_KdXakklIycuA-1; Mon, 17 Aug 2020 07:41:49 -0400
X-MC-Unique: Mdh07icJM_KdXakklIycuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 389FA100CF75;
 Mon, 17 Aug 2020 11:41:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E959784B5;
 Mon, 17 Aug 2020 11:41:46 +0000 (UTC)
Subject: Re: [RFC PATCH 07/22] block/export: Remove magic from block-export-add
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <2a6528d8-1792-ec1e-287b-a9b9e2f20eef@redhat.com>
Date: Mon, 17 Aug 2020 13:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-8-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cfLlZpKZTqquCFIvt4X6DJPcVxFPTbRNS"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfLlZpKZTqquCFIvt4X6DJPcVxFPTbRNS
Content-Type: multipart/mixed; boundary="cjXCyBvClO6CdwHjdHkDEG2BwUwzuu3jO"

--cjXCyBvClO6CdwHjdHkDEG2BwUwzuu3jO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> nbd-server-add tries to be convenient and adds two questionable
> features that we don't want to share in block-export-add, even for NBD
> exports:
>=20
> 1. When requesting a writable export of a read-only device, the export
>    is silently downgraded to read-only. This should be an error in the
>    context of block-export-add.
>=20
> 2. When using a BlockBackend name, unplugging the device from the guest
>    will automatically stop the NBD server, too. This may sometimes be
>    what you want, but it could also be very surprising. Let's keep
>    things explicit with block-export-add. If the user wants to stop the
>    export, they should tell us so.
>=20
> Move these things into the nbd-server-add QMP command handler so that
> they apply only there.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/nbd.h   |  3 ++-
>  block/export/export.c | 44 ++++++++++++++++++++++++++++++++++++++-----
>  blockdev-nbd.c        | 10 ++++------
>  nbd/server.c          | 19 ++++++++++++-------
>  qemu-nbd.c            |  3 +--
>  5 files changed, 58 insertions(+), 21 deletions(-)

[...]

> diff --git a/block/export/export.c b/block/export/export.c
> index 3d0dacb3f2..2d5f92861c 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c

[...]

> @@ -34,24 +36,56 @@ static const BlockExportDriver *blk_exp_find_driver(B=
lockExportType type)
>      return NULL;
>  }
> =20
> -void qmp_block_export_add(BlockExportOptions *export, Error **errp)
> +static BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp=
)
>  {
>      const BlockExportDriver *drv;
> =20
>      drv =3D blk_exp_find_driver(export->type);
>      if (!drv) {
>          error_setg(errp, "No driver found for the requested export type"=
);
> -        return;
> +        return NULL;
>      }
> =20
> -    drv->create(export, errp);
> +    return drv->create(export, errp);
> +}
> +
> +void qmp_block_export_add(BlockExportOptions *export, Error **errp)
> +{
> +    blk_exp_add(export, errp);
>  }

Interesting.  I would have added it this way from the start then (with a
note that we=E2=80=99ll need it later).

>  void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
>  {
> -    BlockExportOptions export =3D {
> +    BlockExport *export;
> +    BlockDriverState *bs;
> +    BlockBackend *on_eject_blk;
> +
> +    BlockExportOptions export_opts =3D {
>          .type =3D BLOCK_EXPORT_TYPE_NBD,
>          .u.nbd =3D *arg,

This copies *arg=E2=80=99s contents...

>      };
> -    qmp_block_export_add(&export, errp);
> +
> +    /*
> +     * nbd-server-add doesn't complain when a read-only device should be
> +     * exported as writable, but simply downgrades it. This is an error =
with
> +     * block-export-add.
> +     */
> +    bs =3D bdrv_lookup_bs(arg->device, arg->device, NULL);
> +    if (bs && bdrv_is_read_only(bs)) {
> +        arg->writable =3D false;

...and here you only modify the original *arg, but not
export_opts.u.nbd.  So I don=E2=80=99t think this will have any effect.

> +    }
> +
> +    export =3D blk_exp_add(&export_opts, errp);
> +    if (!export) {
> +        return;
> +    }
> +
> +    /*
> +     * nbd-server-add removes the export when the named BlockBackend use=
d for
> +     * @device goes away.
> +     */
> +    on_eject_blk =3D blk_by_name(arg->device);
> +    if (on_eject_blk) {
> +        nbd_export_set_on_eject_blk(export, on_eject_blk);
> +    }
>  }

The longer it gets, the more I think maybe it should be in some NBD file
like blockdev-nbd.c after all.

[...]

> diff --git a/nbd/server.c b/nbd/server.c
> index 92360d1f08..0b84fd30e2 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1506,11 +1506,22 @@ static void nbd_eject_notifier(Notifier *n, void =
*data)
>      aio_context_release(aio_context);
>  }
> =20
> +void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
> +{
> +    NBDExport *nbd_exp =3D container_of(exp, NBDExport, common);
> +    assert(exp->drv =3D=3D &blk_exp_nbd);
> +

I think asserting that the nbd_exp->eject_notifier is unused so far
would make sense (e.g. just checking that eject_notifier_blk is NULL).

Max

> +    blk_ref(blk);
> +    nbd_exp->eject_notifier_blk =3D blk;
> +    nbd_exp->eject_notifier.notify =3D nbd_eject_notifier;
> +    blk_add_remove_bs_notifier(blk, &nbd_exp->eject_notifier);
> +}
> +


--cjXCyBvClO6CdwHjdHkDEG2BwUwzuu3jO--

--cfLlZpKZTqquCFIvt4X6DJPcVxFPTbRNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86bPkACgkQ9AfbAGHV
z0Do1wf/TCM4XY2djVhyLOLsF6csyyzeRnGwvnOk+kym078jLLJwLJOUKRLfW9i8
wvoxjqjRb/xmap+XsL8yTGVbSHwUMWgTBgb0MRFnaTffDkDLsLv3tMrmFHzNA9oR
sEGidZdCKJ5hMb2luGXqKYI6+o0qUtANbkWmp9HGyQr3D/xp+Yu0fhDYa4mhI8QP
u5eysoHGi721YMx9TZxdMrVM/kFzyMydHMKn2DNLEXJcYwKxI+j4tR6p+XJHrT0R
Zcalr1GtOk9PRAPWejjHksy9+McdgdDolP61MrwDk7JB90bLA6Y815MhZFpsgy8J
Gr6wJ6lZHAmX8pQKWOtDbhtUG51Umg==
=+qWQ
-----END PGP SIGNATURE-----

--cfLlZpKZTqquCFIvt4X6DJPcVxFPTbRNS--


