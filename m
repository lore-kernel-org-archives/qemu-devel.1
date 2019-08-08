Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F97C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A95721874
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A95721874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvhqq-0000cZ-M1
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 08:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58839)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hvhqG-00005h-JL
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hvhqF-0000W8-JQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:48:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hvhqD-0000Sf-6E; Thu, 08 Aug 2019 08:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 294DB30A00E9;
 Thu,  8 Aug 2019 12:48:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39A9960A35;
 Thu,  8 Aug 2019 12:48:22 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, kwolf@redhat.com, armbru@redhat.com
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
 <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>
 <8f43b3ab-7c90-0965-4707-9aae1be787a0@redhat.com>
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
Message-ID: <082f08e5-7c3b-9e6a-5bdb-8785158a82a7@redhat.com>
Date: Thu, 8 Aug 2019 14:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8f43b3ab-7c90-0965-4707-9aae1be787a0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9PRHFNXmprfxeEaqhZE3ip2sZ0bRjWLtv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 08 Aug 2019 12:48:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qcow2: introduce compression type
 feature
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9PRHFNXmprfxeEaqhZE3ip2sZ0bRjWLtv
Content-Type: multipart/mixed; boundary="2nJEtp54P8pTdXwmR5lM735OK5E3ohMfD";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, kwolf@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <082f08e5-7c3b-9e6a-5bdb-8785158a82a7@redhat.com>
Subject: Re: [PATCH v2 1/3] qcow2: introduce compression type feature
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
 <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>
 <8f43b3ab-7c90-0965-4707-9aae1be787a0@redhat.com>
In-Reply-To: <8f43b3ab-7c90-0965-4707-9aae1be787a0@redhat.com>

--2nJEtp54P8pTdXwmR5lM735OK5E3ohMfD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.08.19 02:09, Eric Blake wrote:
> On 8/7/19 6:12 PM, Max Reitz wrote:
>=20
>>> =20
>>> +static int check_compression_type(BDRVQcow2State *s, Error **errp)
>>> +{
>>> +    switch (s->compression_type) {
>>> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
>>> +        break;
>>> +
>>> +    default:
>>> +        error_setg(errp, "qcow2: unknown compression type: %u",
>>> +                   s->compression_type);
>>> +        return -ENOTSUP;
>>> +    }
>>> +
>>> +    /*
>>> +     * if the compression type differs from QCOW2_COMPRESSION_TYPE_Z=
LIB
>>> +     * the incompatible feature flag must be set
>>> +     */
>>> +
>>> +    if (s->compression_type !=3D QCOW2_COMPRESSION_TYPE_ZLIB &&
>>> +        !(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE=
)) {
>>> +            error_setg(errp, "qcow2: Invalid compression type settin=
g");
>>> +            return -EINVAL;
>>
>> (1) Why is this block indented twice?
>>
>> (2) Do we need this at all?  Sure, it=E2=80=99s a corruption, but do w=
e need to
>> reject the image because of it?
>=20
> Yes, because otherwise there is a high risk of some application
> misinterpreting the contents (whether an older qemu that silently
> ignores unrecognized headers, and so assumes it can decode compressed
> clusters with zlib even though the decode will only succeed with zstd,
> or can write a compressed cluster with zlib which then causes corruptio=
n
> when the newer qemu tries to read it with zstd).  The whole point of an=

> incompatible bit is to reject opening an image that can't be interprete=
d
> correctly, and where writing may break later readers.

Fair enough.

>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> Overall, I don=E2=80=99t see the purpose of this function.  I don=E2=80=
=99t see any need
>> to call it in qcow2_update_header().  And without =E2=80=9Cdoes non-zl=
ib
>> compression imply the respective incompatible flag?=E2=80=9D check, yo=
u can just
>> inline the rest (checking that we recognize the compression type) into=

>> qcow2_do_open().
>>
>=20
> Inlining may indeed be possible; the real question is whether the
> function expands later in the series to the point that inlining no
> longer makes sense.

A quick search says no.

Max


--2nJEtp54P8pTdXwmR5lM735OK5E3ohMfD--

--9PRHFNXmprfxeEaqhZE3ip2sZ0bRjWLtv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1MGhQACgkQ9AfbAGHV
z0Az+wf8CX+2WfQyUV1LULkrIeUOcqcekNkyTGDe2LWz8IuqDVClH28BU5v4j1MT
RqPjleMj6FFS4772xw9+1i1LOPNc5a2x/exAp9FNse/A7wYQD+Xtd/j+XeC2k/8b
A82bxE1NF2XTbutG/bjxdh/mNxOq0QmjIe4XpOGeE3TLN4Kdlfe411wWWoxtzM26
1XnLOYPRykhJU1H8oUkTgzJO8mS0GzMy8S9hzVLIGy58/BFjEvifRULsNlnmIisj
cm2uE2VxuNeFcg5lNoLBy40w56sDb7TDIaP+U64rT7QEwnhctKZqF2+/y0hyb35/
ftIjkvGsnsJWzsktkXdropjYWVl/XQ==
=wmOA
-----END PGP SIGNATURE-----

--9PRHFNXmprfxeEaqhZE3ip2sZ0bRjWLtv--

