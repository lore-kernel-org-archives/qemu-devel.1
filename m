Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0AC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792DE206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792DE206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlU7-00016y-Ri
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHlQi-0006AN-3f
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHlQg-0002SV-M4
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHlQR-00026P-VT; Tue, 08 Oct 2019 05:05:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3D92308FBA0;
 Tue,  8 Oct 2019 09:04:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7983919C68;
 Tue,  8 Oct 2019 09:04:57 +0000 (UTC)
Subject: Re: [PATCH 1/2] tests: Make iotest 223 easier to edit
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190924143522.22902-1-eblake@redhat.com>
 <20190924143522.22902-2-eblake@redhat.com>
 <7aea45cd-bada-4e90-9ee9-1bac19e3c7df@redhat.com>
 <40b49be4-950c-a71d-1803-af0b0b8d9eb5@redhat.com>
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
Message-ID: <7760a1ff-5034-cafa-1689-ced92994fa68@redhat.com>
Date: Tue, 8 Oct 2019 11:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <40b49be4-950c-a71d-1803-af0b0b8d9eb5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BfWVP3m2ltkhwo1jo5WzCFNWJVULQPbcz"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 08 Oct 2019 09:04:58 +0000 (UTC)
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
Cc: nsoffer@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BfWVP3m2ltkhwo1jo5WzCFNWJVULQPbcz
Content-Type: multipart/mixed; boundary="LexsU2PjBF04n8p71sST1Azybm0PVOayf"

--LexsU2PjBF04n8p71sST1Azybm0PVOayf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.10.19 22:06, Eric Blake wrote:
> On 10/7/19 7:05 AM, Max Reitz wrote:
>> On 24.09.19 16:35, Eric Blake wrote:
>>> Log the QMP input to qemu, not just the QMP output.
>>
>> Why not just add this functionality to _send_qemu_cmd directly?=C2=A0 =
(Like
>> silent already does for replies, although it=E2=80=99s inverted.)
>=20
> Interesting idea.=C2=A0 I'll give it a shot (it may have a larger effec=
t on
> more .out files, but that's probably a good thing).

I was thinking about making it conditional, like it=E2=80=99s done with t=
he
$silent parameter.  But I mean, there is actually no good reason for it
to print the output but omit the input, I suppose...  (Other than that
this change will affect many .out files, as you say)

Max

>> (Although I=E2=80=99m not quite sold on the indentation for commands, =
because
>> (1) we don=E2=80=99t do that in other tests, (2) I=E2=80=99d prefer so=
me prefix like
>> ->/<-, and (3) there is generally no need because commands start with
>> =E2=80=9Cexecute=E2=80=9D and replies start with =E2=80=9Creturn=E2=80=
=9D, =E2=80=9Cerror=E2=80=9D, or =E2=80=9Cevent=E2=80=9D, so they
>> already have clear prefixes to distinguish the two classes.)
>=20
> I don't mind avoiding indentation; as you say, direction can be inferre=
d
> by contents.
>=20



--LexsU2PjBF04n8p71sST1Azybm0PVOayf--

--BfWVP3m2ltkhwo1jo5WzCFNWJVULQPbcz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2cUTgACgkQ9AfbAGHV
z0Dy5gf+MHMkQF3k03rr8TWizC9HT7lSHX2EpZEY6I2BiXrT80rHtCgkUAYJ1N74
5YhL7OldGUEgwL7X+tGxOdRM5NEseUJfBAs/VdHlEcADIPIvSWlpmLGxZf5UcP+u
0xWHfqP96gyLpawbcr9VmMb/NO07FAmVozelPz0+iQ6TMu2un9MM09qsH/kLdVqG
Ov++B9RjQ97pCBklKjkEUQ8iBoGi6hs/ooboDGzIIrtovvbabQybczXzRcoeJ2wK
4XPYZoqisUv1v+RHv9IFNCA+7fnJXz9F390zKqj6ZPLxL/MyRkt2+60nYmx7XKHZ
JKiV/027MzHfgOmRm1Cve1eOX9NBHw==
=gci+
-----END PGP SIGNATURE-----

--BfWVP3m2ltkhwo1jo5WzCFNWJVULQPbcz--

