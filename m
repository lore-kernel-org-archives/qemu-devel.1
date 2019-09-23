Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A949C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8D020665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8D020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOXV-00045q-DI
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCOUT-0001B9-JP
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCOUS-0005UT-GK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCOUQ-0005Sk-3I; Mon, 23 Sep 2019 09:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C28E80F6D;
 Mon, 23 Sep 2019 13:34:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A137A19C77;
 Mon, 23 Sep 2019 13:34:49 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] iotests: add script_initialize
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-3-jsnow@redhat.com>
 <07f8a7ea-a438-0ad2-580d-3e57e0ccf4a2@redhat.com>
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
Message-ID: <4fd60492-e3db-b4fc-24be-5850a6e70046@redhat.com>
Date: Mon, 23 Sep 2019 15:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <07f8a7ea-a438-0ad2-580d-3e57e0ccf4a2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k1BZKOmznAeQfTX1zWWh2n2uVvHrs1b7i"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 23 Sep 2019 13:34:53 +0000 (UTC)
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
--k1BZKOmznAeQfTX1zWWh2n2uVvHrs1b7i
Content-Type: multipart/mixed; boundary="FuTqXWgyArDRD5LGYMll3gI0JyOGKPI2w";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <4fd60492-e3db-b4fc-24be-5850a6e70046@redhat.com>
Subject: Re: [PATCH v5 2/5] iotests: add script_initialize
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-3-jsnow@redhat.com>
 <07f8a7ea-a438-0ad2-580d-3e57e0ccf4a2@redhat.com>
In-Reply-To: <07f8a7ea-a438-0ad2-580d-3e57e0ccf4a2@redhat.com>

--FuTqXWgyArDRD5LGYMll3gI0JyOGKPI2w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.09.19 15:30, Max Reitz wrote:
> On 18.09.19 01:45, John Snow wrote:
>> Like script_main, but doesn't require a single point of entry.
>> Replace all existing initialization sections with this drop-in replace=
ment.
>>
>> This brings debug support to all existing script-style iotests.
>>
>> Any specification for supported_oses=3D['linux'] was dropped as explai=
ned
>> in the previous commit, because there was never any reason to limit py=
thon
>> tests to linux-only.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/qemu-iotests/149        |  3 +-
>>  tests/qemu-iotests/194        |  3 +-
>>  tests/qemu-iotests/202        |  3 +-
>>  tests/qemu-iotests/203        |  3 +-
>>  tests/qemu-iotests/206        |  2 +-
>>  tests/qemu-iotests/207        |  2 +-
>>  tests/qemu-iotests/208        |  2 +-
>>  tests/qemu-iotests/209        |  2 +-
>>  tests/qemu-iotests/210        |  2 +-
>>  tests/qemu-iotests/211        |  2 +-
>>  tests/qemu-iotests/212        |  2 +-
>>  tests/qemu-iotests/213        |  2 +-
>>  tests/qemu-iotests/216        |  3 +-
>>  tests/qemu-iotests/218        |  2 +-
>>  tests/qemu-iotests/219        |  2 +-
>>  tests/qemu-iotests/222        |  5 ++-
>>  tests/qemu-iotests/224        |  3 +-
>>  tests/qemu-iotests/228        |  3 +-
>>  tests/qemu-iotests/234        |  3 +-
>>  tests/qemu-iotests/235        |  4 +--
>>  tests/qemu-iotests/236        |  2 +-
>>  tests/qemu-iotests/237        |  2 +-
>>  tests/qemu-iotests/238        |  2 ++
>>  tests/qemu-iotests/242        |  2 +-
>>  tests/qemu-iotests/246        |  2 +-
>>  tests/qemu-iotests/248        |  2 +-
>>  tests/qemu-iotests/254        |  2 +-
>>  tests/qemu-iotests/255        |  2 +-
>>  tests/qemu-iotests/256        |  2 +-
>>  tests/qemu-iotests/262        |  3 +-
>>  tests/qemu-iotests/iotests.py | 62 ++++++++++++++++++++++------------=
-
>>  31 files changed, 73 insertions(+), 63 deletions(-)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

(Forgot to add: Needs a bit of rebase on Kevin=E2=80=99s patch to drop Py=
thon 2
support, but the changes look obvious enough.)


--FuTqXWgyArDRD5LGYMll3gI0JyOGKPI2w--

--k1BZKOmznAeQfTX1zWWh2n2uVvHrs1b7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2IyfgACgkQ9AfbAGHV
z0DcXQgAha1gK8Plin71UJ85xsC0yXKYQT+7MHLcGeGG0sC9q3rejDYLB+bK9x3T
IQb8PjIE9QqgTPh7Y+qnZd488siQcGHx1yDdPnK3n71B3avqaSuG4tE+3dHVwk+3
gxJtN27NIeAwBoTmaxsX0EdxEF7aFNwDiMu92XBvAS4pPrlbIVMx792ELH1g+ffB
Xm4QvBmQpm/vNQXNl8OWFH0gUvNAcxPm5+JU/BRpl9bSLyj6EqD/Lhq+YX+k2S9+
t0ettCXlbAW189KtGV71K1Mi522lB0IjKW391QHUVHNy7YPXSlrb3QoL7N6LjQke
2A7d7okHp5hkfFqKY1ubbauaPHOO6w==
=Ftfu
-----END PGP SIGNATURE-----

--k1BZKOmznAeQfTX1zWWh2n2uVvHrs1b7i--

