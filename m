Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB9BC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB0A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB0A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLCim-0000i8-II
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 16:17:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hLChj-0008Ud-Fx
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hLChi-0001iK-CB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hLChf-0001gY-Kk; Mon, 29 Apr 2019 16:16:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FB033082B69;
	Mon, 29 Apr 2019 20:16:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-144.brq.redhat.com
	[10.40.204.144])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4669957A4;
	Mon, 29 Apr 2019 20:16:40 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
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
Message-ID: <03585bce-afb0-cd39-9732-7946fa1b03fc@redhat.com>
Date: Mon, 29 Apr 2019 22:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190311165017.32247-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 29 Apr 2019 20:16:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 10/10] file-posix: Make
 auto-read-only dynamic
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429201639.bUS_Cw69ivxyaTWH1_9m3Gputs81JLZb1_eAwVdT6vM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <03585bce-afb0-cd39-9732-7946fa1b03fc@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 10/10] file-posix: Make auto-read-only
 dynamic
References: <20190311165017.32247-1-kwolf@redhat.com>
 <20190311165017.32247-11-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.03.19 17:50, Kevin Wolf wrote:
> Until now, with auto-read-only=3Don we tried to open the file read-writ=
e
> first and if that failed, read-only was tried. This is actually not goo=
d
> enough for libvirt, which gives QEMU SELinux permissions for read-write=

> only as soon as it actually intends to write to the image. So we need t=
o
> be able to switch between read-only and read-write at runtime.
>=20
> This patch makes auto-read-only dynamic, i.e. the file is opened
> read-only as long as no user of the node has requested write
> permissions, but it is automatically reopened read-write as soon as the=

> first writer is attached. Conversely, if the last writer goes away, the=

> file is reopened read-only again.
>=20
> bs->read_only is no longer set for auto-read-only=3Don files even if th=
e
> file descriptor is opened read-only because it will be transparently
> upgraded as soon as a writer is attached. This changes the output of
> qemu-iotests 232.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c         | 36 +++++++++++++++++-------------------
>  tests/qemu-iotests/232.out | 12 ++++++------
>  2 files changed, 23 insertions(+), 25 deletions(-)

https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793 seems to be caused
by this patch: When the mirror job completes, it drops all permissions
on its target BB with an &error_abort.  As of this patch, this may
result in file-posix attempting to reopen the FD, which may fail.

There are two problems I can see: First, the previous patch should have
updated s->open_flags along with s->fd when the FD is switched.  As it
is now, s->open_flags is not updated, so it stays on O_RDONLY and every
time the permissions are checked, the FD is reconfigured and then switche=
d.

That's simple to fix, just add BDRVRawState.perm_change_flags and set it
to open_flags after raw_reconfigure_getfd() returned a ret !=3D s->fd
(when s->perm_change_fd is set).

That fixes the problem of file-posix attempting to reopen the FD to
O_RDWR all the time, which caused the crash.

But that gives us another crash, because now dropping the permissions
(correctly) reopens the FD to O_RDONLY, with the exact same implications
as above: If the target becomes unavailable, opening the new FD will
fail, and qemu will crash.

I don't know what to do about this.  In the spirit of "dropping
permissions should always work", I presume raw_reconfigure_getfd()
should just return the old FD if it had more permissions than the new
one would have.  But if the user issues an explicit reopen command, they
probably want such an error to be reported.

Max


--UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzHW6cACgkQ9AfbAGHV
z0AYnAf/e31fEFmLPwebhQ54XUV7sQY3UbPuQZmRgkRhybqBZlkS9wLuVcSxs6Kx
AXk9yibnxgKkEveYM/DVC//xkuoF6Vw43Auh23G6+mIhtg/i5Yd1lH4PiLVP3LKl
KHeg3JOrd/i2bU2GEIZ+NbMNNHpRlkTL4Kci7wtIS3CLqircxsG3Io2QkwnCFx8a
ARJrLDavh6AFSInSbAxliMPCDyVmBopgrmcCkb2dhlg2IBNcVLadVvR+k2OLINzh
1N2e73blfDbz1x5jluSOkIXbbjbvLr8JaYxH2FNwDb4mW7MUt1XnkUy/0LI/a+nr
vAtFFCq2V3QAF7PJL8Z6rvjFEIBJMQ==
=j151
-----END PGP SIGNATURE-----

--UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS--

