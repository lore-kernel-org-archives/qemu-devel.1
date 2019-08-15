Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E744C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1406B2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1406B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyEvz-0004HP-VH
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 08:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hyEur-0003lQ-Et
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hyEup-0002EW-Sj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hyEul-00024m-99; Thu, 15 Aug 2019 08:31:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB72E3003715;
 Thu, 15 Aug 2019 12:31:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2C08388D;
 Thu, 15 Aug 2019 12:31:23 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190815110623.13646-1-kwolf@redhat.com>
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
Message-ID: <e87c2ff7-edf9-7b1f-331f-a9fcf9e5efbe@redhat.com>
Date: Thu, 15 Aug 2019 14:31:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815110623.13646-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gjwMI3x4C4eQ1cFmSJX9ckUMCMHo9Kc1E"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 15 Aug 2019 12:31:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img convert: Deprecate using -n
 and -o together
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gjwMI3x4C4eQ1cFmSJX9ckUMCMHo9Kc1E
Content-Type: multipart/mixed; boundary="GHwwgrB3qQKnxAQuQsdnUl5JceD4OIQvS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Message-ID: <e87c2ff7-edf9-7b1f-331f-a9fcf9e5efbe@redhat.com>
Subject: Re: [PATCH v2] qemu-img convert: Deprecate using -n and -o together
References: <20190815110623.13646-1-kwolf@redhat.com>
In-Reply-To: <20190815110623.13646-1-kwolf@redhat.com>

--GHwwgrB3qQKnxAQuQsdnUl5JceD4OIQvS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.08.19 13:06, Kevin Wolf wrote:
> bdrv_create options specified with -o have no effect when skipping imag=
e
> creation with -n, so this doesn't make sense. Warn against the misuse
> and deprecate the combination so we can make it a hard error later.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>=20
> - Hopefully removed the "finger-wagging" that John saw, without stating=

>   that the combination doesn't have a well-defined behaviour (because
>   skipping image creation and therefore ignoring -o is well-defined
>   behaviour).

The problem is that e.g. the man page never says that -o gives creation
options.  It says that =E2=80=9Coptions is a [...] list of format specifi=
c
options=E2=80=9D, nothing more.

>  qemu-img.c           | 5 +++++
>  qemu-deprecated.texi | 7 +++++++
>  2 files changed, 12 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--GHwwgrB3qQKnxAQuQsdnUl5JceD4OIQvS--

--gjwMI3x4C4eQ1cFmSJX9ckUMCMHo9Kc1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1VUJkACgkQ9AfbAGHV
z0AKSAf/Y26CQpQ+ZEtk9ViFSTz7c/eiFfJ6IbZfw7YHgD+eqXsVnbU1ptT4eEE6
IZFY/TTA83rkzAKnIooo8zbjjbld9huwxwSKjWidmxafrmolAF3+4U2TyyZPupct
e+yfWfPzZQ9uOi5ohgzcnbZh0LEhhM8MEt0mVB2VTLgkuEHCvlDmbVgFJldwr8Kf
PtKcnziuSXYn+/6IZedaryaqVs1GZnMAn4Xh8Tvo6XhJ2zXmob1NWSjxICUW//VK
gnYOt/Np6L6Tdn+aSp4vdwXfZ+c2ZeIfWcrFF+zmnAZcqNvYzLrtKRw9IJyKycAC
eg0ohfdAZHwCuTS4bnXyuOWQi8Fwag==
=4Osv
-----END PGP SIGNATURE-----

--gjwMI3x4C4eQ1cFmSJX9ckUMCMHo9Kc1E--

