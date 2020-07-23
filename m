Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D79C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012202086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQ0Of/yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012202086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyWSU-0002uJ-5A
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 04:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyWRd-0002Pq-GJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:19:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28595
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyWRa-0007om-OX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595492349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e3vurLUuBk7QDCSGIbFxFDPT6zZu4aqQDMFOO/n26h0=;
 b=SQ0Of/ygN0okXREiZuV5oZx9sWFjKmi+w/ikw5abbkkBcgdcWEO7zOCBtBdUNmKAxv0pMS
 1F9MOg0SRmdIjwRyGjmrbdnGOqHdFtw3izSMov5h6zuAFYCcdOYTGS763OcCbYY66+FrTr
 4JS/+/cS8aGcYgl5xjbXOEgNDXeDnUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-kZJhHTXNPmWTxZqZ8BLjcw-1; Thu, 23 Jul 2020 04:19:06 -0400
X-MC-Unique: kZJhHTXNPmWTxZqZ8BLjcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4929D100CCC0;
 Thu, 23 Jul 2020 08:19:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCEF027CDD;
 Thu, 23 Jul 2020 08:19:02 +0000 (UTC)
Subject: Re: [PATCH v2 14/20] iotests: 185: prepare for backup over block-copy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-15-vsementsov@virtuozzo.com>
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
Message-ID: <9f8d6176-e110-42ee-a579-7c4dd12511d5@redhat.com>
Date: Thu, 23 Jul 2020 10:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-15-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ljob3MIktykyeb7BRQoY7vt3FxzGNWKqi"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ljob3MIktykyeb7BRQoY7vt3FxzGNWKqi
Content-Type: multipart/mixed; boundary="pkc5LJv6Z66uepcyXEV7bgjX5Gz3UAbZa"

--pkc5LJv6Z66uepcyXEV7bgjX5Gz3UAbZa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> The further change of moving backup to be a on block-copy call will

-on?

> make copying chunk-size and cluster-size a separate things. So, even

s/a/two/

> with 64k cluster sized qcow2 image, default chunk would be 1M.
> 185 test however assumes, that with speed limited to 64K, one iteration
> would result in offset=3D64K. It will change, as first iteration would
> result in offset=3D1M independently of speed.
>=20
> So, let's explicitly specify, what test wants: set max-chunk to 64K, so
> that one iteration is 64K. Note, that we don't need to limit
> max-workers, as block-copy rate limitator will handle the situation and

*limitator

> wouldn't start new workers when speed limit is obviously reached.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/185     | 3 ++-
>  tests/qemu-iotests/185.out | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> index fd5e6ebe11..6afb3fc82f 100755
> --- a/tests/qemu-iotests/185
> +++ b/tests/qemu-iotests/185
> @@ -182,7 +182,8 @@ _send_qemu_cmd $h \
>                        'target': '$TEST_IMG.copy',
>                        'format': '$IMGFMT',
>                        'sync': 'full',
> -                      'speed': 65536 } }" \
> +                      'speed': 65536,
> +                      'x-max-chunk': 65536 } }" \

Out of curiosity, would it also suffice to disable copy offloading?

But anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      "return"
> =20
>  # If we don't sleep here 'quit' command races with disk I/O
> diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
> index ac5ab16bc8..5232647972 100644
> --- a/tests/qemu-iotests/185.out
> +++ b/tests/qemu-iotests/185.out
> @@ -61,7 +61,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D=
67108864 cluster_size=3D65536 l
> =20
>  { 'execute': 'qmp_capabilities' }
>  {"return": {}}
> -{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': =
'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 6553=
6 } }
> +{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': =
'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 6553=
6, 'x-max-chunk': 65536 } }
>  Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67108864 cluster_=
size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzli=
b
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
>=20



--pkc5LJv6Z66uepcyXEV7bgjX5Gz3UAbZa--

--Ljob3MIktykyeb7BRQoY7vt3FxzGNWKqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8ZR/UACgkQ9AfbAGHV
z0C8NQf/ZTYCJxwhcWagl4vtqpZl915cKNUrLih9/zxGV2cBQioCODbnKe2iIeKX
TRjkk5dlYr1lGPLppZ7KnAuhuTXTc+gZ7Xn2Cx8NxUmAvMs+0WnACJJalOD1YyhS
KQrcVRvQn9vuByCKo+E2feBJAjLCvm0NDLMVkNy3y0Hq7q/rDoXW51FdX1phkOV4
rrd/dnv2wQJJck3GOxF8q5JixwfpG/N1a0KpNt7qnI0LoHz9fFPWM0E3a+PAHfq5
6ZJt1d+Pib6jh41Z5ueZM0phRmYMG6cVvngr2qiAIIKg3IhzPicQSyh+Yz3+YRTA
nu5lOcJ3c2Hzdx90fmhL8YPERt/WRw==
=OPPQ
-----END PGP SIGNATURE-----

--Ljob3MIktykyeb7BRQoY7vt3FxzGNWKqi--


