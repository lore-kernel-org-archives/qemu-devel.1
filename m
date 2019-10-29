Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B8CA9EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B862087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4/uW5MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B862087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPSFQ-0003N0-69
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 10:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPSDH-00013o-DD
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPS4z-00033M-Bw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:02:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43374
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPS4y-000336-Vn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572357755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D00i0CncG3PBBnd1Wec+kZsdrFbgN6cBiEgvXDi37Qo=;
 b=g4/uW5MFFdQ+mznVQBcbVywEY0vsDp1/plG5i0vjWrWlFJvbNj93r+UaXEKX7PcYsar4mb
 r0ws52teWDfC/xCeNUP6sTmNOY4fWUYrWsEvN4FpvggHLxha4KNMNCup26dunnDJrv+zqn
 X4QijHi5NFPSC1l6uqD487YOQk6hYOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-d4Zg4wcfNr2LOINPmtCX6w-1; Tue, 29 Oct 2019 10:02:33 -0400
X-MC-Unique: d4Zg4wcfNr2LOINPmtCX6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F1581A334;
 Tue, 29 Oct 2019 14:02:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 829A25D6C3;
 Tue, 29 Oct 2019 14:02:22 +0000 (UTC)
Subject: Re: [PATCH 0/1] dirty-bitmaps: remove deprecated autoload parameter
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190924230143.22551-1-jsnow@redhat.com>
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
Message-ID: <2140d2fb-9c9d-d4cb-ec90-67062ed383d5@redhat.com>
Date: Tue, 29 Oct 2019 15:02:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190924230143.22551-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uYYuujBHRsPUvOo8Jf0RcPKPFflgz55SA"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uYYuujBHRsPUvOo8Jf0RcPKPFflgz55SA
Content-Type: multipart/mixed; boundary="cDcgB7jpwP2U7XeiyWoOPWHgBVkZfMBM7"

--cDcgB7jpwP2U7XeiyWoOPWHgBVkZfMBM7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 01:01, John Snow wrote:
> I'm going to be honest, here. There's actually no real reason to remove
> this now, but we could, so I'm going to.
>=20
> Also, in terms of the API serving as documentation, it's nicer to not
> pretend this is an option that does anything, so out it goes.
>=20
> This will serve as a little smoke test to see what happens if we
> actually stop dropping features we claimed were deprecated.
>=20
> John Snow (1):
>   dirty-bitmaps: remove deprecated autoload parameter
>=20
>  qemu-deprecated.texi | 20 +++++++++++++++-----
>  qapi/block-core.json |  6 +-----
>  blockdev.c           |  6 ------
>  3 files changed, 16 insertions(+), 16 deletions(-)

Cleaning up my inbox...  Was it your intention for someone other than
yourself to take this patch? :S

Max


--cDcgB7jpwP2U7XeiyWoOPWHgBVkZfMBM7--

--uYYuujBHRsPUvOo8Jf0RcPKPFflgz55SA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl24RmwACgkQ9AfbAGHV
z0DRIQf/YGzTxQZDEZ6o4d72Dxw4FhutvBqNxvmK0IRzYDk6fxp6RQd+04H4m6hc
SXUr6fdYxYuQqW9IH1f7wg/S+4T1cE4C7wDrh9Ws+Rtgk3mvBhGWGF7xLcPOoz+k
N2DN5myyPNH57rItk8f6hPg9H+6ZcUhmiiSoUiZGPLRQYR6HygylCZ+5O0ilaawG
ygrrp3PnyZbcbnBKs1tnl0aaKKo0FM8hkv9mpFcvrIOp2S1VnnESt+H3+1u1V7uj
rrQbz12Cku/A6DfCRyKNRKPZZdeu5aL/5qzZPC6rZLoNmbhFn6bnKtjp4yIs6Sjs
Wfit5yyZdtdks5TdRKFTUNHxtxJD6Q==
=mOFw
-----END PGP SIGNATURE-----

--uYYuujBHRsPUvOo8Jf0RcPKPFflgz55SA--


