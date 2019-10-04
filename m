Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E71C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F352084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F352084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGStL-000713-JH
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 15:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGSiL-0000S4-DN
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGSiH-0001k6-FD
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37093)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGSi1-0001It-2b; Fri, 04 Oct 2019 14:53:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63281300BEAF;
 Fri,  4 Oct 2019 18:53:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F059B60852;
 Fri,  4 Oct 2019 18:53:37 +0000 (UTC)
Subject: Re: [PATCH v2 07/11] block: add x-blockdev-amend qmp command
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-8-mlevitsk@redhat.com>
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
Message-ID: <931af700-bb9a-ae84-bd01-215560f66494@redhat.com>
Date: Fri, 4 Oct 2019 20:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190912223028.18496-8-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZVsA3ZI6YM0i2copeOHcV26mtYvqTGw6t"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 04 Oct 2019 18:53:42 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZVsA3ZI6YM0i2copeOHcV26mtYvqTGw6t
Content-Type: multipart/mixed; boundary="JFGdls3N788KBnBbfA1QN5wazLuTYbWkb"

--JFGdls3N788KBnBbfA1QN5wazLuTYbWkb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 00:30, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/Makefile.objs       |   2 +-
>  block/amend.c             | 116 ++++++++++++++++++++++++++++++++++++++=

>  include/block/block_int.h |  23 ++++++--
>  qapi/block-core.json      |  26 +++++++++
>  qapi/job.json             |   4 +-
>  5 files changed, 163 insertions(+), 8 deletions(-)
>  create mode 100644 block/amend.c

I think I=E2=80=99d move this (and everything to belongs to it) to a diff=
erent
series.

> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 35f3bca4d9..10d0308792 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -18,7 +18,7 @@ block-obj-y +=3D block-backend.o snapshot.o qapi.o
>  block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
>  block-obj-$(CONFIG_POSIX) +=3D file-posix.o
>  block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
> -block-obj-y +=3D null.o mirror.o commit.o io.o create.o
> +block-obj-y +=3D null.o mirror.o commit.o io.o create.o amend.o
>  block-obj-y +=3D throttle-groups.o
>  block-obj-$(CONFIG_LINUX) +=3D nvme.o
> =20
> diff --git a/block/amend.c b/block/amend.c
> new file mode 100644
> index 0000000000..9bd28e08e7
> --- /dev/null
> +++ b/block/amend.c
> @@ -0,0 +1,116 @@
> +/*
> + * Block layer code related to image options amend
> + *
> + * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
> + * Copyright (c) 2019 Maxim Levitsky <mlevitsk@redhat.com>
> + *
> + * Heavily based on create.c
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "block/block_int.h"
> +#include "qemu/job.h"
> +#include "qemu/main-loop.h"
> +#include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qapi-visit-block-core.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/error.h"
> +
> +typedef struct BlockdevAmendJob {
> +    Job common;
> +    BlockdevCreateOptions *opts;
> +    BlockDriverState *bs;
> +    bool force;
> +} BlockdevAmendJob;
> +
> +static int coroutine_fn blockdev_amend_run(Job *job, Error **errp)
> +{
> +    BlockdevAmendJob *s =3D container_of(job, BlockdevAmendJob, common=
);
> +    int ret;
> +
> +    job_progress_set_remaining(&s->common, 1);
> +    ret =3D s->bs->drv->bdrv_co_amend(s->bs, s->opts, s->force, errp);=

> +    job_progress_update(&s->common, 1);

It would be nice if the amend job could make use of the progress
reporting that we have in place for amend.

> +
> +    qapi_free_BlockdevCreateOptions(s->opts);
> +
> +    return ret;
> +}
> +
> +static const JobDriver blockdev_amend_job_driver =3D {
> +    .instance_size =3D sizeof(BlockdevAmendJob),
> +    .job_type      =3D JOB_TYPE_AMEND,
> +    .run           =3D blockdev_amend_run,
> +};
> +
> +void qmp_x_blockdev_amend(const char *job_id,
> +                        const char *node_name,
> +                        BlockdevCreateOptions *options,
> +                        bool has_force,
> +                        bool force,
> +                        Error **errp)
> +{
> +    BlockdevAmendJob *s;
> +    const char *fmt =3D BlockdevDriver_str(options->driver);
> +    BlockDriver *drv =3D bdrv_find_format(fmt);
> +    BlockDriverState *bs =3D bdrv_find_node(node_name);
> +
> +    /*
> +     * If the driver is in the schema, we know that it exists. But it =
may not
> +     * be whitelisted.
> +     */
> +    assert(drv);
> +    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
> +        error_setg(errp, "Driver is not whitelisted");
> +        return;
> +    }
> +
> +    if (bs->drv !=3D drv) {
> +        error_setg(errp,
> +                   "x-blockdev-amend doesn't support changing the bloc=
k driver");
> +        return;
> +
> +    }
> +
> +    /* Error out if the driver doesn't support .bdrv_co_amend */
> +    if (!drv->bdrv_co_amend) {
> +        error_setg(errp, "Driver does not support x-blockdev-amend");
> +        return;
> +    }
> +
> +    /*
> +     * Create the block job
> +     * TODO Running in the main context. Block drivers need to error o=
ut or add
> +     * locking when they use a BDS in a different AioContext.

Why shouldn=E2=80=99t the job just run in the node=E2=80=99s context?

Max


--JFGdls3N788KBnBbfA1QN5wazLuTYbWkb--

--ZVsA3ZI6YM0i2copeOHcV26mtYvqTGw6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XlTAACgkQ9AfbAGHV
z0Cc6Af/R2bE0jZUkrjoZHxrByb17FrRdmGxCq5abC6HVDx2xzCpakixanttSbCT
Bo0CFavSWEWvGWIlsuhYw8evXVRm9o7sdsYPc41RkHikhprl0hloW/2cm6hcpidA
wXdMt5vo1QRrN/DxcE479oIeJ9p8PEG34ZxZtR0WqTjCrLF86EsOkekFjPPbd+Gh
KIKc6gsvytP06Feqkgemaw+p7/mxier+vQW+4e6Pb1ov5tufOfTpOr6vz3tJPI+5
v7Rnoeg69g4EaHUjSsQL46kbS+z2nWEcErfvyrgjw4nOMdyyXSY/B7lb7njB6lMA
XrnUpUAnZ2QXCrm6Iq4qPNhTb6MT5g==
=5CM2
-----END PGP SIGNATURE-----

--ZVsA3ZI6YM0i2copeOHcV26mtYvqTGw6t--

