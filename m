Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD954C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9303222BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9303222BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgXb-0008Up-OL
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqgXP-000813-FI
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqgXO-0000hg-G6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqgXM-0000d3-4s; Thu, 25 Jul 2019 12:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C234C070E3A;
 Thu, 25 Jul 2019 16:24:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A28D67150;
 Thu, 25 Jul 2019 16:24:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-3-mreitz@redhat.com>
 <9021e43da1e3c46354486c416c1d65935b37a9d2.camel@redhat.com>
 <9f60f964-8b4b-cd7f-d538-b8c41268e804@redhat.com>
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
Message-ID: <14116f4b-0fbf-c7e3-570e-03a78b2e60ff@redhat.com>
Date: Thu, 25 Jul 2019 18:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9f60f964-8b4b-cd7f-d538-b8c41268e804@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UwRR8cywaVpjvWZ0Fi59TXVFNkLSQ7bl1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 25 Jul 2019 16:24:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/11] mirror: Fix bdrv_has_zero_init()
 use
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
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UwRR8cywaVpjvWZ0Fi59TXVFNkLSQ7bl1
Content-Type: multipart/mixed; boundary="iYKNA74bAVkI8jrp78DL6I8PZzv3PsjCc";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <14116f4b-0fbf-c7e3-570e-03a78b2e60ff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/11] mirror: Fix bdrv_has_zero_init()
 use
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-3-mreitz@redhat.com>
 <9021e43da1e3c46354486c416c1d65935b37a9d2.camel@redhat.com>
 <9f60f964-8b4b-cd7f-d538-b8c41268e804@redhat.com>
In-Reply-To: <9f60f964-8b4b-cd7f-d538-b8c41268e804@redhat.com>

--iYKNA74bAVkI8jrp78DL6I8PZzv3PsjCc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 18:21, Max Reitz wrote:
> On 25.07.19 17:28, Maxim Levitsky wrote:

[...]

>> For example, QMP reference states that MIRROR_SYNC_MODE_TOP copies dat=
a in the topmost image to the destination.
>> If there is only the topmost image, I could image the caller assume th=
at target is identical to the source.
>=20
> It doesn=E2=80=99t say that it copies the data in the topmost image.  I=
t says it
> copies the data *allocated* in the topmost image.  It follows that it
> will not copy any data that is not allocated.

(I just saw that MirrorSyncMode indeed just says =E2=80=9Cdata in the top=
most
image=E2=80=9D.  I was looking at DriveBackup and blockdev-backup, which =
say
=E2=80=9Conly the sectors allocated in the topmost image=E2=80=9D.  I thi=
nk what
DriveBackup and blockdev-backup say takes precedence here.)

Max


--iYKNA74bAVkI8jrp78DL6I8PZzv3PsjCc--

--UwRR8cywaVpjvWZ0Fi59TXVFNkLSQ7bl1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0516YACgkQ9AfbAGHV
z0BxYwf9GzpjY24OU+VB4kU+KwUBphzH1vdrzWLV6SgT4LbmtxtJ1qAMRaDi2kkt
FmaObOkqiTS2cIDQJmAs5ppSE5dQ7NXrjBcll1w9AilXrOI3HRTnm+S09QeTOrp/
HPca0RJRfBL2ugS1HPXeBouTFVOrW1QOhJA5bX0V4Uy+Gq27/Rh5CbCyM3CSBwvP
qEHosczZxzuA/kNuECsyKEhluxEVfCUqZETG3S2hdDMUq27vAIdhlBDbMiI3fh52
sKsqie8Yz9xnHQuo7wfWZ4QwJlFMkQJuupOJrOfEQkqLxMh7VrutRuIXqbUrmDKn
zKqvG2P1BIJct7X/zyJvmKn1bos/pQ==
=KtFC
-----END PGP SIGNATURE-----

--UwRR8cywaVpjvWZ0Fi59TXVFNkLSQ7bl1--

