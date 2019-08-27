Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB72C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F802173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F802173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2erW-00010M-D3
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 13:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2epS-0008Hb-31
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 13:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2epQ-0002By-V2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 13:00:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2epN-00027K-9x; Tue, 27 Aug 2019 13:00:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96D7318C4269;
 Tue, 27 Aug 2019 17:00:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DCAD1001B09;
 Tue, 27 Aug 2019 17:00:15 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
References: <20190827010528.8818-1-nsoffer@redhat.com>
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
Message-ID: <2b1dc4ab-f313-2420-7898-66d8ccddae24@redhat.com>
Date: Tue, 27 Aug 2019 19:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827010528.8818-1-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hQEUEzmyU4Uxhm4ddtwQSHWqBCX3ErFSM"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 27 Aug 2019 17:00:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Optimize alignment probing
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
--hQEUEzmyU4Uxhm4ddtwQSHWqBCX3ErFSM
Content-Type: multipart/mixed; boundary="gSXU6WlNVA0f4K8fp1WAwe0C7aMmV5Twd";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <2b1dc4ab-f313-2420-7898-66d8ccddae24@redhat.com>
Subject: Re: [PATCH v3 0/2] Optimize alignment probing
References: <20190827010528.8818-1-nsoffer@redhat.com>
In-Reply-To: <20190827010528.8818-1-nsoffer@redhat.com>

--gSXU6WlNVA0f4K8fp1WAwe0C7aMmV5Twd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.08.19 03:05, Nir Soffer wrote:
> When probing unallocated area on remote XFS filesystem we cannot detect=
 request
> alignment and we fallback to safe value which may not be optimal. Avoid=
 this
> fallback by always allocating the first block when creating a new image=
 or
> resizing empty image.
>=20
> Tested with all formats:
>=20
>     for fmt in raw bochs cloop parallels qcow qcow2 qed vdi vpc vhdx vm=
dk luks dmg; do
>         ./check -$fmt
>     done

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--gSXU6WlNVA0f4K8fp1WAwe0C7aMmV5Twd--

--hQEUEzmyU4Uxhm4ddtwQSHWqBCX3ErFSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1lYZ0ACgkQ9AfbAGHV
z0CX0ggAjlb1dVpHvbWnnRojmkt+UvwZO6fm1pV83RClh9d22kofxujUHxIOncX0
Q3/238zq+7fZbCaEpC8EP3IAi5/SHmmJQc1P3AuVPsICT7HowMLXWllSI1dA3ehT
TOTZ8Pz8KHq7SIwGHSSIukE4lKhP+PwQelOpDsub+qDHDZCEVFuz7iuvfbUQvtnt
QRzMqWjm0Z1+BXD9OHOCBOaMtv40rNMFQIljUAny1KcRH/MoU4Pq2HFaZk0n9KyD
GkrkYj8BJp5b//N8cSEZTIw/35mwlQsaRXScZojsg92My4HO/7Nd07QWCH+fDQmk
dZv1dR+p4dzokAdiiIAIKKtHHDL5Dw==
=HtUj
-----END PGP SIGNATURE-----

--hQEUEzmyU4Uxhm4ddtwQSHWqBCX3ErFSM--

