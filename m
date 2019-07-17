Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B533C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F7A205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F7A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnjFC-0002Fu-Lb
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 08:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnjF1-0001ql-Sh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnjEy-0003K3-CM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnjEv-0003GS-AE; Wed, 17 Jul 2019 08:40:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E814335D0;
 Wed, 17 Jul 2019 12:40:56 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E0935C21A;
 Wed, 17 Jul 2019 12:40:51 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <bb3c5cc1-6aa6-ccae-455d-b9b4bf6479a5@redhat.com>
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
Message-ID: <9fad7a25-a02b-ddca-2543-d4305f40c0db@redhat.com>
Date: Wed, 17 Jul 2019 14:40:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bb3c5cc1-6aa6-ccae-455d-b9b4bf6479a5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3hP63uJsj6Pb7kEE9tIqOWXfuED1Ym5De"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 17 Jul 2019 12:40:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] iotest 141 fails with qed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3hP63uJsj6Pb7kEE9tIqOWXfuED1Ym5De
Content-Type: multipart/mixed; boundary="evlaeco8osi8BhqsF3IsThtJMp1ZxT6Gu";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <9fad7a25-a02b-ddca-2543-d4305f40c0db@redhat.com>
Subject: Re: iotest 141 fails with qed
References: <bb3c5cc1-6aa6-ccae-455d-b9b4bf6479a5@redhat.com>
In-Reply-To: <bb3c5cc1-6aa6-ccae-455d-b9b4bf6479a5@redhat.com>

--evlaeco8osi8BhqsF3IsThtJMp1ZxT6Gu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.07.19 14:35, Thomas Huth wrote:
> FWIW, I've got a new iotest failure with current master branch:
>=20
> $ ./check -qed 141
> QEMU          -- "/tmp/qemu/tests/qemu-iotests/../../x86_64-softmmu/qem=
u-system-x86_64" -nodefaults -machine accel=3Dqtest
> QEMU_IMG      -- "/tmp/qemu/tests/qemu-iotests/../../qemu-img"=20
> QEMU_IO       -- "/tmp/qemu/tests/qemu-iotests/../../qemu-io"  --cache =
writeback -f qed
> QEMU_NBD      -- "/tmp/qemu/tests/qemu-iotests/../../qemu-nbd"=20
> IMGFMT        -- qed
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.21.3.el7.x86_64
> TEST_DIR      -- /tmp/qemu/tests/qemu-iotests/scratch
> SOCKET_SCM_HELPER -- /tmp/qemu/tests/qemu-iotests/socket_scm_helper
>=20
> 141      fail       [14:31:35] [14:31:36]                    output mis=
match (see 141.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/141.out	2019-07-15 17:37:=
59.000000000 +0200
> +++ /tmp/qemu/tests/qemu-iotests/141.out.bad	2019-07-17 14:31:36.142127=
948 +0200
> @@ -42,9 +42,9 @@
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
> -{"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0=
, "speed": 0, "type": "commit"}}
> +{"return": {}}
>  {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: bloc=
k device is in use by block job: commit"}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
> Failures: 141
> Failed 1 of 1 tests
>=20
> IIRC this was working fine two months ago (at least I don't remember
> having seen it at that point in time).

You are correct.

Vladimir proposed a fix for this:

https://lists.nongnu.org/archive/html/qemu-block/2019-05/msg00982.html

But he never sent a patch, so I guess I=E2=80=99ll have to make it a patc=
h, then.

Max


--evlaeco8osi8BhqsF3IsThtJMp1ZxT6Gu--

--3hP63uJsj6Pb7kEE9tIqOWXfuED1Ym5De
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0vF1EACgkQ9AfbAGHV
z0B0jgf/XqAkL/kWzzZ/8Vl9G4C8383V2XtFuVBjks/ySArMZ8A1CjTL+hJ/CFvU
Lsj7Z4/jTrJC8uCo8g4jxBKAmMWV7hyhwoQmHJdmdCy+dDs0ze4tnmPmpO4M/wSa
L5lrWqnMPCyLQqLy5W6puhsKC4Z02HlI8+XDvnfx7HnUtUSr1JJxnoJjsZoRkT8t
Azkpe2tBO0LScwIvja6FivjopAV7W4+PRQaBHQbxx7aghOFZmbXl6/OTspwrwdip
KCj/OIWcHUkpxJCT2tklPe+TYav7XtNByd4N111ldX3yMbhva0BUtSh7Xf5UEzUX
92n/05JLnji9TBAOUQhrKeaKPwPChQ==
=Hm7u
-----END PGP SIGNATURE-----

--3hP63uJsj6Pb7kEE9tIqOWXfuED1Ym5De--

