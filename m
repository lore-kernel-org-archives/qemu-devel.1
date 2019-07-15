Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD7C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B05A2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B05A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1Eq-0007Bl-Mq
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51581)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hn1Eg-0006kV-7K
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hn1Ef-0005t6-80
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50919)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hn1Ed-0005ri-12; Mon, 15 Jul 2019 09:41:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14E17308FB93;
 Mon, 15 Jul 2019 13:41:42 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E73D65D721;
 Mon, 15 Jul 2019 13:41:40 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190703172813.6868-1-mreitz@redhat.com>
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
Message-ID: <adfb4c1e-e704-89a8-7e9d-b10f3ab49069@redhat.com>
Date: Mon, 15 Jul 2019 15:41:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CT89GoL4WuwuGlOhTa1EQoonj0LaQabqi"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 15 Jul 2019 13:41:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: Fixes for concurrent block
 jobs
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
--CT89GoL4WuwuGlOhTa1EQoonj0LaQabqi
Content-Type: multipart/mixed; boundary="X3DKRtyCRi4XPzLTD4M30tDuzVMGwrjaY";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <adfb4c1e-e704-89a8-7e9d-b10f3ab49069@redhat.com>
Subject: Re: [PATCH v2 00/12] block: Fixes for concurrent block jobs
References: <20190703172813.6868-1-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>

--X3DKRtyCRi4XPzLTD4M30tDuzVMGwrjaY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 19:28, Max Reitz wrote:
> This is a v2 to =E2=80=9Cblock: Add BDS.never_freeze=E2=80=9D.
>=20
> It depends on my =E2=80=9Cblock: Delay poll when ending drained section=
s=E2=80=9D
> series:
>=20
> Depends-on: <20190619152603.5937-1-mreitz@redhat.com>
>=20
>=20
> It turned out that if you run 030 (or just the new test_overlapping_5
> case) sufficiently often, it breaks; which is why I=E2=80=99m hesitant =
to just
> merge the =E2=80=9Cadd never_freeze=E2=80=9D series as it is.
>=20
> There are several reasons for why this test case breaks, I hope patches=

> 3 to 6 fix them.  Patch 12 adds a test that is much more reliable than
> test_overlapping_5 at detecting the problems fixed by at least patches =
4
> to 6.  (I think that 3 doesn=E2=80=99t really need a test.)
>=20
> I=E2=80=99m sure there are other ways to see these problems, but well, =
coming
> from 030, concurrent commit/stream jobs are how I reproduced them.
> Hence the same of this series.
>=20
> Patch 2 is for something I encountered on the way.  Patch 11 tests it.

Applied patches 1, 2, 3, and 6 through 11 to my block branch.


So what remains are patches 4, 5, and 12.

For 4, I don=E2=80=99t know whether the approach is too heavy-handed (may=
be a
simple bdrv_drained_begin()/-end() would suffice), and whether it=E2=80=99=
s even
right to wrap the whole function in a drained section.  (Unless there
are objections, I=E2=80=99ll still take it for rc2.)

5 is just pretty complex, and it also depends on my other series in its
current form.  So I wouldn=E2=80=99t like to take it without any reviews.=


12 is a test that will fail without 4 and 5, so I can=E2=80=99t take it w=
ithout
those two.

Max


--X3DKRtyCRi4XPzLTD4M30tDuzVMGwrjaY--

--CT89GoL4WuwuGlOhTa1EQoonj0LaQabqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0sgpIACgkQ9AfbAGHV
z0DMmwf9GxD3+VNNAaWT96W00isCXRO2hzsAypiZBOhONPUIJE6VCCVF+S3LoGmZ
ffd/bpGnfmP19DKKdDboeTXeNVpf0fgWETpdiIBMMhOQ7Ao3lTrXC4/Xg2pX05g6
A5uJyxAgWsg8hT5kP8ggvotG4A5qpq4RKJyWXz84vDab2kRimHOUuMRDxMCg+IFm
CJeBJry3gJVB/PUwGxyNE26LXM++lrywYXA5DvevCT0MpsTr7o1e6NRFSnZ/jvKP
3JaTo6eanfm5DjXIYI0OJfbRL3iEAocRrjBBidY8JRIvv0lIFYjsknUQ+rZ961XD
sh9uJLheK+8bH583I7KNCjYXPvI94g==
=DvAA
-----END PGP SIGNATURE-----

--CT89GoL4WuwuGlOhTa1EQoonj0LaQabqi--

