Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855AC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15332080C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15332080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2EHu-0006Sk-3T
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 08:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2EH3-0005nV-Fe
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2EH1-0004xE-By
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2EGy-0004ry-PH; Mon, 26 Aug 2019 08:39:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9871F3082B67;
 Mon, 26 Aug 2019 12:38:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4630E601B3;
 Mon, 26 Aug 2019 12:38:54 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-3-nsoffer@redhat.com>
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
Message-ID: <6c6e8226-8aac-e5df-7a5f-706bc25c77c7@redhat.com>
Date: Mon, 26 Aug 2019 14:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825220329.7942-3-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XvtmnMWmWlCvdbhx5mDos7YPRRNsi8JLL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 26 Aug 2019 12:38:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: Test
 allocate_first_block() with O_DIRECT
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XvtmnMWmWlCvdbhx5mDos7YPRRNsi8JLL
Content-Type: multipart/mixed; boundary="umMG2chVqyHWGtnTzLWijtoEp8ZnreWhp";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <6c6e8226-8aac-e5df-7a5f-706bc25c77c7@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: Test allocate_first_block() with O_DIRECT
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-3-nsoffer@redhat.com>
In-Reply-To: <20190825220329.7942-3-nsoffer@redhat.com>

--umMG2chVqyHWGtnTzLWijtoEp8ZnreWhp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 00:03, Nir Soffer wrote:
> Using block_resize we can test allocate_first_block() with file
> descriptor opened with O_DIRECT, ensuring that it works for any size
> larger than 4096 bytes.
>=20
> Testing smaller sizes is tricky as the result depends on the filesystem=

> used for testing. For example on NFS any size will work since O_DIRECT
> does not require any alignment.
> ---
>  tests/qemu-iotests/175     | 25 +++++++++++++++++++++++++
>  tests/qemu-iotests/175.out |  8 ++++++++
>  2 files changed, 33 insertions(+)

Thanks for the test!

There=E2=80=99s just one thing: 175 now needs

_default_cache_mode none
_supported_cache_modes none directsync

somewhere near the top (where the rest of _supported*) is.  (Otherwise,
it will fail when the iotests should be run with some other cache mode
instead of being skipped.)

With that added:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--umMG2chVqyHWGtnTzLWijtoEp8ZnreWhp--

--XvtmnMWmWlCvdbhx5mDos7YPRRNsi8JLL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1j0twACgkQ9AfbAGHV
z0Ah6wf/f9mro4D4naIjsCOO1z+fq3jgQzrW8HjAbdtR7IJhnKOYVx6Ap5XtvXN2
6t4RGFf79GikdrM589pDDwT9I/tRn5iOZnnBr/Cnr5lxLL1le4ldJCtv5oTgd/7Q
Ycu4szbbbtkcwI7puWZ7jya887axGWJXuYRA88UfTKkxJFXyPDkkLBx+6EpvXeAt
xP4avGs8N0ylQz5xsySNKGbLdCotaEGQqGzJ0sO9BwY7PLSmgA97qxDu4ZvD+dKb
Oum2PK2YOUs8rt8yxZVQjWToGPMwkND8uJHpvb/MXHRhJ91d9/3TciPty9xvUNR/
p+8sSre7mgzjXfS53Fy5ebgP+mHv8A==
=hwKx
-----END PGP SIGNATURE-----

--XvtmnMWmWlCvdbhx5mDos7YPRRNsi8JLL--

