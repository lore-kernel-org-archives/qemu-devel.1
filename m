Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239CBC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E733720449
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E733720449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36455 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLtP-0005Qn-94
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:41:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOLsU-0004q4-H3
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOLsT-0006SH-Fl
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOLsN-0006EX-8c; Wed, 08 May 2019 08:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9ADA821EF;
	Wed,  8 May 2019 12:40:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-94.brq.redhat.com
	[10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F2F984502;
	Wed,  8 May 2019 12:40:43 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <aac34cba-a184-f059-20f1-fb1e7e219d0b@redhat.com>
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
Message-ID: <1a4339c6-b426-0972-246a-30494020751f@redhat.com>
Date: Wed, 8 May 2019 14:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aac34cba-a184-f059-20f1-fb1e7e219d0b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HKVCRnktd3va6TvGpgop1b7yp8TnJsXe0"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 08 May 2019 12:40:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] qemu iotest 192 does not clean up correctly
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HKVCRnktd3va6TvGpgop1b7yp8TnJsXe0
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>
Message-ID: <1a4339c6-b426-0972-246a-30494020751f@redhat.com>
Subject: Re: qemu iotest 192 does not clean up correctly
References: <aac34cba-a184-f059-20f1-fb1e7e219d0b@redhat.com>
In-Reply-To: <aac34cba-a184-f059-20f1-fb1e7e219d0b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.19 10:14, Thomas Huth wrote:
>=20
> I've ran into this failure today:
>=20
> 140 0s ... - output mismatch (see 140.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/140.out	2019-05-07 17:57:=
08.000000000 +0200
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/140.out.bad	2019-05-0=
8 07:19:23.000000000 +0200
> @@ -10,6 +10,8 @@
>  {"return": {}}
>  qemu-io: can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: Requ=
ested export not available
>  server reported: export 'drv' not present
> +mkfifo: cannot create fifo '/home/thuth/tmp/qemu-build/tests/qemu-iote=
sts/scratch/qmp-out-27628_0': File exists
> +mkfifo: cannot create fifo '/home/thuth/tmp/qemu-build/tests/qemu-iote=
sts/scratch/qmp-in-27628_0': File exists
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
>  *** done
>=20
> ... and indeed, there were lots of stale qmp-in-* and qmp-out-*
> files in my scratch directory, ultimately causing the above failure
> after a couple of days.
>=20
> After some more testing, it seems like test 192 is not cleaning up
> correctly:
>=20
> $ ls scratch/
> $ ./check -qcow2 192
> [...]
> 192 0s ...
> Passed all 1 tests
> $ ls scratch/
> nbd  qemu-0.pid  qmp-in-8772_0  qmp-out-8772_0
>=20
> Any ideas how to fix this in a clean way (e.g. simply add a
> "rm -f scratch/..." at the end of the script) ?

I think it=E2=80=99s just lacking a _cleanup_qemu.

Max


--HKVCRnktd3va6TvGpgop1b7yp8TnJsXe0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzSzkkACgkQ9AfbAGHV
z0A4xwf+OdcFbFWcFe5B+4TPJLLW1vlK2PTtUsds8+o6MJcGk20gV4/eTAHFhHNf
+CvyEMiY8rcn0vBR6T01yOTAtIyrB6w9ZU53RuJgKdkLZItEQSmlw4K9+yQu6ozR
jge+4YGMstKKt+nBss0qy8AMsawp0rZ0L/qKS9RNAmxT2fnErmVrZCDNbHgMEyAJ
57yO3N16kmkLU17OfbErB1qfrK/jqNlP+DYloS1VbNM7wFdj/GDg0dWSCHaGmjii
YWUfw3vMmB4xaJiQuBjgUtnQwVpmeKViFHDiuzZXKh/1lBVHRFu83NlNClpl1Hh9
HNBMcfjw4eprmkoeCx3Wpf/iHB2sxw==
=r0fA
-----END PGP SIGNATURE-----

--HKVCRnktd3va6TvGpgop1b7yp8TnJsXe0--

