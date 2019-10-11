Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F1AC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FEC2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FEC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpvJ-0005Ux-BX
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIpuF-0004qo-7x
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIpuD-0006ft-Cz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIpu6-0006aO-Ls; Fri, 11 Oct 2019 04:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0CA4309BF02;
 Fri, 11 Oct 2019 08:04:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-40.ams2.redhat.com
 [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2FFA60BE1;
 Fri, 11 Oct 2019 08:04:00 +0000 (UTC)
Subject: Re: [PATCH 00/23] iotests: Add and use $SOCK_DIR
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20191010152457.17713-1-mreitz@redhat.com>
 <5f346ee9-9ffe-7290-eb0e-50d2ab28d363@redhat.com>
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
Message-ID: <ad97e658-2224-17e1-e7fd-383513244411@redhat.com>
Date: Fri, 11 Oct 2019 10:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5f346ee9-9ffe-7290-eb0e-50d2ab28d363@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wJ2njPjQbBUV0pwNt0ZK3WKHn8UcerH1K"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 11 Oct 2019 08:04:01 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wJ2njPjQbBUV0pwNt0ZK3WKHn8UcerH1K
Content-Type: multipart/mixed; boundary="VGGEyehxAvLMlLcszxKIAZK83WD60BoPC"

--VGGEyehxAvLMlLcszxKIAZK83WD60BoPC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 09:27, Thomas Huth wrote:
> On 10/10/2019 17.24, Max Reitz wrote:
>> Hi,
>>
>> Perhaps the main reason we cannot run important tests such as 041 in C=
I
>> is that when they care Unix sockets in $TEST_DIR, the path may become
>> too long to connect to them.
>>
>> To get by this problem, this series lets the check script create a new=

>> temporary directory (mktemp -d) and then makes the iotests use it for
>> all Unix sockets.
>=20
> Thanks a lot for tackling this!
>=20
> I gave it a try, and most tests work fine now indeed when I run them in=

> a directory with a veeeery long file name.
>=20
> I still get an error with 028 though:

Hm, I didn=E2=80=99t see any error for 028 or 055 myself.  028 makes use =
of
common.qemu, which uses FIFOs, and I thought there were exempt from this
problem.  And for 055 I have no idea.

Maybe just bugs in qemu? :-)

Max


--VGGEyehxAvLMlLcszxKIAZK83WD60BoPC--

--wJ2njPjQbBUV0pwNt0ZK3WKHn8UcerH1K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2gN24ACgkQ9AfbAGHV
z0Ck8Qf/bO6vw5Xklu56NlV27TwMS1h3UvZWexENd23Cys0d22lwxnRQCszaitR0
jc1LPW3/fCCaJmphbrz4Onmd+2z9zwDhwsJCcNnLGI3ijLsU8ueoJdmr4EWnr1J4
UlX7nmCnO3Rgr2StojrC+8+eoKCld5aTjCy1aMfs/4vXrURrG2omrmrcv49fM7uv
Qeou5WgWEIFOR6QcD15eJhtJPgxRZxAEVorZXhkZnfL/x7jzleh3d6Vn+MJGaU7t
gJBOJHKdL/wXPLtw4dT3wUc1yvT6h7vS0x4lM2Wj5AVR0zY5J0Q01GIMg36Md1P3
sX41VxpU6FUe9ArNK5ro9uy1zbWFbQ==
=XOJl
-----END PGP SIGNATURE-----

--wJ2njPjQbBUV0pwNt0ZK3WKHn8UcerH1K--

