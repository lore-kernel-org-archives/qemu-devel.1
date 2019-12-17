Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE05420733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7IS6HJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE05420733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihD0U-0008Ui-Qq
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 08:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihCzn-0007zF-Td
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihCzl-00064K-3v
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:34:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihCzk-00061e-Lv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576589675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SukMhDbQfpgalRVMVitVWO+CmK51TUWjIjwOxybNsZg=;
 b=K7IS6HJWA+PDCrIKQ3WDgypDDoPNUFd6Zy4fk7TL+cGW/dz/v2TGBD6d3EI4cOcZNw3+OX
 CfRFs+CsTh2uGbz2shUElB5xhHBH/12kjte3S5W4jyxzvNwcETrLTsCjV9gbqavfHj7MHF
 l6dCG9yI5L3TUu8Uh+37zxV4AJyBqPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-b5__LYqlOB62qI0h_AIaow-1; Tue, 17 Dec 2019 08:34:33 -0500
X-MC-Unique: b5__LYqlOB62qI0h_AIaow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA06800053;
 Tue, 17 Dec 2019 13:34:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D93061000325;
 Tue, 17 Dec 2019 13:34:31 +0000 (UTC)
Subject: Re: [PATCH] blockjob: Fix error message for negative speed
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191126134222.16340-1-kwolf@redhat.com>
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
Message-ID: <5476f6f8-ce61-d487-9399-fcb5eeda1f8a@redhat.com>
Date: Tue, 17 Dec 2019 14:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126134222.16340-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3ryRHFK3WmBQsCNfSLKi5TPX1igOLcm4W"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ryRHFK3WmBQsCNfSLKi5TPX1igOLcm4W
Content-Type: multipart/mixed; boundary="Y4j9CE1ZDVAIzwDEfnHYOu0hWIPX1WJ9v"

--Y4j9CE1ZDVAIzwDEfnHYOu0hWIPX1WJ9v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.11.19 14:42, Kevin Wolf wrote:
> The error message for a negative speed uses QERR_INVALID_PARAMETER,
> which implies that the 'speed' option doesn't even exist:
>=20
>     {"error": {"class": "GenericError", "desc": "Invalid parameter 'speed=
'"}}
>=20
> Make it use QERR_INVALID_PARAMETER_VALUE instead:
>=20
>     {"error": {"class": "GenericError", "desc": "Parameter 'speed' expect=
s a non-negative value"}}
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockjob.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This needs an update to iotest 030.

Max


--Y4j9CE1ZDVAIzwDEfnHYOu0hWIPX1WJ9v--

--3ryRHFK3WmBQsCNfSLKi5TPX1igOLcm4W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl342WUACgkQ9AfbAGHV
z0Bkpgf/bJqtHB6UUvEhuNiVEv39VGvKaUJu+nfRHHZZMbnGMwzScGI3i1IQ5ufh
Prb0Og8UClGp4Aft/7XtXyZQHgS8ESkfZEgL+feIbHqrtcuxVOYcvvH8uaqn3vQW
x5qjD/eBXu0djfW9ZYDyiJvZbxjxYMaME1Ybi/FTCeAh4V5/ucsi06NRfKsF+PK2
8c5ZNDeiFla5F09VzZ0y6rPLcaayO42joTWdoLzPa3rb3uaEwFpO4y7o7tElpSHc
vjbAocrr9eE8GUmAbnLKjROekfFTQeKPjWeD7Brl1Musp2bR5ki5VjcSnJRUgap6
Ox7fYK4H8PGE48sDYqVZWOSKPirlcQ==
=zJC7
-----END PGP SIGNATURE-----

--3ryRHFK3WmBQsCNfSLKi5TPX1igOLcm4W--


