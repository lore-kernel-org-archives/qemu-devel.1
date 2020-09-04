Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F97CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46342137B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46342137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAfk-0001Ra-TS
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kEAf5-0000oa-HO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:17:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kEAf3-0001sV-Rl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:17:47 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-712NvVH3MgylmYoOGS6g_w-1; Fri, 04 Sep 2020 08:17:43 -0400
X-MC-Unique: 712NvVH3MgylmYoOGS6g_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D9331074650;
 Fri,  4 Sep 2020 12:17:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-156.ams2.redhat.com
 [10.36.114.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 042A87E40A;
 Fri,  4 Sep 2020 12:17:39 +0000 (UTC)
Subject: Re: [PATCH v8 4/7] copy-on-read: pass base file name to COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-5-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <15dbdc16-8d4d-3830-01af-8cc149ffd79d@redhat.com>
Date: Fri, 4 Sep 2020 14:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598633579-221780-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YvZaaBIncumEqIRTF8LVAgCOEiU3elI9R"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YvZaaBIncumEqIRTF8LVAgCOEiU3elI9R
Content-Type: multipart/mixed; boundary="1VxzUwxdj4cv9yl8GtjRQR0Ln0WDWWVX1"

--1VxzUwxdj4cv9yl8GtjRQR0Ln0WDWWVX1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.08.20 18:52, Andrey Shinkevich wrote:
> To limit the guest's COR operations by the base node in the backing
> chain during stream job, pass the base file name to the copy-on-read

Does it have to be a filename?  That sounds really bad to me.

> driver. The rest of the functionality will be implemented in the patch
> that follows.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/copy-on-read.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  block/copy-on-read.h |  1 +
>  2 files changed, 41 insertions(+), 1 deletion(-)

Furthermore, I believe that this option should become an externally
visible option for the copy-on-read filter (i.e., part of its
BlockdevOptions) =E2=80=93 but that definitely won=E2=80=99t be viable if @=
base contains
a filename.

Can=E2=80=99t we let the stream job invoke bdrv_find_backing_image() to
translate a filename into a node name that=E2=80=99s then passed to the COR=
 filter?

> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 0ede7aa..1f858bb 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -24,19 +24,45 @@
>  #include "block/block_int.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>  #include "qapi/qmp/qdict.h"
>  #include "block/copy-on-read.h"
> =20
> =20
>  typedef struct BDRVStateCOR {
>      bool active;
> +    BlockDriverState *base_bs;
>  } BDRVStateCOR;
> =20
> +/*
> + * Non-zero pointers are the caller's responsibility.
> + */
> +static BlockDriverState *get_base_by_name(BlockDriverState *bs,
> +                                          const char *base_name, Error *=
*errp)
> +{
> +    BlockDriverState *base_bs =3D NULL;
> +    AioContext *aio_context;
> +
> +    base_bs =3D bdrv_find_backing_image(bs, base_name);
> +    if (base_bs =3D=3D NULL) {
> +        error_setg(errp, QERR_BASE_NOT_FOUND, base_name);
> +        return NULL;
> +    }
> +
> +    aio_context =3D bdrv_get_aio_context(bs);
> +    aio_context_acquire(aio_context);
> +    assert(bdrv_get_aio_context(base_bs) =3D=3D aio_context);
> +    aio_context_release(aio_context);

Er.  OK.  But why?  Isn=E2=80=99t this just guaranteed by the block layer? =
 I
don=E2=80=99t think we need an explicit assertion for this, especially if i=
t
means having to acquire an AioContext.

Furthermore, I don=E2=80=99t even know why we=E2=80=99d need the AioContext=
.  On one
hand, we don=E2=80=99t need to acquire a context just to get it or compare =
it;
on the other, this I would have thought that .bdrv_open() runs in the
BDS=E2=80=99s AioContext anyway (or the caller already has it acquired at l=
east).

Max


--1VxzUwxdj4cv9yl8GtjRQR0Ln0WDWWVX1--

--YvZaaBIncumEqIRTF8LVAgCOEiU3elI9R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9SMGIACgkQ9AfbAGHV
z0CMwAf+Po1L76pjopvFbMQ7TQRL38ak5Wh0AJU6cSslBuEAjL1/5JyllqsV1Frg
WFZMWLzo2i29a9DZO41BIMCzBGD1NYUvE+Vt9CnNwYFESq1bHunhgoJoKWAm6to7
E4BLSkh3nTFVUmfvsl8zgMt/1TMzz+BkTCrgsHUYyiz0GdPyTzJHKkXJH6hukEea
PnWPwc+cG6pCQVL8HHPWgoUmNqdYYR+a8f/AztdxEpk7RdsObngcV3RW5F+e6eTX
vHwyWx14iuRZufkDxBtjTMSH+OGW5RHVL4nPKcK2cGq1f7W8eIdJOFL6L6mUIWFH
298y79jPS+NfCgf+XGXZpvZ4kwHnqA==
=FPb/
-----END PGP SIGNATURE-----

--YvZaaBIncumEqIRTF8LVAgCOEiU3elI9R--


