Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E09ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313FB21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn3YJjcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313FB21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzST-0000qy-L9
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNzOr-00040M-Ed
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNzOq-0000xl-B4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:13:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNzOq-0000xZ-7K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572009183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BJLpPRUP3p6ol7UnWXCW+0KnDSYD6Jp3/hbZQJAqpD8=;
 b=Dn3YJjcnF5W77Tk8yDBjUvCdTIZlsKWSe7lUdHQPwIcYKEgualx61FzFaGp9vWlq3/dHNg
 saF0DEU5TnEHBBY9WMgw+MaYJCekv5+OkVOxUtfy3BBVd6KvMaEd1jJhvr8HeJ+qVMkbHa
 N9T8wC3hd1H8NCm2ku5UpLA42U2bcow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-IlF2IsURNlGg2F_2RsRkpg-1; Fri, 25 Oct 2019 09:12:57 -0400
X-MC-Unique: IlF2IsURNlGg2F_2RsRkpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56AD780183D;
 Fri, 25 Oct 2019 13:12:56 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E5C75C1B5;
 Fri, 25 Oct 2019 13:12:52 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] iotests: add 269 to check maximum of bitmaps in
 qcow2
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <20191014115126.15360-3-vsementsov@virtuozzo.com>
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
Message-ID: <7c9e6d62-fc5e-204e-778d-0320833e9b00@redhat.com>
Date: Fri, 25 Oct 2019 15:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014115126.15360-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nIViJQZrFgFX7fHeKpj4GQFtCPRPVZyRU"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nIViJQZrFgFX7fHeKpj4GQFtCPRPVZyRU
Content-Type: multipart/mixed; boundary="gjI5Gl8jPrO9Vrbv6beNjkwbpE1jcPryk"

--gjI5Gl8jPrO9Vrbv6beNjkwbpE1jcPryk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.19 13:51, Vladimir Sementsov-Ogievskiy wrote:
> Check that it's impossible to create more persistent bitmaps than qcow2
> supports.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/269     | 47 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/269.out |  3 +++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 51 insertions(+)
>  create mode 100755 tests/qemu-iotests/269
>  create mode 100644 tests/qemu-iotests/269.out

Is there no way to make this test any faster, e.g. by creating like
65534 bitmaps with dd and a binary blob?  (Similarly to what I do in
=E2=80=9Ciotests: Test qcow2's snapshot table handling=E2=80=9D)

This is such an edge case, but running the test took 3:46 min before
patch 1 (which I already find much too long), and 8:13 min afterwards
(on my machine).

(To be honest, if we take this test as-is, I=E2=80=99m probably just never =
going
to run it.)

Max


--gjI5Gl8jPrO9Vrbv6beNjkwbpE1jcPryk--

--nIViJQZrFgFX7fHeKpj4GQFtCPRPVZyRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2y9NMACgkQ9AfbAGHV
z0B4iQf9HtSL7ntLz01on10tO7WhcyTFaQ7g1RHfJF1fWm3FcrpH9oEsHgXB+DJL
RZquQMc8xMSx7qaWmeG14TfuJSlKht3NfLYEyd8zqzpN82H8kWLB5FDWTMBTx+ZM
ElbUZlALZrffzzIviSZfZtDAhIIrSdf+MO1gVrKvF0L4TvNyHxl1TKae9YuDZfJA
GIbP65dwIAtKMbTZcO5HRSZP3D4BxcWE0HSzQbfGq55U9qM7EicJO9JCWus60vgh
kXmtuxw0F+2Mm3x6aoKJFsAxWU36+atDW9p6w1+Bpj5QqMzKgXB6+LLxfUyvvKt2
RpzUqM7nwhF4DRno+AzQRW5Q8FTwxg==
=wpwT
-----END PGP SIGNATURE-----

--nIViJQZrFgFX7fHeKpj4GQFtCPRPVZyRU--


