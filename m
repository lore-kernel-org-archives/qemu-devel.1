Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5ACC31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2381B207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2381B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRr5-0005mI-A5
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36501)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbQVv-0002FN-Nk
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbQVt-0002pk-Bw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:15:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbQVn-0002l8-2z; Thu, 13 Jun 2019 10:15:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 281AC30C134C;
 Thu, 13 Jun 2019 14:15:29 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2BB75C3F8;
 Thu, 13 Jun 2019 14:15:27 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-11-mreitz@redhat.com>
 <ff13463f-04a8-d519-d61d-6766960fcddd@virtuozzo.com>
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
Message-ID: <04d99b34-8258-61ed-f5ad-04ed186e9ab7@redhat.com>
Date: Thu, 13 Jun 2019 16:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ff13463f-04a8-d519-d61d-6766960fcddd@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hejgq9E3jTZjhEMpvcAWo46GXAgsjYlse"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 13 Jun 2019 14:15:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 10/42] block: Use CAF in
 bdrv_is_encrypted()
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hejgq9E3jTZjhEMpvcAWo46GXAgsjYlse
Content-Type: multipart/mixed; boundary="705RkiYeZnZfGdrZnlux6UpTHUbP9OYOD";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <04d99b34-8258-61ed-f5ad-04ed186e9ab7@redhat.com>
Subject: Re: [PATCH v5 10/42] block: Use CAF in bdrv_is_encrypted()
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-11-mreitz@redhat.com>
 <ff13463f-04a8-d519-d61d-6766960fcddd@virtuozzo.com>
In-Reply-To: <ff13463f-04a8-d519-d61d-6766960fcddd@virtuozzo.com>

--705RkiYeZnZfGdrZnlux6UpTHUbP9OYOD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 15:16, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> bdrv_is_encrypted() should not only check the BDS's backing child, but=

>> any filtered child: If a filter's child is encrypted, the filter node
>> itself naturally is encrypted, too.  Furthermore, we need to recurse
>> down the chain.
>>
>> (CAF means child access function.)
>=20
> Hmm, so, if only one node in the backing chain is encrypted, all overla=
ys,
> filters or not are considered encrypted too? Even if all the data is in=
 top
> node and is not encrypted?
>=20
> Checked that the function is used only for reporting through
> bdrv_query_image_info, which is called from bdrv_block_device_info() (w=
hich
> loops through backings), and from collect_image_info_list(), which loop=
s through
> backings if @chain=3Dtrue.
>=20
> And collect_image_info_list() is used only in img_info(), @chain is a m=
irrored
> --backing-chain parameter..
>=20
> So, isn't it more correct to return exactly bs->encrypted in this funct=
ion? It will
> give more correct and informative results for queries for the whole cha=
in.

Hm.  Maybe? :-)

I personally feel more comfortable to report more devices as being
reported than less.  The description of @encrypted in @BlockDeviceInfo
is vague enough that we can just =E2=80=9Cmake it more precise=E2=80=9D.

You=E2=80=99re right, it does sound more useful.

Max


--705RkiYeZnZfGdrZnlux6UpTHUbP9OYOD--

--Hejgq9E3jTZjhEMpvcAWo46GXAgsjYlse
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CWn4ACgkQ9AfbAGHV
z0AHBQgAn7p1vbZrc4w29+6DqL3LhwJKHTzd0Olslaid2HsfKDTjOtWKVWd8AJtL
3CvHha2K32DRXeKv71PtY/Lbreg0xM/BdLt92YGXFIw6jHDkFkeJEE8gYnq7dIcg
9hGJ0RoV3d0YlhcWYegFVJZQUc1uUlCQ1PI2hUp2ZlCk3+RGHDJ/Zn4wsiswzgpM
mMrab3LrX4oCNsDR5LbbMCO6Uzf+VaDgQL7sv1UHZCWOdhBVpL79IvVNLxqy6VV5
AUlSh4FbExUgxLEBWhTn+FO9vJGWwcJeKkwzubDvO+6mQjs9kXMLj6dsB79VUEQV
4qFeSp/ZdnxDbZV1fy5b+VdbAlUHUw==
=AmAo
-----END PGP SIGNATURE-----

--Hejgq9E3jTZjhEMpvcAWo46GXAgsjYlse--

