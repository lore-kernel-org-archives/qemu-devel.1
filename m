Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE3C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DF6206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DF6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzdq-0003pN-HX
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAzca-0002ym-FE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAzcZ-0000mu-2Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAzcS-0000ib-4J; Thu, 19 Sep 2019 12:49:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08D3489F39E;
 Thu, 19 Sep 2019 16:49:23 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF93A5D6B0;
 Thu, 19 Sep 2019 16:49:18 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 2/4] blkdebug: Allow taking/unsharing
 permissions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-3-mreitz@redhat.com>
 <79ab5656-5845-2c4c-6802-2be22baf56d9@virtuozzo.com>
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
Message-ID: <84586806-87cf-0024-f583-d4ef9fde2212@redhat.com>
Date: Thu, 19 Sep 2019 18:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <79ab5656-5845-2c4c-6802-2be22baf56d9@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KlTQZIQT6SmARryzICoe3Uf7oXl87uNfV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 19 Sep 2019 16:49:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KlTQZIQT6SmARryzICoe3Uf7oXl87uNfV
Content-Type: multipart/mixed; boundary="oVKypTwqEddhAYwn81DNNj1MigTFVrVzk";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <84586806-87cf-0024-f583-d4ef9fde2212@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] blkdebug: Allow taking/unsharing
 permissions
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-3-mreitz@redhat.com>
 <79ab5656-5845-2c4c-6802-2be22baf56d9@virtuozzo.com>
In-Reply-To: <79ab5656-5845-2c4c-6802-2be22baf56d9@virtuozzo.com>

--oVKypTwqEddhAYwn81DNNj1MigTFVrVzk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 18:01, Vladimir Sementsov-Ogievskiy wrote:
> 12.09.2019 16:56, Max Reitz wrote:
>> Sometimes it is useful to be able to add a node to the block graph tha=
t
>> takes or unshare a certain set of permissions for debugging purposes.
>> This patch adds this capability to blkdebug.
>>
>> (Note that you cannot make blkdebug release or share permissions that =
it
>> needs to take or cannot share, because this might result in assertion
>> failures in the block layer.  But if the blkdebug node has no parents,=

>> it will not take any permissions and share everything by default, so y=
ou
>> can then freely choose what permissions to take and share.)
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   qapi/block-core.json |  29 +++++++++++-
>>   block/blkdebug.c     | 106 +++++++++++++++++++++++++++++++++++++++++=
+-
>>   2 files changed, 133 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index e6edd641f1..336043e02c 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3347,6 +3347,21 @@
>>               '*state': 'int',
>>               'new_state': 'int' } }
>>  =20
>> +##
>> +# @BlockdevPermission:
>> +#
>> +# Permissions that an edge in the block graph can take or share.
>> +#
>> +# Since: 4.2
>> +##
>> +{ 'enum': 'BlockdevPermission',
>> +  'data': [
>> +      'consistent-read',
>> +      'write',
>> +      'write-unchanged',
>> +      'resize',
>> +      'graph-mod' ] }
>=20
> :)
>=20
> BlockPermission is already here since 4.0 and has exactly same content.=
 (And better documented)

Oops.  Very good, then, thanks. :-)

[...]

>> @@ -344,6 +349,84 @@ static void blkdebug_parse_filename(const char *f=
ilename, QDict *options,
>>       qdict_put_str(options, "x-image", filename);
>>   }
>>  =20
>> +static int blkdebug_parse_perm_list(uint64_t *dest, QDict *options,
>> +                                    const char *prefix, Error **errp)=

