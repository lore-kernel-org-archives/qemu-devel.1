Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E3AC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83DE20645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83DE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVLO-0006Dm-9p
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57141)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfVF1-0000XP-Bd
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfVEz-0008BL-EW
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfVEv-0007xd-5D; Mon, 24 Jun 2019 16:06:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3BAD3087955;
 Mon, 24 Jun 2019 20:06:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-152.brq.redhat.com
 [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EDF819936;
 Mon, 24 Jun 2019 20:06:47 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-12-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <dc4268a2-8aa6-273c-1052-ca84f8468fcd@redhat.com>
Date: Mon, 24 Jun 2019 22:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624173935.25747-12-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="McOXRtVHfYklkOSczlkmtLzn6MMLF6tiU"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 20:06:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 11/14] block: Try to create well typed
 json:{} filenames
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--McOXRtVHfYklkOSczlkmtLzn6MMLF6tiU
Content-Type: multipart/mixed; boundary="NpzidxgdNTa9VJj6t27eEp6JGUoBHYy3I";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <dc4268a2-8aa6-273c-1052-ca84f8468fcd@redhat.com>
Subject: Re: [PATCH v4 11/14] block: Try to create well typed json:{}
 filenames
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-12-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-12-mreitz@redhat.com>

--NpzidxgdNTa9VJj6t27eEp6JGUoBHYy3I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.06.19 19:39, Max Reitz wrote:
> By applying qdict_flatten(), the flat-confused input visitor, and the
> output visitor, we can at least try to bring bs->full_open_options into=

> accordance with the QAPI schema.  This may not always work (there are
> some options left that have not been QAPI-fied yet), but in practice it=

> usually will.
>=20
> In any case, sometimes emitting wrongly typed json:{} filenames is
> better than doing it effectively half the time.
>=20
> This affects some iotests because json:{} filenames are now usually
> crumpled.  In 198, "format": "auto" now appears in the qcow2 encryption=

> options because going through a visitor makes optional members' default=

> values explicit.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534396
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c                    | 68 +++++++++++++++++++++++++++++++++++++-=

