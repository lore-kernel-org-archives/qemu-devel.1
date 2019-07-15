Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E645DC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AC0214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AC0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwV9-0008BU-TW
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 04:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hmwUy-0007mm-M7
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hmwUw-0007I5-5P
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hmwUs-0007El-Rg; Mon, 15 Jul 2019 04:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68C575AFE3;
 Mon, 15 Jul 2019 08:38:09 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E5F819C59;
 Mon, 15 Jul 2019 08:38:07 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
References: <20190711150940.17483-1-mlevitsk@redhat.com>
 <20190711162740.5p7znt5ernlw67nx@steredhat>
 <28c82479b79d6280b598ebace4a218e7e6bfa8f4.camel@redhat.com>
 <20190715083031.jdy5hujqibf5gx2h@steredhat>
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
Message-ID: <f3a4ab3d-6b2a-ef1e-8878-96ac5a066142@redhat.com>
Date: Mon, 15 Jul 2019 10:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715083031.jdy5hujqibf5gx2h@steredhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RSOB3S869TmSctr4suoY7YlbrqbHlKPQo"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 15 Jul 2019 08:38:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] LUKS: support preallocation
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RSOB3S869TmSctr4suoY7YlbrqbHlKPQo
Content-Type: multipart/mixed; boundary="8jYNhyPEiGm5bn149Rsk5VAqeuj2AOYIM";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <f3a4ab3d-6b2a-ef1e-8878-96ac5a066142@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3] LUKS: support preallocation
References: <20190711150940.17483-1-mlevitsk@redhat.com>
 <20190711162740.5p7znt5ernlw67nx@steredhat>
 <28c82479b79d6280b598ebace4a218e7e6bfa8f4.camel@redhat.com>
 <20190715083031.jdy5hujqibf5gx2h@steredhat>
In-Reply-To: <20190715083031.jdy5hujqibf5gx2h@steredhat>

--8jYNhyPEiGm5bn149Rsk5VAqeuj2AOYIM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.07.19 10:30, Stefano Garzarella wrote:
> On Sun, Jul 14, 2019 at 05:51:51PM +0300, Maxim Levitsky wrote:
>> On Thu, 2019-07-11 at 18:27 +0200, Stefano Garzarella wrote:
>>> On Thu, Jul 11, 2019 at 06:09:40PM +0300, Maxim Levitsky wrote:
>>>> preallocation=3Doff and preallocation=3Dmetadata
>>>> both allocate luks header only, and preallocation=3Dfalloc/full
>>>> is passed to underlying file.
>>>>
>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
>>>>
>>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>>>
>>>> ---
>>>>
>>>> Note that QMP support was only compile tested, since I am still lear=
ning
>>>> on how to use it.
>>>>
>>>> If there is some library/script/etc which makes it more high level,
>>>> I would more that glad to hear about it. So far I used the qmp-shell=

