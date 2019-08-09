Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65F6C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E13F2086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E13F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw8B7-0004sv-SB
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw8Ag-0004OJ-OH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw8Af-0006er-Og
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw8Ad-0006dL-ON; Fri, 09 Aug 2019 12:55:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EDFE4308FEC1;
 Fri,  9 Aug 2019 16:55:14 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8623E60600;
 Fri,  9 Aug 2019 16:55:10 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-5-vsementsov@virtuozzo.com>
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
Message-ID: <e1ce8b5b-d443-36a7-d979-cce9b440e69c@redhat.com>
Date: Fri, 9 Aug 2019 18:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809153207.49288-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wfbDmbWUYoZjuN2PN5mivkV7DxrTMWnW5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 09 Aug 2019 16:55:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/7] block/backup: drop handling of
 max_transfer for copy_range
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wfbDmbWUYoZjuN2PN5mivkV7DxrTMWnW5
Content-Type: multipart/mixed; boundary="7stLnomdFLKOOsD6wJ7oTcdyamFbkiTSB";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <e1ce8b5b-d443-36a7-d979-cce9b440e69c@redhat.com>
Subject: Re: [PATCH v2 4/7] block/backup: drop handling of max_transfer for
 copy_range
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190809153207.49288-5-vsementsov@virtuozzo.com>

--7stLnomdFLKOOsD6wJ7oTcdyamFbkiTSB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.08.19 17:32, Vladimir Sementsov-Ogievskiy wrote:
> Since previous commit, copy_range supports max_transfer, so we don't
> need to handle it by hand.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7stLnomdFLKOOsD6wJ7oTcdyamFbkiTSB--

--wfbDmbWUYoZjuN2PN5mivkV7DxrTMWnW5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1NpWwACgkQ9AfbAGHV
z0A/AwgAmQutcNWoip9swNCohuE8UiGmZf8CCq9y7FwBKkd1EfbROOGLXMNtgjpN
yYTu3m5bwc8QcIOrIbtWcM2IOCA5nOPfTLCHhA4cyyaeAyft4twfDAGlxn5YerP+
mhK3oLzQV+pNYg28zGv9kHqY20EFLMFvPObwYrEq+Wt018l4z7EUZNZ7wEFn5ldg
U9tr1f5vrYSFgl3Jj/SJMR3v4Q6rv+K1LptWurWwA4PTJB/WHGm/T/x86jnaA0wb
+66/3ci3vFpU/Wwquy6ukGxvtm1z7FyNfNP7zzsFKk2L/xThjQf2B+T0V1ZBrOJH
5VrjstXVt7G2dZ+FzI5Vaf1TdCp51g==
=VIk8
-----END PGP SIGNATURE-----

--wfbDmbWUYoZjuN2PN5mivkV7DxrTMWnW5--

