Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A5FC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52AD20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52AD20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCKA-0002dF-Uj
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51473)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBmp-0002RJ-8G
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBmo-0006cD-6D
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:32:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBmj-0006QI-K3; Wed, 12 Jun 2019 18:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A631F30C31AD;
 Wed, 12 Jun 2019 22:32:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6514D5D6A6;
 Wed, 12 Jun 2019 22:31:59 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190612220839.1374-1-mreitz@redhat.com>
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
Message-ID: <5f8b48f2-7671-cc9f-9701-a25800753146@redhat.com>
Date: Thu, 13 Jun 2019 00:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612220839.1374-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KlJNKz1TBMVvVRg2UgP6OGaHArpmbKJ8z"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 22:32:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] vl: Drain before (block) job cancel
 when quitting
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KlJNKz1TBMVvVRg2UgP6OGaHArpmbKJ8z
Content-Type: multipart/mixed; boundary="14NzCVemONeWwe3Qhub2rVfO7DOFBv7OY";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <5f8b48f2-7671-cc9f-9701-a25800753146@redhat.com>
Subject: Re: [PATCH 0/2] vl: Drain before (block) job cancel when quitting
References: <20190612220839.1374-1-mreitz@redhat.com>
In-Reply-To: <20190612220839.1374-1-mreitz@redhat.com>

--14NzCVemONeWwe3Qhub2rVfO7DOFBv7OY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 00:08, Max Reitz wrote:
> Quitting qemu should lead to qemu exiting pretty much immediately.  Tha=
t
> means if you have a block job running on a throttled block node, the
> node should ignore its throttling and the job should be cancelled
> immediately.
>=20
> Unfortunately, that is not what happens.  Currently, the node will be
> drained (with a bdrv_drain_all()), and then again unquiesced (because
> bdrv_drain_all() ends).  Then, the block job is cancelled; but at this
> point, the node is no longer drained, so it will block, as it befits a
> throttling node.
>=20
> To fix this issue, we have to keep all nodes drained while we cancel al=
l
> block jobs when quitting qemu.  This will make the throttle node ignore=

> its throttling and thus let the block job cancel immediately.

I forgot to mention: This series depends on =E2=80=9Cblock: Keep track of=
 parent
quiescing=E2=80=9D, specifically patch 3 (=E2=80=9Ciotests: Add @has_quit=
 to
vm.shutdown()=E2=80=9D).

Based-on: <20190605161118.14544-1-mreitz@redhat.com>

Max

> Max Reitz (2):
>   vl: Drain before (block) job cancel when quitting
>   iotests: Test quitting with job on throttled node
>=20
>  vl.c                       | 11 ++++++++
>  tests/qemu-iotests/218     | 55 ++++++++++++++++++++++++++++++++++++--=

>  tests/qemu-iotests/218.out |  4 +++
>  3 files changed, 68 insertions(+), 2 deletions(-)
>=20



--14NzCVemONeWwe3Qhub2rVfO7DOFBv7OY--

--KlJNKz1TBMVvVRg2UgP6OGaHArpmbKJ8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0BfV0ACgkQ9AfbAGHV
z0A9Mgf/RJOZX/AxyBBSWv1AnuZP4LCZIu7MmQz0me1oEtxU0LC36m7W6Zs8gBmK
bEf9t230yoWUFibMgQjYshZurFlhtdezfwGS2wUDSU8cYv4TyJCAzNKJY+Wv3rup
zPi11LbB83384r+yE8JrUZTawd9oUz2Ltl1xeyBLwu79kbMUE5EYrj4jzGFt84U6
MCDOlfw72F0ovFelLXBJLGNPyb8xsTuKyN8dmBlgFxQE5NXWiaAwbw1QvnRBcr9c
3Uod/LuWAUsQjbOAtei7EegKSNz6t0Ds5nQldIoqltPL8PJoRaJ5Pq8j2Zs0Fj3/
a9m2udzLh0yjBy3nY5yG9STG99ZqaA==
=ZB7e
-----END PGP SIGNATURE-----

--KlJNKz1TBMVvVRg2UgP6OGaHArpmbKJ8z--

