Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E87C4CED0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CC921848
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CC921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34277 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rFG-0007Jy-B7
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 09:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9rE8-0006Hy-WB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9rE7-00008P-NY
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9rE3-00006m-NQ; Mon, 16 Sep 2019 09:39:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A1A380F98;
 Mon, 16 Sep 2019 13:39:30 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B0655C21A;
 Mon, 16 Sep 2019 13:39:24 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190915203655.21638-1-mlevitsk@redhat.com>
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
Message-ID: <d2c07712-c292-1341-3dfb-2529e71e3744@redhat.com>
Date: Mon, 16 Sep 2019 15:39:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190915203655.21638-1-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RRsj0DtiZ7KYjnjA6wIbIjXK6oqqTLH5N"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 16 Sep 2019 13:39:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 0/3] Fix qcow2+luks corruption
 introduced by commit 8ac0f15f335
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RRsj0DtiZ7KYjnjA6wIbIjXK6oqqTLH5N
Content-Type: multipart/mixed; boundary="lcy1wLXSyEgd72n67nYOUhbQiZmDL8a8I";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <d2c07712-c292-1341-3dfb-2529e71e3744@redhat.com>
Subject: Re: [PATCH v7 0/3] Fix qcow2+luks corruption introduced by commit
 8ac0f15f335
References: <20190915203655.21638-1-mlevitsk@redhat.com>
In-Reply-To: <20190915203655.21638-1-mlevitsk@redhat.com>

--lcy1wLXSyEgd72n67nYOUhbQiZmDL8a8I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.09.19 22:36, Maxim Levitsky wrote:
> Commit 8ac0f15f335 accidently broke the COW of non changed areas
> of newly allocated clusters, when the write spans multiple clusters,
> and needs COW both prior and after the write.
> This results in 'after' COW area being encrypted with wrong
> sector address, which render it corrupted.
>=20
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1745922
>=20
> CC: qemu-stable <qemu-stable@nongnu.org>
>=20
> V2: grammar, spelling and code style fixes.
> V3: more fixes after the review.
> V4: addressed review comments from Max Reitz,
>     and futher refactored the qcow2_co_encrypt to just take full host a=
nd guest offset
>     which simplifies everything.
>=20
> V5: reworked the patches so one of them fixes the bug
>     only and other one is just refactoring
>=20
> V6: removed do_perform_cow_encrypt
>=20
> V7: removed do_perform_cow_encrypt take two, this
>     time I hopefully did that correctly :-)
>     Also updated commit names and messages a bit

Luckily for you (maybe), Vladimir=E2=80=99s series doesn=E2=80=98t quite =
pass the
iotests for me, so unfortunately (I find it unfortunate) I had to remove
it from my branch.  Thus, the conflicts are much more tame and I felt
comfortable taking the series to my branch (with the remaining trivial
conflicts resolved, and with Vladimir=E2=80=99s suggestion applied):

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--lcy1wLXSyEgd72n67nYOUhbQiZmDL8a8I--

--RRsj0DtiZ7KYjnjA6wIbIjXK6oqqTLH5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1/kIoACgkQ9AfbAGHV
z0D/7AgArVTIxe3WdhHK93paWVVh6ANQ/eikRVuEz43u0Y+GYV7lncFbxzSTnlsW
woFKmjD0OHeWtG+O/kCd93oK+0zD0uv5eSe9c1imbZrNIx2jv7vDeZ8kXs3VGb1d
KqK/hF4sPlxmOjJ5TrbqgmrHGLhdv1C5f+vuTlHfSNM7PjxPHd607TkBQtktDDgY
W4RFd7V5TTVWnpS7phSvWJbyqnsiiAAo9JGlUSfoel6et6FJuC83z5j3St4GMZX5
jY8Fhl7bOqZ8Pqq0HZlANj9FAZv0/wFVuQijMfl9tNj33CiVbec3O4s0EtM+I+db
PhdjRHlIijQkS1wyDEteL/4eMMAeww==
=vu/M
-----END PGP SIGNATURE-----

--RRsj0DtiZ7KYjnjA6wIbIjXK6oqqTLH5N--