>  tests/qemu-iotests/059.out |  2 +-
>  tests/qemu-iotests/099.out |  4 +--
>  tests/qemu-iotests/110.out |  2 +-
>  tests/qemu-iotests/198.out |  4 +--
>  5 files changed, 73 insertions(+), 7 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index c139540f2b..d3c1041087 100644
> --- a/block.c
> +++ b/block.c
> @@ -36,6 +36,7 @@
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qnull.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qobject-input-visitor.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "sysemu/block-backend.h"
> @@ -6283,6 +6284,56 @@ static bool bdrv_backing_overridden(BlockDriverS=
tate *bs)
>      }
>  }
> =20
> +/**
> + * Take a blockdev @options QDict and convert its values to the
> + * correct type.
> + *
> + * Fail if @options does not match the QAPI schema of BlockdevOptions.=

> + *
> + * In case of failure, return NULL and set @errp.
> + *
> + * In case of success, return a correctly typed new QDict.
> + */
> +static QDict *bdrv_type_blockdev_opts(const QDict *options, Error **er=
rp)
> +{
> +    Visitor *v;
> +    BlockdevOptions *blockdev_options;
> +    QObject *typed_opts;
> +    QDict *string_options;
> +    Error *local_err =3D NULL;
> +
> +    string_options =3D qdict_clone_shallow(options);
> +
> +    qdict_flatten(string_options);
> +    v =3D qobject_input_visitor_new_flat_confused(string_options, errp=
);

Imagine a

+    qobject_unref(string_options);

here.

Max

> +    if (!v) {
> +        error_prepend(errp, "Failed to prepare options: ");
> +        return NULL;
> +    }
> +
> +    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err)=
;
> +    visit_free(v);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "Not a valid BlockdevOptions object: ");
> +        return NULL;
> +    }
> +
> +    v =3D qobject_output_visitor_new(&typed_opts);
> +    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err)=
;
> +    if (!local_err) {
> +        visit_complete(v, &typed_opts);
> +    }
> +    visit_free(v);
> +    qapi_free_BlockdevOptions(blockdev_options);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return qobject_to(QDict, typed_opts);
> +}
> +
>  /* Updates the following BDS fields:
>   *  - exact_filename: A filename which may be used for opening a block=
 device
>   *                    which (mostly) equals the given BDS (even withou=
t any
> @@ -6400,10 +6451,25 @@ void bdrv_refresh_filename(BlockDriverState *bs=
)
>      if (bs->exact_filename[0]) {
>          pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename=
);
>      } else {
> -        QString *json =3D qobject_to_json(QOBJECT(bs->full_open_option=
s));
> +        QString *json;
> +        QDict *typed_opts, *json_opts;
> +
> +        typed_opts =3D bdrv_type_blockdev_opts(bs->full_open_options, =
NULL);
> +
> +        /*
> +         * We cannot be certain that bs->full_open_options matches
> +         * BlockdevOptions, so bdrv_type_blockdev_opts() may fail.
> +         * That is not fatal, we can just emit bs->full_open_options
> +         * directly -- qemu will accept that, even if it does not
> +         * match the schema.
> +         */
> +        json_opts =3D typed_opts ?: bs->full_open_options;
> +
> +        json =3D qobject_to_json(QOBJECT(json_opts));
>          snprintf(bs->filename, sizeof(bs->filename), "json:%s",
>                   qstring_get_str(json));
>          qobject_unref(json);
> +        qobject_unref(typed_opts);
>      }
>  }
> =20
> diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
> index 4fab42a28c..53109b2d49 100644
> --- a/tests/qemu-iotests/059.out
> +++ b/tests/qemu-iotests/059.out
> @@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240
> =20
>  =3D=3D=3D Testing monolithicFlat with internally generated JSON file n=
ame =3D=3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 subformat=
=3DmonolithicFlat
> -qemu-io: can't open: Cannot use relative extent paths with VMDK descri=
ptor file 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGF=
MT"}, "driver": "blkdebug", "inject-error.0.event": "read_aio"}'
> +qemu-io: can't open: Cannot use relative extent paths with VMDK descri=
ptor file 'json:{"inject-error": [{"event": "read_aio"}], "image": {"driv=
er": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}'
> =20
>  =3D=3D=3D Testing version 3 =3D=3D=3D
>  image: TEST_DIR/iotest-version3.IMGFMT
> diff --git a/tests/qemu-iotests/099.out b/tests/qemu-iotests/099.out
> index 8cce627529..0a9c434148 100644
> --- a/tests/qemu-iotests/099.out
> +++ b/tests/qemu-iotests/099.out
> @@ -12,11 +12,11 @@ blkverify:TEST_DIR/t.IMGFMT.compare:TEST_DIR/t.IMGF=
MT
> =20
>  =3D=3D=3D Testing JSON filename for blkdebug =3D=3D=3D
> =20
> -json:{"driver": "IMGFMT", "file": {"image": {"driver": "file", "filena=
me": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "inject-error.0.event": =
"l1_update"}}
> +json:{"driver": "IMGFMT", "file": {"inject-error": [{"event": "l1_upda=
te"}], "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "dri=
ver": "blkdebug"}}
> =20
>  =3D=3D=3D Testing indirectly enforced JSON filename =3D=3D=3D
> =20
> -json:{"driver": "raw", "file": {"test": {"driver": "IMGFMT", "file": {=
"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "=
blkdebug", "inject-error.0.event": "l1_update"}}, "driver": "blkverify", =
"raw": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}
> +json:{"driver": "raw", "file": {"test": {"driver": "IMGFMT", "file": {=
"inject-error": [{"event": "l1_update"}], "image": {"driver": "file", "fi=
lename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}}, "driver": "blkveri=
fy", "raw": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}=

> =20
>  =3D=3D=3D Testing plain filename for blkdebug =3D=3D=3D
> =20
> diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
> index f60b26390e..d95b92bee7 100644
> --- a/tests/qemu-iotests/110.out
> +++ b/tests/qemu-iotests/110.out
> @@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.=
IMGFMT.base)
> =20
>  =3D=3D=3D Non-reconstructable filename =3D=3D=3D
> =20
> -image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_a=
io", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "drive=
r": "blkdebug", "set-state.0.new_state": 42}}
> +image: json:{"driver": "IMGFMT", "file": {"set-state": [{"new_state": =
42, "event": "read_aio"}], "image": {"driver": "file", "filename": "TEST_=
DIR/t.IMGFMT"}, "driver": "blkdebug"}}
>  file format: IMGFMT
>  virtual size: 64 MiB (67108864 bytes)
>  backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
> diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
> index e86b175e39..eef8af3cdc 100644
> --- a/tests/qemu-iotests/198.out
> +++ b/tests/qemu-iotests/198.out
> @@ -32,7 +32,7 @@ read 16777216/16777216 bytes at offset 0
>  16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  =3D=3D checking image base =3D=3D
> -image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
> +image: json:{"driver": "IMGFMT", "encrypt": {"format": "auto", "key-se=
cret": "sec0"}, "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT=
=2Ebase"}}
>  file format: IMGFMT
>  virtual size: 16 MiB (16777216 bytes)
>  Format specific information:
> @@ -74,7 +74,7 @@ Format specific information:
>          master key iters: 1024
> =20
>  =3D=3D checking image layer =3D=3D
> -image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
> +image: json:{"driver": "IMGFMT", "encrypt": {"format": "auto", "key-se=
cret": "sec1"}, "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT=
"}}
>  file format: IMGFMT
>  virtual size: 16 MiB (16777216 bytes)
>  backing file: TEST_DIR/t.IMGFMT.base
>=20



--NpzidxgdNTa9VJj6t27eEp6JGUoBHYy3I--

--McOXRtVHfYklkOSczlkmtLzn6MMLF6tiU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0RLVYACgkQ9AfbAGHV
z0C0qwf/aqeanLfeCmYR0byezcwLrdDNf0rvKrl133BP57HxSgolTZa6D6i2FfaB
EwlxYuBimK18/x/FsOSbkZL1qmKoC0pA4VLLX6dKVyeYIvaGAunuL1fnOuYd2LHp
fJJnprEX6a1sI6wl65X70OdsLA8XHT2pEJEATp92JBzcAkBlvsmRh0LEsMA/DLVb
ZRDKktgzgHWIn8D8tb/ys7bS01uuCAx8NGEPr3t6wkclANXz4DqgY0go8u8zXIOp
p1Fm7V8lCpfOd1doWZ/rIHlTzZd+WvqWgqnZXj579cRTqcsqRsdVtQJJztcAOQqF
tVubaCbVKV9gatDrziNdUIX9u1GobQ==
=RiJN
-----END PGP SIGNATURE-----

--McOXRtVHfYklkOSczlkmtLzn6MMLF6tiU--

