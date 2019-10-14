Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C043FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9604E20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9604E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1pu-0000V8-MZ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iK1or-0008La-L3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iK1oq-0003yD-G3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:59:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iK1on-0003wD-Ql; Mon, 14 Oct 2019 10:59:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B67220FE;
 Mon, 14 Oct 2019 14:59:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-165.ams2.redhat.com
 [10.36.117.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88BA1608C2;
 Mon, 14 Oct 2019 14:59:25 +0000 (UTC)
Subject: Re: [PATCH v4 0/7] iotests: Selfish patches
To: qemu-block@nongnu.org
References: <20190917092004.999-1-mreitz@redhat.com>
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
Message-ID: <80224b65-9741-befb-7a3e-fbc44746efee@redhat.com>
Date: Mon, 14 Oct 2019 16:59:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917092004.999-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nclFDyk8y4bBIBS2mG2w6CBbsQmUuB9qr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 14 Oct 2019 14:59:29 +0000 (UTC)
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nclFDyk8y4bBIBS2mG2w6CBbsQmUuB9qr
Content-Type: multipart/mixed; boundary="oUBiBolW6xLPsL4S6R79XUzPf4qqpBYol"

--oUBiBolW6xLPsL4S6R79XUzPf4qqpBYol
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.09.19 11:19, Max Reitz wrote:
> Hi,
>=20
> Again, let me start with a link to an actually explanatory cover letter=
:
> https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg01102.html
>=20
> v3:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00950.html
>=20
> v4:
> - I merged the old patch 1 in the meantime
>=20
> - Patch 2: Adjusted the comment to make it more clear that it is
>            case_notrun() itself that will not skip the test case, as
>            requested by Andrey (I hope it fits what he had in mind, mor=
e
>            or less); kept the R-bs, because I somehow feel like that=E2=
=80=99s
>            the right thing to do here.
>=20
> - Patch 3: The func_wrapper returned by the skip_test_decorator has a
>            mandatory argument; make that and its required type explicit=

>            (with an annotation), as suggested by John
>            (Kevin made me aware of the fact that annotations exist sinc=
e
>            Python 3.0, it=E2=80=99s just that they didn=E2=80=99t mean =
anything back
>            then (neither do they really now, but whatever, it=E2=80=99s=
 better
>            than a comment))
>=20
> - Patch 4: Resolved a conflict because of the change to patch 3

Thanks for the reviews, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--oUBiBolW6xLPsL4S6R79XUzPf4qqpBYol--

--nclFDyk8y4bBIBS2mG2w6CBbsQmUuB9qr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2kjUwACgkQ9AfbAGHV
z0DCnQf/cIFkvjDzHE/mB+ahrV+R8syJ/eptVVp1DleoA41YwoEr4DAXrNstr/3N
7tzeTElTsdpzbSgKoxWrva95bpU8P7waytK+DkSa9B2kWSTf3oZ8cHpzU3Zm7bII
UKwMJCpnx/6x4RFvUZVJcuA16aSsD+PD1NOc/4JNJYlYNbJOU0x7Lb95sFD37tLq
7AbnRpQdnS8DkJ/1MhqbBVFDhdQSmID7F0OCCCEbwW4qYrZAL2+fmmMwrbbKmDJJ
RKgBPbpNImAN9+1I56Wz4k6q4qc7Wcs9veLJOHp8udjfB7ofgt+8zWaLzxgD/xPc
uVcDpEaalobo6mWLuusAGRzEwnJqAw==
=93fY
-----END PGP SIGNATURE-----

--nclFDyk8y4bBIBS2mG2w6CBbsQmUuB9qr--

