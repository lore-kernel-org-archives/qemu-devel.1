Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB672C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345B820C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkuA7wUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345B820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKDi-0002vc-9J
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGKDA-0002O8-Aq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGKD8-0005rU-PV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599735229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CKxNoenD4vadztZO7HTMtPEOAQMffdaqY6lPZ5A+y0g=;
 b=LkuA7wUxlxklpo6+hRlkUNlgLZRLc2nDIXaJaPp3SHrZIiKxb4X3nPwlbYcm+sOR38hlCH
 HwF2J37a+tuZmDsFRcGkNR8vAOVDjTsUXlCO04gfRSo4PDKqD91iAc+Ll4GB71tLmDSruh
 bSFp5X3mWszS6PUqH9chzNhZ+yZJPdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-SKWcQ_EHMISVYg5McuNSLw-1; Thu, 10 Sep 2020 06:53:47 -0400
X-MC-Unique: SKWcQ_EHMISVYg5McuNSLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D0558030C7;
 Thu, 10 Sep 2020 10:53:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-197.ams2.redhat.com
 [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95F239CBA;
 Thu, 10 Sep 2020 10:53:45 +0000 (UTC)
Subject: Re: [PATCH 07/29] block/export: Remove magic from block-export-add
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-8-kwolf@redhat.com>
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
Message-ID: <65fdd8a4-03c8-6220-1280-8081e7a98980@redhat.com>
Date: Thu, 10 Sep 2020 12:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907182011.521007-8-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jOGxOtasyKNZCupWcqVvxNKypdDGu4KJx"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
--jOGxOtasyKNZCupWcqVvxNKypdDGu4KJx
Content-Type: multipart/mixed; boundary="iuUoPUWlpPPjZqNwijsoFbhepdlnG4hrJ"

--iuUoPUWlpPPjZqNwijsoFbhepdlnG4hrJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 20:19, Kevin Wolf wrote:
> nbd-server-add tries to be convenient and adds two questionable
> features that we don't want to share in block-export-add, even for NBD
> exports:
>=20
> 1. When requesting a writable export of a read-only device, the export
>    is silently downgraded to read-only. This should be an error in the
>    context of block-export-add.
>=20
> 2. When using a BlockBackend name, unplugging the device from the guest
>    will automatically stop the NBD server, too. This may sometimes be
>    what you want, but it could also be very surprising. Let's keep
>    things explicit with block-export-add. If the user wants to stop the
>    export, they should tell us so.
>=20
> Move these things into the nbd-server-add QMP command handler so that
> they apply only there.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/export.h |  2 ++
>  include/block/nbd.h    |  3 ++-
>  block/export/export.c  | 13 +++++++++---
>  blockdev-nbd.c         | 47 +++++++++++++++++++++++++++++++++++-------
>  nbd/server.c           | 20 +++++++++++-------
>  qemu-nbd.c             |  3 +--
>  6 files changed, 67 insertions(+), 21 deletions(-)

[...]

> +    if (bdrv_is_read_only(bs)) {
> +        export_opts.u.nbd.has_writable =3D true;

Ah, yes, setting that might be nice. :)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--iuUoPUWlpPPjZqNwijsoFbhepdlnG4hrJ--

--jOGxOtasyKNZCupWcqVvxNKypdDGu4KJx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9aBbcACgkQ9AfbAGHV
z0Ck/wgAoN1MLCcdwrNyq7BlBlhghHsDwdoQ5ERU8miUN/iQpM42RueQzexnN4pj
DIsKhTAAiWcP6ZUj6LZcMMmqDe1ZBwfGO7i+SwKQTi1kr2PMsHdci3vtXSgV/LIE
lHQuli4/i584VN3MxPueUWAI8Slc99Xx4T1/otTSpQ+3DRNmz9o4ArUIYPqx30eA
ZKYqL9rcN7F6UT4tQg1kAHiJk0p/X1xpwiKruj5EUv/VjFWx+dhZr9GfwIHUjZ7Z
PyaJ4UOa06aS8+0m2Yx4Z4Sf8TNFqyNBFjLHtvliP+T2geJlYjNSwkT539q5w98p
LvF7fTQmx2OTFarAogWbFduFeYtOJQ==
=Gnh6
-----END PGP SIGNATURE-----

--jOGxOtasyKNZCupWcqVvxNKypdDGu4KJx--