>> +{
>> +    int ret =3D 0;
>> +    QDict *subqdict =3D NULL;
>> +    QObject *crumpled_subqdict =3D NULL;
>> +    QList *perm_list;
>> +    const QListEntry *perm;
>> +
>> +    qdict_extract_subqdict(options, &subqdict, prefix);
>> +    if (!qdict_size(subqdict)) {
>> +        goto out;
>> +    }
>> +
>> +    crumpled_subqdict =3D qdict_crumple(subqdict, errp);
>> +    if (!crumpled_subqdict) {
>> +        ret =3D -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    perm_list =3D qobject_to(QList, crumpled_subqdict);
>> +    if (!perm_list) {
>> +        /* Omit the trailing . from the prefix */
>> +        error_setg(errp, "%.*s expects a list",
>> +                   (int)(strlen(prefix) - 1), prefix);
>> +        ret =3D -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    for (perm =3D qlist_first(perm_list); perm; perm =3D qlist_next(p=
erm)) {
>> +        const char *perm_name;
>> +        BlockdevPermission perm_bit;
>> +
>> +        perm_name =3D qstring_get_try_str(qobject_to(QString, perm->v=
alue));
>> +        if (!perm_name) {
>> +            /* Omit the trailing . from the prefix */
>> +            error_setg(errp, "%.*s expects a list of enum strings",
>> +                       (int)(strlen(prefix) - 1), prefix);
>> +            ret =3D -EINVAL;
>> +            goto out;
>> +        }
>> +
>> +        perm_bit =3D qapi_enum_parse(&BlockdevPermission_lookup, perm=
_name,
>> +                                   BLOCKDEV_PERMISSION__MAX, errp);
>> +        if (perm_bit =3D=3D BLOCKDEV_PERMISSION__MAX) {
>> +            ret =3D -EINVAL;
>> +            goto out;
>> +        }
>> +
>> +        *dest |=3D UINT64_C(1) << perm_bit;
>> +    }
>> +
>> +out:
>> +    qobject_unref(subqdict);
>> +    qobject_unref(crumpled_subqdict);
>> +    return ret;
>> +}
>> +
>> +static int blkdebug_parse_perms(BDRVBlkdebugState *s, QDict *options,=

>> +                                Error **errp)
>> +{
>> +    int ret;
>> +
>> +    ret =3D blkdebug_parse_perm_list(&s->take_child_perms, options,
>> +                                   "take-child-perms.", errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    ret =3D blkdebug_parse_perm_list(&s->unshare_child_perms, options=
,
>> +                                   "unshare-child-perms.", errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>=20
>=20
> It's a pity that being described in json, these new parameters still no=
t parsed automatically..

That would require changing the whole bdrv_open() infrastructure to use
QAPI types.

>> +
>>   static QemuOptsList runtime_opts =3D {
>=20
> and that we have to keep these runtime_opts everywhere, which duplicate=
s json definitions..

Well, it duplicates some json definitions.  I don=E2=80=99t add the new
parameters added in this patch to the list, because there is no point in
supporting them outside of blockdev-add.

Max


--oVKypTwqEddhAYwn81DNNj1MigTFVrVzk--

--KlTQZIQT6SmARryzICoe3Uf7oXl87uNfV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2DsY0ACgkQ9AfbAGHV
z0DaaAf/U7F57MITloX1ou5d7F4y03deV2kYFoPB0SoSpQ7EjiH9m/hPgyBVODx5
HjwBk00Ka2L9hWIG5x1x6q9f+X5udz9oiTTRunUkAHCriperY1kIEiGqOIHh8orF
ekUkqBavKvGAWnJL+BJ8OaIoHzvhdNfEQJ1pyNyxSkrl8EI7PWwBH0sc3oUuWg4W
WNwhfWnoyH1yvHuQNUQQBpnhBa4dy9Z/ZD4FAaJMk1taR76lDLD11p25S0Sk3yQi
PV94l5nYVYrSo0T+cA8ItNnGX59asfwr5MjpcpcuNz3G4NZ2CNCfEBz4zDGSS05C
fZYnkqt4GvikrerAfsIy2kpOPJVqpg==
=yXoM
-----END PGP SIGNATURE-----

--KlTQZIQT6SmARryzICoe3Uf7oXl87uNfV--

