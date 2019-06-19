Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F44C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 17:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1262084E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 17:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1262084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdeSv-00073R-7B
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hde7d-0006sp-9c
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 13:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hde7S-0005Cb-3G
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 13:11:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hde7A-0004Na-Cj; Wed, 19 Jun 2019 13:11:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BEE20309267F;
 Wed, 19 Jun 2019 17:10:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-121.ams2.redhat.com
 [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2AC19C5B;
 Wed, 19 Jun 2019 17:10:05 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
 <20190605121721.29815-2-shmuel.eiderman@oracle.com>
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
Message-ID: <f55d8c2e-27e7-ca1b-b1e7-ef2f4a8b0823@redhat.com>
Date: Wed, 19 Jun 2019 19:10:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605121721.29815-2-shmuel.eiderman@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iAh7GBdU2VHBttcybdr3b3KK0DdHdqENS"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 19 Jun 2019 17:10:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] vmdk: Fix comment regarding max
 l1_size coverage
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
Cc: arbel.moshe@oracle.com, liran.alon@oracle.com, eyal.moscovici@oracle.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iAh7GBdU2VHBttcybdr3b3KK0DdHdqENS
Content-Type: multipart/mixed; boundary="6TUFItNCtSuc20wtJbrQ4GLUdNvqyaMr5";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eyal.moscovici@oracle.com, karl.heubaum@oracle.com,
 liran.alon@oracle.com, arbel.moshe@oracle.com
Message-ID: <f55d8c2e-27e7-ca1b-b1e7-ef2f4a8b0823@redhat.com>
Subject: Re: [PATCH v2 1/3] vmdk: Fix comment regarding max l1_size coverage
References: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
 <20190605121721.29815-2-shmuel.eiderman@oracle.com>
In-Reply-To: <20190605121721.29815-2-shmuel.eiderman@oracle.com>

--6TUFItNCtSuc20wtJbrQ4GLUdNvqyaMr5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.06.19 14:17, Sam Eiderman wrote:
> Commit b0651b8c246d ("vmdk: Move l1_size check into vmdk_add_extent")
> extended the l1_size check from VMDK4 to VMDK3 but did not update the
> default coverage in the moved comment.
>=20
> The previous vmdk4 calculation:
>=20
>     (512 * 1024 * 1024) * 512(l2 entries) * 65536(grain) =3D 16PB
>=20
> The added vmdk3 calculation:
>=20
>     (512 * 1024 * 1024) * 4096(l2 entries) * 512(grain) =3D 1PB
>=20
> Adding the calculation of vmdk3 to the comment.
>=20
> In any case, VMware does not offer virtual disks more than 2TB for
> vmdk4/vmdk3 or 64TB for the new undocumented seSparse format which is
> not implemented yet in qemu.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  block/vmdk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6TUFItNCtSuc20wtJbrQ4GLUdNvqyaMr5--

--iAh7GBdU2VHBttcybdr3b3KK0DdHdqENS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0KbGwACgkQ9AfbAGHV
z0BC0Af/SBvZFaHz6FJh0BlaYFYoYIZ0VsCiYWLTvZMq4gPlqviN7Imk6HlUkqZd
JXNA5ORRXpyGTX9hXFJcPNv29rzB84BcAIHAnpbpCmsuTxnNNX3p4vmJbUTNaFgd
wzRMRpvubhpouDnvLb0ZrhuaCasB2cn7Gd8o60F4x0FIooxHMq2ltIBFwASoDI6x
xGjS1fhaL7QD7tY8UGZGZaCMgJFEURmXyaHaTwzvjZKn5q4KzrKSRW2LWsPXYkeu
sJAcwIjFIwkbzh/ZlhP9s25R5a1V9jMn17TBgLmPSu7U9eC+anNikPPjZL4hJKkj
3flIjfvMg/laNaIBHI8dqgRm7RXmhw==
=KiGH
-----END PGP SIGNATURE-----

--iAh7GBdU2VHBttcybdr3b3KK0DdHdqENS--

