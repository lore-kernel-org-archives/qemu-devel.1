Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEF6CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82DE20656
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4Tn6lrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82DE20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMW6N-00039U-Kp
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMW3D-00083V-BP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMW3B-0007nd-NP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:40:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38271
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMW3B-0007mq-HI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571658035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=STfqfLBYxA/Gob9KNl38W5XGhCLo0Qrkgql6Cgo624s=;
 b=H4Tn6lrxvzgUpwaambsYrg/Vo1GP9GG21bfMiQwOKuHLiTnvFTfCLgI7yMuILZFLLGSO1z
 TvBH2RGZpgad48sWJCm0+4sICpwc6BxFbAkRi2jMZk9eF5mtAyL+/0ABTmW+rqELJ7qsw8
 ASArVWOziblJESsuJQi8U7VkXaV6/7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-aJB-BtnfOaiaQye-08Vs2g-1; Mon, 21 Oct 2019 07:40:32 -0400
X-MC-Unique: aJB-BtnfOaiaQye-08Vs2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F831800DC7;
 Mon, 21 Oct 2019 11:40:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-17.ams2.redhat.com
 [10.36.117.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BC355D9E2;
 Mon, 21 Oct 2019 11:40:29 +0000 (UTC)
Subject: Re: Problems with c8bb23cbdbe3 on ppc64le
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
References: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
 <5ba5d289-4450-135c-f058-a7e498725058@virtuozzo.com>
 <cd53cd86-e93c-297a-c08e-3fc1ae2618ac@redhat.com>
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
Message-ID: <4c61a0ba-3a75-fffb-a724-4f4700eaa111@redhat.com>
Date: Mon, 21 Oct 2019 13:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <cd53cd86-e93c-297a-c08e-3fc1ae2618ac@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q8XEDnvbfCWVR6buquzqooxXRlGB6wUEe"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
--Q8XEDnvbfCWVR6buquzqooxXRlGB6wUEe
Content-Type: multipart/mixed; boundary="5Iz8RuRXY8bOXiDfTxCec1zPcEmC4hWrD"

--5Iz8RuRXY8bOXiDfTxCec1zPcEmC4hWrD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 09:49, Max Reitz wrote:
> On 10.10.19 18:15, Anton Nefedov wrote:
>> On 10/10/2019 6:17 PM, Max Reitz wrote:
>>> Hi everyone,
>>>
>>> (CCs just based on tags in the commit in question)
>>>
>>> I have two bug reports which claim problems of qcow2 on XFS on ppc64le
>>> machines since qemu 4.1.0.  One of those is about bad performance
>>> (sorry, is isn=E2=80=99t public :-/), the other about data corruption
>>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1751934).
>>>
>>> It looks like in both cases reverting c8bb23cbdbe3 solves the problem
>>> (which optimized COW of unallocated areas).
>>>
>>> I think I=E2=80=99ve looked at every angle but can=E2=80=98t find what =
could be wrong
>>> with it.  Do any of you have any idea? :-/
>>>
>>
>> hi,
>>
>> oh, that patch strikes again..
>>
>> I don't quite follow, was this bug confirmed to happen on x86? Comment 8
>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1751934#c8) mentioned tha=
t
>> (or was that mixed up with the old xfsctl bug?)
>=20
> I think that was mixed up with the xfsctl bug, yes.
>=20
>> Regardless of the platform, does it reproduce? That's comforting
>> already; worst case we can trace each and every request then (unless it
>> will stop to reproduce this way).
>=20
> I haven=E2=80=99t been able to reproduce it yet (wrestling with the test =
system
> and getting ppc64 machines provisioned), but as far as I know it
> reproduces reliably on ppc64, but only there.
>=20
>> Also, perhaps it's worth to try to replace fallocate with write(0)?
>> Either in qcow2 (in the patch, bdrv_co_pwrite_zeroes -> bdrv_co_pwritev)
>> or in the file driver. It might hint whether it's misbehaving fallocate
>> (in qemu or in kernel) or something else.
>=20
> Good idea, that should at least tell us something about the corruption.

OK, after a week of debugging I=E2=80=99m not really much wiser.

One thing I know is that I can see the issue on x86-64 now, but not on
ext4, only XFS.

Replacing the zero-write with actually writing zeroes fixes it, but I
still don=E2=80=99t know whether that=E2=80=99s because of the kernel or be=
cause the
write is just slower or takes another code path...

The only thing I could narrow it down to is this:

The issue persists if handle_alloc_space() writes zeroes (with a
narrowed aligned zero-write with NO_FALLBACK) only to the non-COW area,
and I keep skip_cow to be false.

So there seems to be some kind of interaction between the zero-write and
the following write of data.  I don=E2=80=99t know what kind of interaction=
 that
is, though.  I have tried to write a test case in qemu-img (basically
rewriting qemu-img bench), but failed so far.

It certainly looks like a kernel issue, but without a simpler reproducer
I just cannot tell.

Max


--5Iz8RuRXY8bOXiDfTxCec1zPcEmC4hWrD--

--Q8XEDnvbfCWVR6buquzqooxXRlGB6wUEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2tmSsACgkQ9AfbAGHV
z0Dd6Af9GqirJaWzsmjDVypVl4AuiNwYUgMkHJY7bVHEzp+GGVbl1d0ae8guMcAD
b558gHDw7jIc9bmUkVn+qECBCZwMTJKUEnx6lCa6hCRd3NzaiiijmMznc4Ne1I5e
zLK3gzytW1iVo3IoP23XLpk9d/K+ePZ5A7xh+8mcAvTZWBbht+RXZ031Q+qse1ot
qWFSV2pFFGukucaBvHlPOQ4gZyeXopjmHoLsAlnT6+qQc2LSeX8lPd6UVpdCtOUk
wXdH5y+yJKeEKw2l686l1b6Yn8IcoUx1khNjg0j7pFG8SFH40uAetBUjz1urddAi
uRLpgQcEX7oxesilZGwlKJTgsENsfQ==
=9fQy
-----END PGP SIGNATURE-----

--Q8XEDnvbfCWVR6buquzqooxXRlGB6wUEe--


