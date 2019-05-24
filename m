Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A8DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43D5206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43D5206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55257 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAwF-00021E-2s
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:12:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUAoc-0003KZ-5T
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUAgS-0002qk-Ly
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:56:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hUAgR-0002oj-4y; Fri, 24 May 2019 09:56:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84B0A36883;
	Fri, 24 May 2019 13:56:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-150.brq.redhat.com
	[10.40.204.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0749F5B689;
	Fri, 24 May 2019 13:56:22 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
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
Message-ID: <f2d129f6-b03f-aaa8-3e7d-fff48ea52233@redhat.com>
Date: Fri, 24 May 2019 15:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z6BS0W6hzbhXZNtvwVVTGneEoO4FxYQnO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 24 May 2019 13:56:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v14 0/1] qcow2: cluster space preallocation
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
	den@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z6BS0W6hzbhXZNtvwVVTGneEoO4FxYQnO
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com, vsementsov@virtuozzo.com
Message-ID: <f2d129f6-b03f-aaa8-3e7d-fff48ea52233@redhat.com>
Subject: Re: [PATCH v14 0/1] qcow2: cluster space preallocation
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.05.19 16:27, Anton Nefedov wrote:
> ..apparently v13 ended up in a weird base64 that would not easily git-a=
m.
> Resending.
>=20
> ----
>=20
> hi,
>=20
> this used to be a large 10-patches series, but now thanks to Kevin's
> BDRV_REQ_NO_FALLBACK series
> (http://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg06389.html)=

> the core block layer functionality is already in place: the existing fl=
ag
> can be reused.
>=20
> A few accompanying patches were also dropped from the series as those c=
an
> be processed separately.
>=20
> So,
>=20
> new in v13:
>    - patch 1 (was patch 9) rebased to use s->data_file pointer
>    - comments fixed/added
>    - other patches dropped ;)
>=20
> v12: http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg02761.h=
tml
> v11: http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg04342.h=
tml
> v10: http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00121.h=
tml
>=20
> ----
>=20
> This pull request is to start to improve a few performance points of
> qcow2 format:
>=20
>   1. non cluster-aligned write requests (to unallocated clusters) expli=
citly
>      pad data with zeroes if there is no backing data.
>      Resulting increase in ops number and potential cluster fragmentati=
on
>      (on the host file) is already solved by:
>        ee22a9d qcow2: Merge the writing of the COW regions with the gue=
st data
>      However, in case of zero COW regions, that can be avoided at all
>      but the whole clusters are preallocated and zeroed in a single
>      efficient write_zeroes() operation
>=20
>   2. moreover, efficient write_zeroes() operation can be used to preall=
ocate
>      space megabytes (*configurable number) ahead which gives noticeabl=
e
>      improvement on some storage types (e.g. distributed storage)
>      where the space allocation operation might be expensive)
>      (Not included in this patchset since v6).
>=20
>   3. this will also allow to enable simultaneous writes to the same una=
llocated
>      cluster after the space has been allocated & zeroed but before
>      the first data is written and the cluster is linked to L2.
>      (Not included in this patchset).
>=20
> Efficient write_zeroes usually implies that the blocks are not actually=

> written to but only reserved and marked as zeroed by the storage.
> Existing bdrv_write_zeroes() falls back to writing zero buffers if
> write_zeroes is not supported by the driver, so BDRV_REQ_NO_FALLBACK is=
 used.
>=20
> simple perf test:
>=20
>   qemu-img create -f qcow2 test.img 4G && \
>   qemu-img bench -c $((1024*1024)) -f qcow2 -n -s 4k -t none -w test.im=
g
>=20
> test results (seconds):
>=20
>     +-----------+-------+------+-------+------+------+
>     |   file    |    before    |     after    | gain |
>     +-----------+-------+------+-------+------+------+
>     |    ssd    |      61.153  |      36.313  |  41% |
>     |    hdd    |     112.676  |     122.056  |  -8% |
>     +-----------+--------------+--------------+------+

I=E2=80=99ve done a few more tests, and I=E2=80=99ve seen more slowdown o=
n an HDD.
(Like 30 % when doing 64 kB requests that are not aligned to clusters.)
 On the other hand, the SSD gain is generally in the same ballpark (38 %
when issuing the same kind of requests.)

On the basis that:

(1) I believe that SSD performance is more important than HDD performance=
,

(2) I can=E2=80=99t think of a simple way to automatically decide whether=
 the
new or the old codepath is more efficient[1], and

(3) users probably would not use a switch if we introduced one.

I have applied this patch to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Thanks!


[1] Hm.  We can probably investigate whether the file is stored on a
rotational medium or not.  Is there a fundamental reason why this patch
seems to degrade performance on an HDD but improves it on an SSD?  If
so, we can probably make a choice based on that.

Max


--Z6BS0W6hzbhXZNtvwVVTGneEoO4FxYQnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzn+AUACgkQ9AfbAGHV
z0C67QgAlrlN+mj82NuGoUntrryHq3vx09zByEpbaSNG3xrOdhGngC8YHKnee4Ij
qpnyhws+6JKApREtvdbsxqDjZOUk6MRbw32YyisJ4mvg1vjJn0jy5VfAA1UCtpsV
zmzjJYHJaA//Weor69zawHuW5JVjyT2U/JvZ0YaL3Le4D+W1bF7VFjLrvvKlIijd
wjZ515O/2FXvFZ03U/y8YXm49gGjpTE6XjfO2ap1J/8gBD77ElczVB6IVG9apmXJ
d8A698xUHGT/WpLWnUT/f9BJrNSmhmm72UYDASti/jcQho3oPxkrcyLhnnkkE3cR
UyznS/UHY7Wl44aMOACRu99u3L8RgQ==
=mJSW
-----END PGP SIGNATURE-----

--Z6BS0W6hzbhXZNtvwVVTGneEoO4FxYQnO--

