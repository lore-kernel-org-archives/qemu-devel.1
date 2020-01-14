Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CABC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA29222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDpDEO47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA29222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOTG-0004m5-9R
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irORN-0002C4-Cx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irORJ-0005WO-Fh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:49:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irORI-0005UE-Of
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579016947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4opq6bFvLmvKn+Ibsp1yV6wDjIfJ3wX3/YmR89DsOHM=;
 b=TDpDEO47p6MQGuS8+t54MrexYZeyQ/Zq3yPbBYkXlB3mClR1yjrcHm4YwTAsfIx17mJRf6
 Sh59QISVB7BFiuvVLmqP/B8YHF8lzS4cmlDJkyK6Y+JYDRWUjmOCMktSQFqkP0Gva7ibNx
 wj71CgTcDaiBNsOE/K1vf5rdtUcSde4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-lFap_rQBO_qxacfSiVBJGA-1; Tue, 14 Jan 2020 10:49:05 -0500
X-MC-Unique: lFap_rQBO_qxacfSiVBJGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B14F190D340;
 Tue, 14 Jan 2020 15:49:04 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD7295D9E5;
 Tue, 14 Jan 2020 15:49:00 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] iotests: add 282 luks qemu-img measure test
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200109111012.559052-1-stefanha@redhat.com>
 <20200109111012.559052-5-stefanha@redhat.com>
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
Message-ID: <e12a1f59-f72b-921b-d211-0931c1682eb9@redhat.com>
Date: Tue, 14 Jan 2020 16:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109111012.559052-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7cRfLgUNef2Johs6JVOLdsqkCDI9fpSdA"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7cRfLgUNef2Johs6JVOLdsqkCDI9fpSdA
Content-Type: multipart/mixed; boundary="q4oSFdZKUzCmD4r3u22tzJc3WpbROQ0VE"

--q4oSFdZKUzCmD4r3u22tzJc3WpbROQ0VE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.01.20 12:10, Stefan Hajnoczi wrote:
> This test exercises the block/crypto.c "luks" block driver
> .bdrv_measure() code.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/282     | 93 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/282.out | 30 ++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 124 insertions(+)
>  create mode 100755 tests/qemu-iotests/282
>  create mode 100644 tests/qemu-iotests/282.out

[...]

> diff --git a/tests/qemu-iotests/282.out b/tests/qemu-iotests/282.out
> new file mode 100644
> index 0000000000..8f4737aef7
> --- /dev/null
> +++ b/tests/qemu-iotests/282.out
> @@ -0,0 +1,30 @@
> +QA output created by 282
> +=3D=3D measure 1G image file =3D=3D
> +
> +required size: 2068480
> +fully allocated size: 1075810304
> +
> +=3D=3D create 1G image file (size should be no greater than measured) =
=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
> +image file size in bytes: 1075810304

It clearly is greater than measured, though.  (Because zero data
generally isn=E2=80=99t encrypted to be zero.)

I also wonder whether it even makes much sense to check the file length,
because I suppose we=E2=80=99re actually interested in how much is allocate=
d.
That is, I think it=E2=80=99s fine to have the file length be greater than
what=E2=80=99s been measured, but the allocated file size shouldn=E2=80=99t=
 be.

But then again the allocated file size may well be greater because of
filesystem shenanigans...

Max


--q4oSFdZKUzCmD4r3u22tzJc3WpbROQ0VE--

--7cRfLgUNef2Johs6JVOLdsqkCDI9fpSdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4d4uoACgkQ9AfbAGHV
z0CXJgf9HkUJlsFlulH0UVhJ/RNTbq9sQVDETxnWIMBJ7C1vwf1OeyaRySpGZY2L
zb/K3n3RREnCVbzwXQ7y9TE4sdg+WZs6Zup111mVJVOOVtBRxT3bASrsX2lD1xEi
sKvfX+I+zx8iB9KD9ICaVakxtF/KrEJhOwE6N6OakMIVS+GyyuO6vW/agbbvLGRW
K3wyXBHPw/E95rik8noNC2LLeuJEJFdid2OnJRpwjNsFc6qjlNFVqjhQlqQE6QJM
QJzPYUpmwuXQjW4ftEmVv4yAt76vUBN+fa1MkhOgfZyOyl8Ab+9VJuiq8rVuws9M
Z4nHKzisJ6MNsnTKKZnrg8h+LFuLvg==
=gaAX
-----END PGP SIGNATURE-----

--7cRfLgUNef2Johs6JVOLdsqkCDI9fpSdA--


