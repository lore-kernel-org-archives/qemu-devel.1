Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9410AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FEB20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FEB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bpq-0007Ld-5L
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7bkT-0003DK-CP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7bkS-0006BJ-3L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33447)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7bkP-0006AP-Rk; Tue, 10 Sep 2019 04:43:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2EEDC30A922E;
 Tue, 10 Sep 2019 08:43:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 974325C21E;
 Tue, 10 Sep 2019 08:43:32 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190729213559.20913-1-jsnow@redhat.com>
 <20190729213559.20913-3-jsnow@redhat.com>
 <2466ccba-bfb9-eca6-5e40-fc7db4e66114@redhat.com>
 <1104dbc8-0535-d893-3200-07c6db964120@redhat.com>
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
Message-ID: <a5432cc7-4a4a-b5a3-62cf-5c3df774549a@redhat.com>
Date: Tue, 10 Sep 2019 10:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1104dbc8-0535-d893-3200-07c6db964120@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UmGmfnlAiuPWomoLFzTJwatlKad6Mgfzz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 10 Sep 2019 08:43:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] iotests: add protocol support to
 initialization info
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UmGmfnlAiuPWomoLFzTJwatlKad6Mgfzz
Content-Type: multipart/mixed; boundary="BZbD1RqkyGSmGwvLFy46uHvqRYXrxgbSG";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com
Message-ID: <a5432cc7-4a4a-b5a3-62cf-5c3df774549a@redhat.com>
Subject: Re: [PATCH v2 2/3] iotests: add protocol support to initialization
 info
References: <20190729213559.20913-1-jsnow@redhat.com>
 <20190729213559.20913-3-jsnow@redhat.com>
 <2466ccba-bfb9-eca6-5e40-fc7db4e66114@redhat.com>
 <1104dbc8-0535-d893-3200-07c6db964120@redhat.com>
In-Reply-To: <1104dbc8-0535-d893-3200-07c6db964120@redhat.com>

--BZbD1RqkyGSmGwvLFy46uHvqRYXrxgbSG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 20:45, John Snow wrote:
>=20
>=20
> On 9/9/19 6:09 AM, Max Reitz wrote:
>> On 29.07.19 23:35, John Snow wrote:
>>> This will add supported_protocols and unsupported_protocols to all of=

>>> iotests.main, iotests.script_main, and iotests.script_initialize.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/qemu-iotests/207        | 4 ++--
>>>  tests/qemu-iotests/210        | 4 ++--
>>>  tests/qemu-iotests/211        | 4 ++--
>>>  tests/qemu-iotests/212        | 4 ++--
>>>  tests/qemu-iotests/213        | 4 ++--
>>>  tests/qemu-iotests/iotests.py | 5 ++++-
>>>  6 files changed, 14 insertions(+), 11 deletions(-)
>>
>> Hm...  Most of the other script-style tests that do not pass
>> supported_protocols yet should probably do so, actually.  I=E2=80=99m =
fairly
>> certain most of them actually only support 'file'.
>=20
> Sounds like a follow-up patch.

Why not.  I think it fits well into this series, but either way works
for me.

> I guess the protocol information patch you talked about is not at
> origin/master yet. Can you point me to it if I need to rebase on top of=
 it?

It=E2=80=99s in Kevin=E2=80=99s branch: git://repo.or.cz/qemu/kevin.git b=
lock

Max


--BZbD1RqkyGSmGwvLFy46uHvqRYXrxgbSG--

--UmGmfnlAiuPWomoLFzTJwatlKad6Mgfzz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13YjIACgkQ9AfbAGHV
z0AW6QgAmzXjsZsxl026RSnBmioX7MrmHhN0tetwfsr4+WHI0SJ0327vv2aArZlE
yJO1xNS4/zO5g0wlsI5pN59R6gzKMj2id7wAfeuJL/CkfAEOg8TjLUZ4ATTLrjT+
HZa08/6GEfdRh99Nd8QP1JwlhqPvZsUeI3cOynC5zIYEATsU1WDYSW56oS8mevus
in2OuPx/aznRbi++iFx09BCI/emw9AvMdWUEC6UuISLXMXJALtNhbOd+KsZ42o9P
8VAEp+Y7vBCqzmSMF+3rza2pnHVfCwGVwwkQQ9/Kt4X+S3RCS9owCQ/43oPyW5Rx
V1fzfwh/CfiQYlYyy3/uYQ7dkriwbQ==
=yXOA
-----END PGP SIGNATURE-----

--UmGmfnlAiuPWomoLFzTJwatlKad6Mgfzz--

