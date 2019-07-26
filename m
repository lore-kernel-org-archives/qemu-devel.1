Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB7CC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0352166E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0352166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqv2e-0004yC-JZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqv2Q-0004WV-Ey
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqv2N-0000zO-R3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:53:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqv2K-0000h4-Rl; Fri, 26 Jul 2019 03:53:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F01E6307D88D;
 Fri, 26 Jul 2019 07:52:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E7355DE80;
 Fri, 26 Jul 2019 07:52:57 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-8-mreitz@redhat.com>
 <c1a6b9bc-0b5e-4b1c-38a7-6d498d10a56a@redhat.com>
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
Message-ID: <c4a77844-2043-1449-9e21-ca15de2110dc@redhat.com>
Date: Fri, 26 Jul 2019 09:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c1a6b9bc-0b5e-4b1c-38a7-6d498d10a56a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pb61SGXslW27elhQgezEZNv0sRuc0Lgc0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 26 Jul 2019 07:52:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/7] iotests: Disable 126 for some vmdk
 subformats
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pb61SGXslW27elhQgezEZNv0sRuc0Lgc0
Content-Type: multipart/mixed; boundary="Pvp0sD7qerLJ0V8bwiX9a2ar5IGBBgHcx";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c4a77844-2043-1449-9e21-ca15de2110dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] iotests: Disable 126 for some vmdk
 subformats
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-8-mreitz@redhat.com>
 <c1a6b9bc-0b5e-4b1c-38a7-6d498d10a56a@redhat.com>
In-Reply-To: <c1a6b9bc-0b5e-4b1c-38a7-6d498d10a56a@redhat.com>

--Pvp0sD7qerLJ0V8bwiX9a2ar5IGBBgHcx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 19:00, Eric Blake wrote:
> On 7/25/19 10:57 AM, Max Reitz wrote:
>> Several vmdk subformats do not work with iotest 126, so disable them.
>>
>> (twoGbMaxExtentSparse actually should work, but fixing that is a bit
>> difficult.  The problem is that the vmdk descriptor file will contain =
a
>> referenc to "image:base.vmdk", which the block layer cannot open becau=
se
>=20
> reference
>=20
>> it does not know the protocol "image".  This is not trivial to solve,
>> because I suppose real protocols like "http://" should be supported.
>> Making vmdk treat all paths with a potential protocol prefix that the
>> block layer does not recognize as plain files seems a bit weird,
>> though.  Ignoring this problem does not seem too bad.)
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/126 | 6 ++++++
>>  1 file changed, 6 insertions(+)
>=20
> Are you aiming to get any of this series in -rc3, or is it firmly 4.2
> material?

No bug fix is ever firmly -next material.  However, the bugs aren=E2=80=99=
t
regressions and not dramatic, so we don=E2=80=99t need to force it into 4=
=2E1.

If I had a strong opinion myself on where to place this series, I=E2=80=99=
d have
given it a for-4.x tag.  I didn=E2=80=99t, because I don=E2=80=99t.

Max


--Pvp0sD7qerLJ0V8bwiX9a2ar5IGBBgHcx--

--pb61SGXslW27elhQgezEZNv0sRuc0Lgc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl06sVYACgkQ9AfbAGHV
z0BWqgf9F0N5A84L3pLkdKVvpDg+j0jzuVc7Yzv4bdnlg/8IXnxivXFK9FcX2DE1
Gv8/egh8fd8L7LtNeEfDShnU9u/IAK2wODbdUM1Zfbz9WtlOzzUMfav1Ijwhw9T7
v1RHtyKOtCyPma+B2QDRnJIC6JUdL3BdhrHgPaEiyNLmLCBUUoi0WcytpYAcTAn8
DV80T+Rh+imjcBAcNH99QB3bNSkR6+csDlyzzM+689swCoJ2A6AvoaWNiHE8VwHR
jTLRuvg3/Nb0/hhqFnb1+ymvhK6vRx1TWFNYnfwt2K3ns14Bdm4fenzPaCmS+wP5
mAcYQEj3f2EV2FeBx5EboKmC6j08HA==
=SJEW
-----END PGP SIGNATURE-----

--pb61SGXslW27elhQgezEZNv0sRuc0Lgc0--

