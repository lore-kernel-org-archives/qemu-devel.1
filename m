Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E01C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28E72190F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnWPxSM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28E72190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkyw-0002Io-Rg
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iWky3-0001gX-GN
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iWky2-0000Tp-FG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:37:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21376
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iWky2-0000TW-BS
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574098657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aVq8/auNNiNVdPVA7t+vzdcLwoUkZ2T3GIVav5i5/kw=;
 b=WnWPxSM/g+TKRkHuaxP8kfBG0QlFExfmnjIrcTs/CHmpQRH3KKt7VG3YOuZz+gckZbiH6V
 E5TyFyUZdJZql1jr5rZS63Bcv4iQrzBKNm/lsnM1eoPp8yszYeRdPNxO0+pbV19pmFzN/V
 oVEscnd7IfWaMpvl0WnXwoWLHyacW0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-cpkixfUqPwqNmLzk5ZJNLA-1; Mon, 18 Nov 2019 12:37:34 -0500
X-MC-Unique: cpkixfUqPwqNmLzk5ZJNLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C933DB23;
 Mon, 18 Nov 2019 17:37:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-88.ams2.redhat.com
 [10.36.117.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D11EF60307;
 Mon, 18 Nov 2019 17:37:31 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] iotests: Include QMP input in .out files
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191114213415.23499-1-eblake@redhat.com>
 <20191114213415.23499-4-eblake@redhat.com>
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
Message-ID: <9c9284a0-19a8-fc17-d20d-346c959f4578@redhat.com>
Date: Mon, 18 Nov 2019 18:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114213415.23499-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2MbM1ZKVxnrKGJhcc06cpv0bPBqP2iPwy"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2MbM1ZKVxnrKGJhcc06cpv0bPBqP2iPwy
Content-Type: multipart/mixed; boundary="0Tvjr27PDKMvQ8MgqRPw5IEoVWPOmyFxK"

--0Tvjr27PDKMvQ8MgqRPw5IEoVWPOmyFxK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 22:34, Eric Blake wrote:
> We generally include relevant HMP input in .out files, by virtue of
> the fact that HMP echoes its input.  But QMP does not, so we have to
> explicitly inject it in the output stream (appropriately filtered to
> keep the tests passing), in order to make it easier to read .out files
> to see what behavior is being tested (especially true where the output
> file is a sequence of {'return': {}}).
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/common.qemu |  9 ++++
>  tests/qemu-iotests/085.out     | 26 ++++++++++
>  tests/qemu-iotests/094.out     |  4 ++
>  tests/qemu-iotests/095.out     |  2 +
>  tests/qemu-iotests/109.out     | 88 ++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/117.out     |  5 ++
>  tests/qemu-iotests/127.out     |  4 ++
>  tests/qemu-iotests/140.out     |  5 ++
>  tests/qemu-iotests/141.out     | 26 ++++++++++
>  tests/qemu-iotests/143.out     |  3 ++
>  tests/qemu-iotests/144.out     |  5 ++
>  tests/qemu-iotests/153.out     | 11 +++++
>  tests/qemu-iotests/156.out     | 11 +++++
>  tests/qemu-iotests/161.out     |  8 ++++
>  tests/qemu-iotests/173.out     |  4 ++
>  tests/qemu-iotests/182.out     |  8 ++++
>  tests/qemu-iotests/183.out     | 11 +++++
>  tests/qemu-iotests/185.out     | 18 +++++++
>  tests/qemu-iotests/191.out     |  8 ++++
>  tests/qemu-iotests/200.out     |  1 +
>  tests/qemu-iotests/223.out     | 19 ++++++++
>  tests/qemu-iotests/229.out     |  3 ++
>  tests/qemu-iotests/249.out     |  6 +++
>  23 files changed, 285 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--0Tvjr27PDKMvQ8MgqRPw5IEoVWPOmyFxK--

--2MbM1ZKVxnrKGJhcc06cpv0bPBqP2iPwy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3S1tkACgkQ9AfbAGHV
z0CiMggAnBbZVNEr+w3k6UP78CCpr7UzRg5OutzwLssEH9S/VtM/yTn1Qf8FWdn5
G190rYkSyjNNDZ098IifMynyl6KCr6D4j8hSQ0cQgAmGfGfe42qwv/VgFRT1Xz0D
NI2Qi2X8FfiQicUyR2ShaAdaGECSyLKoB2mlIqckCYBI5cmkFSL6S/ClOwQ0LsTt
tRwEGPIUIS+3O294WUvqXr7A9BK4XPNAlhMlhlK6ISZiADRm4j1phFwi+aLJLhbH
Rcl6YmbZI3/3LWpd1NGb0VsF3w5PplJFsUPDyv+AF4PfozdrQPn0d08azg59NSNj
29JQhf95jFhKY2JInlV0KrmLPXPmfA==
=ugMS
-----END PGP SIGNATURE-----

--2MbM1ZKVxnrKGJhcc06cpv0bPBqP2iPwy--


