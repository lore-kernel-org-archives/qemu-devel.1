Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82104C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475FE21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475FE21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1A6a-0002iM-4M
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i1A56-0001Mw-U0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i1A55-0007Gi-21
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i1A50-0007Ez-Nw; Fri, 23 Aug 2019 09:58:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F048B10C696E;
 Fri, 23 Aug 2019 13:58:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-96.brq.redhat.com
 [10.40.204.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 527885D6B2;
 Fri, 23 Aug 2019 13:58:12 +0000 (UTC)
To: Nir Soffer <nsoffer@redhat.com>
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
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
Message-ID: <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
Date: Fri, 23 Aug 2019 15:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jSxkJuQPNKZOKQd6AsBt5FxWJ90uwey4q"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 23 Aug 2019 13:58:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: posix: Always allocate the first
 block
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Nir Soffer <nirsof@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jSxkJuQPNKZOKQd6AsBt5FxWJ90uwey4q
Content-Type: multipart/mixed; boundary="wNNUip95a8TSQyzKarcwmIOkhrB6Rq29q";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
Subject: Re: [PATCH] block: posix: Always allocate the first block
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
In-Reply-To: <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>

--wNNUip95a8TSQyzKarcwmIOkhrB6Rq29q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.08.19 21:01, Nir Soffer wrote:
> On Thu, Aug 22, 2019 at 9:11 PM Max Reitz <mreitz@redhat.com
> <mailto:mreitz@redhat.com>> wrote:
>=20
>     On 22.08.19 18:39, Nir Soffer wrote:
>     > On Thu, Aug 22, 2019 at 5:28 PM Max Reitz <mreitz@redhat.com
>     <mailto:mreitz@redhat.com>
>     > <mailto:mreitz@redhat.com <mailto:mreitz@redhat.com>>> wrote:
>     >
>     >=C2=A0 =C2=A0 =C2=A0On 16.08.19 23:21, Nir Soffer wrote:
>     >=C2=A0 =C2=A0 =C2=A0> When creating an image with preallocation "o=
ff" or "falloc",
>     the first
>     >=C2=A0 =C2=A0 =C2=A0> block of the image is typically not allocate=
d. When using
>     Gluster
>     >=C2=A0 =C2=A0 =C2=A0> storage backed by XFS filesystem, reading th=
is block using
>     direct I/O
>     >=C2=A0 =C2=A0 =C2=A0> succeeds regardless of request length, fooli=
ng alignment
>     detection.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> In this case we fallback to a safe value (40=
96) instead of
>     the optimal
>     >=C2=A0 =C2=A0 =C2=A0> value (512), which may lead to unneeded data=
 copying when
>     aligning
>     >=C2=A0 =C2=A0 =C2=A0> requests.=C2=A0 Allocating the first block a=
voids the fallback.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> When using preallocation=3Doff, we always al=
locate at least one
>     >=C2=A0 =C2=A0 =C2=A0filesystem
>     >=C2=A0 =C2=A0 =C2=A0> block:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0$ ./qemu-img create -f ra=
w test.raw 1g
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Formatting 'test.raw', fm=
t=3Draw size=3D1073741824
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0$ ls -lhs test.raw
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A04.0K -rw-r--r--. 1 nsoffe=
r nsoffer 1.0G Aug 16 23:48
>     test.raw
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> I did quick performance tests for these flow=
s:
>     >=C2=A0 =C2=A0 =C2=A0> - Provisioning a VM with a new raw image.
>     >=C2=A0 =C2=A0 =C2=A0> - Copying disks with qemu-img convert to new=
 raw target image
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> I installed Fedora 29 server on raw sparse i=
mage, measuring
>     the time
>     >=C2=A0 =C2=A0 =C2=A0> from clicking "Begin installation" until the=
 "Reboot" button
>     appears:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Before(s)=C2=A0 After(s)=C2=A0 =C2=A0 =C2=A0=
Diff(%)
>     >=C2=A0 =C2=A0 =C2=A0> -------------------------------
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 356=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 389=C2=A0 =C2=A0 =C2=A0 =C2=A0 +8.4
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> I ran this only once, so we cannot tell much=
 from these results.
>     >
>     >=C2=A0 =C2=A0 =C2=A0So you=E2=80=99d expect it to be fast but it w=
as slower?=C2=A0 Well, you
>     only ran it
>     >=C2=A0 =C2=A0 =C2=A0once and it isn=E2=80=99t really a precise ben=
chmark...
>     >
>     >=C2=A0 =C2=A0 =C2=A0> The second test was cloning the installation=
 image with qemu-img
>     >=C2=A0 =C2=A0 =C2=A0> convert, doing 10 runs:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0for i in $(seq 10); do
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f dst.r=
aw
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 10
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time ./qemu=
-img convert -f raw -O raw -t none -T none
>     >=C2=A0 =C2=A0 =C2=A0src.raw dst.raw
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0done
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Here is a table comparing the total time spe=
nt:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Type=C2=A0 =C2=A0 Before(s)=C2=A0 =C2=A0Afte=
r(s)=C2=A0 =C2=A0 Diff(%)
>     >=C2=A0 =C2=A0 =C2=A0> ---------------------------------------
>     >=C2=A0 =C2=A0 =C2=A0> real=C2=A0 =C2=A0 =C2=A0 530.028=C2=A0 =C2=A0=
 469.123=C2=A0 =C2=A0 =C2=A0 -11.4
>     >=C2=A0 =C2=A0 =C2=A0> user=C2=A0 =C2=A0 =C2=A0 =C2=A017.204=C2=A0 =
=C2=A0 =C2=A010.768=C2=A0 =C2=A0 =C2=A0 -37.4
>     >=C2=A0 =C2=A0 =C2=A0> sys=C2=A0 =C2=A0 =C2=A0 =C2=A0 17.881=C2=A0 =
=C2=A0 =C2=A0 7.011=C2=A0 =C2=A0 =C2=A0 -60.7
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Here we see very clear improvement in CPU us=
age.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Signed-off-by: Nir Soffer <nsoffer@redhat.co=
m
>     <mailto:nsoffer@redhat.com>
>     >=C2=A0 =C2=A0 =C2=A0<mailto:nsoffer@redhat.com <mailto:nsoffer@red=
hat.com>>>
>     >=C2=A0 =C2=A0 =C2=A0> ---
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 block/file-posix.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 25 +++++++++++++++++++++++++
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 tests/qemu-iotests/150.out |=C2=A0 1 +=

>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 tests/qemu-iotests/160=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 4 ++++
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 tests/qemu-iotests/175=C2=A0 =C2=A0 =C2=
=A0| 19 +++++++++++++------
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 tests/qemu-iotests/175.out |=C2=A0 8 +=
+++----
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 tests/qemu-iotests/221.out | 12 ++++++=
++----
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 tests/qemu-iotests/253.out | 12 ++++++=
++----
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 7 files changed, 63 insertions(+), 18 =
deletions(-)
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> diff --git a/block/file-posix.c b/block/file=
-posix.c
>     >=C2=A0 =C2=A0 =C2=A0> index b9c33c8f6c..3964dd2021 100644
>     >=C2=A0 =C2=A0 =C2=A0> --- a/block/file-posix.c
>     >=C2=A0 =C2=A0 =C2=A0> +++ b/block/file-posix.c
>     >=C2=A0 =C2=A0 =C2=A0> @@ -1755,6 +1755,27 @@ static int handle_aio=
cb_discard(void
>     *opaque)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 return ret;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0
>     >=C2=A0 =C2=A0 =C2=A0> +/*
>     >=C2=A0 =C2=A0 =C2=A0> + * Help alignment detection by allocating t=
he first block.
>     >=C2=A0 =C2=A0 =C2=A0> + *
>     >=C2=A0 =C2=A0 =C2=A0> + * When reading with direct I/O from unallo=
cated area on
>     Gluster
>     >=C2=A0 =C2=A0 =C2=A0backed by XFS,
>     >=C2=A0 =C2=A0 =C2=A0> + * reading succeeds regardless of request l=
ength. In this
>     case we
>     >=C2=A0 =C2=A0 =C2=A0fallback to
>     >=C2=A0 =C2=A0 =C2=A0> + * safe aligment which is not optimal. Allo=
cating the first
>     block
>     >=C2=A0 =C2=A0 =C2=A0avoids this
>     >=C2=A0 =C2=A0 =C2=A0> + * fallback.
>     >=C2=A0 =C2=A0 =C2=A0> + *
>     >=C2=A0 =C2=A0 =C2=A0> + * Returns: 0 on success, -errno on failure=
=2E
>     >=C2=A0 =C2=A0 =C2=A0> + */
>     >=C2=A0 =C2=A0 =C2=A0> +static int allocate_first_block(int fd)
>     >=C2=A0 =C2=A0 =C2=A0> +{
>     >=C2=A0 =C2=A0 =C2=A0> +=C2=A0 =C2=A0 ssize_t n;
>     >=C2=A0 =C2=A0 =C2=A0> +
>     >=C2=A0 =C2=A0 =C2=A0> +=C2=A0 =C2=A0 do {
>     >=C2=A0 =C2=A0 =C2=A0> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D pwrite(fd=
, "\0", 1, 0);
>     >
>     >=C2=A0 =C2=A0 =C2=A0This breaks when fd has been opened with O_DIR=
ECT.
>     >
>     >
>     > It seems that we always open images without O_DIRECT when creatin=
g
>     an image
>     > in qemu-img create, or when creating a target image in qemu-img
>     convert.
>=20
>     Yes.=C2=A0 But you don=E2=80=99t call this function directly from i=
mage creation code
>     but instead from the truncation function.=C2=A0 (The former also ca=
lls the
>     latter, but truncating is also an operation on its own.)
>=20
>     [...]
>=20
>     >=C2=A0 =C2=A0 =C2=A0(Which happens when you open some file with ca=
che.direct=3Don,
>     and then
>     >=C2=A0 =C2=A0 =C2=A0use e.g. QMP=E2=80=99s block_resize.)
>     >
>     >
>     > What would be a command triggering this? I can add a test.
>=20
>     block_resize, as I=E2=80=99ve said:
>=20
>     $ ./qemu-img create -f raw empty.img 0
>=20
>=20
> This is extreme edge case - why would someone create such image?

Because it works?

This is generally the fist step of image creation with blockdev-create,
because you don=E2=80=99t care about the size of the protocol layer.

If you have a format layer that truncates the image to a fixed size and
does not write anything into the first block itself (say because it uses
a footer), then (with O_DIRECT) allocate_first_block() will fail
(silently, because while it does return an error value, it is never
checked and there is no comment that explains why we don=E2=80=99t check =
it) and
the first block actually will not be allocated.

I could show you that with VPC (which supports a fixed subformat where
it uses a footer), but unfortunately that=E2=80=99s a bit broken right no=
w
(because of a bug in blockdev-create; I=E2=80=99ll send a patch).

The test would go like this:

$ x86_64-softmmu/qemu-system-x86_64 -qmp stdio
{"execute":"qmp_capabilities"}

{"execute":"blockdev-create",
 "arguments":{
    "job-id":"create",
    "options":{"driver":"file",
               "filename":"test.img",
               "size":0}}}

[Wait until the job is pending]

{"execute":"job-dismiss","arguments":{"id":"create"}}

{"execute":"blockdev-add",
 "arguments":{
    "driver":"file",
    "node-name":"protocol-node",
    "filename":"test.img",
    "cache":{"direct":true}}}

{"execute":"blockdev-create",
 "arguments":{
    "job-id":"create",
    "options":{"driver":"vpc",
               "file":"protocol-node",
               "subformat":"fixed",
               "size":67108864,
               "force-size":true}}}

[Wait until the job is pending]

{"execute":"job-dismiss","arguments":{"id":"create"}}

{"execute":"quit"}

And then:

$ ./qemu-img map test.img
Offset          Length          Mapped to       File
0x4000000       0x200           0x4000000       test.img

The footer is mapped, but the first block is not allocated.


As I said, for that to work, you need a patch (because of a bug), namely:=


[Start of patch]

diff --git a/block/create.c b/block/create.c
index 1bd00ed5f8..572d3a4176 100644
--- a/block/create.c
+++ b/block/create.c
@@ -48,7 +48,7 @@ static int coroutine_fn blockdev_create_run(Job *job,
Error **errp)

     qapi_free_BlockdevCreateOptions(s->opts);

-    return ret;
+    return ret < 0 ? ret : 0;
 }

 static const JobDriver blockdev_create_job_driver =3D {

[End of patch]

(The reason being that the vpc block driver returns 512 here to signify
success, but the job infrastructure treats anything but 0 as a failure.)

>     $ x86_64-softmmu/qemu-system-x86_64 \
>     =C2=A0 =C2=A0 -qmp stdio \
>     =C2=A0 =C2=A0 -blockdev file,node-name=3Dfile,filename=3Dempty.img,=
cache.direct=3Don \
>     =C2=A0 =C2=A0 =C2=A0<<EOF
>     {'execute':'qmp_capabilities'}
>=20
>=20
> This is probably too late for the allocation, since we already probed
> the alignment before executing block_resize, and used a safe fallback
> (4096).
> It can help if the image is reopened, since we probe alignment again.

I=E2=80=99m not talking about getting the alignment right when you have a=

zero-length image.  That can probably never work with probing.  (Well, I
mean, technically you could make allocate_first_block() probe.  I won=E2=80=
=99t
ask for that because that really seems like too little gain for too much
effort.)

I=E2=80=99m just talking about the fact that this allocating write will f=
ail, so
when the image is used the next time, it will not have the first block
allocated.

[...]

>     >=C2=A0 =C2=A0 =C2=A0> @@ -1794,6 +1815,8 @@ static int handle_aioc=
b_truncate(void
>     *opaque)
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* posix_fallocate() doesn't set errno. */
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -result,
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0"Could not preallocate new
>     data");
>     >=C2=A0 =C2=A0 =C2=A0> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
 else if (current_length =3D=3D 0) {
>     >=C2=A0 =C2=A0 =C2=A0> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 allocate_first_block(fd);
>     >
>     >=C2=A0 =C2=A0 =C2=A0Should posix_fallocate() not take care of prec=
isely this?
>     >
>     >
>     > Only if the filesystem does not support fallocate() (e.g. NFS < 4=
=2E2).
>     >
>     > In this case posix_fallocate() is doing:
>     >
>     > =C2=A0 for (offset +=3D (len - 1) % increment; len > 0; offset +=3D=
 increment)
>     > =C2=A0 =C2=A0 {
>     > =C2=A0 =C2=A0 =C2=A0 len -=3D increment;
>     > =C2=A0 =C2=A0 =C2=A0 if (offset < st.st_size)
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char c;
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t rsize =3D __pread (fd,=
 &c, 1, offset);
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rsize < 0)
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno;
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If there is a non-zero byte=
, the block must have been
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allocated already=
=2E =C2=A0*/
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (rsize =3D=3D 1 && c !=
=3D 0)
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     > =C2=A0 =C2=A0 =C2=A0 if (__pwrite (fd, "", 1, offset) !=3D 1)
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno;
>     > =C2=A0 =C2=A0 }
>     >
>     >
>     https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocat=
e.c.html#96
>     >
>     > So opening a file with O_DIRECT will break preallocation=3Dfalloc=
 on
>     such
>     > filesystems,
>=20
>     But won=E2=80=99t the function above just fail with EINVAL?
>     allocate_first_block() is executed only in case of success.
>=20
>=20
> Sure, but if posix_fallocate() fails, we fail qemu-img create/convert.

Exactly.  But if posix_fallocate() works, it should have allocated the
first block.

Max


--wNNUip95a8TSQyzKarcwmIOkhrB6Rq29q--

--jSxkJuQPNKZOKQd6AsBt5FxWJ90uwey4q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1f8PIACgkQ9AfbAGHV
z0BRYQf+KGZenytJg32B7iEblOybw76ow5Akts52geNdVZYTA+w1790MLpirVmBX
ZZd1FvCrX1VHhUYsfCbhDz3Ua4RvEvAZqOvu+yLU3jXJ6/eNU1JvdxNkNWSIWGhg
mTgUQOsIbFcLVr2o95KZXd4BXEqysilz/823Deozp0UndqQe7dx6Em+jSE3zs3OG
VGqyDaK656mLzNXW+ncBejfwMEUeMitX2QJk7QjjfeRaS+ERCCROI/98+KGuFheu
GKPQkIZlasNDRtSBGtsJWLAhKPu7/AP5w1ggNUp0IMJUshnWKskztQUO4gElMfiP
E0C9t8NWE6yDYROoNMI9Pyc7JDf7PA==
=KInD
-----END PGP SIGNATURE-----

--jSxkJuQPNKZOKQd6AsBt5FxWJ90uwey4q--

