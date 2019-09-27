Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0854EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6418207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6418207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmez-0005MN-FG
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmZY-0001zs-On
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmZX-0005TD-Cc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmZR-0005K1-AN; Fri, 27 Sep 2019 05:29:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F9943082135;
 Fri, 27 Sep 2019 09:29:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-76.brq.redhat.com
 [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 257F660A9F;
 Fri, 27 Sep 2019 09:29:45 +0000 (UTC)
Subject: Re: [PATCH 0/3] iotests: Fix 125
To: qemu-block@nongnu.org
References: <20190925183231.11196-1-mreitz@redhat.com>
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
Message-ID: <db32c2d6-ff45-f651-bc90-ef3d4c79d5eb@redhat.com>
Date: Fri, 27 Sep 2019 11:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925183231.11196-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0Au30nqWPGHVCDKGsCrm6OPoE3nUSnJu8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 27 Sep 2019 09:29:47 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0Au30nqWPGHVCDKGsCrm6OPoE3nUSnJu8
Content-Type: multipart/mixed; boundary="apIE46xiOL6RubfR92I2iWCky5Kw9Sbsi"

--apIE46xiOL6RubfR92I2iWCky5Kw9Sbsi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 20:32, Max Reitz wrote:
> Hi,
>=20
> iotest 125 is very broken.  It uses qemu-img info=E2=80=99s =E2=80=9Cdi=
sk size=E2=80=9D to
> determine an image=E2=80=99s on-disk size, but it does so in a wrong wa=
y: It
> just fetches the first number ([0-9]+), but that isn=E2=80=99t very use=
ful
> because qemu-img info emits human-readable values that include units an=
d
> decimal points.
>=20
> We should ust stat -c %b instead.  That=E2=80=99s done in patch 3.
> Unfortunately, doing so exposed more problems.
>=20
> Patch 1 fixes a stupid bug in the test itself that we never noticed
> because of what patch 3 fixes.  (Pull patch 3 before patch 1 and you=E2=
=80=99ll
> see.)
>=20
> The other thing is actually a bug in XFS.  Its fallocate()
> implementation rounds up the length independently of the offset, so if
> you try to fallocate an unaligned range, chances are that it might not
> allocate the last block your range touches.  Patch 2 detects that case
> and skips the test then.  (Pull patch 3 before patch 2 and you=E2=80=99=
ll see
> the test fail on XFS.)
>=20
>=20
> Max Reitz (3):
>   iotests: Fix 125 for growth_mode =3D metadata
>   iotests: Disable 125 on broken XFS versions
>   iotests: Use stat -c %b in 125
>=20
>  tests/qemu-iotests/125 | 45 +++++++++++++++++++++++++++++++++++++++---=

>  1 file changed, 42 insertions(+), 3 deletions(-)

Thanks for the review, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block


And for the record, I=E2=80=99ve sent a patch to the XFS driver:

https://www.spinics.net/lists/linux-xfs/msg32174.html

Max


--apIE46xiOL6RubfR92I2iWCky5Kw9Sbsi--

--0Au30nqWPGHVCDKGsCrm6OPoE3nUSnJu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2N1ogACgkQ9AfbAGHV
z0AqTAf+Ihe/tOdjQ3/b/weEI+sZ/ejqRKa28aI5Mcw67uaxzpEcT2teAXTZq2Cc
8KI3AtIAj7aN91x928K/CWK5JMivsqBYc8oIPdVLC+yihEE5P11sga8ON5IEA368
vsH8Jksk3bWDkjDWA1bnbQrVJu/zmXt5XmODM+Agui30Na74nOQ0/MQvNAkdMcwF
6CGfgpm/N6NA3K1GiDEYXZkS8RZNUmX9qQf/j4riW6cq08DB6/olsfjLNjXVEnxl
IYzgONEtBh5FQVnhkZ0V6j7k/+ASs/caExSLlWC9UHdSzXzhT2c26gzu0sghPBZN
m2mxGhdGDsVwS5oHSB/PfP4XlyoZjg==
=hg/5
-----END PGP SIGNATURE-----

--0Au30nqWPGHVCDKGsCrm6OPoE3nUSnJu8--

