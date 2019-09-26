Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C6CC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9863B21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9863B21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRgL-0005uq-Qb
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRcM-00024F-OY
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRcL-0003xy-Ab
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:07:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRcI-0003wN-W0; Thu, 26 Sep 2019 07:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAB96300CB2C;
 Thu, 26 Sep 2019 11:07:21 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96B5E5D9C9;
 Thu, 26 Sep 2019 11:07:20 +0000 (UTC)
Subject: Re: [PATCH 08/22] quorum: Store children in own structure
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-9-mreitz@redhat.com>
 <d27a4ba9-8abe-2eb6-f48c-9fc9609b9d95@virtuozzo.com>
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
Message-ID: <18063457-949c-1960-c3e4-53bc1cc83d0e@redhat.com>
Date: Thu, 26 Sep 2019 13:07:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d27a4ba9-8abe-2eb6-f48c-9fc9609b9d95@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hRIeCzGPEArXvofpzCPgaqnyaYNtCCsYb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 26 Sep 2019 11:07:22 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hRIeCzGPEArXvofpzCPgaqnyaYNtCCsYb
Content-Type: multipart/mixed; boundary="GnjtUyZetEHQNFepMfO7rHNAe6Y9y03kg"

--GnjtUyZetEHQNFepMfO7rHNAe6Y9y03kg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 15:21, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:27, Max Reitz wrote:

[...]

>> @@ -1022,8 +1028,10 @@ static void quorum_add_child(BlockDriverState *=
bs, BlockDriverState *child_bs,
>>           s->next_child_index--;
>>           goto out;
>>       }
>=20
> more context:
>      assert(s->num_children <=3D INT_MAX / sizeof(BdrvChild *));
>      if (s->num_children =3D=3D INT_MAX / sizeof(BdrvChild *) ||
>          s->next_child_index =3D=3D UINT_MAX) {
>          error_setg(errp, "Too many children");
>          return;
>      }
>=20
> here: s/BdrvChild */QuorumChild
>=20
>=20
>> -    s->children =3D g_renew(BdrvChild *, s->children, s->num_children=
 + 1);
>> -    s->children[s->num_children++] =3D child;
>> +    s->children =3D g_renew(QuorumChild, s->children, s->num_children=
 + 1);
>> +    s->children[s->num_children++] =3D (QuorumChild){
>> +        .child =3D child,
>> +    };
>>  =20
>>   out:
>>       bdrv_drained_end(bs);

[...]

>> @@ -1059,7 +1067,7 @@ static void quorum_del_child(BlockDriverState *b=
s, BdrvChild *child,
>>       /* We can safely remove this child now */
>>       memmove(&s->children[i], &s->children[i + 1],
>>               (s->num_children - i - 1) * sizeof(BdrvChild *));
>=20
> s/BdrvChild */QuorumChild/

Damn, yes to both.

I was really hoping I didn=E2=80=99t mess this patch up.

Thanks.

Max

>> -    s->children =3D g_renew(BdrvChild *, s->children, --s->num_childr=
en);
>> +    s->children =3D g_renew(QuorumChild, s->children, --s->num_childr=
en);
>>       bdrv_unref_child(bs, child);
>>  =20
>>       bdrv_drained_end(bs);
>> @@ -1100,7 +1108,7 @@ static void quorum_gather_child_options(BlockDri=
verState *bs, QDict *target,
>>  =20
>>       for (i =3D 0; i < s->num_children; i++) {
>>           qlist_append(children_list,
>> -                     qobject_ref(s->children[i]->bs->full_open_option=
s));
>> +                     qobject_ref(s->children[i].child->bs->full_open_=
options));
>>       }
>>   }
>>  =20
>>
>=20
> with my suggestions:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20



--GnjtUyZetEHQNFepMfO7rHNAe6Y9y03kg--

--hRIeCzGPEArXvofpzCPgaqnyaYNtCCsYb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Mm+cACgkQ9AfbAGHV
z0DJCAf/YBsQMIFyfC6TfVVH+zr8wJ1rlHu6yVE6uodsadiuTVLOa/vPAXofcmZ3
ZHCfTwN6XGfoMUvWRP5MAPi+AImQHlWXHCNJLZov/hn0f+LE/BucUlrcCoApdkzh
0JgsEqNyse3Ue5tdnUiChZDLpTrr0jlEO8rTz9i/FYyIJ6p7SJ/erKcMCwTXXpKv
b6anBuYa7HD9PxRaygGB/Z2YmPYzNCu6WkauyvTn/OB9YVakDsvZZKyRnoaeYW8x
60hgDf4UNCD1Tq9lQEbDB1OBj4R6NO0EZKBKi4cwbF53M2U89JfWxE95kYJ11owa
RA2JOYr4KmbfhipvRY/4XejfwUkkMA==
=C01+
-----END PGP SIGNATURE-----

--hRIeCzGPEArXvofpzCPgaqnyaYNtCCsYb--

