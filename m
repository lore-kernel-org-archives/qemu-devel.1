Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D255C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA4320643
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8/BUM/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA4320643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYA3i-0001Rf-Vg
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYA2w-0000Us-41
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:08:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25056
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYA2u-0003r3-2e
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589209722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mMgLGx5RAH+N378a0PAUzHRxfI1vE+02V5Bbk3yhRwM=;
 b=i8/BUM/vYkc8Q5OodezjQXfwNz+0pZ2gRIe/K4yy9AVr507MyJZjc3Y6h1pn0VkCHObDmH
 Uq83sggcHcAGgE3TebGkZWEzZEX2iIxFK7+bw0G56NwK8XnlmoX2XcQgG8KyCviGRjHcDJ
 qDyjTCN4jqhO4zZlfvw5+FN5zFRZNRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-TSEExeK0OWqn2NPwAUSO5A-1; Mon, 11 May 2020 11:08:36 -0400
X-MC-Unique: TSEExeK0OWqn2NPwAUSO5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C86EC1A2;
 Mon, 11 May 2020 15:08:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-247.ams2.redhat.com
 [10.36.113.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CF135EE0C;
 Mon, 11 May 2020 15:08:24 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] iotests/109: Don't mirror with mismatched size
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-2-kwolf@redhat.com>
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
Message-ID: <8bd8e50f-30b8-f3b7-acd1-6f2cfb32a2f3@redhat.com>
Date: Mon, 11 May 2020 17:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511135825.219437-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZxlRUZLCTg01r8WrSsS8XsrZZx7iWiqbd"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZxlRUZLCTg01r8WrSsS8XsrZZx7iWiqbd
Content-Type: multipart/mixed; boundary="ieQJ0So9HpJzQSdPTGVZzGKLRhbPmlPYN"

--ieQJ0So9HpJzQSdPTGVZzGKLRhbPmlPYN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.05.20 15:58, Kevin Wolf wrote:
> This patch makes the raw image the same size as the file in a different
> format that is mirrored as raw to it to avoid errors when mirror starts
> to enforce that source and target are the same size.
>=20
> We check only that the first 512 bytes are zeroed (instead of 64k)
> because some image formats create image files that are smaller than 64k,
> so trying to read 64k would result in I/O errors. Apart from this, 512
> is more appropriate anyway because the raw format driver protects
> specifically the first 512 bytes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/109           | 10 ++---
>  tests/qemu-iotests/109.out       | 74 +++++++++++++-------------------
>  tests/qemu-iotests/common.filter |  5 +++
>  3 files changed, 41 insertions(+), 48 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
> index 5bc2e9b001..3ffeaf3c55 100755
> --- a/tests/qemu-iotests/109
> +++ b/tests/qemu-iotests/109
> @@ -77,14 +77,14 @@ for fmt in qcow qcow2 qed vdi vmdk vpc; do
>      echo "=3D=3D=3D Writing a $fmt header into raw =3D=3D=3D"
>      echo
> =20
> -    _make_test_img 64M
>      TEST_IMG=3D"$TEST_IMG.src" IMGFMT=3D$fmt _make_test_img 64M
> +    _make_test_img $(du -b "$TEST_IMG.src" | cut -f1) | _filter_img_crea=
te_size

Why du and not the file length (stat -c '%s')?

Max


--ieQJ0So9HpJzQSdPTGVZzGKLRhbPmlPYN--

--ZxlRUZLCTg01r8WrSsS8XsrZZx7iWiqbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl65amQACgkQ9AfbAGHV
z0AYOggAjvSo8AYjxLsY8/VVEkny0E8M+uxtALDBnkQ2Ey5TDTzLokNuuiGCBdQA
gNMAaYiTfnWuKMeCe7cEmdTlhIm8X5uAoLxOEQOVPnXcAk8+6nFQ6tbGsUl2UVGN
Kkrjw6VCPeqs0P9icu3rreTi6eEjnEOLmn/cVPxj1cY40sJAW8T9aWpbqqa/TzLf
y+GL9gt0ih8rnHprlyhqEvjeH7HrmaP/z35ZH6YgJzQeOl4i6djB/BT2ZXHCfIk1
gs69JLF/iTDTuewcArsEkImbEHdGUEM1b4I7yxU+jPf0nQF8xD9UNhcrHglnP+m1
KAj9pUSH2BpCUCEsReDs9fi9IITqdA==
=sqP0
-----END PGP SIGNATURE-----

--ZxlRUZLCTg01r8WrSsS8XsrZZx7iWiqbd--


