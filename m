Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B09C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2EA20835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2EA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGnpR-00029z-Fr
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 12:54:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnoT-0001nT-KC
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnoS-0001VK-8u
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hGnoK-0001Jc-Mq; Wed, 17 Apr 2019 12:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A731E3099FD4;
	Wed, 17 Apr 2019 16:53:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-140.brq.redhat.com
	[10.40.204.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A4421001E9A;
	Wed, 17 Apr 2019 16:53:15 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190417154850.29110-1-kwolf@redhat.com>
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
Message-ID: <5eeffb36-9db3-30e8-91d2-2e3796b0a40d@redhat.com>
Date: Wed, 17 Apr 2019 18:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 17 Apr 2019 16:53:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] block: Fix AioContext switch for bs->drv
 == NULL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417165314.kjGKTlS32_MBNCLpMFjRRiBZYRuYnPBS5CMXHa3OKsg@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org
Message-ID: <5eeffb36-9db3-30e8-91d2-2e3796b0a40d@redhat.com>
Subject: Re: [PATCH] block: Fix AioContext switch for bs->drv == NULL
References: <20190417154850.29110-1-kwolf@redhat.com>
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.19 17:48, Kevin Wolf wrote:
> Even for block nodes with bs->drv =3D=3D NULL, we can't just ignore a
> bdrv_set_aio_context() call. Leaving the node in its old context can
> mean that it's still in an iothread context in bdrv_close_all() during
> shutdown, resulting in an attempted unlock of the AioContext lock which=

> we don't hold.
>=20
> This is an example stack trace of a related crash:
>=20
>  #0  0x00007ffff59da57f in raise () at /lib64/libc.so.6
>  #1  0x00007ffff59c4895 in abort () at /lib64/libc.so.6
>  #2  0x0000555555b97b1e in error_exit (err=3D<optimized out>, msg=3Dmsg=
@entry=3D0x555555d386d0 <__func__.19059> "qemu_mutex_unlock_impl") at uti=
l/qemu-thread-posix.c:36
>  #3  0x0000555555b97f7f in qemu_mutex_unlock_impl (mutex=3Dmutex@entry=3D=
0x5555568002f0, file=3Dfile@entry=3D0x555555d378df "util/async.c", line=3D=
line@entry=3D507) at util/qemu-thread-posix.c:97
>  #4  0x0000555555b92f55 in aio_context_release (ctx=3Dctx@entry=3D0x555=
556800290) at util/async.c:507
>  #5  0x0000555555b05cf8 in bdrv_prwv_co (child=3Dchild@entry=3D0x7fffc8=
0012f0, offset=3Doffset@entry=3D131072, qiov=3Dqiov@entry=3D0x7fffffffd4f=
0, is_write=3Dis_write@entry=3Dtrue, flags=3Dflags@entry=3D0)
>          at block/io.c:833
>  #6  0x0000555555b060a9 in bdrv_pwritev (qiov=3D0x7fffffffd4f0, offset=3D=
131072, child=3D0x7fffc80012f0) at block/io.c:990
>  #7  0x0000555555b060a9 in bdrv_pwrite (child=3D0x7fffc80012f0, offset=3D=
131072, buf=3D<optimized out>, bytes=3D<optimized out>) at block/io.c:990=

>  #8  0x0000555555ae172b in qcow2_cache_entry_flush (bs=3Dbs@entry=3D0x5=
55556810680, c=3Dc@entry=3D0x5555568cc740, i=3Di@entry=3D0) at block/qcow=
2-cache.c:51
>  #9  0x0000555555ae18dd in qcow2_cache_write (bs=3Dbs@entry=3D0x5555568=
10680, c=3D0x5555568cc740) at block/qcow2-cache.c:248
>  #10 0x0000555555ae15de in qcow2_cache_flush (bs=3D0x555556810680, c=3D=
<optimized out>) at block/qcow2-cache.c:259
>  #11 0x0000555555ae16b1 in qcow2_cache_flush_dependency (c=3D0x5555568a=
1700, c=3D0x5555568a1700, bs=3D0x555556810680) at block/qcow2-cache.c:194=

>  #12 0x0000555555ae16b1 in qcow2_cache_entry_flush (bs=3Dbs@entry=3D0x5=
55556810680, c=3Dc@entry=3D0x5555568a1700, i=3Di@entry=3D0) at block/qcow=
2-cache.c:194
>  #13 0x0000555555ae18dd in qcow2_cache_write (bs=3Dbs@entry=3D0x5555568=
10680, c=3D0x5555568a1700) at block/qcow2-cache.c:248
>  #14 0x0000555555ae15de in qcow2_cache_flush (bs=3Dbs@entry=3D0x5555568=
10680, c=3D<optimized out>) at block/qcow2-cache.c:259
>  #15 0x0000555555ad242c in qcow2_inactivate (bs=3Dbs@entry=3D0x55555681=
0680) at block/qcow2.c:2124
>  #16 0x0000555555ad2590 in qcow2_close (bs=3D0x555556810680) at block/q=
cow2.c:2153
>  #17 0x0000555555ab0c62 in bdrv_close (bs=3D0x555556810680) at block.c:=
3358
>  #18 0x0000555555ab0c62 in bdrv_delete (bs=3D0x555556810680) at block.c=
:3542
>  #19 0x0000555555ab0c62 in bdrv_unref (bs=3D0x555556810680) at block.c:=
4598
>  #20 0x0000555555af4d72 in blk_remove_bs (blk=3Dblk@entry=3D0x555556810=
3d0) at block/block-backend.c:785
>  #21 0x0000555555af4dbb in blk_remove_all_bs () at block/block-backend.=
c:483
>  #22 0x0000555555aae02f in bdrv_close_all () at block.c:3412
>  #23 0x00005555557f9796 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at vl.c:4776
>=20
> The reproducer I used is a qcow2 image on gluster volume, where the
> virtual disk size (4 GB) is larger than the gluster volume size (64M),
> so we can easily trigger an ENOSPC. This backend is assigned to a
> virtio-blk device using an iothread, and then from the guest a
> 'dd if=3D/dev/zero of=3D/dev/vda bs=3D1G count=3D1' causes the VM to st=
op
> because of an I/O error. qemu_gluster_co_flush_to_disk() sets
> bs->drv =3D NULL on error, so when virtio-blk stops the dataplane, the
> block nodes stay in the iothread AioContext. A 'quit' monitor command
> issued from this paused state crashes the process.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1631227
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3WfoACgkQ9AfbAGHV
z0Cwvgf8CW8OEOu77hMjYsdBX+rYsbGYvkG0C2wkrdbV62WxXPOxsIV9QYw3F5Bb
K8L5f/YeEDDI4fHb4yDh45nb2xhq0rrkQKxnjAIiNUlpymSWa5xPorTvxMAjMPl3
cocAsE6dEM1mIZtQ9R0vM91d1XSe6n6PuMquKJYj1oLA91WRJV2NWk75Cr3+CbNd
lSXDpLKzdfmkMHLnuXo3cwxWtVdfG8kxjsLw/YQI9JiAkorky33grtl75QUD7/TY
AeDv2HYf7oAeSmA34+Evj18Nr6cfx1ID6Fc7qBVOghZ7j5uTfXiXh46X7neMa1DU
SD3wtajVh1ELfUOBDYIpaCD9I2ErZQ==
=KAt6
-----END PGP SIGNATURE-----

--2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG--

