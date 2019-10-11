Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B208FECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F2020679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F2020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpkY-000443-Of
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIpft-0006wK-6v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIpfs-00065j-0e
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIpfp-00062r-AW; Fri, 11 Oct 2019 03:49:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81A7C18CB8E0;
 Fri, 11 Oct 2019 07:49:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-40.ams2.redhat.com
 [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF1835D9DC;
 Fri, 11 Oct 2019 07:49:14 +0000 (UTC)
Subject: Re: Problems with c8bb23cbdbe3 on ppc64le
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
References: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
 <5ba5d289-4450-135c-f058-a7e498725058@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <cd53cd86-e93c-297a-c08e-3fc1ae2618ac@redhat.com>
Date: Fri, 11 Oct 2019 09:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5ba5d289-4450-135c-f058-a7e498725058@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SsADHb2C5JxHd56Kv6KZFI5komTiO6KuA"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 07:49:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SsADHb2C5JxHd56Kv6KZFI5komTiO6KuA
Content-Type: multipart/mixed; boundary="hxaVx7MgZUtnqJ1Ca31TBJTencdfFQ1ov"

--hxaVx7MgZUtnqJ1Ca31TBJTencdfFQ1ov
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.10.19 18:15, Anton Nefedov wrote:
> On 10/10/2019 6:17 PM, Max Reitz wrote:
>> Hi everyone,
>>
>> (CCs just based on tags in the commit in question)
>>
>> I have two bug reports which claim problems of qcow2 on XFS on ppc64le=

>> machines since qemu 4.1.0.  One of those is about bad performance
>> (sorry, is isn=E2=80=99t public :-/), the other about data corruption
>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1751934).
>>
>> It looks like in both cases reverting c8bb23cbdbe3 solves the problem
>> (which optimized COW of unallocated areas).
>>
>> I think I=E2=80=99ve looked at every angle but can=E2=80=98t find what=
 could be wrong
>> with it.  Do any of you have any idea? :-/
>>
>=20
> hi,
>=20
> oh, that patch strikes again..
>=20
> I don't quite follow, was this bug confirmed to happen on x86? Comment =
8
> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1751934#c8) mentioned th=
at
> (or was that mixed up with the old xfsctl bug?)

I think that was mixed up with the xfsctl bug, yes.

> Regardless of the platform, does it reproduce? That's comforting
> already; worst case we can trace each and every request then (unless it=

> will stop to reproduce this way).

I haven=E2=80=99t been able to reproduce it yet (wrestling with the test =
system
and getting ppc64 machines provisioned), but as far as I know it
reproduces reliably on ppc64, but only there.

> Also, perhaps it's worth to try to replace fallocate with write(0)?
> Either in qcow2 (in the patch, bdrv_co_pwrite_zeroes -> bdrv_co_pwritev=
)
> or in the file driver. It might hint whether it's misbehaving fallocate=

> (in qemu or in kernel) or something else.

Good idea, that should at least tell us something about the corruption.

Max


--hxaVx7MgZUtnqJ1Ca31TBJTencdfFQ1ov--

--SsADHb2C5JxHd56Kv6KZFI5komTiO6KuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2gM/cACgkQ9AfbAGHV
z0DYYQgAg6+lu0lI4EpHsdYyOjmwi2cZJ5klnu8QNcSxdMqigxgtM8Wt/udzm6qV
Qgy+e1h0k6SiUTii/7OZ0hzUPRtmM/ZkYPD8dMHzacBkCx5AVdgf567n7W8D+BRt
XHJFxP+obnRM+gePM7w2RvCqorVxarxTrYnVoCfrsrHqSGhVzrNONMTrVw0oe07y
sPX8I7+PcZUx0k6tWeDebIqZXdB1p6/hHWFxnZxiOKy5RvCmSeY/N4TNq/1yRq5m
idcCjEa3jHDUyhlIGHMLw2uNNS5N7K6AH/ql8zzr8pbhOWjJ+sbI08WtYoCWhZg5
qsRHTay4hP510NLVMe8PJL/8xai7eA==
=R9Rn
-----END PGP SIGNATURE-----

--SsADHb2C5JxHd56Kv6KZFI5komTiO6KuA--

