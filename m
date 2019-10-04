Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7642AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485AD2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485AD2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGT1P-0004Rz-8M
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 15:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGSzl-0003OI-1N
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGSzk-0000zA-0H
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGSzh-0000vr-E7; Fri, 04 Oct 2019 15:12:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABF68309DEED;
 Fri,  4 Oct 2019 19:12:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44A495D6B7;
 Fri,  4 Oct 2019 19:11:56 +0000 (UTC)
Subject: Re: [PATCH v2 11/11] iotests : add tests for encryption key management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-12-mlevitsk@redhat.com>
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
Message-ID: <d66665e3-5eed-eef7-f56f-6392418913bf@redhat.com>
Date: Fri, 4 Oct 2019 21:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190912223028.18496-12-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E2G0hklPUcubadvdC04s3yHiOYaYi9pav"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 04 Oct 2019 19:12:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E2G0hklPUcubadvdC04s3yHiOYaYi9pav
Content-Type: multipart/mixed; boundary="KJNA0jAkzYHSgNEyvUU7tmZjS8claQF5n"

--KJNA0jAkzYHSgNEyvUU7tmZjS8claQF5n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 00:30, Maxim Levitsky wrote:
> Note that currently I add tests 300-302, which are
> placeholders to ease the rebase. In final version
> of these patches I will update these.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/300     | 202 +++++++++++++++++++++++++++++
>  tests/qemu-iotests/300.out |  98 +++++++++++++++
>  tests/qemu-iotests/301     |  90 +++++++++++++
>  tests/qemu-iotests/301.out |  30 +++++
>  tests/qemu-iotests/302     | 252 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/302.out |  18 +++
>  tests/qemu-iotests/303     | 228 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/303.out |  28 +++++
>  tests/qemu-iotests/group   |   9 ++
>  9 files changed, 955 insertions(+)
>  create mode 100755 tests/qemu-iotests/300
>  create mode 100644 tests/qemu-iotests/300.out
>  create mode 100755 tests/qemu-iotests/301
>  create mode 100644 tests/qemu-iotests/301.out
>  create mode 100644 tests/qemu-iotests/302
>  create mode 100644 tests/qemu-iotests/302.out
>  create mode 100644 tests/qemu-iotests/303
>  create mode 100644 tests/qemu-iotests/303.out

[...]

> diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
> new file mode 100644
> index 0000000000..1cf3917208
> --- /dev/null
> +++ b/tests/qemu-iotests/303.out
> @@ -0,0 +1,28 @@
> +qemu-img: Failed to get shared "consistent read" lock
> +Is another process using the image [/home/mlevitsk/USERSPACE/qemu/buil=
d-luks/tests/qemu-iotests/scratch/test.img]?

Ah, this should be filtered.

Max


--KJNA0jAkzYHSgNEyvUU7tmZjS8claQF5n--

--E2G0hklPUcubadvdC04s3yHiOYaYi9pav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XmXoACgkQ9AfbAGHV
z0CpaAf9Fx6RgFxZyaKl/hA9VSE3VrkyhLwhW5tC1UoNbKhRXAJW6BfuIknYou3/
xiw5bQC5s1VUeeZT5H5oIcr87N/wo7THFXPGbZW+bAS8rSdydBYshHkDXLNkxgDn
Hm/w+J2I6WemR3aOFwTMp44LCNeA2M9WZJbzbQweGCQy1/ZuxZCF1IOb8WxTBPan
g+vnbPkUNuVN5zC5EGmU7YhQ+dD1rb4BjxeQXp3vNb/57P5KHpVfdN20cCPRqskr
ONTQEaYpWBgojMSCepkZ/rGvZ/+6MtistZGTYz+i3+GltNvfnxmObEH/Q0sXyu6A
d18ROoN8WRY95y5n6SoTLdVC4L1tTQ==
=rgwH
-----END PGP SIGNATURE-----

--E2G0hklPUcubadvdC04s3yHiOYaYi9pav--

