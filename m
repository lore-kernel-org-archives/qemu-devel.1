Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0757CC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3DD206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3DD206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHRSr-0002SY-Vk
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 07:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHRRf-0001Vo-7B
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHRRd-00065g-Kq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:44:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHRRY-000648-7l; Mon, 07 Oct 2019 07:44:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1F2BC057F88;
 Mon,  7 Oct 2019 11:44:46 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B3856061E;
 Mon,  7 Oct 2019 11:44:45 +0000 (UTC)
Subject: Re: [PATCH 0/2] enhance iotest 223 coverage
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190924143522.22902-1-eblake@redhat.com>
 <8463a76e-74d7-7785-79f4-563cd78182a5@virtuozzo.com>
 <473f7df2-9845-d90e-6dc9-0542ec2c3c76@redhat.com>
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
Message-ID: <e050358d-95a9-78b3-c219-a708bee75da6@redhat.com>
Date: Mon, 7 Oct 2019 13:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <473f7df2-9845-d90e-6dc9-0542ec2c3c76@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F6a5Z1Hq9xsvpekMmHLpHSz4HrXxi8YD8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 07 Oct 2019 11:44:46 +0000 (UTC)
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
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F6a5Z1Hq9xsvpekMmHLpHSz4HrXxi8YD8
Content-Type: multipart/mixed; boundary="dJ2bDdtNcNO6F7SpBD28vUavygR884TxA"

--dJ2bDdtNcNO6F7SpBD28vUavygR884TxA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.09.19 21:51, Eric Blake wrote:
> On 9/24/19 2:26 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 24.09.2019 17:35, Eric Blake wrote:
>>> Commit 506902c6 dropped non-iothread coverage in order to test iothre=
ad,
>>> better is to run things twice.  In doing this, I found it easier to
>>> edit the test when the log shows what commands were triggering variou=
s
>>> responses.
>>
>> Did you consider adding -iothread to tests/qemu-iotests/check instead,=
 to be
>> able to run any (or some) tests with or without iothread?
>=20
> I don't know how many of the existing iotests would benefit from the
> ability supply iothread as an option, nor how likely it is that someone=

> would actually remember to run the testsuite twice to cover the use of
> that option.

I would, because I already run all qcow2 tests without any creation
options, with compat=3D0.10, and with refcount_bits=3D1.  (And plan to ad=
d
data_file=3D$TEST_IMG.data_file in the future.)

(And I let the iotests run through a script from some json description
files, so I won=E2=80=99t forget.)

> I also don't know how hard it would be to retrofit the
> addition of optional iothread support into all the tests.

That I don=E2=80=99t know either.  Though I think the point wouldn=E2=80=99=
t be to
retrofit iothread support into all tests, but just start with some.
(For example, 262 uses =E2=80=9Can iothread just for fun=E2=80=9D.  So it=
 could clearly
run with both configurations.)

I do think it=E2=80=99s an interesting idea, but I don=E2=80=99t think it=
=E2=80=99s important
right now.

Max

> Rather, I
> addressed the more immediate concern of the fact that my recent additio=
n
> to using iothread in 223 lost the previous ability of that test to cove=
r
> non-iothread, and where this patch series now makes it cover both
> scenarios with a single iotests run.
>=20



--dJ2bDdtNcNO6F7SpBD28vUavygR884TxA--

--F6a5Z1Hq9xsvpekMmHLpHSz4HrXxi8YD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bJSsACgkQ9AfbAGHV
z0DTlgf/abOxlG3ICCM+Rsz1P1+3yCwEWMQ8riG25i879Mp51ZPWXhKau9nyy8xs
gyJeU/c0+6QTRFaNc4DEzUpPPAweRxFmysGjBeRkZaKnutMrtzB24ftB2NYokby4
0yITeDstFRyHcLo+gh+DmkmRFueh0SoL89V8LAFTcVbelTO+3m3U8sYGFz5HsRNM
rRuV1PHe7fTF4rWUwTrN9vDiEk0CFjRJ10luQHMTFxT6KLF3/CXlF9qy0r7Yz0/3
vC7huki6uy9vZaKNt9wiUsP2WEpyGs2F3i+aW54faJ0kpaq/dtWKXC3e2Ej1LOaw
obYhcS0nF13y/tDV+YE1G0Uz+SthjQ==
=tBZh
-----END PGP SIGNATURE-----

--F6a5Z1Hq9xsvpekMmHLpHSz4HrXxi8YD8--

