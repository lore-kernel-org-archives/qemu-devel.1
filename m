Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF2C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FE520673
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FE520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxGLQ-0002mF-BN
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 15:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxGKy-0001zK-Ne
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxGKx-0000ri-Ms
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:50:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxGKv-0000r3-4v; Mon, 12 Aug 2019 15:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A81430872DD;
 Mon, 12 Aug 2019 19:50:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 908CE7D4FB;
 Mon, 12 Aug 2019 19:50:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
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
Message-ID: <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
Date: Mon, 12 Aug 2019 21:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9oN0Fg0d5vouudxWSIffeQCS9ma2N43A9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 12 Aug 2019 19:50:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9oN0Fg0d5vouudxWSIffeQCS9ma2N43A9
Content-Type: multipart/mixed; boundary="x6JEUTRFTw2IvKllcZZpXmn2flX1F9ANK";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@openvz.org
Message-ID: <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
Subject: Re: [PATCH 0/2] deal with BDRV_BLOCK_RAW
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
In-Reply-To: <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>

--x6JEUTRFTw2IvKllcZZpXmn2flX1F9ANK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 21:46, Max Reitz wrote:
> On 12.08.19 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> I'm not sure, is it a bug or a feature, but using qcow2 under raw is
>> broken. It should be either fixed like I propose (by Max's suggestion)=

>> or somehow forbidden (just forbid backing-file supporting node to be
>> file child of raw-format node).
>=20
> I agree, I think only filters should return BDRV_BLOCK_RAW.
>=20
> (And not even them, they should just be handled transparently by
> bdrv_co_block_status().  But that=E2=80=99s something for later.)
>=20
>> Vladimir Sementsov-Ogievskiy (2):
>>   block/raw-format: switch to BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
>>   iotests: test mirroring qcow2 under raw format
>>
>>  block/raw-format.c         |  2 +-
>>  tests/qemu-iotests/263     | 46 +++++++++++++++++++++++++++++++++++++=
+
>>  tests/qemu-iotests/263.out | 12 ++++++++++
>>  tests/qemu-iotests/group   |  1 +
>>  4 files changed, 60 insertions(+), 1 deletion(-)
>>  create mode 100755 tests/qemu-iotests/263
>>  create mode 100644 tests/qemu-iotests/263.out
>=20
> Thanks, applied to my block-next branch:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Oops, maybe not.  221 needs to be adjusted.

Max


--x6JEUTRFTw2IvKllcZZpXmn2flX1F9ANK--

--9oN0Fg0d5vouudxWSIffeQCS9ma2N43A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RwwQACgkQ9AfbAGHV
z0AD+ggAoD2TwNVOKKaL9fgZAjmiaS2f6Wc+qgQM8XjlvM+azswbvb2jbexW+lsz
wjGTgVaMTvhwUxrAR42osG2BVvehR2kp/j24U874331KYcVLIgQ9vQojWYDG/z+/
wtGLQm55J8ruJY/uJms1KelrNzKVyJFJpgm18ivuUN6SSbGixdFsM7IIL9C0kR7B
LL8IY10qn33YMXrceOQ+E1GyQnbRdv5rxFgzi5Tfptr5NjalsJY00pL+Uws2kAbf
LSTYcWMq9ofDzbeLwevLpzrXYb2QlxxhTM2iWwSmRNEZ8isfLSdhHxPMltcW3HVT
u1gaKEOm5kf6SrLlDnuMRuAzhVm3SA==
=l19T
-----END PGP SIGNATURE-----

--9oN0Fg0d5vouudxWSIffeQCS9ma2N43A9--

