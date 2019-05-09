Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35070C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2222054F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2222054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkUz-0003mX-8W
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:58:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOkTk-000389-Np
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOkTh-0001Kp-Uc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOkTf-0001JS-EU; Thu, 09 May 2019 10:56:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB8173078ABD;
	Thu,  9 May 2019 14:56:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-168.brq.redhat.com
	[10.40.204.168])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 903F860FE6;
	Thu,  9 May 2019 14:56:48 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
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
Message-ID: <5a643d95-3732-e22d-7cc5-122ae5792641@redhat.com>
Date: Thu, 9 May 2019 16:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506142741.41731-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jff3sLgP2iVO0yPsmqkAJYqt8f98vOzJM"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 09 May 2019 14:56:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v6 0/8] qcow2: encryption threads
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, berto@igalia.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jff3sLgP2iVO0yPsmqkAJYqt8f98vOzJM
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com,
 berrange@redhat.com, den@openvz.org
Message-ID: <5a643d95-3732-e22d-7cc5-122ae5792641@redhat.com>
Subject: Re: [PATCH v6 0/8] qcow2: encryption threads
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190506142741.41731-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.19 16:27, Vladimir Sementsov-Ogievskiy wrote:
> v6:
>  - Rebase on master, so 02 changed to reflect changes in
>    qcow2_compress(), keep r-b.
>  - Rewrite 06 to even simpler locking [Max], drop r-b
>    Drop following
>    "qcow2: qcow2_co_preadv: skip using hd_qiov when possible", I'll do
>    it in my other coming soon series, and it is actually unrelated to
>    current.
>  - Drop controversial perf test, hope I'll return to this topic, but no=
t
>    in context of these series.
>  - Add Max's r-b's to all here, except 06
>=20
> Vladimir Sementsov-Ogievskiy (8):
>   qcow2.h: add missing include
>   qcow2: add separate file for threaded data processing functions
>   qcow2-threads: use thread_pool_submit_co
>   qcow2-threads: qcow2_co_do_compress: protect queuing by mutex
>   qcow2-threads: split out generic path
>   qcow2: qcow2_co_preadv: improve locking
>   qcow2: bdrv_co_pwritev: move encryption code out of the lock
>   qcow2: do encryption in threads
>=20
>  block/qcow2.h          |  20 ++-
>  block/qcow2-bitmap.c   |   1 -
>  block/qcow2-cache.c    |   1 -
>  block/qcow2-cluster.c  |   8 +-
>  block/qcow2-refcount.c |   1 -
>  block/qcow2-snapshot.c |   1 -
>  block/qcow2-threads.c  | 268 +++++++++++++++++++++++++++++++++++++++++=

>  block/qcow2.c          | 241 +++++-------------------------------
>  block/Makefile.objs    |   2 +-
>  9 files changed, 321 insertions(+), 222 deletions(-)
>  create mode 100644 block/qcow2-threads.c

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--jff3sLgP2iVO0yPsmqkAJYqt8f98vOzJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzUP64ACgkQ9AfbAGHV
z0DZNgf+MGUD2gl3dFrYQLH5bQHYY5pXifXit0Po65mGL1Bpdr8g+RwA3S4V7iUg
2SowSHlf8zo4OHwS7PhEVOKmVj1gNJaNbN/Q33OtYATjszIVAVdg39WEXKvWF6Q3
jbwRfmrPtW7LH5+WbxC7TuoSwyWmP1aD+JXE14+AFC39m8p5J4xJsRKx19N40hMT
pbx8s653m1hFLA/nW2ZMnzBrhQ5G56/0RECPDWR1mjagyd5rgNNcvXgYOhAvk4lg
Gjr5dUruLbRTpTxHNol8HeAYAXSrxDJ35TKE01YcXfVsLBtjx9kskuu97w7qgOs1
hmZUvkMQy0IFR0cdfkWO1KpG4vQGYg==
=Xi62
-----END PGP SIGNATURE-----

--jff3sLgP2iVO0yPsmqkAJYqt8f98vOzJM--

