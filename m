Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF489C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB412206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0f7Idsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB412206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItqb-0006sN-RL
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jItlz-0004zE-KL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jItly-0002aK-MU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:44:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jItly-0002Zm-HH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585572250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n55/7I5xTgF2SK7KmE5MtVSSPxtmfviuZ0fYjgACcQs=;
 b=D0f7IdswUwGs/2UtzuSb9JX/pUdRrwNVCIon9ByXmA/EgHSR+OKDtM/Psz7gkL48TQ33cO
 s9ePe+htqVqp3vougGmJPfpl53xm/RGURhAFLLw99LUqq17BM6B4owBM8q0bzIxO5o4lCF
 vInRLhWXNrLO8gf6AuI9oguFtCMaI20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-2k4pYdC4M3mx0XsW6Olgew-1; Mon, 30 Mar 2020 08:44:07 -0400
X-MC-Unique: 2k4pYdC4M3mx0XsW6Olgew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFBAA1902EBE;
 Mon, 30 Mar 2020 12:44:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-93.ams2.redhat.com
 [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC26E60251;
 Mon, 30 Mar 2020 12:44:04 +0000 (UTC)
Subject: Re: [PATCH v9 10/14] iotests: add hmp helper with logging
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-11-jsnow@redhat.com>
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
Message-ID: <01994563-6ad2-5393-9be5-00a946ad5272@redhat.com>
Date: Mon, 30 Mar 2020 14:44:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-11-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1gzKVpHbQWJH47PZ07bs6YQtC8lKMVpkh"
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1gzKVpHbQWJH47PZ07bs6YQtC8lKMVpkh
Content-Type: multipart/mixed; boundary="9aSh4SlyPBU95lHDuKTYulPa2AnbEEkAn"

--9aSh4SlyPBU95lHDuKTYulPa2AnbEEkAn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 00:20, John Snow wrote:
> Just a mild cleanup while I was here.
>=20
> Although we now have universal qmp logging on or off, many existing
> callers to hmp functions don't expect that output to be logged, which
> causes quite a few changes in the test output.
>=20
> For now, just offer a use_log parameter.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9aSh4SlyPBU95lHDuKTYulPa2AnbEEkAn--

--1gzKVpHbQWJH47PZ07bs6YQtC8lKMVpkh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6B6ZIACgkQ9AfbAGHV
z0BGEgf/QX/cx8vPEUNCddfm/x9B5HsszdsMvQ5vO97Yq0vLD5G7h/ExsCGhXXv0
xj2B7Tq9odlxMRCTuHdkjJeu2c84qht3AZuXnhIAxb7u9amSu6xmQhR0FdQnErJH
NRFWYfIfSODbYmVGOYMDEu71yGIOrCVs2q1rNk2fOAEiZcqmC2fsDXhRwkwFYZJc
JUidKnEd87e1+4hCAmSg1Atejxd/IfOdNoG0UsOTY8ToknOpFtggcva7Iqq5aPGQ
e0wow0IXYoD279nJppV2CascSHZ0e9wgqPAt1B3LCNymAf+L9KYbfQok5JXtrwk1
+8XRNW26dzIGeoWgxd8HQLayfaXv2Q==
=7S+I
-----END PGP SIGNATURE-----

--1gzKVpHbQWJH47PZ07bs6YQtC8lKMVpkh--