>>>>
>>>> Also can I use qmp's blockdev-create outside a vm running?
>>>>
>>>>  block/crypto.c       | 29 ++++++++++++++++++++++++++---
>>>>  qapi/block-core.json |  5 ++++-
>>>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/block/crypto.c b/block/crypto.c
>>>> index 8237424ae6..034a645652 100644
>>>> --- a/block/crypto.c
>>>> +++ b/block/crypto.c
>>>> @@ -74,6 +74,7 @@ static ssize_t block_crypto_read_func(QCryptoBlock=
 *block,
>>>>  struct BlockCryptoCreateData {
>>>>      BlockBackend *blk;
>>>>      uint64_t size;
>>>> +    PreallocMode prealloc;
>>>>  };
>>>> =20
>>>> =20
>>>> @@ -112,7 +113,7 @@ static ssize_t block_crypto_init_func(QCryptoBlo=
ck *block,
>>>>       * available to the guest, so we must take account of that
>>>>       * which will be used by the crypto header
>>>>       */
>>>> -    return blk_truncate(data->blk, data->size + headerlen, PREALLOC=
_MODE_OFF,
>>>> +    return blk_truncate(data->blk, data->size + headerlen, data->pr=
ealloc,
>>>>                          errp);
>>>>  }
>>>> =20
>>>> @@ -251,6 +252,7 @@ static int block_crypto_open_generic(QCryptoBloc=
kFormat format,
>>>>  static int block_crypto_co_create_generic(BlockDriverState *bs,
>>>>                                            int64_t size,
>>>>                                            QCryptoBlockCreateOptions=
 *opts,
>>>> +                                          PreallocMode prealloc,
>>>>                                            Error **errp)
>>>>  {
>>>>      int ret;
>>>> @@ -266,9 +268,14 @@ static int block_crypto_co_create_generic(Block=
DriverState *bs,
>>>>          goto cleanup;
>>>>      }
>>>> =20
>>>> +    if (prealloc =3D=3D PREALLOC_MODE_METADATA) {
>>>> +        prealloc =3D PREALLOC_MODE_OFF;
>>>> +    }
>>>> +
>>>>      data =3D (struct BlockCryptoCreateData) {
>>>>          .blk =3D blk,
>>>>          .size =3D size,
>>>> +        .prealloc =3D prealloc,
>>>>      };
>>>> =20
>>>>      crypto =3D qcrypto_block_create(opts, NULL,
>>>> @@ -500,6 +507,7 @@ block_crypto_co_create_luks(BlockdevCreateOption=
s *create_options, Error **errp)
>>>>      BlockdevCreateOptionsLUKS *luks_opts;
>>>>      BlockDriverState *bs =3D NULL;
>>>>      QCryptoBlockCreateOptions create_opts;
>>>> +    PreallocMode preallocation =3D PREALLOC_MODE_OFF;
>>>>      int ret;
>>>> =20
>>>>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_LUKS);
>>>> @@ -515,8 +523,11 @@ block_crypto_co_create_luks(BlockdevCreateOptio=
ns *create_options, Error **errp)
>>>>          .u.luks =3D *qapi_BlockdevCreateOptionsLUKS_base(luks_opts)=
,
>>>>      };
>>>> =20
>>>> +    if (luks_opts->has_preallocation)
>>>> +        preallocation =3D luks_opts->preallocation;
>>>> +
>>>>      ret =3D block_crypto_co_create_generic(bs, luks_opts->size, &cr=
eate_opts,
>>>> -                                         errp);
>>>> +                                         preallocation, errp);
>>>>      if (ret < 0) {
>>>>          goto fail;
>>>>      }
>>>> @@ -534,12 +545,24 @@ static int coroutine_fn block_crypto_co_create=
_opts_luks(const char *filename,
>>>>      QCryptoBlockCreateOptions *create_opts =3D NULL;
>>>>      BlockDriverState *bs =3D NULL;
>>>>      QDict *cryptoopts;
>>>> +    PreallocMode prealloc;
>>>> +    char *buf =3D NULL;
>>>>      int64_t size;
>>>>      int ret;
>>>> +    Error *local_err =3D NULL;
>>>> =20
>>>>      /* Parse options */
>>>>      size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
>>>> =20
>>>> +    buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
>>>> +    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
>>>> +                               PREALLOC_MODE_OFF, &local_err);
>>>> +    g_free(buf);
>>>> +    if (local_err) {
>>>> +        error_propagate(errp, local_err);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>>      cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
>>>>                                               &block_crypto_create_o=
pts_luks,
>>>>                                               true);
>>>> @@ -565,7 +588,7 @@ static int coroutine_fn block_crypto_co_create_o=
pts_luks(const char *filename,
>>>>      }
>>>> =20
>>>>      /* Create format layer */
>>>> -    ret =3D block_crypto_co_create_generic(bs, size, create_opts, e=
rrp);
>>>> +    ret =3D block_crypto_co_create_generic(bs, size, create_opts, p=
realloc, errp);
>>>>      if (ret < 0) {
>>>>          goto fail;
>>>>      }
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 0d43d4f37c..ebcfc9f903 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -4205,13 +4205,16 @@
>>>>  #
>>>>  # @file             Node to create the image format on
>>>>  # @size             Size of the virtual disk in bytes
>>>> +# @preallocation    Preallocation mode for the new image (default: =
off;
>>>> +#                   allowed values: off/falloc/full
>>>
>>> Should we add also "metadata" to allowed values? and "since: 4.2"?
>>> I'd like to have (just to have similar documentation with others
>>> preallocation parameters):
>>
>> It it support but preallocation=3Doff is the same as preallocation=3Dm=
etadata in luks,
>> as luks only metadata is the header which is created anyway.
>> In some sense I should throw a error for preallocation=3Doff, but I su=
spect that
>> that will break userspace api.
>> What do you think?
>=20
> I don't know very well the details, but I agree with you that some
> user APIs could expect that preallocation=3Doff is always available.
>=20
> Maybe we can write something in the comment (explaining that off and me=
tadata
> are the same) and make the preallocation=3Dmetadata the default choice.=


preallocation=3Doff does not mean =E2=80=9CDo not allocate any metadata=E2=
=80=9D.  For
example, qcow2 still creates the qcow2 header and a minimal refcount
structure.  It just means not to allocate any unnecessary metadata.

For LUKS, all metadata is necessary, so preallocation=3Doff and
preallocation=3Dmetadata are the same.  I don=E2=80=98t think that means =
we only
need to support one or the other.  I think just making
preallocation=3Dmetadata an alias for preallocation=3Doff here is fine =E2=
=80=93 and
preallocation=3Doff should stay the default, because it=E2=80=99s the def=
ault for
everything else.

Max


--8jYNhyPEiGm5bn149Rsk5VAqeuj2AOYIM--

--RSOB3S869TmSctr4suoY7YlbrqbHlKPQo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0sO2wACgkQ9AfbAGHV
z0DrsQf/a1AkKFEGjNgKfXDr/GbBMs9PTOvt3FXyJesTPdp2CzfPyopmyon4kYTW
fAj1fHg1lJB7qYK8twKQjNvCBLlyUDZNJiV3SgeAGcM/rFGnHZaH+aVn2Xc6liLt
/NWLlAhj6eOm727dSL9u9KwgEjek83b7UGR0Uf35lzl6+TrNJK+/jFCp5o7ro6hl
nFYiQKRbxiz/jcBESzQlF9tfyuOZ/NRSHSBzWwIyC52+H8HrUv5k9V6iRziFMKa8
U2J5Z7GAcWcXy/xIB6PDvxMjmVh42nLEM3Ar9Ucgw5jLmht97+z6z+PuMriS50CP
jM5b9ZcP4Y16eXUg7MTsWW3B3PkDRA==
=g4M7
-----END PGP SIGNATURE-----

--RSOB3S869TmSctr4suoY7YlbrqbHlKPQo--

