Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC275C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBA725F28
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBA725F28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWg5s-0005Y0-VT
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 07:53:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hWg52-0005CL-OE
	for qemu-devel@nongnu.org; Fri, 31 May 2019 07:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hWg51-0008AA-AJ
	for qemu-devel@nongnu.org; Fri, 31 May 2019 07:52:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hWg4w-0007vF-MZ; Fri, 31 May 2019 07:52:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51B97308FF30;
	Fri, 31 May 2019 11:51:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EB389473C4;
	Fri, 31 May 2019 11:51:53 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190524172812.27308-1-mreitz@redhat.com>
	<20190524172812.27308-2-mreitz@redhat.com>
	<20190529221010.GC3471@localhost.localdomain>
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
Message-ID: <9690f4f9-d618-4d0d-4094-356f8e5c922a@redhat.com>
Date: Fri, 31 May 2019 13:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529221010.GC3471@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rZYRCLDpDjWDHR6YUXaXn5VxqzM4u1bf8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 31 May 2019 11:51:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC 1/3] block: Add ImageRotationalInfo
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
Cc: Alberto Garcia <berto@igalia.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rZYRCLDpDjWDHR6YUXaXn5VxqzM4u1bf8
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <9690f4f9-d618-4d0d-4094-356f8e5c922a@redhat.com>
Subject: Re: [RFC 1/3] block: Add ImageRotationalInfo
References: <20190524172812.27308-1-mreitz@redhat.com>
 <20190524172812.27308-2-mreitz@redhat.com>
 <20190529221010.GC3471@localhost.localdomain>
In-Reply-To: <20190529221010.GC3471@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.05.19 00:10, Kevin Wolf wrote:
> Am 24.05.2019 um 19:28 hat Max Reitz geschrieben:
>> This enum indicates whether a file is stored on a rotating disk or a
>> solid-state drive.  Drivers report it via the .bdrv_get_info() callbac=
k,
>> and if they do not, the global bdrv_get_info() implementation
>> automatically takes it from bs->file or bs->backing, if available.
>=20
> Good that you wrote "bs->file or bs->backing" explicitly. Otherwise, I
> might have missed that it begs one big question: What is the correct
> answer for a qcow2 file that has bs->file on an SSD, but bs->backing on=

> a rotating disk?
>=20
> I don't think there is a correct answer for the whole device, so maybe
> this information shouldn't be per device in BlockDriverInfo, but per
> block in bdrv_co_block_status() (optionally determined if the caller
> requests it)?

I think that=E2=80=99s taking it a bit too far.  There is no heavy implic=
ation
in making the wrong choice here, it=E2=80=99s just a performance problem.=

Having to call block_status for every block where we want to know what
to do seems like the opposite of performance optimization to me.  (We
could add a flag to block_status to only query that status, but that
sounds plainly wrong.)

So, in this series I decided that since all writes go to bs->file, that
seemed like what mostly determines the behavior of @bs.  (After my =E2=80=
=9CDeal
with filters=E2=80=9D series, that would become a decision of bdrv_storag=
e_bs()
vs. bdrv_filtered_cow_bs().)

(Note that it has to get even funnier with vmdk, if your extents are on
an HDD, but your descriptor file is on an SSD.  I don=E2=80=99t care too =
much
about vmdk=E2=80=99s performance, though.)

In my v1, I=E2=80=99ll add a per-node @rotational parameter with which th=
e user
can override the status we guessed.  In fact, currently, my commit
message explicitly notes that case:

https://git.xanclic.moe/XanClic/qemu/commit/0834f1ce77b4c27f0c00f1e4fbee0=
99278e530b2

(Point 4)

(from
https://git.xanclic.moe/XanClic/qemu/commits/branch/spinning-rust-next)


Alternatively to making bs->file take precedence over bs->backing, we
could also just set the status to unknown if bs->file and bs->backing
differ in their status.


I think it=E2=80=99s generally better to prefer what bs->file says.  This=
 is an
optimization case, so I think it=E2=80=99s more important to get it right=
 most
of the time (and guess wrong sometimes) than to stop guessing in all
cases where we could be wrong.

Max


--rZYRCLDpDjWDHR6YUXaXn5VxqzM4u1bf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzxFVcACgkQ9AfbAGHV
z0BwtggAsed5H1dplITqwzld3nMDuY6a6m483uwhXaC1TZd6SIAlgG9zIXQk1jyL
W2JIi4uAh9/6O30qUAclrkMN2RDIICmabGu1BeiIXM0ajpVC4YjEwWWf2OgHNDhQ
rDlOSHUXW86Hx/hCb/heYmmzK/EvebXHctTzk34hBnTdnVOdvtmn7JCXawtjMnRk
yFCzcp/VvGN7A1WnJq059mbsOCbCwjR1OLtMamLFLE34AOLiNZAKf5FRoNsk/ZQA
H6HmershFfvuLwdm6bz9UEIPZ3sYyVmT/oejMHb4pZV4sbfg1m+uNAniy1jtFocx
g1bJ5nPu9MJQEcNbId8nQRFlPZr46Q==
=Oh88
-----END PGP SIGNATURE-----

--rZYRCLDpDjWDHR6YUXaXn5VxqzM4u1bf8--

