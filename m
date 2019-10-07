Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A09C352AA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074D32084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074D32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPpt-0000mq-6h
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHPon-0008Vf-RP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHPom-0005TO-Mm
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHPoi-0005PP-TX; Mon, 07 Oct 2019 06:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B513D10F2E8E;
 Mon,  7 Oct 2019 10:00:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C3C5C1D4;
 Mon,  7 Oct 2019 10:00:32 +0000 (UTC)
Subject: Re: [PATCH] iotests: Do not run the iotests during "make check"
 anymore
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20191002142146.6124-1-thuth@redhat.com>
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
Message-ID: <602a9254-43f1-887f-f661-1233068646e9@redhat.com>
Date: Mon, 7 Oct 2019 12:00:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002142146.6124-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wLEmJAmMt4xQOSELxTifxdNr5t7AXbv70"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 07 Oct 2019 10:00:34 +0000 (UTC)
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
--wLEmJAmMt4xQOSELxTifxdNr5t7AXbv70
Content-Type: multipart/mixed; boundary="uzQUBhWSI1VRGKTap1vUJvNQ5xLPLfhMo"

--uzQUBhWSI1VRGKTap1vUJvNQ5xLPLfhMo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.19 16:21, Thomas Huth wrote:
> Running the iotests during "make check" is causing more headaches than
> benefits for the block layer maintainers, so let's disable the iotests
> during "make check" again.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include   | 2 +-
>  tests/qemu-iotests/group | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

So the background behind this patch is that I continued to
complain/whine until I had a short open discussion with Thomas in which
he agreed to send this patch.  My points were:

(1) It doesn=E2=80=99t seem like people care too much about this.

(2) It isn=E2=80=99t very useful, because we run so few tests, and they d=
on=E2=80=99t
seem to be the critical ones.

(3) In the past months, I feel like I was the single person of contact
when it comes to iotests breaking, and given the above I don=E2=80=99t fe=
el like
having to act immediately on a broken make check is a good use of my
time (there=E2=80=99s always too much to do, so I do have to prioritize (=
like
everyone else)).


I=E2=80=99d hoped that this patch would provoke people that disagree with=
 (1) or
(2), and potentially help me out to alleviate (3).  Or maybe provoke
nobody, in which case (1) would have been confirmed.


That didn=E2=80=99t quite happen, but Kevin and Peter decided to reply to=
 my
original discussion with Thomas.

=46rom what they=E2=80=99ve said I gather that (1) and (2) are wrong, and=
 I assume
that Kevin will as the/a block maintainer have the same responsibility
as me when it comes to (3).

As such, while I can=E2=80=99t NAK this patch in their name, I can say th=
at I no
longer see a need for this patch, because the reasons for why I=E2=80=99v=
e
requested it have been shown to be wrong.

I assume that Thomas actually doesn=E2=80=99t want to see this patch merg=
ed, and
that Kevin won=E2=80=99t merge it either, so I think that effectively mak=
es this
a =E2=80=9Cpassive-NAK=E2=80=9D.

Max


--uzQUBhWSI1VRGKTap1vUJvNQ5xLPLfhMo--

--wLEmJAmMt4xQOSELxTifxdNr5t7AXbv70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bDL4ACgkQ9AfbAGHV
z0AuxQf+INrCES/Xpz6Rssoszgbrb8U9Veqt6z7XyugxnXCLVvFXoTv/QOewQL+e
4EUXYpkW5BKufk+90Qw0SC87Mvxh/4nzP+VACSsiNK9UXIhh9Vn7DLsRP+opMmwU
8tp7tUHSdfNxihud7oakJE3g6FOA+9VCCXcI/fCOxIqIkIg/noq9sHjIAz0kG1wt
iV9mzzlrxs1dxHq6OPy5LtTX5oSxSD2XykpqTTw50FUZOFAjSNO4EAeztgCrvmsX
QMzFZ+oTltDUPGI8+eU8VktuW3WUXF1/hsjdQkXro69+a6b2gcFgPxzTKDGlhDUo
Wx2gzGoZbOQqaReD8Kh+r/zJiEzJOw==
=IQot
-----END PGP SIGNATURE-----

--wLEmJAmMt4xQOSELxTifxdNr5t7AXbv70--

