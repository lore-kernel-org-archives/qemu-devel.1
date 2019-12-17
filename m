Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9A8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447D024655
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KT+wX5Vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447D024655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDuh-0006Zr-8h
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihDtn-0005yA-QQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihDtl-0007AR-HV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:32:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihDtl-0007AE-Co
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576593148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lkqhp0b0MB0H2+GoCL+ZGd7NwoW2mMccsYUZcxhqmh0=;
 b=KT+wX5ViipIGLKNeEo95zi49g04znXPZR/XLd7nse7+7sazNhDQS0PwWZJHMscCl9wt6VA
 C+7WjmRPIIxZiKZ0BqKtRLhBqaUxpAUUfSbVMCtpr6tw25Mr07I7oPChRPM9RjSm4Eyh1G
 IjRdT4pwJxJavAuOyx57H7mD3xKI1Gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-FeE350YsNSKR_S5Bf_ICtQ-1; Tue, 17 Dec 2019 09:32:25 -0500
X-MC-Unique: FeE350YsNSKR_S5Bf_ICtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D444D800053;
 Tue, 17 Dec 2019 14:32:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 875E4167A3;
 Tue, 17 Dec 2019 14:32:23 +0000 (UTC)
Subject: Re: [PATCH v3 00/22] iotests: Allow ./check -o data_file
To: qemu-block@nongnu.org
References: <20191107163708.833192-1-mreitz@redhat.com>
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
Message-ID: <0e756bbe-4213-c662-99ae-ffbcf87c390c@redhat.com>
Date: Tue, 17 Dec 2019 15:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o9nLw83kJjz7wmIFUKEvPEApUN3v08Z4Q"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o9nLw83kJjz7wmIFUKEvPEApUN3v08Z4Q
Content-Type: multipart/mixed; boundary="wHj9UVK9J8j2WVxaj5Ww32zvPUC7Rg5x3"

--wHj9UVK9J8j2WVxaj5Ww32zvPUC7Rg5x3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.19 17:36, Max Reitz wrote:
> Hi,
>=20
> The cover letter from v1 (explaining the motivation behind this series
> and the general structure) is here:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01323.html
>=20
>=20
> For v2, I=E2=80=99ve addressed more of Maxim=E2=80=99s comments:
> - Patch 1: Added; Maxim noted this problem on patch 5, but that patch
>            doesn=E2=80=99t touch all files that have this mistake, so I d=
ecided
>            to make it an extra patch
>=20
> - Patch 20 (now patch 21):
>   - Added TODO comments where it would make sense to at some point split
>     off some cases into an own test file (so they can run with an
>     external data file, where the whole test now has to be skipped)
>   - Fixed the reason why we have to skip 138 with external data files
>   - Disable 261, too (which was added in the meantime)
>=20
> - Some contextual differences in some patches due to the $SOCK_DIR
>   series

Thanks for the reviews, fixed the typo in patch 21, disabled data_file
for 273 (which was added in the meantime), and applied the series to my
block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--wHj9UVK9J8j2WVxaj5Ww32zvPUC7Rg5x3--

--o9nLw83kJjz7wmIFUKEvPEApUN3v08Z4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl345vUACgkQ9AfbAGHV
z0DKCAgAtP6lBPTc2WaDPsZj5uqS/xpUdk+UmzeKv3cisHS+By2lKTCQkrpmV9jr
nCy7246ceiqbRE0AXfW8NlPP61gwI18aRNQXlzk2yEBEb8RNsNhGHsG+3Ju0hBhp
7P+a/JVTbr8q6TDKPMSsvwjQ8EenN20hCtGuTLn+6iHtr5wQOYtC0h62j3j1DoOp
PARKL2avXyHm50t5A2HEInPhiksfebKCgyHwM1yKxGfwin0U1l2pUOI5rdP5RWMv
9E1qumw9Q5EdrLgx7Qx+0HKVtTLAFhUQdCYjNJM+XM+JTV0jDgKokmdSP8Z8yDn+
aFfhS6N+y/i2cE394rN/7F0shnU4Jw==
=dtFX
-----END PGP SIGNATURE-----

--o9nLw83kJjz7wmIFUKEvPEApUN3v08Z4Q--


