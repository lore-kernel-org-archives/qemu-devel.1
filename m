Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724BEECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4434B21A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4434B21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7w1n-0003VC-FU
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7w0r-0002jX-5a
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7w0q-0002fa-3u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:21:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7w0n-0002cG-T4; Wed, 11 Sep 2019 02:21:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A64F3082B02;
 Wed, 11 Sep 2019 06:21:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-94.ams2.redhat.com
 [10.36.116.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A67E65C21E;
 Wed, 11 Sep 2019 06:21:49 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-24-mreitz@redhat.com>
 <20190910150241.GJ4446@localhost.localdomain>
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
Message-ID: <bff21e00-96ea-47bd-3411-ac5d71b8e513@redhat.com>
Date: Wed, 11 Sep 2019 08:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910150241.GJ4446@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="myHKyDAxXlc4PcvsFb4SFoMxmtGn4Aud7"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 11 Sep 2019 06:21:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 23/42] blockdev: Use CAF in
 external_snapshot_prepare()
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--myHKyDAxXlc4PcvsFb4SFoMxmtGn4Aud7
Content-Type: multipart/mixed; boundary="p9PtTpMyHYC89agw1KAShYkZ4YPpKE9lX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bff21e00-96ea-47bd-3411-ac5d71b8e513@redhat.com>
Subject: Re: [PATCH v6 23/42] blockdev: Use CAF in external_snapshot_prepare()
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-24-mreitz@redhat.com>
 <20190910150241.GJ4446@localhost.localdomain>
In-Reply-To: <20190910150241.GJ4446@localhost.localdomain>

--p9PtTpMyHYC89agw1KAShYkZ4YPpKE9lX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 17:02, Kevin Wolf wrote:
> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>> This allows us to differentiate between filters and nodes with COW
>> backing files: Filters cannot be used as overlays at all (for this
>> function).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Didn't we occasionally advertise blockdev-snapshot as the way to insert=

> filters on top at runtime?

I can only remember advertising for it as the only graph manipulation
tool we had, and maybe saying =E2=80=9CWe=E2=80=99d want something like
blockdev-snapshot for filters, too=E2=80=9D.

Max

> Though it seems it has always only worked for
> filters that use bs->backing, among which I think there aren't any
> user-creatable ones. So we're probably good.
>=20
> Kevin
>=20
>>  blockdev.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 29c6c6044a..c540802127 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1664,7 +1664,12 @@ static void external_snapshot_prepare(BlkAction=
State *common,
>>          goto out;
>>      }
>> =20
>> -    if (state->new_bs->backing !=3D NULL) {
>> +    if (state->new_bs->drv->is_filter) {
>> +        error_setg(errp, "Filters cannot be used as overlays");
>> +        goto out;
>> +    }
>> +
>> +    if (bdrv_filtered_cow_child(state->new_bs)) {
>>          error_setg(errp, "The overlay already has a backing image");
>>          goto out;
>>      }
>> --=20
>> 2.21.0
>>



--p9PtTpMyHYC89agw1KAShYkZ4YPpKE9lX--

--myHKyDAxXlc4PcvsFb4SFoMxmtGn4Aud7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl14knsACgkQ9AfbAGHV
z0DJ/wgAj/B3q2kDwaM72wGdtSLE2FWURyQ482/hODFJQglq9IqiXXy/AWKtKqoR
/bylE8EyxR1bv180klhOLwDmp2+QT+fkxnqPBQkxT6xCNVZuyJ8XT2gRk7hovtGL
Stj4elBG+CvedeuAkzRgU/RMwcw0VzZltUWiv028nSfVACddhkJ40+x8WXglf4w8
dGtQHuBXjhsBp1rieGuOpzIV9l6q24lT6S63sBF3qIQf1wCuAVn6ESKD9zX7S8TQ
Rv2IXEW21dKRxyzdZD+eYRKBgE2on2sl4rAHXy9vgS7XVU679AvcQvRJ/5SndOXM
NCERc5TJLdlNGgw0HwLEdM50t896fA==
=/qrC
-----END PGP SIGNATURE-----

--myHKyDAxXlc4PcvsFb4SFoMxmtGn4Aud7--

