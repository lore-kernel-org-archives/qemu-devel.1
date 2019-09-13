Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC05DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A169520717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A169520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8iFU-0006x4-Pa
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8iEh-0006Iu-N5
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8iEg-0004rz-QX
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8iEe-0004rH-FC; Fri, 13 Sep 2019 05:51:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DF7B8AC6FF;
 Fri, 13 Sep 2019 09:51:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B344608AB;
 Fri, 13 Sep 2019 09:51:21 +0000 (UTC)
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-2-pl@kamp.de>
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
Message-ID: <ede55319-ca74-ab1c-6b3e-8558d9e6bdd8@redhat.com>
Date: Fri, 13 Sep 2019 11:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910154110.6905-2-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1XArpyi18yYvXN0BfGex5FLGEAWmxjZUY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 13 Sep 2019 09:51:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 1/2] block/nfs: tear down aio before
 nfs_close
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, ronniesahlberg@gmail.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1XArpyi18yYvXN0BfGex5FLGEAWmxjZUY
Content-Type: multipart/mixed; boundary="3xLprZR5L68Qg634PBgZDIoK3scBBjCvy";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ronniesahlberg@gmail.com,
 qemu-stable@nongnu.org
Message-ID: <ede55319-ca74-ab1c-6b3e-8558d9e6bdd8@redhat.com>
Subject: Re: [PATCH V2 1/2] block/nfs: tear down aio before nfs_close
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-2-pl@kamp.de>
In-Reply-To: <20190910154110.6905-2-pl@kamp.de>

--3xLprZR5L68Qg634PBgZDIoK3scBBjCvy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 17:41, Peter Lieven wrote:
> nfs_close is a sync call from libnfs and has its own event
> handler polling on the nfs FD. Avoid that both QEMU and libnfs
> are intefering here.
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I=E2=80=99ve just seen that Kevin has already included the second patch (=
in its
v1) in his pull request.

So all that I can do is take this patch, which sounds good to me,
especially since Ronnie has agreed that we should remove our FD handler
there.

(So I=E2=80=99ve rebased the patch on top of Kevin=E2=80=99s pull request=
, and I=E2=80=99ve
taken it to my block branch.)

Max


--3xLprZR5L68Qg634PBgZDIoK3scBBjCvy--

--1XArpyi18yYvXN0BfGex5FLGEAWmxjZUY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17ZpcACgkQ9AfbAGHV
z0DdjQgAoBL59E9eJoz0UZuQM/OLmwj04Cmxvkw3E8tnwIpXNC/LPgm+j2dDYu2e
eyueQCGSPUlzKrwRQNNqRxDCbm9EtKFgj4GiJXrHB8rNrtjUsBTFwWxJ+ONynBYy
U7dkXucNw/s1bOIcJ8P3ox2qWnxvJWxPoB3NNAVHHiDYak66Vb3zcg02R1CoX2Dt
S7ArwDxGBr1wayvEQHhSgdh7G8Ljq1XWWHt6xep3B8SN6dg3RonPCBeYQIULekm5
uqd918wAZ1mYfF6VEKOoSo4aypb4tEdnqM31VK0Ig04eZe69wsRPBK6NZNyM1YCg
FN+Zy7lFXU3unuen9q0nyCNyfexq8w==
=mTfT
-----END PGP SIGNATURE-----

--1XArpyi18yYvXN0BfGex5FLGEAWmxjZUY--

