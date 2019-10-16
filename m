Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC9EC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD8D20872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD8D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKdaq-0006mt-LM
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 03:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKda4-0006Gq-PG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKda3-0004id-H7
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKda0-0004iF-Iy; Wed, 16 Oct 2019 03:18:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82672A3CD8A;
 Wed, 16 Oct 2019 07:18:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-109.ams2.redhat.com
 [10.36.117.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EE075C1B5;
 Wed, 16 Oct 2019 07:18:42 +0000 (UTC)
Subject: Re: [PATCH v2 00/21] iotests: Allow ./check -o data_file
To: qemu-devel@nongnu.org
References: <157118519444.5946.8808407300812393372@37313f22b938>
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
Message-ID: <8b2d6f8c-92a1-03d8-163c-59404081b30c@redhat.com>
Date: Wed, 16 Oct 2019 09:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <157118519444.5946.8808407300812393372@37313f22b938>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vtFIoTbMqgm503oWEhn0IQjhRoUoWPPX2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 16 Oct 2019 07:18:43 +0000 (UTC)
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vtFIoTbMqgm503oWEhn0IQjhRoUoWPPX2
Content-Type: multipart/mixed; boundary="eaxjkagEsHHQDSeanxLPVbEbwZaRxdWEh"

--eaxjkagEsHHQDSeanxLPVbEbwZaRxdWEh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.10.19 02:19, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191015142729.18123-1-mreitz@red=
hat.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20
> Subject: [PATCH v2 00/21] iotests: Allow ./check -o data_file
> Type: series
> Message-id: 20191015142729.18123-1-mreitz@redhat.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 7e75916 iotests: Allow check -o data_file
> a21918d iotests: Disable data_file where it cannot be used
> 1eb7209 iotests: Make 198 work with data_file
> 02453ff iotests: Make 137 work with data_file
> cdb651c iotests: Make 110 work with data_file
> 1b30e90 iotests: Make 091 work with data_file
> 26ebffa iotests: Avoid cp/mv of test images
> 5d6ba79 iotests: Use _rm_test_img for deleting test images
> 4c20fa0 iotests: Avoid qemu-img create
> 944555b iotests: Drop IMGOPTS use in 267
> 9037b83 iotests: Replace IMGOPTS=3D'' by --no-opts
> e62282b iotests: Replace IMGOPTS=3D by -o
> 26d39b5 iotests: Inject space into -ocompat=3D0.10 in 051
> 99d129e iotests: Add -o and --no-opts to _make_test_img
> 301f2c3 iotests: Let _make_test_img parse its parameters
> 53a8dea iotests: Drop compat=3D1.1 in 050
> 85b18f8 iotests: Replace IMGOPTS by _unsupported_imgopts
> 476fb23 iotests: Filter refcount_order in 036
> 67b9119 iotests: Add _filter_json_filename
> fbf9402 iotests/qcow2.py: Split feature fields into bits
> afe3486 iotests/qcow2.py: Add dump-header-exts
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/21 Checking commit afe348661672 (iotests/qcow2.py: Add dump-header-ex=
ts)
> ERROR: line over 90 characters
> #32: FILE: tests/qemu-iotests/qcow2.py:237:
> +    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image=
 header extensions' ],
>=20
> total: 1 errors, 0 warnings, 17 lines checked

I actually saw this error locally but decided to go with it because it
fits the current style of qcow2.py in that place.  (And I don=E2=80=99t t=
hink
the line length does any harm there.)

Max


--eaxjkagEsHHQDSeanxLPVbEbwZaRxdWEh--

--vtFIoTbMqgm503oWEhn0IQjhRoUoWPPX2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2mxFAACgkQ9AfbAGHV
z0CnRQf/WwMYnGxtlG+fztAaZNWabGQHZWJ6TiXrczaYruENGg+PfT1LiwUWwLzP
2XRtnNwOKGlBAx3UUslfPX71HDQbiDnTNxn12tMSKLsFIAT6boRCecg85q03oTp4
yvbDuppA9vSYKVp2/cuhaaAH+aTJIF3rNZ0LI01YQmRAlPLEnUDmp0+m46u5ogg8
WFJsFBKtWoq840UrtLMVFHtjZYEhqXp0Z7vhlK94UwN7NEuxRsgom95xmDUdqrLb
/gzhq8SrwpvX9aKmskFRrJTD8y/9xQ2prbgsrYxq8Jc0erSvBtnC34GZUy8z2ZxR
hj7TPFmyLONrmnDlX+/fGRFOV3g6OQ==
=Yctv
-----END PGP SIGNATURE-----

--vtFIoTbMqgm503oWEhn0IQjhRoUoWPPX2--

