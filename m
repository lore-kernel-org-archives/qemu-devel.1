Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237CC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C948B20663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij5Wqwae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C948B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3qL-0000m6-Md
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT3p4-0007qF-2c
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT3ow-0000C8-V3
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:29:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jT3ow-0000Bq-Fx
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587994152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Pc9bzsgwoVXsR8yccEf5vhZzMbCPc+Sbk3bPHrvhv4g=;
 b=Ij5WqwaeOJMM+DhSmofTHkbU6HhoLpeVfJkUvQ6vjNMgKmyPpq7Udy7UooonfU90pgb7gO
 lCzSUY6lDGYeeJGCFDkzVgjS8OerwYymuw25IeCMTQXb5QO059S3hgEHo5f9oYn0g87Uw4
 AMbVpUXiWp/KGJlWxvC2zzolH1E68f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-vtsqHNaiOqOF0cYWUZIjTQ-1; Mon, 27 Apr 2020 09:29:09 -0400
X-MC-Unique: vtsqHNaiOqOF0cYWUZIjTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006F5100A614;
 Mon, 27 Apr 2020 13:29:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-29.ams2.redhat.com
 [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B1A5D9DA;
 Mon, 27 Apr 2020 13:29:05 +0000 (UTC)
Subject: Re: [PATCH v20 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-5-dplotnikov@virtuozzo.com>
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
Message-ID: <c0fdc097-dabd-4661-fce9-a63a24a8d792@redhat.com>
Date: Mon, 27 Apr 2020 15:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421081117.7595-5-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yNGb16rDELMAozvD1pEmHpgRrP5yCohWg"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yNGb16rDELMAozvD1pEmHpgRrP5yCohWg
Content-Type: multipart/mixed; boundary="63CbgU7SUBukRPeOQKxCbByVEpAAXJTw4"

--63CbgU7SUBukRPeOQKxCbByVEpAAXJTw4
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 10:11, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requirements for the compression
> type feature and zstd compression type operability.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  tests/qemu-iotests/287     | 146 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/287.out |  67 +++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 214 insertions(+)
>  create mode 100755 tests/qemu-iotests/287
>  create mode 100644 tests/qemu-iotests/287.out
>=20
> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> new file mode 100755
> index 0000000000..156acc40ad
> --- /dev/null
> +++ b/tests/qemu-iotests/287
> @@ -0,0 +1,146 @@
> +#!/usr/bin/env bash
> +#
> +# Test case for an image using zstd compression
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +# creator
> +owner=3Ddplotnikov@virtuozzo.com
> +
> +seq=3D"$(basename $0)"
> +echo "QA output created by $seq"
> +
> +status=3D1=09# failure is the default!
> +
> +# standard environment
> +. ./common.rc
> +. ./common.filter
> +
> +# This tests qocw2-specific low-level functionality
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux

This test doesn=92t work with compat=3D0.10 (because we can=92t store a
non-default compression type there) or data_file (because those don=92t
support compression), so those options should be marked as unsupported.

(It does seem to work with any refcount_bits, though.)

> +
> +COMPR_IMG=3D"$TEST_IMG.compressed"
> +RAND_FILE=3D"$TEST_DIR/rand_data"
> +
> +_cleanup()
> +{
> +=09_cleanup_test_img
> +=09rm -f "$COMPR_IMG"

Using _rm_test_img() would be nicer.  There shouldn=92t be a functional
difference here because there=92d only be one with external data files (I
think), which won=92t work with this test, but still.

> +=09rm -f "$RAND_FILE"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# for all the cases
> +CLUSTER_SIZE=3D65536
> +
> +# Check if we can run this test.
> +if IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M |
> +    grep "Invalid parameter 'zstd'"; then
> +    _notrun "ZSTD is disabled"
> +fi
> +
> +echo
> +echo "=3D=3D=3D Testing compression type incompatible bit setting for zl=
ib =3D=3D=3D"
> +echo
> +IMGOPTS=3D'compression_type=3Dzlib' _make_test_img 64M

Please use -o so user options are still considered.

(i.e., _make_test_img -o compression_type=3Dzlib)

[...]

> +echo
> +echo "=3D=3D=3D Testing incompressible cluster processing with zstd =3D=
=3D=3D"
> +echo
> +# create a 2M image and fill it with 1M likely incompressible data
> +# and 1M compressible data
> +dd if=3D/dev/urandom of=3D"$RAND_FILE" bs=3D1M count=3D1 seek=3D1
> +QEMU_IO_OPTIONS=3D"$QEMU_IO_OPTIONS_NO_FMT" \
> +$QEMU_IO -f raw -c "write -P 0xFA 0 1M" "$RAND_FILE" | _filter_qemu_io
> +$QEMU_IMG convert -f raw -O $IMGFMT -c "$RAND_FILE" "$TEST_IMG" | _filte=
r_qemu_io
> +
> +$QEMU_IMG convert -O $IMGFMT -c -o compression_type=3Dzstd \
> +                  "$TEST_IMG" "$COMPR_IMG"

Again, it would be nice to not discard the user-supplied options here,
and maybe it would also be nicer to explicitly pass the compression type
for the first convert, too.  So we=92d use
  -o "$(_optstr_add "$IMGOPTS" "compression_type=3Dzlib")"
for the first convert, and
  -o "$(_optstr_add "$IMGOPTS" "compression_type=3Dzstd")"
for the second one.

Max


--63CbgU7SUBukRPeOQKxCbByVEpAAXJTw4--

--yNGb16rDELMAozvD1pEmHpgRrP5yCohWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6m3iAACgkQ9AfbAGHV
z0CVlggAq0pjj8ECcDIKRP9iULQoN6ji4THxXs3hN0lp51UUhISPTIQo9dBhnTJC
mrdsjEtSz6R7w0XCu8G9JGNgsFC4YH5upMn9CSN9Y/Y9G7K8P03+qP+ZrhU17NPE
UcdcdFGvt9pGX+lOYSL5owYZ+F2oF5E+t6GbVBlO2e1WUQyiqGNfC2OWbnXUXGZp
M3y4j5dUX4blvnBliIK2Lt5DUulkfeM6kVtKMEld13aAXduE/Olmng5hrKor2A25
6vrjsAvWL8rpAPtyy/CpGszTJVI9vRj5ijTeWDpAZhTTRqs437AxMaivn+W+SfE+
xNP2X+0Knpgdf88ltrZnBHqRfauudg==
=4kH9
-----END PGP SIGNATURE-----

--yNGb16rDELMAozvD1pEmHpgRrP5yCohWg--


