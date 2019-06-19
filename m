Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC694C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA062084B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA062084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgIK-0000xM-VL
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdgFf-0007Mc-9M
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdgFe-0007Pf-7R
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:28:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdgFZ-0007KZ-SG; Wed, 19 Jun 2019 15:28:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7109AC1EB20A;
 Wed, 19 Jun 2019 19:28:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-121.ams2.redhat.com
 [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 845F01001B12;
 Wed, 19 Jun 2019 19:27:50 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1559152576-281803-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <e3cf99ae-62e9-8b6e-5a06-d3c8b9363b85@redhat.com>
Date: Wed, 19 Jun 2019 21:27:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559152576-281803-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vz8GapngQoo4zr3b03v0PJqnreuf6aNaW"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 19 Jun 2019 19:28:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 1/3] block: include base when checking
 image chain for block allocation
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 berto@igalia.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vz8GapngQoo4zr3b03v0PJqnreuf6aNaW
Content-Type: multipart/mixed; boundary="qlNZh4IxgAv6wgZV2wqkcsRvhJ3wNMlel";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, jsnow@redhat.com,
 stefanha@redhat.com, fam@euphon.net, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <e3cf99ae-62e9-8b6e-5a06-d3c8b9363b85@redhat.com>
Subject: Re: [PATCH v7 1/3] block: include base when checking image chain for
 block allocation
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1559152576-281803-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1559152576-281803-2-git-send-email-andrey.shinkevich@virtuozzo.com>

--qlNZh4IxgAv6wgZV2wqkcsRvhJ3wNMlel
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.05.19 19:56, Andrey Shinkevich wrote:
> This patch is used in the 'block/stream: introduce a bottom node'
> that is following. Instead of the base node, the caller may pass
> the node that has the base as its backing image to the function
> bdrv_is_allocated_above() with a new parameter include_base =3D true
> and get rid of the dependency on the base that may change during
> commit/stream parallel jobs. Now, if the specified base is not
> found in the backing image chain, the QEMU will abort.
>=20
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c        |  2 +-
>  block/io.c            | 21 +++++++++++++++------
>  block/mirror.c        |  2 +-
>  block/replication.c   |  2 +-
>  block/stream.c        |  2 +-
>  include/block/block.h |  3 ++-
>  6 files changed, 21 insertions(+), 11 deletions(-)

This needs the following hunk squashed in so it still compiles:

(I can do that, if you agree.)

diff --git a/block/qcow2.c b/block/qcow2.c
index 9396d490d5..2a59eb27fe 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2148,7 +2148,8 @@ static bool is_unallocated(BlockDriverState *bs,
int64_t offset, int64_t bytes)
 {
     int64_t nr;
     return !bytes ||
-        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr
=3D=3D bytes);
+        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &=
&
+         nr =3D=3D bytes);
 }

 static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
diff --git a/qemu-img.c b/qemu-img.c
index 158b3a505f..79983772de 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3518,7 +3518,7 @@ static int img_rebase(int argc, char **argv)
                  * to take action
                  */
                 ret =3D bdrv_is_allocated_above(backing_bs(bs),
prefix_chain_bs,
-                                              offset, n, &n);
+                                              false, offset, n, &n);
                 if (ret < 0) {
                     error_report("error while reading image metadata: %s=
",
                                  strerror(-ret));


--qlNZh4IxgAv6wgZV2wqkcsRvhJ3wNMlel--

--vz8GapngQoo4zr3b03v0PJqnreuf6aNaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0KjLUACgkQ9AfbAGHV
z0DFxgf/a5TALurJhT71ytdeLnr9pEOcOl7OBI3KVvquvW4a0KsYlkv5Nh+pefUU
+97QK8cJaoXcV3TokPXCt5YJe/r6oVfbNHOIgEDZvjmhiQF+13J08rVLpRMOq7Xb
IOiPUY+4N6ay4nGRIAF0r5SFL9JH/vgfacD/qUUINkLQXJ1Y6x+ebAIbP++foHaQ
v6S1Lp1WQcPiM5qeUgKHVs7UV3YLzMQm/VxeBXCnWJZzusR1HUpPJco0gnQdAEiz
yt7WHk6E003n7YfWTrXHXsd8rQ9iyiGHD0FFzUf5Up1qu8x7igK54m014nIRz0Jn
z2elq34yfzURUMbxq7fC2FDik5kvxg==
=UpAa
-----END PGP SIGNATURE-----

--vz8GapngQoo4zr3b03v0PJqnreuf6aNaW--

