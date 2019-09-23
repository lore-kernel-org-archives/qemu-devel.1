Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFC2C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DF020820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DF020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCM4U-0007Eq-At
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 06:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCM3k-0006j2-7e
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCM3j-0008LF-1D
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCM3f-0008H4-V0; Mon, 23 Sep 2019 06:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A5B289AC2;
 Mon, 23 Sep 2019 10:59:06 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C623C60852;
 Mon, 23 Sep 2019 10:59:01 +0000 (UTC)
Subject: Re: [PATCH v9 0/9] discard blockstats
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
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
Message-ID: <13885e81-16ae-f2f3-488c-b55fb76aaf4c@redhat.com>
Date: Mon, 23 Sep 2019 12:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AVxgYMVeshQK9u2D1kVq2JmV16lSe23FX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 23 Sep 2019 10:59:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AVxgYMVeshQK9u2D1kVq2JmV16lSe23FX
Content-Type: multipart/mixed; boundary="wULJwlvs2PVcNysMdSNIzfAjkqUGiT9af";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com,
 vsementsov@virtuozzo.com
Message-ID: <13885e81-16ae-f2f3-488c-b55fb76aaf4c@redhat.com>
Subject: Re: [PATCH v9 0/9] discard blockstats
References: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>

--wULJwlvs2PVcNysMdSNIzfAjkqUGiT9af
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.09.19 18:01, Anton Nefedov wrote:
> v9:
>  - fixed patch 5 so the fields are actually numbered in sectors not blo=
cks
>  - fixed patch 7 accordingly
>  - patch 8: make stat fields unsigned
>  - qapi patches: "since 4.1" -> "since 4.2"
>=20
> v8: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03709.html=


For the record: Looks OK to me, but I suppose you still wanted to change
patch 3=E2=80=99s commit message.

(I still don=E2=80=99t like patch 9 very much, but that won=E2=80=99t sto=
p me from
taking it.)

Max


--wULJwlvs2PVcNysMdSNIzfAjkqUGiT9af--

--AVxgYMVeshQK9u2D1kVq2JmV16lSe23FX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2IpXQACgkQ9AfbAGHV
z0AGYggApCNP4fu7zCdnD0P1437x2iI2PQA9odID3Imm3c13fMA3PGffvdkErwGg
bKd+NNeWXB9Ef1iYZ3GzcjnQvX0wWFyJ0Pqof9eZzGh9a+HeB2KUxxUZUG9dJgAU
Jd4KZkbILlJiCJ6p//9GqE3DZ8sRM47IYhjewsZqQO+AITPnUxx5559MGZdYRR7E
0E4J9zJFQSlr/y5G5x+jTdokSO5Y0M4b22q0dzgC03g3NwaNxMtoGJSq+LQHo/iX
ktQEtQ0jD16+AtNW8TcgIyiUWO3wqQhFYvKUi0HQJiqmT4XX3MfuSVF+Gxuw1/69
eTLlvNOAuFUVqC/ks8SnzE5wO05fmA==
=dNk6
-----END PGP SIGNATURE-----

--AVxgYMVeshQK9u2D1kVq2JmV16lSe23FX--

