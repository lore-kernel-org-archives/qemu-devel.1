Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90293C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A8621A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A8621A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRXj-0005Z0-DD
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRWB-0004vy-PT
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRW8-0006yg-H5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRVs-0006aK-0x; Thu, 26 Sep 2019 07:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1437018C4269;
 Thu, 26 Sep 2019 11:00:43 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 250A91001DE4;
 Thu, 26 Sep 2019 11:00:38 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] blkdebug: Allow taking/unsharing permissions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190923115728.28250-1-mreitz@redhat.com>
 <20190923115728.28250-3-mreitz@redhat.com>
 <a51238ad-bfac-32eb-1b1e-05f526181e07@virtuozzo.com>
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
Message-ID: <8ec11c5e-6a41-d116-7bcb-6ac2ea16493d@redhat.com>
Date: Thu, 26 Sep 2019 13:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <a51238ad-bfac-32eb-1b1e-05f526181e07@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pLEfPiKoP43LQGORNfpTfPaHivhYMEqYq"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 26 Sep 2019 11:00:43 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pLEfPiKoP43LQGORNfpTfPaHivhYMEqYq
Content-Type: multipart/mixed; boundary="5u1ezOTgv7mz1aNi7ZCOMVWsWY1p1oUlJ"

--5u1ezOTgv7mz1aNi7ZCOMVWsWY1p1oUlJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 12:12, Vladimir Sementsov-Ogievskiy wrote:
> 23.09.2019 14:57, Max Reitz wrote:
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
>>   qapi/block-core.json |  14 +++++-
>>   block/blkdebug.c     | 106 +++++++++++++++++++++++++++++++++++++++++=
+-
>>   2 files changed, 118 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index b5cd00c361..572c5756f1 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3394,6 +3394,16 @@
>>   #
>>   # @set-state:       array of state-change descriptions
>>   #
>> +# @take-child-perms: Permissions to take on @image in addition to wha=
t
>> +#                    is necessary anyway (which depends on how the
>> +#                    blkdebug node is used).  Defaults to none.
>> +#                    (since 4.2)
>> +#
>> +# @unshare-child-perms: Permissions not to share on @image in additio=
n
>> +#                       to what cannot be shared anyway (which depend=
s
>> +#                       on how the blkdebug node is used).  Defaults
>> +#                       to none.  (since 4.2)
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'struct': 'BlockdevOptionsBlkdebug',
>> @@ -3403,7 +3413,9 @@
>>               '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
>>               '*opt-discard': 'int32', '*max-discard': 'int32',
>>               '*inject-error': ['BlkdebugInjectErrorOptions'],
>> -            '*set-state': ['BlkdebugSetStateOptions'] } }
>> +            '*set-state': ['BlkdebugSetStateOptions'],
>> +            '*take-child-perms': ['BlockPermission'],
>> +            '*unshare-child-perms': ['BlockPermission'] } }
>>  =20
>>   ##
>>   # @BlockdevOptionsBlklogwrites:
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 5ae96c52b0..f3c1e4ad7b 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -28,9 +28,11 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/config-file.h"
>>   #include "block/block_int.h"
>> +#include "block/qdict.h"
>>   #include "qemu/module.h"
>>   #include "qemu/option.h"
>>   #include "qapi/qmp/qdict.h"
>> +#include "qapi/qmp/qlist.h"
>>   #include "qapi/qmp/qstring.h"
>>   #include "sysemu/qtest.h"
>>  =20
>> @@ -44,6 +46,9 @@ typedef struct BDRVBlkdebugState {
>>       uint64_t opt_discard;
>>       uint64_t max_discard;
>>  =20
>> +    uint64_t take_child_perms;
>> +    uint64_t unshare_child_perms;
>> +
>>       /* For blkdebug_refresh_filename() */
>>       char *config_file;
>>  =20
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
>> +        BlockPermission perm_bit;
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
>> +        perm_bit =3D qapi_enum_parse(&BlockPermission_lookup, perm_na=
me,
>> +                                   BLOCK_PERMISSION__MAX, errp);
>> +        if (perm_bit =3D=3D BLOCK_PERMISSION__MAX) {
>> +            ret =3D -EINVAL;
>> +            goto out;
>> +        }
>> +
>> +        *dest |=3D UINT64_C(1) << perm_bit;
>> +    }
>=20
>=20
> I still think that parsing it all by hand is a bad idea. We already hav=
e
> functions which does it, why to opencode? The following works for me:

Ah, yes.  I don=E2=80=99t know why I didn=E2=80=99t think of just using a=
 visitor for
the crumpled sub-QDict.  Will do, thanks.

Max


--5u1ezOTgv7mz1aNi7ZCOMVWsWY1p1oUlJ--

--pLEfPiKoP43LQGORNfpTfPaHivhYMEqYq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2MmlUACgkQ9AfbAGHV
z0DJWQf/aI8Ih0wOKD0v/Xmwka0VYdjQQh8HaUkfHDs+ny0yKFVqrvf27I18CaXd
gt+ZT26nEcwNZ9v/k16ZIBBTu4tfPZxRSarbRucV09SVRVmHkhven3J899rQtJSe
MlZl23MQBIvllYc5+pgKPXZfHKNgVEwPvoNNdptakiiM9KC/p4CHUPKY+ui5QDz5
H3JzB3JfT/+EF8xuc6MyuMJPkEmU6ImVceVPZPOjI5tUR6s0wQxAoFwhNGqXqchl
X+Dc0dDQFgvEqkCGzj+7EGd5B/ITCmOUjwh459aYBUQiatMssJinjt7rcWMT6bD9
vCoN5MCeqPbBhOjiUQ9lC1j45WSxxA==
=1jgn
-----END PGP SIGNATURE-----

--pLEfPiKoP43LQGORNfpTfPaHivhYMEqYq--

