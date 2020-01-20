Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DFBC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF0B24125
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnKMCooV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF0B24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYR1-0006i0-Ej
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itYPt-0005jZ-ME
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itYPq-0007sJ-3w
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:52:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itYPp-0007s8-Ve
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579531953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J3FnzsGbUlvJVvQqe2Wi5GnKOvCXiqf+KwanGk5rBC8=;
 b=hnKMCooV1w8ueKsMZaUXujN/g65RHqfRW6a8J74PRi9PAEG6Lr2qrjQKKCQhXUxLfhyx0E
 aM5/0q73+XdjrkvUsKA8XGIrICZhrCvpxV9wbMzUq4zDaPhqvTPPBWKZFzHjIX2KXk5mV5
 1bBZXf1yz5RQzC6IZiKlwVJZ6AqqJQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-9xKVfMqrPC6wnXoRYagfHQ-1; Mon, 20 Jan 2020 09:52:31 -0500
X-MC-Unique: 9xKVfMqrPC6wnXoRYagfHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08CA107ACC7;
 Mon, 20 Jan 2020 14:52:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26F795D9E1;
 Mon, 20 Jan 2020 14:52:26 +0000 (UTC)
Subject: Re: [PATCH v4 0/6] Enable more iotests during "make check-block"
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
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
Message-ID: <57826390-d8fd-9cfc-b3b0-e8c07e18ece1@redhat.com>
Date: Mon, 20 Jan 2020 15:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191202101039.8981-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PXfUyNsP56aGpTPSFu5ij1T8B4sjQAEX8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PXfUyNsP56aGpTPSFu5ij1T8B4sjQAEX8
Content-Type: multipart/mixed; boundary="v33MoE0RucZpiKudAsTsArBlNGveTJBMq"

--v33MoE0RucZpiKudAsTsArBlNGveTJBMq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.12.19 11:10, Thomas Huth wrote:
> As discussed here:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html
>=20
> and here:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html
>=20
> it would be good to have some more valuable iotests enabled in the
> "auto" group to get better iotest coverage during "make check".
>=20
> Since these Python-based tests require a QEMU that features a 'virtio-blk=
'
> device, we can only run the Python tests if this device is available. Wit=
h
> binaries like qemu-system-tricore, the Python-based tests will be skipped=
.
>=20
> v4:
>  - The check for 'virtio-blk' is now done in the tests/qemu-iotests/check
>    script instead of tests/check-block.sh (to avoid to duplicate the code
>    that searches for the right QEMU binary - and we can also still run
>    the shell-based tests this way).
>  - Added the new patch to check for the availability of virtio devices in
>    the iotests 127 and 267.
>  - The patch that drops test 130 from the "auto" group has already been
>    merged and thus been dropped from this series.

Looks good to me, the only question is whether you=E2=80=99d like to add a
$python_unusable_because in patch 5 or not.

Max


--v33MoE0RucZpiKudAsTsArBlNGveTJBMq--

--PXfUyNsP56aGpTPSFu5ij1T8B4sjQAEX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lvqgACgkQ9AfbAGHV
z0BoAQf/RKNO1ISwt7hahnjfPJ/MMc4AOJZwJ+IVvw+/m9OwDWspgoI2BR6aMcDn
dYSw2KZJbLMIW5TJ1LQI3WOpnCajflGRBoJebchzniJRKZlzi8kw4GsmwZrjXAT/
bLJbhh0wu687Ifye3RnmJmWMnFua0arkfku+vDfWpPTj6QzTzaG1iVrEyKCcRmRx
pBslhA5JL5ia++oBo/a/mD1bbTloVTighqK/APLuh+YRwEAOINLIc+e4gNczY3GU
t9JTxQ4ZqHkG3qbMH8mo9rFKbZF5nzpGgcsXPEbBkkU0+AK3j1SGtzJyW+WmNZ2F
JBxiC3wFh7JTYWHPRDJz16WZT/c7Zw==
=L2mc
-----END PGP SIGNATURE-----

--PXfUyNsP56aGpTPSFu5ij1T8B4sjQAEX8--


