Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD8C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108122467B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4orDn/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108122467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RfO-0007BE-AS
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4ReZ-0005zo-FJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4ReY-0003Na-Ib
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:52:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60977
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4ReY-0003N9-EF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582127565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AjJkDQVymM6YhTjHc2FL5vTT9SCuqxh9VeaQevBlzKA=;
 b=Z4orDn/raUU2jhBNqKv7AwdNIwecmSZzzFUaShzHdABJRRr+doFIgVgWLuqLoey3XMu98D
 IMwllXrp4TNtrqLlby/js5nMoIeRmf/E/jcP2XMjGKxtVu8N6X7oj86RttulS21Xgquzym
 i8QPcpSCu3ziGyJmgrmx0ss7Q1VED2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-bYEyldOqNRGlyPAJKNezrg-1; Wed, 19 Feb 2020 10:52:40 -0500
X-MC-Unique: bYEyldOqNRGlyPAJKNezrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C37568010E5;
 Wed, 19 Feb 2020 15:52:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-32.ams2.redhat.com
 [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC92B7792F;
 Wed, 19 Feb 2020 15:52:33 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] iotests: add 282 luks qemu-img measure test
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200211160318.453650-1-stefanha@redhat.com>
 <20200211160318.453650-5-stefanha@redhat.com>
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
Message-ID: <82a9dce6-9b20-ce3d-b785-ee7124d3f57e@redhat.com>
Date: Wed, 19 Feb 2020 16:52:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211160318.453650-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1iQOyxJlgfLLz3nmkzz6vEF19OxizBNkJ"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1iQOyxJlgfLLz3nmkzz6vEF19OxizBNkJ
Content-Type: multipart/mixed; boundary="P2gfEsG5YPr59f97RlDHOm1Kn0nVM0tm5"

--P2gfEsG5YPr59f97RlDHOm1Kn0nVM0tm5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.02.20 17:03, Stefan Hajnoczi wrote:
> This test exercises the block/crypto.c "luks" block driver
> .bdrv_measure() code.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/282     | 93 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/282.out | 30 ++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 124 insertions(+)
>  create mode 100755 tests/qemu-iotests/282
>  create mode 100644 tests/qemu-iotests/282.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


--P2gfEsG5YPr59f97RlDHOm1Kn0nVM0tm5--

--1iQOyxJlgfLLz3nmkzz6vEF19OxizBNkJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5NWcAACgkQ9AfbAGHV
z0C9PwgAo2GQD9A6X5/AgprdSwkSnsbr0v8s44O0n9afbXeD5AkY6es+WmHbzrRM
aUFd9YGctwUtHDt1sv4RtxOvXa2Ry7/XQzkGSex1JbHffb/RwCGy3W6aBtip3Xvi
QREiCQB05yFW7DZn1eyBMS+pAO3iZy7ojzxt0ztDVzIanHrLCvdjG9GOwVaGauwr
HKmdNOH+kleXsA4ETOu8/gjjYNI3NYvJrjE77R5QS/jhGfufFUcD7gbiq6tDBxgm
2wJ4OAQiKXZsHY638IzQLR3l6JT6FxILb6oWMTR6cgluoaDr15v2AS1+Qp4QXTdn
Pm6BcfUQaFJjx785w63Ku1DFxzyr+g==
=15US
-----END PGP SIGNATURE-----

--1iQOyxJlgfLLz3nmkzz6vEF19OxizBNkJ--


