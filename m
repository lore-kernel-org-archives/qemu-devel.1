Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70286C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1C3206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlF6s6mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1C3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIKZ-0001IM-FY
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrIJy-0000mu-R8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:49:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrIJw-000101-86
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593769762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KxDyDUVc2SXIbMlLfc3ac/dQ/efLgIJeYQIGWzQhJ1Q=;
 b=LlF6s6mvbFN1uQMu9OVrRnC0K2W8RpDNGdbw+CcItF1Wtxylyvib20gbXTEto9IhMXGEF0
 UPRNlm4HuT4lNbAEucmrzqccOttl+AdFFq23ymbzZWPFUazR4+REUQeiRhKtR/stn4ugsG
 jOTQ3ljmlDneD6/p608PFcRMekRWWNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-uXXUjYIuNdSQAlD8WjkMMw-1; Fri, 03 Jul 2020 05:49:20 -0400
X-MC-Unique: uXXUjYIuNdSQAlD8WjkMMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67D87107ACCA;
 Fri,  3 Jul 2020 09:49:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-131.ams2.redhat.com
 [10.36.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 845AD6FEF7;
 Fri,  3 Jul 2020 09:49:16 +0000 (UTC)
Subject: Re: [PATCH v9 34/34] iotests: Add tests for qcow2 images with
 extended L2 entries
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <536717bef174a2d5405647bf9ecf899e0aafadbb.1593342067.git.berto@igalia.com>
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
Message-ID: <2a791051-5967-0279-75a1-4a44817b83b3@redhat.com>
Date: Fri, 3 Jul 2020 11:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <536717bef174a2d5405647bf9ecf899e0aafadbb.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jvSm7QAKfePCJY1YmvxdGpQT6v3Xru6nW"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jvSm7QAKfePCJY1YmvxdGpQT6v3Xru6nW
Content-Type: multipart/mixed; boundary="mz4n616zUdmMEJR45S7sxXQBTRNel8zXs"

--mz4n616zUdmMEJR45S7sxXQBTRNel8zXs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/271     | 901 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/271.out | 724 +++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 1626 insertions(+)
>  create mode 100755 tests/qemu-iotests/271
>  create mode 100644 tests/qemu-iotests/271.out
>=20
> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
> new file mode 100755
> index 0000000000..5ef3ebb2bf
> --- /dev/null
> +++ b/tests/qemu-iotests/271

[...]

> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto file nfs
> +_supported_os Linux
> +_unsupported_imgopts extended_l2 compat=3D0.10 cluster_size data_file

I=E2=80=99d also add a 'refcount_bits=3D1[^0-9]', because this test doesn=
=E2=80=99t pass
with refcount-bits=3D1 (due to taking a snapshot at one point).

> +
> +l2_offset=3D$((0x40000))
> +
> +_verify_img()
> +{
> +    $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG.raw" | grep -v 'Images are =
identical'
> +    $QEMU_IMG check "$TEST_IMG" | _filter_qemu_img_check | \
> +        grep -v 'No errors were found on the image'
> +}
> +
> +# Compare the bitmap of an extended L2 entry against an expected value
> +_verify_l2_bitmap()
> +{
> +    entry_no=3D"$1"            # L2 entry number, starting from 0
> +    expected_alloc=3D"$alloc"  # Space-separated list of allocated subcl=
uster indexes
> +    expected_zero=3D"$zero"    # Space-separated list of zero subcluster=
 indexes
> +
> +    offset=3D$(($l2_offset + $entry_no * 16))
> +    entry=3D$(peek_file_be "$TEST_IMG" $offset 8)
> +    offset=3D$(($offset + 8))
> +    bitmap=3D$(peek_file_be "$TEST_IMG" $offset 8)
> +
> +    expected_bitmap=3D0
> +    for bit in $expected_alloc; do
> +        expected_bitmap=3D$(($expected_bitmap | (1 << $bit)))
> +    done
> +    for bit in $expected_zero; do
> +        expected_bitmap=3D$(($expected_bitmap | (1 << (32 + $bit))))
> +    done
> +    printf -v expected_bitmap "%llu" $expected_bitmap # Convert to unsig=
ned

Does the length modifier =E2=80=9Cll=E2=80=9D actually do anything?

> +
> +    printf "L2 entry #%d: 0x%016lx %016lx\n" "$entry_no" "$entry" "$bitm=
ap"

Or the =E2=80=9Cl=E2=80=9D here?

> +    if [ "$bitmap" !=3D "$expected_bitmap" ]; then
> +        printf "ERROR: expecting bitmap       0x%016lx\n" "$expected_bit=
map"

(or here)

> +    fi
> +}
Apart from those nit picks, I didn=E2=80=99t find anything to complain abou=
t.
My brain feels like mush now, though, after having brooded over this
test for over an hour...

Max


--mz4n616zUdmMEJR45S7sxXQBTRNel8zXs--

--jvSm7QAKfePCJY1YmvxdGpQT6v3Xru6nW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7+/xoACgkQ9AfbAGHV
z0DPogf/XdLrQeTEOaXIcHqS1W+Ekg2c0FcUBx7PzphM/g/8Tu+K8bMnZHYvbwcE
sOY/2zcZT8dhXyfU/ePfPyLzU0kC5BEbbifHvkb+CDj5z/JBAqR/ZItE1RXbNcDh
7lUby17qWE2VGlbUUxRtcPfN+3Lj4bQ+lCS49vH3sWHkqkPi9/buxDAIOeTb97Mw
C2xIBgrBCojyS9ltWCEmexR0BhmN9pxKxC3mwU1y3Vlo/KKAWWETu2UDqMRFDagI
17UBNkxs/Bqy8ouoao20Q40GW8NdYD7aL017wB5JIBGiHVi7ezW0EHH1i/XvYPyv
lAoPCGmOCHHpmd3vTy33A7hjEGXuxw==
=lEkM
-----END PGP SIGNATURE-----

--jvSm7QAKfePCJY1YmvxdGpQT6v3Xru6nW--


