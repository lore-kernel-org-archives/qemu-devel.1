Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38C0C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1A720786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnwvqUfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1A720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhHC-0005hE-MG
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGhGZ-0004rK-MZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGhGY-00074W-A3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:58:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGhGY-00074B-4W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585047517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=18+2TqYH0sHjDBUbdE0XjiWvVI0eVItk+tYKs3iD1Fg=;
 b=VnwvqUfgTDNa4pQbWpWtVNtYfOnDjzox4KqFEWCiiXB6Xqg47MuGRGrq/UC0+B4fCKhq5W
 vpfXjL6rrN2h+c4iINY42Rzww/SZfOREUcLQpj+an5QUjXd+ibQx7TMaEBVJp8wWsrKm6j
 6X0XuAEXJ1r2+D0PhROqhpYPMS0JeVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-3AeuZgBkOhOAgpYRFVo52w-1; Tue, 24 Mar 2020 06:58:35 -0400
X-MC-Unique: 3AeuZgBkOhOAgpYRFVo52w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 980C71055538;
 Tue, 24 Mar 2020 10:58:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EA415ED35;
 Tue, 24 Mar 2020 10:58:30 +0000 (UTC)
Subject: Re: [PATCH] iotests: Fix cleanup path in some tests
To: qemu-block@nongnu.org
References: <20200224171631.384314-1-mreitz@redhat.com>
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
Message-ID: <b9817305-c8c2-e63d-7dc5-13345fa5e4a7@redhat.com>
Date: Tue, 24 Mar 2020 11:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200224171631.384314-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7SQOuL7DlYf2bot1CYNRZ4uotn4FZJSkm"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
--7SQOuL7DlYf2bot1CYNRZ4uotn4FZJSkm
Content-Type: multipart/mixed; boundary="2dCdrKdGNhdUhcT7PpL1sHATaghDuycS2"

--2dCdrKdGNhdUhcT7PpL1sHATaghDuycS2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.02.20 18:16, Max Reitz wrote:
> Some iotests leave behind some external data file when run for qcow2
> with -o data_file.  Fix that.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/085 | 1 +
>  tests/qemu-iotests/087 | 6 ++++++
>  tests/qemu-iotests/279 | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)

Thanks for the review, applied to my block branch.

Max


--2dCdrKdGNhdUhcT7PpL1sHATaghDuycS2--

--7SQOuL7DlYf2bot1CYNRZ4uotn4FZJSkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5559MACgkQ9AfbAGHV
z0B+wAgAqJ04L7RO1T1orMBYKr9XZ5yMphS/CMplJIaA2q+xBVFhZMKddhmhyd5s
UW+syiF3ah6/rhj1DZ/xAb2VC7+WYij0OpvoTgkSqiWcQAxIoTKSRdt2WtcGdfcD
hgAGA5UI1jVx43/5YOQqJYhW4oHzEFw61p0I3iAmo2gsuk9b2SuGWNM4YGmgT/z2
RnjgzY6gQOh8apCLvbRhyI/xqr+6Cji0t/aKdfZjL7nS1jbg3S174VR/6bbFLzqm
6sgspAA84ej12E7FS//tuevKreTCugJrFjhCinF0/1P17FtPMZCaA1Q5BhJCCHPt
Qh/VRy9zAlWJRuq6XNO7GfzS5+d5Fg==
=wubq
-----END PGP SIGNATURE-----

--7SQOuL7DlYf2bot1CYNRZ4uotn4FZJSkm--


