Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D85C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC0C20665
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC0C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyI1e-0003mV-U8
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hyI0b-0002mZ-A5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hyI0V-0005fA-Kk
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:49:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hyI0M-0005bV-Af; Thu, 15 Aug 2019 11:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B5A811A12;
 Thu, 15 Aug 2019 15:49:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-81.brq.redhat.com
 [10.40.204.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31FEA841DC;
 Thu, 15 Aug 2019 15:49:32 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190725155512.9827-1-mreitz@redhat.com>
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
Message-ID: <40182dab-ed10-fed9-451c-e8ae2e4fa745@redhat.com>
Date: Thu, 15 Aug 2019 17:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725155512.9827-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z7na1IA25O6gDpvrKJmApBk1BmQTyxyib"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 15 Aug 2019 15:49:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] block: Make various formats'
 block_status recurse again
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z7na1IA25O6gDpvrKJmApBk1BmQTyxyib
Content-Type: multipart/mixed; boundary="CJhQwmtGzQBDby3lJf13lyBPQ4ULkG65S";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <40182dab-ed10-fed9-451c-e8ae2e4fa745@redhat.com>
Subject: Re: [PATCH 0/3] block: Make various formats' block_status recurse
 again
References: <20190725155512.9827-1-mreitz@redhat.com>
In-Reply-To: <20190725155512.9827-1-mreitz@redhat.com>

--CJhQwmtGzQBDby3lJf13lyBPQ4ULkG65S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 17:55, Max Reitz wrote:
> Hi,
>=20
> 69f47505ee66afaa513305de0c1895a224e52c45 changed block_status so that i=
t
> would only go down to the protocol layer if the format layer returned
> BDRV_BLOCK_RECURSE, thus indicating that it has no sufficient
> information whether a given range in the image is zero or not.
> Generally, this is because the image is preallocated and thus all range=
s
> appear as zeroes.
>=20
> However, it only implemented this preallocation detection for qcow2.
> There are more formats that support preallocation, though: vdi, vhdx,
> vmdk, vpc.  (Funny how they all start with =E2=80=9Cv=E2=80=9D.)
>=20
> For vdi, vmdk, and vpc, the fix is rather simple, because they really
> have different subformats depending on whether an image is preallocated=

> or not.  This makes the check very simple.
>=20
> vhdx is more like qcow2, where after the image has been created, it
> isn=E2=80=99t clear whether it=E2=80=99s been preallocated or everythin=
g is allocated
> because everything was already written to.  69f47505ee added a heuristi=
c
> to qcow2 to get around this, but I think that=E2=80=99s too much for vh=
dx.  I
> just left it unfixed, because I don=E2=80=99t care that much, honestly =
(and I
> don=E2=80=99t think anyone else does).
>=20
>=20
> Max Reitz (3):
>   vdi: Make block_status recurse for fixed images
>   vmdk: Make block_status recurse for flat extents
>   vpc: Do not return RAW from block_status
>=20
>  block/vdi.c  | 3 ++-
>  block/vmdk.c | 3 +++
>  block/vpc.c  | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)

Thanks for the reviews, applied to my block-next branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--CJhQwmtGzQBDby3lJf13lyBPQ4ULkG65S--

--z7na1IA25O6gDpvrKJmApBk1BmQTyxyib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1VfwoACgkQ9AfbAGHV
z0CPJwf/ZGNoi3PWBKcGSDF3Ds9N0TLI5FRwTPWRtrza1d0a+D1wi/IMfAAXGV8s
0kwjjfToXb2RInWEmxa+EtjAeRwTMHz0HGaiLP9liWcfCf+ycMqBbGc3zArdDVob
TDCAtMGVuts2PhF74uLa3VMMqij8vxWOAX2Pu/IwQ2o9HqYRHIMXX6k1XjIogBCY
Ig2rEekngm2drp1C+8ZX6nSlptbjS0IcFUUNaebscGyfEMSjMto23+p0qcRTQwJ3
m+MAWWVch/9Z4EnrG5yH0KHAwEc+Isk+Gy6VyhP0yxdXeQOLGfIq7ojTsPXKw0Uj
3EZ/ItdH5CEEX6/HhSH1PX/PPHXmXA==
=VFFH
-----END PGP SIGNATURE-----

--z7na1IA25O6gDpvrKJmApBk1BmQTyxyib--

