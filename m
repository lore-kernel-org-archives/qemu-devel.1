Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9380C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0E72173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0E72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4ovm-0001Qt-JN
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 12:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4ouk-0000my-0K
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4ouj-0006ix-3A
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:10:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4oug-0006gb-Vn; Mon, 02 Sep 2019 12:10:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F1453003715;
 Mon,  2 Sep 2019 16:10:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-221.brq.redhat.com
 [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3EA95C21A;
 Mon,  2 Sep 2019 16:10:30 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-8-vsementsov@virtuozzo.com>
 <8700abe3-01a0-9395-59fb-ca78d9f05a30@redhat.com>
 <77ac0ee1-166d-fc50-f7b8-24485460b24c@virtuozzo.com>
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
Message-ID: <7abe0e0d-320a-c0b3-475c-893cebc8b8f0@redhat.com>
Date: Mon, 2 Sep 2019 18:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <77ac0ee1-166d-fc50-f7b8-24485460b24c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XMDaCbyd8ctPT15BEXNtCSSlnuEhx204e"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 02 Sep 2019 16:10:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 07/13] iotests: prepare 124 and 257
 bitmap querying for backup-top filter
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XMDaCbyd8ctPT15BEXNtCSSlnuEhx204e
Content-Type: multipart/mixed; boundary="C0Zjqx0YMkw1bDpdtqSRszdLzqf0n0iXf";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <7abe0e0d-320a-c0b3-475c-893cebc8b8f0@redhat.com>
Subject: Re: [PATCH v9 07/13] iotests: prepare 124 and 257 bitmap querying for
 backup-top filter
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-8-vsementsov@virtuozzo.com>
 <8700abe3-01a0-9395-59fb-ca78d9f05a30@redhat.com>
 <77ac0ee1-166d-fc50-f7b8-24485460b24c@virtuozzo.com>
In-Reply-To: <77ac0ee1-166d-fc50-f7b8-24485460b24c@virtuozzo.com>

--C0Zjqx0YMkw1bDpdtqSRszdLzqf0n0iXf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.08.19 15:22, Vladimir Sementsov-Ogievskiy wrote:
> 28.08.2019 19:40, Max Reitz wrote:
>> On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:

[...]

>>> +
>>> +    def get_bitmap(self, bitmaps, node_name, name, recording=3DNone)=
:
>>> +        """
>>> +        get a specific bitmap from the object returned by query_bitm=
aps.
>>> +        :param recording: If specified, filter results by the specif=
ied value.
>>> +        """
>>> +        if bitmaps is None:
>>> +            bitmaps =3D self.query_bitmaps()
>>> +
>>> +        for bitmap in bitmaps['bitmaps'][node_name]:
>>> +            if bitmap.get('name', '') =3D=3D name:
>>> +                if recording is None:
>>> +                    return bitmap
>>> +                elif bitmap.get('recording') =3D=3D recording:
>>> +                    return bitmap
>>
>> Maybe add a =E2=80=9Cbreak=E2=80=9D or =E2=80=9Creturn None=E2=80=9D h=
ere?
>>
>> (Yes, yes, you just moved existing code.  Still.)
>>
>=20
> No, as we may have several unnamed bitmaps, which should be selected by=
 "recording"..

Ah.  OK.  Now it all makes sense...

Max


--C0Zjqx0YMkw1bDpdtqSRszdLzqf0n0iXf--

--XMDaCbyd8ctPT15BEXNtCSSlnuEhx204e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1tPvUACgkQ9AfbAGHV
z0BhSQf9HWaIskAa5SitVLvLubieLjbUpjbPVfwpBBJX6765t9YL1RFGlaU0Mluz
OFUXxdJjUFhtq3Jnne56k1zXqbip7c7OVOG8ndEcJvs4FSzfGN7J087gyAkv7dl9
RAJ7WH8HhiEpqjniMlKsRJzJxQn/omKD+Jdz6ZKib9UzzPZ8dIvVF/6CQ14WU3fB
9EBV3zeEiGUL8MdLF+ueFVGMqyvvBL3pb1x2YGikLcc6cFc+W8gR6dAIz2ci+cXU
vf6mhA8WniCmrVvQuPdKj+ipHs7aAqjXsX3LrOT/3jHNeMsXSw6SZ2F/cYd1wBFL
smbL/e1jN365brjv1TzQeUwvR+XD0w==
=jnvz
-----END PGP SIGNATURE-----

--XMDaCbyd8ctPT15BEXNtCSSlnuEhx204e--

