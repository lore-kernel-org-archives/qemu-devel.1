Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0BC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B899F20848
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9KChpcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B899F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBzhg-0000g4-TS
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 07:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBzgh-0000AI-2A
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBzgf-0006h4-Ui
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:38:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBzgf-0006da-PH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583926689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QAUQZRDfqhxAJ1YMP2OCIbax2GV5zpv7d/k3WXcwKhQ=;
 b=a9KChpcmsdEJVp1QuPtfeZNgWTWsmv9cYRC1R6xH7KsrI2iZ35qgMfFY77JPt2wHd2F+RR
 OSwRFiJ+v/Xbdnh/TK+iWXaKegf7dYXNXJ4B5+BVrgjKgCaDWcHB45TF1WjxxfMWLfZqpg
 0z8p+PMLXXe6mFbrPbqSglU7HgwUMk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-DfOrEDAWMVWKuy6tLwBeNw-1; Wed, 11 Mar 2020 07:38:03 -0400
X-MC-Unique: DfOrEDAWMVWKuy6tLwBeNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3592A101FC61;
 Wed, 11 Mar 2020 11:38:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-216.ams2.redhat.com
 [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B50B60BF4;
 Wed, 11 Mar 2020 11:37:59 +0000 (UTC)
Subject: Re: [PATCH v4 0/9] block-copy improvements: part I
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200311103004.7649-1-vsementsov@virtuozzo.com>
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
Message-ID: <ef8eb81d-32be-1360-11f4-743438b4b3e3@redhat.com>
Date: Wed, 11 Mar 2020 12:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311103004.7649-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WMt9GTf0T1AiNP6TudrEAQYUyNwZlGXWN"
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
Cc: kwolf@redhat.com, andrey.shinkevich@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WMt9GTf0T1AiNP6TudrEAQYUyNwZlGXWN
Content-Type: multipart/mixed; boundary="lB3n3pKltIE9W6tJ90UhNpfPjlvb2myEB"

--lB3n3pKltIE9W6tJ90UhNpfPjlvb2myEB
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.03.20 11:29, Vladimir Sementsov-Ogievskiy wrote:
> v4:
>=20
> 01: add Max's r-b
> 02: rm ProgressResetCallbackFunc typedef
> 03-06: add Max's r-b
> 07: fix indentation
> 08: update in_flight_bytes in block_copy_inflight_req_shrink
>     improve comment above block_copy() definition
> 09: add Andrey's and Max's r-b
>     drop hunk fixing indentation (merged to 07)
>=20
> Vladimir Sementsov-Ogievskiy (9):
>   job: refactor progress to separate object
>   block/block-copy: fix progress calculation
>   block/block-copy: specialcase first copy_range request
>   block/block-copy: use block_status
>   block/block-copy: factor out find_conflicting_inflight_req
>   block/block-copy: refactor interfaces to use bytes instead of end
>   block/block-copy: rename start to offset in interfaces
>   block/block-copy: reduce intersecting request lock
>   block/block-copy: hide structure definitions

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--lB3n3pKltIE9W6tJ90UhNpfPjlvb2myEB--

--WMt9GTf0T1AiNP6TudrEAQYUyNwZlGXWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5ozZUACgkQ9AfbAGHV
z0AhPQf/dRrBeEYOyugjOpoPUFmGPMqsxe+oKaDLKGcXHFIgPdX4JrnZeqTVDyNe
Eom4nGMdpcamKrZB85Sqm33wcl2t2695QZfdQ4qVR0O7y4BmmFie3B1MM19ck3gM
1glkDML6xwH0km8n5okbCYH0pfyxFZ1RCV+197D7/IC6PGQuSjtXbBfX0ZcJeBCz
ZUoiQ4yjDWVZ67WIclLJArofkBhMHmG5ccI4Jg4tJEX8E86O2F7V9xh7LetMfpWr
kMaNYoDBykBYx6rficzy8Una02fbsWadHDorz0Z8PohIraHhbUpPP8KolTBolfpN
6SMkgZnrtO8SVFoUdSp7kYa8oqx93g==
=IVDS
-----END PGP SIGNATURE-----

--WMt9GTf0T1AiNP6TudrEAQYUyNwZlGXWN--


