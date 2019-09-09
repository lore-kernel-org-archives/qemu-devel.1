Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC9C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C1D2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C1D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Eev-0007Ak-GG
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 04:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7EdV-0006GX-GO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7EdU-0001mK-Ck
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:02:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7EdR-0001ke-MZ; Mon, 09 Sep 2019 04:02:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E18D464D28;
 Mon,  9 Sep 2019 08:02:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55EAC5D9D6;
 Mon,  9 Sep 2019 08:02:51 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-10-mreitz@redhat.com>
 <20190905130501.GA4911@localhost.localdomain>
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
Message-ID: <e2d1cd43-cfac-32cd-cfb7-1ebd2dcc5091@redhat.com>
Date: Mon, 9 Sep 2019 10:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905130501.GA4911@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7wDI6qvLtSwQoYAGAKFAhfCYGfaIGH87F"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 09 Sep 2019 08:02:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 09/42] block: Include filters when
 freezing backing chain
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
--7wDI6qvLtSwQoYAGAKFAhfCYGfaIGH87F
Content-Type: multipart/mixed; boundary="BGkG9ySXLKiH30LGO0M0HMcEQBEBQtJuQ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e2d1cd43-cfac-32cd-cfb7-1ebd2dcc5091@redhat.com>
Subject: Re: [PATCH v6 09/42] block: Include filters when freezing backing
 chain
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-10-mreitz@redhat.com>
 <20190905130501.GA4911@localhost.localdomain>
In-Reply-To: <20190905130501.GA4911@localhost.localdomain>

--BGkG9ySXLKiH30LGO0M0HMcEQBEBQtJuQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.09.19 15:05, Kevin Wolf wrote:
> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>> In order to make filters work in backing chains, the associated
>> functions must be able to deal with them and freeze all filter links, =
be
>> they COW or R/W filter links.
>>
>> In the process, rename these functions to reflect that they now act on=

>> generalized chains of filter nodes instead of backing chains alone.
>=20
> I don't think this is a good idea. The functions are still following th=
e
> backing chain. A generic "chain" could mean following the bs->file link=
s
> or any other children, so the new name is confusing because it doesn't
> really tell you any more what the function does. I'd prefer the name to=

> stay specific.
They=E2=80=99re following backing chains, among others.

It would make sense to rename s/backing_chain/filter_chain/, that is, in
case you don=E2=80=98t find lumping COW and R/W filters together under =E2=
=80=9Cfilter=E2=80=9D
too offensive.

(Naming things is hard.  I=E2=80=99m open for suggestions, but I found th=
e
=E2=80=9Cfilter=E2=80=9D concept succinct, even if it does not fully alig=
n with our
existing parlance.)

Max

>> While at it, add some comments that note which functions require their=

>> caller to ensure that a given child link is not frozen, and how the
>> callers do so.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Kevin
>=20



--BGkG9ySXLKiH30LGO0M0HMcEQBEBQtJuQ--

--7wDI6qvLtSwQoYAGAKFAhfCYGfaIGH87F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12BykACgkQ9AfbAGHV
z0BBOAf/a++65CyI5oeYZj6uQQIGnPzcXNuNNdB/z4zlYMy7EB6ciGB5cK4AVuYu
oaa7JvDK8g24NYQzVvacR+yns83dZm9kqQzU37/alaQcJdgvKLFbO/LQA4rGrUgG
KaNBpJUNvLSeOtq5uwYI5YpDnAMIBfadOXUvBtVTcS+Oki6UtBkxEA+qJ8UODIHb
QhS7qVsqWWVF6Q0m5R1fCaBGTV0dQ0FkVbF//SHq67P0/WQnz6vUbLQkh7TK7Zq7
HdvmSHyTos2LYTs7K0kYh2ZpAknWCRFrYgL9JULzyqZtZwzm2GPlXZKX9Cc6WrJG
PmJ/nTuap/WbXbMnMNIj+3lWDdLgWQ==
=t0HO
-----END PGP SIGNATURE-----

--7wDI6qvLtSwQoYAGAKFAhfCYGfaIGH87F--

