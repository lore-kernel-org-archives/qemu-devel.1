Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1298C74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9744D20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9744D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlEGF-00059r-4c
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 11:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlEFW-0004fF-Mc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlEFU-000881-J5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:11:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlEFL-0007ZC-Pz; Wed, 10 Jul 2019 11:11:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94CB6307D915;
 Wed, 10 Jul 2019 15:10:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 683615FCB9;
 Wed, 10 Jul 2019 15:10:54 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-2-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <ea1c21bf-c281-75e9-9f54-3fd39df5d286@redhat.com>
Date: Wed, 10 Jul 2019 17:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190710010556.32365-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C58Wt9ig9ZvwfmTzhK6XyPFG5xJDF2HYF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 10 Jul 2019 15:10:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/8] iotests/257: add Pattern class
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C58Wt9ig9ZvwfmTzhK6XyPFG5xJDF2HYF
Content-Type: multipart/mixed; boundary="HbHQOagNmxE0ArXhWFxT4liZa3sAG0V0j";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <ea1c21bf-c281-75e9-9f54-3fd39df5d286@redhat.com>
Subject: Re: [PATCH 1/8] iotests/257: add Pattern class
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-2-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-2-jsnow@redhat.com>

--HbHQOagNmxE0ArXhWFxT4liZa3sAG0V0j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 03:05, John Snow wrote:
> Just kidding, this is easier to manage with a full class instead of a
> namedtuple.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/257 | 58 +++++++++++++++++++++++-------------------=

>  1 file changed, 32 insertions(+), 26 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--HbHQOagNmxE0ArXhWFxT4liZa3sAG0V0j--

--C58Wt9ig9ZvwfmTzhK6XyPFG5xJDF2HYF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0l//wACgkQ9AfbAGHV
z0AHmQf8D48GxGwrVYihR1Q9NeZ1HkpqwyLHnDfmLZDD9f9r9PiMP8v2Dske7Zj5
bOKB+RsfvSzggusr4XLbwiejF7Hlxv0NURq8JujoPCHWU2IFXAQc4c0874TFJNrh
+ujdKI9A9MiZ4n5faFuHCyJRhN7bjVMA6Xft4PlHdr9BuvgdhPndalmN8gg4noBz
aicnTUauwMhevgxM8dejRYP536KkV6cQJ+e4nNAhZefrZg6PkdUV8rhRONp8frHz
70Z/bNdt6xiZIUnMdbzyGJHoevryOdAfiptC10U/oFbiE33Kt0hSi3AlUJ1MluSi
aVbaf6t5fWrf/KWnAAJ5istjigEgQQ==
=FLQn
-----END PGP SIGNATURE-----

--C58Wt9ig9ZvwfmTzhK6XyPFG5xJDF2HYF--

