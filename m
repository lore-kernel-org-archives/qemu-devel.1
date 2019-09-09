Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1494C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A1B20674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A1B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Fjn-0007rG-LE
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7Fj5-0007JS-3g
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7Fj4-0001Kh-9r
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:12:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7Fj0-0001JL-A1; Mon, 09 Sep 2019 05:12:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9631D18CB516;
 Mon,  9 Sep 2019 09:12:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0654860BE2;
 Mon,  9 Sep 2019 09:12:31 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-14-vsementsov@virtuozzo.com>
 <bcfb962a-0ca1-7f3f-1db4-5098c66a08da@redhat.com>
 <0a166308-7492-7489-be60-50e150beebc1@virtuozzo.com>
 <d0235117-87f7-2e8d-83e9-4678b5e4f1bb@redhat.com>
 <9efd8378-2e19-b3f4-e449-0d46719baebb@virtuozzo.com>
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
Message-ID: <1e9afd7e-5494-6316-0723-5634a283b9f6@redhat.com>
Date: Mon, 9 Sep 2019 11:12:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9efd8378-2e19-b3f4-e449-0d46719baebb@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aRGCOXpvRHu0oOKeotYaZzb6GxHWtUnQG"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 09 Sep 2019 09:12:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 13/13] block/backup: use backup-top
 instead of write notifiers
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
--aRGCOXpvRHu0oOKeotYaZzb6GxHWtUnQG
Content-Type: multipart/mixed; boundary="lIJt4HfDJbHxpXqqzrQIRrjVkZXsYoOhn";
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
Message-ID: <1e9afd7e-5494-6316-0723-5634a283b9f6@redhat.com>
Subject: Re: [PATCH v9 13/13] block/backup: use backup-top instead of write
 notifiers
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-14-vsementsov@virtuozzo.com>
 <bcfb962a-0ca1-7f3f-1db4-5098c66a08da@redhat.com>
 <0a166308-7492-7489-be60-50e150beebc1@virtuozzo.com>
 <d0235117-87f7-2e8d-83e9-4678b5e4f1bb@redhat.com>
 <9efd8378-2e19-b3f4-e449-0d46719baebb@virtuozzo.com>
In-Reply-To: <9efd8378-2e19-b3f4-e449-0d46719baebb@virtuozzo.com>

--lIJt4HfDJbHxpXqqzrQIRrjVkZXsYoOhn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.09.19 10:06, Vladimir Sementsov-Ogievskiy wrote:
> 02.09.2019 19:34, Max Reitz wrote:

[...]

>> I=E2=80=99m not saying that we need to abandon having BBs right now, b=
ut I think
>> there are a couple of cases which show why I say it=E2=80=99s uglier t=
han using
>> BdrvChildren instead.
>>
>=20
> OK. I'd prefer to move block-copy to BdrvChildren as follow-up, if you =
don't mind.

Yep, sure, that=E2=80=99s A-OK with me.

Max


--lIJt4HfDJbHxpXqqzrQIRrjVkZXsYoOhn--

--aRGCOXpvRHu0oOKeotYaZzb6GxHWtUnQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12F34ACgkQ9AfbAGHV
z0DO8Af+PMOwJ7v9TmBxdnroDp1+wicS9K4jynVbo0uyAnVen6QHupSoXYwSUNEe
NH+3wHHP7wryrf3wH1Fxgs2hQFXOAW/fKZpJZO/TRYp5jUbo1uOTdMbAuXlknyuW
HPj2c/P/u0Kctgagzn9jSb5A/6i31KdEQj6W94AvUsv/BSjlErp+IPNbF1BoZOo1
ghQv6bZXNgkSfpIgyWuXov8VlWPH/egO6MEK/7Dl+/b1G2KE1vNfuiwOW/xSrkei
GQjizohtdKNo3Rf2W6B34TGK4X+Y/IszBk+9q14Ls3U9LLBISlA2kFFkPzHRc5yU
kdZ7BXL2L9RUua9RV1y/ZXBws2rdOQ==
=upj+
-----END PGP SIGNATURE-----

--aRGCOXpvRHu0oOKeotYaZzb6GxHWtUnQG--

