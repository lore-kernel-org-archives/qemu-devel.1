Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97366C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED2720665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED2720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOVl-0001sU-0e
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCOQR-0007YJ-9N
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCOQQ-0002xv-3L
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCOQM-0002vS-BX; Mon, 23 Sep 2019 09:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70424A2667F;
 Mon, 23 Sep 2019 13:30:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E55F910013D9;
 Mon, 23 Sep 2019 13:30:36 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] iotests: add script_initialize
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-3-jsnow@redhat.com>
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
Message-ID: <07f8a7ea-a438-0ad2-580d-3e57e0ccf4a2@redhat.com>
Date: Mon, 23 Sep 2019 15:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917234549.22910-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E0z6RlZRpdA6HO16aBNl8JARDIZWjAFTe"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 23 Sep 2019 13:30:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E0z6RlZRpdA6HO16aBNl8JARDIZWjAFTe
Content-Type: multipart/mixed; boundary="npctU2YW1hQQCHUxxu4ZxE8eeybzJFSur";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <07f8a7ea-a438-0ad2-580d-3e57e0ccf4a2@redhat.com>
Subject: Re: [PATCH v5 2/5] iotests: add script_initialize
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-3-jsnow@redhat.com>
In-Reply-To: <20190917234549.22910-3-jsnow@redhat.com>

--npctU2YW1hQQCHUxxu4ZxE8eeybzJFSur
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 01:45, John Snow wrote:
> Like script_main, but doesn't require a single point of entry.
> Replace all existing initialization sections with this drop-in replacem=
ent.
>=20
> This brings debug support to all existing script-style iotests.
>=20
> Any specification for supported_oses=3D['linux'] was dropped as explain=
ed
> in the previous commit, because there was never any reason to limit pyt=
hon
> tests to linux-only.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/149        |  3 +-
>  tests/qemu-iotests/194        |  3 +-
>  tests/qemu-iotests/202        |  3 +-
>  tests/qemu-iotests/203        |  3 +-
>  tests/qemu-iotests/206        |  2 +-
>  tests/qemu-iotests/207        |  2 +-
>  tests/qemu-iotests/208        |  2 +-
>  tests/qemu-iotests/209        |  2 +-
>  tests/qemu-iotests/210        |  2 +-
>  tests/qemu-iotests/211        |  2 +-
>  tests/qemu-iotests/212        |  2 +-
>  tests/qemu-iotests/213        |  2 +-
>  tests/qemu-iotests/216        |  3 +-
>  tests/qemu-iotests/218        |  2 +-
>  tests/qemu-iotests/219        |  2 +-
>  tests/qemu-iotests/222        |  5 ++-
>  tests/qemu-iotests/224        |  3 +-
>  tests/qemu-iotests/228        |  3 +-
>  tests/qemu-iotests/234        |  3 +-
>  tests/qemu-iotests/235        |  4 +--
>  tests/qemu-iotests/236        |  2 +-
>  tests/qemu-iotests/237        |  2 +-
>  tests/qemu-iotests/238        |  2 ++
>  tests/qemu-iotests/242        |  2 +-
>  tests/qemu-iotests/246        |  2 +-
>  tests/qemu-iotests/248        |  2 +-
>  tests/qemu-iotests/254        |  2 +-
>  tests/qemu-iotests/255        |  2 +-
>  tests/qemu-iotests/256        |  2 +-
>  tests/qemu-iotests/262        |  3 +-
>  tests/qemu-iotests/iotests.py | 62 ++++++++++++++++++++++-------------=

>  31 files changed, 73 insertions(+), 63 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--npctU2YW1hQQCHUxxu4ZxE8eeybzJFSur--

--E0z6RlZRpdA6HO16aBNl8JARDIZWjAFTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2IyPsACgkQ9AfbAGHV
z0B3dwgArNs3+OPXcIER3BTc0PhfDMa9gkm6YZsH0qIyiHseZBRlvDmdskFrkW9F
cBKtp++W1bHLYUAqE4Bu748Dpccg9r1RxrfjXplhNZyh5WOswGb4KIHZIwKvO+Cx
d9J/iJ3+9Bc7qgvudtTaCWiS7pwQTzGvLK7GPXijkOB5d+iCQuMRm+J1uW4qghW4
rMQ0wYYnS6p/tmTWrqdnteur+eGpxQfzjlZ3y/On7ODfw2Qo0+wrara1h+j3TBFw
MhDQ+0VnF3BghLJsNXFiRSfDeW7wV3eHBwYGz9ryNOCAfzeFtTPf9tpOxP9RciPV
4nxImI4wCNSaEOiWSGsyPMvQjn9T9Q==
=IF4q
-----END PGP SIGNATURE-----

--E0z6RlZRpdA6HO16aBNl8JARDIZWjAFTe--

