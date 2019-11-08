Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90755FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F7E214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwISEJhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F7E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT12w-0001aN-Vh
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT11t-0000fe-IJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT11r-0001xy-Hs
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:58:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT11q-0001xA-AY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WA3Fed3mdqKnzNX+sHk5IgaeP0I694x4lPZtkzC6asw=;
 b=OwISEJhfdJsQJUcDXpThfDFHe6+/3jULMkgt1mCftjhQ1C47fNZMIQU99mtUJ3dz1hGoO8
 MT3u4Szmyzy25QsciV5nuNjE94XnOvnrTz/BibGSBAz9b04ENoe8XTAtX2+CapZNs2adY1
 gP/kouPTiFmRHam8Rc5t2nEedyOyg8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-SRLep9yJNXuhSnL1CHSzfQ-1; Fri, 08 Nov 2019 04:57:58 -0500
X-MC-Unique: SRLep9yJNXuhSnL1CHSzfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A7A48017DE;
 Fri,  8 Nov 2019 09:57:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 267911001B34;
 Fri,  8 Nov 2019 09:57:55 +0000 (UTC)
Subject: Re: [PATCH v3 00/22] iotests: Allow ./check -o data_file
To: qemu-devel@nongnu.org
References: <157316100035.31898.12423456223361881058@37313f22b938>
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
Message-ID: <f655b450-12d0-27c5-a3ac-265fb25bffa4@redhat.com>
Date: Fri, 8 Nov 2019 10:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157316100035.31898.12423456223361881058@37313f22b938>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a78GL0pelV1MOH9MvsyD5PeSQtzsQOzGB"
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a78GL0pelV1MOH9MvsyD5PeSQtzsQOzGB
Content-Type: multipart/mixed; boundary="icjjOrZRPpb0SnkkjFdwz4W1mtidBmhLH"

--icjjOrZRPpb0SnkkjFdwz4W1mtidBmhLH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.19 22:10, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191107163708.833192-1-mreitz@redh=
at.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Subject: [PATCH v3 00/22] iotests: Allow ./check -o data_file
> Type: series
> Message-id: 20191107163708.833192-1-mreitz@redhat.com
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
> 01a2839 iotests: Allow check -o data_file
> 31bc07b iotests: Disable data_file where it cannot be used
> 98a2575 iotests: Make 198 work with data_file
> e8f406f iotests: Make 137 work with data_file
> 46cc09d iotests: Make 110 work with data_file
> 1f7b2e5 iotests: Make 091 work with data_file
> 401d3ef iotests: Avoid cp/mv of test images
> a3746a2 iotests: Use _rm_test_img for deleting test images
> 37a01c8 iotests: Avoid qemu-img create
> a05c5ec iotests: Drop IMGOPTS use in 267
> 44aac70 iotests: Replace IMGOPTS=3D'' by --no-opts
> cb9ee70 iotests: Replace IMGOPTS=3D by -o
> 3c2893f iotests: Inject space into -ocompat=3D0.10 in 051
> 8b5f9d4 iotests: Add -o and --no-opts to _make_test_img
> 239f933 iotests: Let _make_test_img parse its parameters
> 405ddde iotests: Drop compat=3D1.1 in 050
> 527ae22 iotests: Replace IMGOPTS by _unsupported_imgopts
> 77f688d iotests: Filter refcount_order in 036
> 3f29d5f iotests: Add _filter_json_filename
> 58975a8 iotests/qcow2.py: Split feature fields into bits
> 7ea641e iotests/qcow2.py: Add dump-header-exts
> 469af5e iotests: s/qocw2/qcow2/
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/22 Checking commit 469af5ede216 (iotests: s/qocw2/qcow2/)
> 2/22 Checking commit 7ea641ec6b0a (iotests/qcow2.py: Add dump-header-exts=
)
> ERROR: line over 90 characters
> #33: FILE: tests/qemu-iotests/qcow2.py:237:
> +    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image h=
eader extensions' ],

As in v1, I deliberately followed the existing style in this file and
believe it=E2=80=99s for the best.

Max


--icjjOrZRPpb0SnkkjFdwz4W1mtidBmhLH--

--a78GL0pelV1MOH9MvsyD5PeSQtzsQOzGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3FPCIACgkQ9AfbAGHV
z0DsOwf+KsaQfrXN1rGtyKLWpq18qn3rZn907nUuNco+3e9wb8y2rP3Hp7j3HGrM
ioXDMcJrzujdRuxWgn12IStfvP732FZmLYsgb5wdxKM3DnI8JxfyLkUio7CphjYX
72yJbYJ4yqsFk2O4/knhtimEMDFqu5DKqj26PEeoURfI8cyNC1AdRK3x3+Q1zxR4
6sXS5zbVuXo6u1cE2UPI9Bc5ROTO0zApje/KHYbNdBR0uDXvaH/loQhA+kzu+t2w
rxKR0LyjFS5iFaRFSu2zuy4zHKRTm5k87dggkzyC1dE4in10WfTVNCTwxygOJmCp
M4nb2QiaNP3LquJ+gKpVXzhbC62/ag==
=QuAC
-----END PGP SIGNATURE-----

--a78GL0pelV1MOH9MvsyD5PeSQtzsQOzGB--


